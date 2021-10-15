/*
  TCL (Transaction Controll Langage : 트랜잭션 제어어)
  트랜잭션 관리 : commit, rollback, savepoint
  트랜잭션 시작 : DB 안에서의 트랜잭션 시작은 첫번 째 DML사용구문, DDL 사용구문
*/

ALTER TABLE EMPLOYEE
DISABLE CONSTRAINT FK_MGRID; --DDL이 사용되면 트랜잭션 (1) 이 시작!! ---START---------------- 또는 트랜잭션을 끝낼수도 있따.
-- DISABLE CONSTRAINT FK_MGRID 제약조건 검사 비활성화 
-- 오라클 버전에 따라 비활성화 되어도 제약조건 검사가 작동되는 경우가 있다.
-- 해결방법 : 제약조건 삭제 > DML 실행 > 다시 제약조건 추가해야함
--ALTER TABLE EMPLOYEE
--DROP CONSTRAINT FK_MGRID; -- 제약조건 삭제

--DML 실행

--ALTER TABLE EMPLOYEE --제약조건 다시 추가
--ADD CONSTRAINT FK_MGRID FOREIGN KEY (MGR_ID) REFERENCES EMPLOYEE;

SAVEPOINT S0;

INSERT INTO DEPARTMENT --DML : 첫번 째 DDL시작의 트랜잭션 안에서의 DML은 같은 트랜잭션으로 들어간다.
VALUES ('40', '홍보팀', 'A1');

SELECT * FROM DEPARTMENT;

SAVEPOINT S1;

SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_ID IS NULL; -- 부서번호가 NULL인 갯수 : 2개 

UPDATE EMPLOYEE
SET DEPT_ID = '40'
WHERE DEPT_ID IS NULL; -- 부서번호가 NULL인 값에 40으로 변경

SELECT COUNT(*)
FROM EMPLOYEE 
WHERE DEPT_ID LIKE '40'; -- 2개 

SAVEPOINT S2;

DELETE FROM EMPLOYEE
WHERE DEPT_ID LIKE '40'; -- 여기까지가 하나의 트랜잭션 (1) 이다 (위에 DDL부터) 
-- COMMIT 명령어나 DDL 구문을 작성을 하지 않으면 트랜잭션은 계속 진행되며 
-- 종료하려면 COMMIT; 이나 DDL 구문(ALTER , CREATE, DROP) 을 작성하는 시점에 트랜잭션 (1)이 종료가 된다.
-- 지금 SQL/DEVELOPER는 자동 커밋되기 때문에 상관은 없지만 자바랑 연동해 어플리케이션을 만들 때 반드시 
-- COMMIT명령어나 ROLLLBACK 명령어를 작성해 어느 한 과정의 작업들(트랜잭션) 을 저장하고, 또는 오류가 나면 취소하고
-- 하는 작업을 해줘야 한다 !!!

--ROLLBACK; -- 처음 트랜잭션 시작 했던 지점부터 취소 시킴
ROLLBACK TO S2; --SAVEPOINT S2 밑에 있는 DELETE 구문이 최소가 되었다 !! / 어디까지만 취소해라는 의미!

SELECT COUNT(*)
FROM EMPLOYEE 
WHERE DEPT_ID LIKE '40'; -- 2개 : DELETE 취소

ROLLBACK TO S1; -- SAVEPOINT S1 밑에 있는 UPDATE 구문 취소

SELECT COUNT(*)
FROM EMPLOYEE 
WHERE DEPT_ID LIKE '40'; -- 0개 : UPDATE 취소

ROLLBACK TO S0; -- SAVEPOINT S0 밑에 있는 INSERT 구문 취소

SELECT * FROM DEPARTMENT; -- INSERT 취소

/* *동시성 제어 : LOCK(잠금)
    SQL/DEBELOPER 를 2개를 열어서 테스트
*/
--접속 1
SELECT EMP_ID, EMP_NAME, MARRIAGE 
FROM EMPLOYEE
WHERE EMP_ID LIKE '124';

UPDATE EMPLOYEE
SET MARRIAGE = 'Y'
WHERE EMP_ID LIKE '124';

COMMIT; --마무리를 해줘야 다른 사용자가 변경된 정보를 조회 할 수 있다
        --커밋을 안하면 동시에 접속했을 때 다른 사용자가 변경된 정보를 보지 못한다.
-----------------------------------------------------        
/* *시퀀스 SEQUENCE : 자동 (정수) 숫자 발생기
    순차적으로 정수 값을 자동으로 발생하는 데이터베이스 객체이다
    ★구문방식 : CREATE SEQUENCE 시퀀스 이름
                [STRAT WITH 시작 숫자] --> 생략시 기본 값 1, 1부터 시작
                [INCREMENT BY 증감치] --> 생략시 기본 값 1 , 1씩증가
                [MAXVALUE 최대 값 | NOMAXVALUE] --> 생략되면 NOMAXVALUE 기본값 최대 얼마까지 증가시킬거냐
                [MINVALUE 최소 값 | NOMINVALUE] --> 생략되면 NOMINVALUE 기본값
                [CYCLE | NOCYCLE] --> 생략되면 NOCYCLE이 기본 값
                [CACHE 저장할 갯수 | NOCATCH] --> CACHE (2 ~ 20) 까지 만들 수 있으며 (기본 값 20)
*/

--시퀀스 만들기
CREATE SEQUENCE SEQ_EMPID
START WITH 300 -- 시작 값 : 300부터 시작
INCREMENT BY 5 -- 증가 값 : 5씩 증가하겠다.
MAXVALUE 310 -- 310 까지 숫자를 생성한다.
NOCYCLE -- 310 생성후 더이상 생성 안하겠다.
NOCACHE; -- 메모리에 미리 숫자를 저장하지 않겠다.

--데이터 딕셔너리에 저장됨
DESCRIBE USER_SEQUENCES;

SELECT * FROM USER_SEQUENCES;

--시퀀스 사용 : 시퀀스 이름.NEXTVAL 을 사용해야 숫자가 발생한다.
-- INSERT 문에서 값 기록시에 사용한다.
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --4번 째 사용할 때 ERROR가 난다 => NOCYCLE로 설정했기 떄문에
SELECT SEQ_EMPID.CURRVAL FROM DUAL;
DROP SEQUENCE SEQ_EMPID;

CREATE SEQUENCE SEQ_EMPID2
START WITH 5
INCREMENT BY 5
MAXVALUE 15
CYCLE -- 값 순환시 무조건 1부터 시작 (START WITH로 정한 5부터 시작하는 것이 아니다.)
NOCACHE;

SELECT * FROM USER_SEQUENCES;
SELECT SEQ_EMPID2.NEXTVAL FROM DUAL; --5, 10, 15, 1 , 6 , 11 , 1, 6, 11. . . . .
SELECT SEQ_EMPID2.CURRVAL FROM DUAL;

--시퀀스 사용방법
--새로운 숫자를 발생 : 시퀀스이름.NEXTVAL
--현재 시퀀스 숫자 확인 : 시퀀스이름.CURRVAL (※반드시 NEXTVAL 한번 실행 후에 사용해야한다!!)

CREATE SEQUENCE SEQ_EMPID3
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

SELECT SEQ_EMPID3.CURRVAL FROM DUAL; --ERROR 
-- NEXTVAL을 한번도 사용하지 않은 상태에서는 CURRVAL을 사용할 수 없다.
SELECT SEQ_EMPID3.NEXTVAL FROM DUAL;
SELECT SEQ_EMPID3.CURRVAL FROM DUAL;

--시퀀스 사용 : 주로 INSERT 문에 사용
CREATE SEQUENCE SEQID
START WITH 300
INCREMENT BY 1
MAXVALUE 999
NOCYCLE
CACHE 5;

INSERT INTO EMPLOYEE (EMP_ID, EMP_NO, EMP_NAME)
VALUES (TO_CHAR(SEQ_EMPID3.NEXTVAL), '201225-1012345' , '윈터');
INSERT INTO EMPLOYEE (EMP_ID, EMP_NO, EMP_NAME)
VALUES (TO_CHAR(SEQID.NEXTVAL), '201225-1012333' , '카리나');

SELECT * FROM EMPLOYEE
ORDER BY EMP_ID DESC;

--시퀀스 수정 
--시퀀스 객체 수정시 START WITH(시작 값)는 수정을 못하고 나머지는 모두 수정이 가능하다.
--START WITH를 변경하고 싶으면 SEQUENCE 객체를 지우고 다시 만들어야한다.
--시퀀스를 변경 후 변경 내용은 이후 사용시에 적용된다.
-- ALTER SEQUENCE 시퀀스 이름
-- [INCREMENT BY 증가치]
-- [MAXVALUE 최대값 | NOMAXVALUE]
-- [MINVALUE 최소값 | NOMINVALUE]
-- [CYCLE | NOCYCLE]
-- [CACHE | NOCACHE]

CREATE SEQUENCE SEQID2
START WITH 100
INCREMENT BY 1
MAXVALUE 110
NOCYCLE
NOCACHE;

ALTER SEQUENCE SEQID2
INCREMENT BY 5;

SELECT SEQID2.NEXTVAL FROM DUAL;
SELECT SEQID2.CURRVAL FROM DUAL;

SELECT * FROM USER_SEQUENCES; --딕셔너리 조회

--시퀀스 삭제 : DROP SEQUENCE 시퀀스이름
DROP SEQUENCE SEQID2;

/* 뷰 (VIEW)
  SELECT 쿼리문을 저장하는 객체
  작성법 : CREATE OR REPLACE VIEW 뷰이름
          AS 서브쿼리(SELECT 문) <-- 뷰에 저장 할 SELECT 쿼리문
*/
--처음 실행시 에러 발생하면 관리자 계정에 권한 부여받아야한다.
--권한부여 : GRANT VIEW TO c##student
CREATE OR REPLACE VIEW V_EMP_DEPT90
AS
SELECT EMP_NAME, DEPT_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE 
LEFT JOIN DEPARTMENT USING(DEPT_ID)
LEFT JOIN JOB USING(JOB_ID)
WHERE DEPT_ID LIKE '90';

--딕셔너리의 뷰 객체 확인 : USER_VIEWS
SELECT * FROM USER_VIEWS;
--SELECT 쿼리문 저장 확인

--뷰 사용 : 테이블처럼 사용한다.(인라인뷰로 작동됨)
SELECT * FROM V_EMP_DEPT90; 

---------------------------------------------------------------------
/* INDEX (인덱스)
  SELECT 문의 처리 속도를 향상시키기 위해서 컬럼에 생성하는 객체
  해당 컬럼 값으로 조회 할 때 검색 속도(값을 찾는 속도)를 빨리 하기 위해 이용하는 객체(무조건은 빠른건 아님) [적당한데이터가 있으면 효과있음]
  구문형식 : CREATE [UNIQUE] INDEX 인덱스 이름
            ON 테이블명 (컬럼명 또는 함수계산식) 일반적으로 컬럼명 
*/
--UNIQUE INDEX : UNIQUE 제약조건과 같은 의미에 INDEX
CREATE UNIQUE INDEX IDX_DNM
ON DEPARTMENT (DEPT_NAME);

--NONUNIQUE INDEX
CREATE INDEX IDX_JID
ON EMPLOYEE (JOB_ID);

--인덱스 객체 삭제
DROP INDEX IDX_JID;

--인덱스 객체도 데이터 딕셔너리에서 관리됨 : USER_INDEXES, USER_CATALOGS, USER_OBJECTS
--컬럼에 대한 인덱스 정보를 확인 관리 : USER_IND_COLUMNS
SELECT INDEX_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME LIKE 'EMPLOYEE';

