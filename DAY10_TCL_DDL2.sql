-- DAY10_TCL_DDL2

-- TCL (Transaction Controll Language : 트랜잭션 제어어)
-- 트랜잭션 관리 : commit, rollback, savepoint
-- 트랜잭션 시작 : 첫번째 DML 사용, DDL 사용

ALTER TABLE EMPLOYEE
DISABLE CONSTRAINT FK_MGRID;  -- DDL 사용 : 트랜잭션 1 시작 -------------------------------------------------------------
-- 오라클 버전에 따라 비활성화되어도 제약조건 검사가 작동되는 경우가 있음
-- 해결방법 : 제약조건 삭제함 > DML 실행 > 제약조건 추가함

-- 제약조건 삭제
--ALTER TABLE EMPLOYEE
--DROP CONSTRAINT FK_MGRID;

-- DML 실행은 생략

-- 제약조건 다시 추가함
--ALTER TABLE EMPLOYEE
--ADD CONSTRAINT FK_MGRID FOREIGN KEY (MGR_ID) REFERENCES EMPLOYEE;

SAVEPOINT S0;

INSERT INTO DEPARTMENT 
VALUES ('40', '기획전략팀', 'A1');

SELECT * FROM DEPARTMENT;

SAVEPOINT S1;

SELECT COUNT(*) 
FROM EMPLOYEE
WHERE DEPT_ID IS NULL;  -- 2개 확인

UPDATE EMPLOYEE
SET DEPT_ID = '40'
WHERE DEPT_ID IS NULL;

SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_ID = '40';  -- 2개

SAVEPOINT S2;

DELETE FROM EMPLOYEE
WHERE DEPT_ID = '40';

SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_ID = '40';  -- 0개  ---------------- 트랜잭션 1 계속 진행

ROLLBACK TO S2;

SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_ID = '40';  -- 2개  : DELETE 취소

ROLLBACK TO S1;

SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_ID = '40';  -- 0개  : UPDATE 취소

ROLLBACK TO S0;

SELECT * FROM DEPARTMENT;  -- INSERT 취소

-- 동시성 제어 : LOCK (잠금)
-- 디벨로퍼 툴 2개 열어서 테스트함
-- 접속 1
SELECT EMP_ID, EMP_NAME, MARRIAGE
FROM EMPLOYEE
WHERE EMP_ID = '124';

UPDATE EMPLOYEE
SET MARRIAGE = 'Y'
WHERE EMP_ID = '124';

COMMIT;

-- ***********************************************************
-- 시퀀스 (SEQUENCE)
-- 자동 정수 번호 발생기
-- 순차적으로 정수 값을 자동으로 발생하는 객체임
/*
구문 작성 형식 : 
CREATE SEQUENCE 시퀀스이름
[START WITH 시작숫자]  -- 생략시 기본값은 1 (1부터 시작)
[INCREMENT BY 증감치]  -- 생략시 기본값은 1 (1씩 증가)
[MAXVALUE 최대값 | NOMAXVALUE] 
[MINVALUE 최소값 | NOMINVALUE]
[CYCLE | NOCYCLE]
[CACHE 저장할갯수 | NOCACHE]  -- CACHE 2 ~ 20 (기본값은 20)
*/

-- 시퀀스 만들기 1
CREATE SEQUENCE SEQ_EMPID
START WITH 300  -- 시작값 : 300부터 시작
INCREMENT BY 5 -- 증가값 : 5씩 증가
MAXVALUE 310   -- 310 까지 생성
NOCYCLE   -- 310 생성 후 더 이상 생성 안 함
NOCACHE;  -- 메모리에 미리 숫자를 저장하지 않음

-- 데이터 딕셔너리에 저장됨
DESCRIBE USER_SEQUENCES;

SELECT * FROM USER_SEQUENCES;

-- 시퀀스 사용 : 시퀀스이름.NEXTVAL 을 사용해야 숫자가 발생함
-- INSERT 문에서 값 기록시에 사용함
SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
-- 4회 사용시 에러 발생함 (NOCYCLE 이기 때문)

-- 시퀀스 만들기 2
CREATE SEQUENCE SEQ_EMPID2
START WITH 5
INCREMENT BY 5
MAXVALUE 15
CYCLE  -- 값 순환시에는 무조건 1부터 시작됨.
NOCACHE;

-- 사용 확인
SELECT SEQ_EMPID2.NEXTVAL FROM DUAL;  -- 5, 10, 15, 1, 6, 11, 1, 6, 11, ......

-- 시퀀스 사용방법 : 
-- 새로운 숫자 발생 : 시퀀스이름.NEXTVAL
-- 현재 시퀀스 숫자 확인 : 시퀀스이름.CURRVAL  (반드시 NEXTVAL 한번 실행한 다음에 사용해야 됨)
SELECT SEQ_EMPID2.CURRVAL FROM DUAL;

CREATE SEQUENCE SEQ_EMPID3
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

SELECT SEQ_EMPID3.CURRVAL FROM DUAL;  -- ERROR
-- NEXTVAL 한번도 사용하지 않은 상태에서는 CURRVAL 사용할 수 없음

SELECT SEQ_EMPID3.NEXTVAL FROM DUAL;
SELECT SEQ_EMPID3.CURRVAL FROM DUAL;

-- 시퀀스 사용 : 주로 INSERT 시에 사용함
CREATE SEQUENCE SEQID
START WITH 300
INCREMENT BY 1
MAXVALUE 999
NOCYCLE
CACHE 5;

INSERT INTO EMPLOYEE (EMP_ID, EMP_NO, EMP_NAME)
VALUES (TO_CHAR(SEQID.NEXTVAL), '841205-1234567', '구진표');

SELECT * FROM EMPLOYEE
ORDER BY EMP_ID DESC;

-- 시퀀스 수정
/*
- START WITH 는 수정 못 함, 나머지는 모두 수정할 수 있음
- STRAT WITH 를 바꾸려면, 시퀀스 객체 삭제하고 다시 만들기해야 함
- 변경 내용은 이후 사용시에 적용됨

ALTER TABLE 시퀀스이름
[INCREMENT BY 증감치]
[MAXVALUE 최대값 | NOMAXVALUE]
[MINVALUE 최소값 | NOMINVALUE]
[CYCLE | NOCYCLE]
[CACHE 저장갯수 | NOCACHE];
*/

CREATE SEQUENCE SEQID2
START WITH 300
INCREMENT BY 1
MAXVALUE 310
NOCYCLE
NOCACHE;

SELECT SEQID2.NEXTVAL FROM DUAL;
SELECT SEQID2.CURRVAL FROM DUAL;
SELECT SEQID2.NEXTVAL FROM DUAL;

ALTER SEQUENCE SEQID2
INCREMENT BY 5;

SELECT SEQID2.NEXTVAL FROM DUAL;

-- 시퀀스 삭제 : DROP SEQUENCE 시퀀스이름;
DROP SEQUENCE SEQID2;

SELECT * FROM USER_SEQUENCES;

-- *********************************************************************************
-- VIEW (뷰)
-- SELECT 쿼리문을 저장하는 객체임
/*
작성방법 : 
CREATE OR REPLACE VIEW 뷰이름
AS 서브쿼리;   -- 뷰에 저장할 SELECT 문임
*/

CREATE OR REPLACE VIEW V_EMP_DEPT90
AS
SELECT EMP_NAME, DEPT_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE DEPT_ID = '90';

-- 처음 실행시 "insufficient privileges" 에러 발생하면
-- 관리자계정(사용자계정을 만든 계정)에 권한 부여받아야 함.
-- system 계정으로 접속 : 
GRANT CREATE VIEW TO c##student;

-- 딕셔너리의 뷰 객체 확인 : USER_VIEWS
SELECT * FROM USER_VIEWS;
-- SELECT 쿼리문 저장 확인함

-- 뷰 사용 : 테이블처럼 사용함 (인라인뷰로 작동됨)
SELECT * FROM V_EMP_DEPT90;

-- *******************************************
-- 인덱스 (INDEX)
-- SELECT 문의 처리 속도를 향상시키기 위해서 컬럼에 생성하는 객체임.
-- 해당 컬럼값으로 조회할 때 검색 속도를 빨리하기 위해서 이용하는 객체임. (무조건 빠른 건 아님.)
/*
CREATE [UNIQUE] INDEX 인덱스이름
ON 테이블명 (컬럼명)
*/

-- UNIQUE INDEX : UNIQUE 제약조건과 같은 의미로 사용됨
CREATE UNIQUE INDEX IDX_DNM
ON DEPARTMENT (DEPT_NAME);

-- NONUNIQUE INDEX
CREATE INDEX IDX_JID
ON EMPLOYEE (JOB_ID);

-- 인덱스 삭제
DROP INDEX IDX_JID;

-- 인덱스도 데이터 딕셔너리에서 관리됨 : USER_INDEXES, USER_CATALOGS, USER_OBJECTS
-- 컬럼에 대한 인덱스 관리 : USER_IND_COLUMNS
SELECT INDEX_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'EMPLOYEE';

