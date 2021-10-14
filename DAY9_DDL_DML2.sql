-- DAY9_DDL_DML2

-- 서브쿼리를 사용해서 새 테이블을 만들 수 있음

-- 90번 부서의 직원명단을 EMP_COPY90 테이블에 저장 처리한다면...
CREATE TABLE EMP_COPY90
AS 
SELECT * FROM EMPLOYEE
WHERE DEPT_ID = '90';

SELECT * FROM EMP_COPY90;

-- 전 직원의 사번, 이름, 급여, 부서명, 직급명을 조회해서
-- TABLE_SUBQUERY1 테이블에 저정 처리하는 구문을 작성 실행하시오.
CREATE TABLE TABLE_SUBQUERY1
AS
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID);

-- 확인
SELECT * FROM TABLE_SUBQUERY1;

-- DESCRIBE 명령어 (줄임말 : DESC)
-- DESCRIBE 테이블명;   또는 DESC 테이블명;
-- 테이블의 구성 정보를 확인할 수 있음 : 컬럼명, 자료형, NULLABLE 등
DESC EMP_COPY90;

-- 서브쿼리를 이용해서 기존 테이블을 복사할 경우,
-- 컬럼명, 자료형, NOT NULL 제약조건은 그대로 복사가 됨
-- 나머지 제약조건은 복사되지 않는다.
CREATE TABLE EMP_COPY
AS
SELECT * FROM EMPLOYEE;

SELECT * FROM EMP_COPY;
DESC EMP_COPY;

-- 연습 : 
-- 사번, 이름, 급여, 직급명, 부서명, 근무지역명, 소속국가명 조회한 결과를
-- EMP_LIST 테이블에 저장함. (전체 직원 정보여야 함)
CREATE TABLE EMP_LIST
AS
SELECT EMP_ID, EMP_NAME, SALARY, JOB_TITLE, DEPT_NAME, LOC_DESCRIBE, COUNTRY_NAME
FROM EMPLOYEE 
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN LOCATION ON (LOC_ID = LOCATION_ID)
LEFT JOIN COUNTRY USING (COUNTRY_ID);

-- 확인
SELECT * FROM EMP_LIST;
DESCRIBE EMP_LIST;

-- 실습 1 : EMPLOYEE 테이블에서 남자 직원들의 정보만 골라내서
-- EMP_MAN 테이블에 저장함
CREATE TABLE EMP_MAN
AS
SELECT * FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3');

SELECT * FROM EMP_MAN;
DESC EMP_MAN;

-- 여자 직원들의 정보만 골라내서, EMP_FEMAIL 테이블에 저장함
CREATE TABLE EMP_FEMALE
AS
SELECT * FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

SELECT * FROM EMP_FEMALE;
DESC EMP_FEMALE;

-- 실습 2 : 부서별로 정렬된 직원의 명단을 PART_LIST 테이블에 저장함
-- DEPT_NAME, JOB_TITLE, EMP_NAME, EMP_ID 순으로 구성함 (부서명 기준 오름차순정렬, 직급명 오름차순)
-- 생성된 테이블의 각 컬럼에 주석(COMMENT) 달기
CREATE TABLE PART_LIST
AS
SELECT DEPT_NAME, JOB_TITLE, EMP_NAME, EMP_ID
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
ORDER BY DEPT_NAME ASC, 2;

SELECT * FROM PART_LIST;

COMMENT ON COLUMN PART_LIST.DEPT_NAME IS '부서이름';
COMMENT ON COLUMN PART_LIST.JOB_TITLE IS '직급이름';
COMMENT ON COLUMN PART_LIST.EMP_NAME IS '직원이름';
COMMENT ON COLUMN PART_LIST.EMP_ID IS '사번';

DESC PART_LIST;

-- 서브쿼리로 새 테이블 만들 때, 컬럼명을 바꿀 수 있음.
-- 주의사항 : 서브쿼리 SELECT 절의 컬럼 갯수와 바꿀 컬럼명의 갯수가 일치해야 함
/*
CREATE TABLE 테이블명 (바꿀컬럼명, .....)
AS 서브쿼리;
*/
CREATE TABLE TABLE_SUBQUERY2 (사번, 이름, 급여, 부서명, 직급명)
AS
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID);

SELECT * FROM TABLE_SUBQUERY2;
DESCRIBE TABLE_SUBQUERY2;

-- 일부 컬럼명만 바꾸고자 한다면, SELECT 절에 별칭 처리함
CREATE TABLE PART_LIST2 --(DNAME, JTITLE, ENAME) : SELECT 절의 항목과 갯수가 일치하지 않으면 에러임
AS
SELECT DEPT_NAME DNAME, JOB_TITLE JTITLE, EMP_NAME ENAME, EMP_ID
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
ORDER BY DEPT_NAME ASC, 2;

SELECT * FROM PART_LIST2;
DESCRIBE PART_LIST2;

-- 실습 : 제약조건이 설정된 테이블 만들기
-- 테이블명 : PHONEBOOK
-- 컬럼명 :  ID  CHAR(3) 기본키(저장이름 : PK_PBID)
--         PNAME      VARCHAR2(20)  널 사용못함.
--                                 (NN_PBNAME) 
--         PHONE      VARCHAR2(15)  널 사용못함
--                                 (NN_PBPHONE)
--                                 중복값 입력못함
--                                 (UN_PBPHONE)
--         ADDRESS    VARCHAR2(100) 기본값 지정함
--                                 '서울시 구로구'

-- NOT NULL을 제외하고, 모두 테이블 레벨에서 지정함.

CREATE TABLE PHONEBOOK (
    ID CHAR(3),
    PNAME VARCHAR2(20)  CONSTRAINT NN_PBNAME NOT NULL,
    PHONE VARCHAR2(15)  CONSTRAINT NN_PBPHONE NOT NULL,
    ADDRESS VARCHAR2(100) DEFAULT '서울시 구로구',
    CONSTRAINT PK_PBID PRIMARY KEY (ID),
    CONSTRAINT UN_PBPHONE UNIQUE (PHONE)
);

INSERT INTO PHONEBOOK 
VALUES ('A01', '홍길동', '010-1234-5678', DEFAULT);

SELECT * FROM PHONEBOOK;

-- 데이터 딕셔너리 (데이터 사전)
-- 사용자가 생성한 모든 데이터베이스 객체 정보를 테이블 형태로 자동 저장관리되는 영역
-- 조회만 할 수 있고, 수정은 못 함
-- DBMS 시스템에 의해 자동 관리되고 있음
-- 예를 들면, 사용자가 설정한 제약조건도 자동 저장 관리되고 있음 : USER_CONSTRAINTS

DESCRIBE USER_CONSTRAINTS;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'PHONEBOOK';

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMPLOYEE';

-- CONSTRAINT_TYPE (제약조건 종류)
-- P : PRIMARY KEY
-- U : UNIQUE
-- C : CHECK, NOT NULL
-- R : FOREIGN KEY

-- 서브쿼리를 가지고 테이블을 만들 때, 데이터는 저장하지 않고 구조만 복사하고자 한다면
-- 서브쿼리 WHERE 절에 1 = 0 라고 기술하면 됨
CREATE TABLE DEPT_COPY
AS
SELECT * FROM DEPARTMENT
WHERE 1 = 0;  -- 테이블 구조만 복사함

SELECT * FROM DEPT_COPY;
DESC DEPT_COPY;

-- 서브쿼리로 새 테이블 만들 때, 컬럼명을 바꾸면서 제약조건도 추가할 수 있음
-- FOREIGN KEY 제약조건은 추가할 수 없음
-- 주의사항 : 서브쿼리의 각 컬럼별 결과값과 맞추어서 제약조건을 추가해야 함

CREATE TABLE TABLE_SUBQUERY3 (
    EID PRIMARY KEY,
    ENAME,
    SAL CHECK (SAL > 2000000),  -- ERROR : 서브쿼리 결과값과 맞지 않음 (2백만보다 작은 값이 현재 기록되어 있음)
    DNAME,
    JTITLE NOT NULL  -- ERROR : 현재 컬럼에 NULL 이 있음
)
AS
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
-- CHECK (SAL > 2000000) 해결 조치
WHERE SALARY > 2000000
-- NOT NULL 해결 조치
AND JOB_TITLE IS NOT NULL;

-- 데이터 딕셔너리
-- 사용자가 생성한 테이블 정보 : USER_TABLES, USER_CATALOGS, USER_OBJECTS
SELECT * FROM USER_TABLES;

-- 사용자가 만든 제약조건 정보 : USER_CONSTRAINTS, USER_CONS_COLUMNS
SELECT * FROM USER_CONSTRAINTS;

-- JOIN 종류
-- INNER JOIN, OUTER JOIN, CROSS JOIN, SELF JOIN, NATURAL JOIN

-- NATURAL JOIN
-- 연결할 컬럼명을 별도로 지정하지 않음
-- 조인할 테이블의 기본키(PRIMARY KEY)를 이용한 EQUAL + INNER JOIN 임
SELECT *
FROM EMPLOYEE
NATURAL JOIN DEPARTMENT;

-- *************************************************************************
-- DML (Data Manipulation Language : 데이터 조작어)
-- INSERT, UPDATE, DELETE 문, TRUNCATE 문
-- 테이블에 데이터를 기록 저장하거나(행 추가), 기록된 데이터를 수정하거나, 행을 삭제하는 구문
-- INSERT 문 : 행 추가 (값 기록 저장)
-- UPDATE 문 : 값 수정 (행 갯수 변화없음)
-- DELETE 문 : 행 삭제 (행 갯수 줄어듦), 복구 가능
-- TRUNCATE 문 : 테이블의 모든 행을 삭제함 (복구 안 됨)

-- UPDATE 문
/*
사용형식 : 
UPDATE 테이블명
SET 값수정할컬럼명 = 수정할값, 컬럼명 = 수정할값, .........
WHERE 컬럼명 연산자 추출값;

주의사항 : WHERE 절이 생략되면, 테이블 전체 컬럼의 값이 수정됨.
참고 : SET 절의 수정할 값 자리에 서브쿼리 사용할 수 있음.
      WHERE 절에 찾을값 대신 서브쿼리 사용할 수 있음.
*/

CREATE TABLE DCOPY
AS
SELECT * FROM DEPARTMENT;

SELECT * FROM DCOPY;

UPDATE DCOPY
SET DEPT_NAME = '인사팀';
-- WHERE 절이 생략되면 해당 컬럼 전체 값이 수정됨

-- 방금 사용한 DML 구문 실행 취소
ROLLBACK;

-- 부서코드 10의 부서명을 인사팀으로 바꾼다면
UPDATE DCOPY
SET DEPT_NAME = '인사팀'
WHERE DEPT_ID = '10';

SELECT * FROM DCOPY;

-- UPDATE 문에 서브쿼리 사용할 수 있음
-- SET 절과 WHERE 절에 사용 가능함

-- 심하균 직원의 직급코드와 급여를 수정
-- 성해교 직원과 같은 직급, 같은 급여로 수정 처리 하시오.
SELECT JOB_ID, SALARY  -- J7 1900000
FROM EMPLOYEE
WHERE EMP_NAME = '성해교';

SELECT JOB_ID, SALARY  -- NULL 2300000
FROM EMPLOYEE
WHERE EMP_NAME = '심하균';

UPDATE EMPLOYEE
SET JOB_ID = 'J7', SALARY = 1900000
WHERE EMP_NAME = '심하균';

SELECT * FROM EMPLOYEE
WHERE EMP_NAME IN ('성해교', '심하균');

ROLLBACK;  -- UPDATE 취소

-- 서브쿼리를 적용한다면...
UPDATE EMPLOYEE
SET JOB_ID = (SELECT JOB_ID FROM EMPLOYEE
              WHERE EMP_NAME = '성해교'), 
    SALARY = (SELECT SALARY FROM EMPLOYEE
              WHERE EMP_NAME = '성해교')
WHERE EMP_NAME = '심하균';

-- 서브쿼리를 다중열 서브쿼리로 바꾼다면...
UPDATE EMPLOYEE
SET (JOB_ID, SALARY) = (SELECT JOB_ID, SALARY 
                        FROM EMPLOYEE
                        WHERE EMP_NAME = '성해교')    
WHERE EMP_NAME = '심하균';

-- 테이블 생성시에 컬럼에 DEFAULT 설정을 한 경우에는 INSERT | UPDATE 시에
-- 기록할 값 | 수정할 값 대신에 DEFAULT 키워드를 사용할 수 있음.

-- 수정 전 확인
SELECT EMP_NAME, MARRIAGE  -- 감우섭 Y
FROM EMPLOYEE
WHERE EMP_ID = '210';

-- 수정
UPDATE EMPLOYEE
SET MARRIAGE = DEFAULT
WHERE EMP_ID = '210';

-- 수정 후 확인
SELECT EMP_NAME, MARRIAGE  -- 감우섭 N
FROM EMPLOYEE
WHERE EMP_ID = '210';

ROLLBACK;

-- UPDATE 문 WHERE 절에서 서브쿼리 사용
-- 해외영업2팀 직원들의 보너스포인트롤 모두 0.3 으로 변경하시오.
UPDATE EMPLOYEE
SET BONUS_PCT = 0.3
WHERE DEPT_ID = (SELECT DEPT_ID
                  FROM DEPARTMENT
                  WHERE DEPT_NAME = '해외영업2팀');

-- 확인
SELECT EMP_NAME, DEPT_ID, BONUS_PCT
FROM EMPLOYEE
WHERE DEPT_ID = (SELECT DEPT_ID
                  FROM DEPARTMENT
                  WHERE DEPT_NAME = '해외영업2팀');

ROLLBACK;

-- INSERT 문
-- 테이블에 새로운 행을 추가할 때 사용함 : 행 갯수가 늘어남
-- 테이블에 데이터를 기록 저장하기 위해 사용함
/*
INSERT INTO 테이블명 (값기록 컬럼명, ..........)
VALUES (나열된 컬럼에 기록할 값, ........)

컬럼명 나열이 생략되면, 테이블이 가진 모든 컬럼에 값을 기록한다는 의미임
주의사항 : 나열된 컬럼과 기록할 값의 갯수가 일치해야 됨, 순서, 자료형도 일치해야 함.
        논리적 오류도 주의해야 함 (EMP_NO <= '홍길동' 기록되면 안됨)
*/
-- 논리적 오류 주의
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, HIRE_DATE, JOB_ID, SALARY, 
                        BONUS_PCT, MARRIAGE, MGR_ID, DEPT_ID)
VALUES ('900', '811225-2345678', '오윤하', 'oyua@kkk.com', '01012345678', '06/01/01', 'J7', 2500000, 0, 'N', '176', '90');                        

SELECT * FROM EMPLOYEE
WHERE EMP_ID = '900';

ROLLBACK;  -- INSERT 취소

-- INSERT 시 값 대신에 NULL 과 DEFAULT 를 사용할 수 있다.
INSERT INTO EMPLOYEE
VALUES ('840', '하지언', '870115-2345678', 'hajiun@kkk.com', NULL, '07/06/15', 'J7', NULL, NULL, DEFAULT, '', DEFAULT);
-- DEFAULT 가 설정되지 않은 컬럼에 DEFAULT 사용하면 NULL 처리됨.

SELECT * FROM EMPLOYEE;

ROLLBACK;

-- 서브쿼리를 이용해서 INSERT 할 수 있다.
-- VALUES 키워드 사용하지 않는다.
CREATE TABLE EMP (
    EMP_ID  CHAR(3),
    EMP_NAME VARCHAR2(20),
    DEPT_NAME VARCHAR2(20)
);

INSERT INTO EMP
(SELECT EMP_ID, EMP_NAME, DEPT_NAME
 FROM EMPLOYEE
 LEFT OUTER JOIN DEPARTMENT USING (DEPT_ID) );
 
SELECT * FROM EMP;

-- DELETE 문
-- 테이블의 행을 삭제하는 구문
/*
DELETE FROM 테이블명
WHERE 삭제를 위한 조건;
*/

-- WHERE 절이 생략되면, 테이블의 모든 행이 삭제됨
SELECT * FROM DCOPY;

DELETE FROM DCOPY;
ROLLBACK;  -- DELETE 는 복구할 수 있음

-- TRUNCATE 문
-- 테이블이 가진 모든 행을 삭제함
-- 복구 안 됨
TRUNCATE TABLE DCOPY;  -
SELECT * FROM DCOPY;
ROLLBACK;  -- 복구 안 됨

-- DDL (Data Definition Language : 데이터 정의어)
-- CREATE, ALTER, DROP
-- 데이터베이스 객체를 만들고, 수정하고, 삭제하는 구문임
-- 테이블 : CREATE TABLE, ALTER TABLE, DROP TABLE
-- 뷰 : CREATE VIEW, DROP VIEW
-- 시퀀스 : CREATE SEQUENCE, ALTER SEQUENCE, DROP SEQUENCE
-- 인덱스 : CREATE INDEX, DROP INDEX

-- 테이블 수정
-- 컬럼 추가/삭제, 제약조건 추가/삭제
-- 컬럼 자료형 변경 (자료형 크기 변경 포함)
-- 테이블명, 컬럼명, 제약조건 이름 변경
-- DEFAULT 값 변경

-- DEPT_COPY 테이블 수정
DROP TABLE DEPT_COPY;

CREATE TABLE DEPT_COPY
AS
SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- 컬럼 추가
-- 테이블 생성시 컬럼 작성과 동일하게 작성하면 됨
ALTER TABLE DEPT_COPY
ADD ( LNAME VARCHAR2(40) );

-- 확인
SELECT * FROM DEPT_COPY;
DESC DEPT_COPY;

ALTER TABLE DEPT_COPY
ADD ( CNAME  VARCHAR2(30) DEFAULT '한국' );

-- 확인
SELECT * FROM DEPT_COPY;
DESC DEPT_COPY;

-- 제약조건 추가
CREATE TABLE EMP2
AS
SELECT * FROM EMPLOYEE;
-- 서브쿼리를 이용한 테이블 생성시에는
-- 컬러명, 자료형(크기), NOT NULL 제약조건, DATA 만 복사됨
-- 나머지 제약조건들과 DEFAULT 는 복사 안 됨

-- 확인
SELECT * FROM EMP2;
DESC EMP2;

ALTER TABLE EMP2
ADD PRIMARY KEY (EMP_ID);

ALTER TABLE EMP2
ADD CONSTRAINT E2_UNENO UNIQUE (EMP_NO);

-- NOT NULL 은 ADD 로 추가할 수 없음
-- MODIFY 로 NULLABLE 을 NO 상태로 바꾸는 것임
ALTER TABLE EMP2
ADD NOT NULL (HIRE_DATE);  --ERROR

ALTER TABLE EMP2
MODIFY ( HIRE_DATE NOT NULL );

DESC EMP2;

-- 컬럼 자료형 변경
-- 값이 비어 있는 컬럼은 아무 자료형으로나 변경 가능함
-- 값이 기록되어 있는 경우에는 문자형만 문자형끼리 변환 가능함. CHAR <==> VARCHAR2
-- 크기는 같거나 크게 변경할 수 있음
ALTER TABLE EMP2
MODIFY (EMP_ID VARCHAR2(3),
         EMP_NAME CHAR(20) );

DESC EMP2;

-- DEFAULT 값 변경
CREATE TABLE EMP3 (
    EMP_ID  CHAR(3),
    EMP_NAME  VARCHAR2(20),
    ADDR1  VARCHAR2(20)  DEFAULT '서울',
    ADDR2  VARCHAR2(100)
);

INSERT INTO EMP3 VALUES ('A01', '임태희', DEFAULT, '첨당동');
INSERT INTO EMP3 VALUES ('A02', '이병언', DEFAULT, '역삼동');

SELECT * FROM EMP3;

ALTER TABLE EMP3
MODIFY ( ADDR1  DEFAULT '경기' );

INSERT INTO EMP3 VALUES ('B03', '임승우', DEFAULT, '정자동');

SELECT * FROM EMP3;

-- 컬럼 삭제
ALTER TABLE DEPT_COPY
DROP COLUMN CNAME;  -- 컬럼 1개 제거

DESC DEPT_COPY;

ALTER TABLE DEPT_COPY
DROP ( LOC_ID, LNAME );  -- 컬럼 여러 개 제거

DESC DEPT_COPY;

-- 데이터베이스 테이블은 최소 1개의 컬럼을 가지고 있어야 함
-- 컬럼이 없는 테이블은 존재할 수 없음
-- 모든 컬럼을 제거할 수는 없음
ALTER TABLE DEPT_COPY
DROP (DEPT_ID, DEPT_NAME);  -- ERROR

CREATE TABLE TB1 ();  -- ERROR

-- 컬럼 제거시 다른 테이블에서 FOREIGN KEY 제약조건으로 참조되고 있는 컬럼(부모키)은 삭제할 수 없음
-- DELETE OPTION 은 기본값이 RESTRICTED 임. (삭제 불가능)
ALTER TABLE DEPARTMENT
DROP (DEPT_ID);  -- ERROR

-- 제약조건이 설정된 컬럼은 삭제할 수 없음.
CREATE TABLE TB1 (
    TPK  NUMBER  PRIMARY KEY,
    TFK  NUMBER  REFERENCES TB1,
    COL1  NUMBER,
    CHECK (TPK > 0 AND COL1 > 0)
);

ALTER TABLE TB1
DROP (TPK);  -- ERROR

ALTER TABLE TB1
DROP (COL1);  -- ERROR

-- 제약조건도 함께 삭제(CASCADE) 하면 됨
ALTER TABLE TB1
DROP (TPK) CASCADE CONSTRAINTS;

DESC TB1;

ALTER TABLE TB1
DROP COLUMN COL1 CASCADE CONSTRAINTS;

-- 제약조건 삭제
-- 제약조건 적용된 테이블 만들기
CREATE TABLE CONSTRAINT_EMP2 (
    EID CHAR(3) ,
    ENAME VARCHAR2(20) CONSTRAINT NENAME2 NOT NULL, 
    ENO CHAR(14) CONSTRAINT NENO2 NOT NULL , 
    EMAIL VARCHAR2(25) ,
    PHONE VARCHAR2(12),
    HIRE_DATE DATE DEFAULT SYSDATE,
    JID CHAR(2) , 
    SALARY NUMBER,
    BONUS_PCT NUMBER,
    MARRIAGE CHAR(1) DEFAULT 'N' ,
    MID CHAR(3) ,
    DID CHAR(2),
    CONSTRAINT PKEID2 PRIMARY KEY (EID),
    CONSTRAINT UENO2 UNIQUE (ENO),
    CONSTRAINT UEMAIL2 UNIQUE (EMAIL),
    CONSTRAINT FKJID2 FOREIGN KEY (JID) REFERENCES JOB ON DELETE SET NULL,
    CONSTRAINT CHK2 CHECK (MARRIAGE IN ('Y','N')),
    CONSTRAINT FKMID2 FOREIGN KEY (MID) REFERENCES CONSTRAINT_EMP2 ON DELETE SET NULL,
    CONSTRAINT FKDID2 FOREIGN KEY (DID) REFERENCES DEPARTMENT ON DELETE CASCADE
);

-- 제약조건 1개 제거
ALTER TABLE CONSTRAINT_EMP2
DROP CONSTRAINT CHK2;

-- 데이터 딕셔너리로 확인
-- 사용자가 만든 제약조건 조회 : USER_CONSTRAINTS
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CONSTRAINT_EMP2';

-- 제약조건 여러 개 제거
ALTER TABLE CONSTRAINT_EMP2
DROP CONSTRAINT FKJID2
DROP CONSTRAINT FKMID2
DROP CONSTRAINT FKDID2;

-- NOT NULL 제약조건은 삭제가 아니라 변경임
-- NOT NULL 을 NULL 로 바꿈
ALTER TABLE CONSTRAINT_EMP2
MODIFY (ENAME NULL, ENO NULL);

-- USER_CONSTRAINTS 딕셔너리 : 컬럼 정보 없음
-- 컬럼별 제약조건을 관리하는 데이터 딕셔너리 : USER_CONS_COLUMNS
DESC USER_CONS_COLUMNS;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, COLUMN_NAME, 
        DELETE_RULE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
JOIN USER_CONS_COLUMNS USING (CONSTRAINT_NAME, TABLE_NAME)
WHERE TABLE_NAME = 'CONSTRAINT_EMP2';

-- 이름 바꾸기 : 테이블명, 컬럼명, 제약조건 이름
CREATE TABLE TB_EXAM (
    COL1  CHAR(3)  PRIMARY KEY,
    ENAME  VARCHAR2(20),
    FOREIGN KEY (COL1) REFERENCES EMPLOYEE
);

DESC TB_EXAM;

-- 컬럼명 바꾸기
ALTER TABLE TB_EXAM
RENAME COLUMN COL1 TO EMPID;

DESC TB_EXAM;

-- 제약조건 이름 바꾸기
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, COLUMN_NAME, 
        DELETE_RULE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
JOIN USER_CONS_COLUMNS USING (CONSTRAINT_NAME, TABLE_NAME)
WHERE TABLE_NAME = 'TB_EXAM';

ALTER TABLE TB_EXAM
RENAME CONSTRAINT SYS_C007444 TO PK_TBE_EID;

ALTER TABLE TB_EXAM
RENAME CONSTRAINT SYS_C007445 TO FK_TBE_EID;

-- 테이블 이름 바꾸기
ALTER TABLE TB_EXAM RENAME TO TB_SAMPLE1;
-- 또는
RENAME TB_SAMPLE1 TO TB_SAMPLE;

-- 테이블 삭제하기
-- DROP TABLE 테이블명 [CASCADE CONSTRAINTS];
DROP TABLE TB_SAMPLE;

-- 참조되는 테이블(FOREIGN KEY 설정에 대한 부모키가 있는 테이블) 은 제거 못 함
CREATE TABLE DEPT (
    DID CHAR(2) PRIMARY KEY,
    DNAME VARCHAR2(10)
);

CREATE TABLE EMP5 (
    EID  CHAR(3) PRIMARY KEY,
    ENAME VARCHAR2(10),
    DID CHAR(2) REFERENCES DEPT
);

DROP TABLE DEPT;  -- EMP5 에서 참조하고 있음. 제거 못 함
-- DEPT 에 대한 REFERENCES 제약조건을 함께 제거하면 됨
DROP TABLE DEPT CASCADE CONSTRAINTS;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, COLUMN_NAME, 
        DELETE_RULE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
JOIN USER_CONS_COLUMNS USING (CONSTRAINT_NAME, TABLE_NAME)
WHERE TABLE_NAME = 'EMP5';

