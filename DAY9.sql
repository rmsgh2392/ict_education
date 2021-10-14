--쿼리를 사용해서 새 테이블을 만들 수 있다.

--90번 부서의 직원 명단을 EMP_COY90태이블에 저장
CREATE TABLE EMP_COY90 
AS
SELECT * FROM EMPLOYEE
WHERE DEPT_ID LIKE '90'; --NOT NULL 제약조건은 자동으로 복사가 되지만 
                        -- 나머지 제약조건은 복사가 안된다.
SELECT * FROM EMP_COY90;

--전 직원의 사번, 이름, 급여, 부서명, 직급명 을 조회해서
--TABLE_SUBQUERY1 테이블에 저장 처리하는 구문을 작성 실행
CREATE TABLE TABLE_SUBQUERY1
AS
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE LEFT JOIN
      DEPARTMENT USING(DEPT_ID)
LEFT JOIN JOB USING(JOB_ID);

SELECT * FROM TABLE_SUBQUERY1;

--테이블의 구조를 보고싶을 때 사용하는 DESCRIBE 명령어(축약형 : DESC)
--DESCIBE 테이블명; 또는 DESC 테이블명;
--테이블의 구성 정보를 확인할 수 있다. : 컬럼명, 자료형, 제약조건 등등
DESCRIBE EMP_COY90;

CREATE TABLE EMP_COPY
AS
SELECT * 
FROM EMPLOYEE;

DESC EMP_COPY;

--사번, 이름, 급여, 직급명, 부서명, 근무지역명, 소속국가명 조회한 결과 테이블
--EMP_LIST 테이블에 저장함
CREATE TABLE EMP_LIST
AS
SELECT EMP_ID, EMP_NAME, 
        SALARY, JOB_TITLE,
        DEPT_NAME, LOC_DESCRIBE, COUNTRY_NAME
FROM EMPLOYEE LEFT JOIN
      DEPARTMENT USING(DEPT_ID)
LEFT JOIN JOB USING(JOB_ID)
LEFT JOIN LOCATION ON (LOC_ID LIKE LOCATION_ID)
LEFT JOIN COUNTRY USING(COUNTRY_ID);

SELECT * FROM EMP_LIST;
DESC EMP_LIST;

-- 남자 직원들의 정보만 골라내서 저장
CREATE TABLE EMP_MAN
AS
SELECT *
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) LIKE 1; -- IN (1, 3)

SELECT * FROM EMP_MAN;
DESCRIBE EMP_MAN;

CREATE TABLE EMP_FEMAIL
AS
SELECT *
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) LIKE 2; -- IN (2, 4)

SELECT * FROM EMP_FEMAIL;
DESC EMP_FEMAIL;

-- 부서별로 정렬된 직원의 명단을 PART_LIST 테이블에 저장함
-- DEPT_NAME, JOB_TITLE, EMP_NAME, EMP_ID 순으로 구성
--생성된 테이블으 각 컬럼에 주석(COMMENT) 달기
CREATE TABLE PART_LIST
AS
SELECT DEPT_NAME, JOB_TITLE, EMP_NAME, EMP_ID --SELECT절에 나열된 컬럼들이 그대로
FROM EMPLOYEE LEFT JOIN                     --PART_LIST 테이블의 컬럼으로 들어간다.
      DEPARTMENT USING(DEPT_ID)
LEFT JOIN JOB USING(JOB_ID)
ORDER BY 1, 2;

COMMENT ON COLUMN PART_LIST.DEPT_NAME IS '부서명';
COMMENT ON COLUMN PART_LIST.JOB_TITLE IS '직급명';
COMMENT ON COLUMN PART_LIST.EMP_NAME IS '사원이름';
COMMENT ON COLUMN PART_LIST.EMP_ID IS '사번';
SELECT * FROM PART_LIST;

--서브쿼리로 새 테이블을 만들 때, 컬럼명을 바꿀 수 있다.
--주의사항: 서브쿼리 SELECT 절의 컬럼 갯수와 바꿀 컬럼명의 갯수가 일치해야 한다.
/*
CREATE TABLE 테이블명 ( 바꿀 컬럼명 ...) 
AS 서브쿼리;
*/
CREATE TABLE TABLE_SUBQUERY2 (사번, 사원이름, 급여, 부서명, 직급명)
AS
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE LEFT JOIN
      DEPARTMENT USING(DEPT_ID)
LEFT JOIN JOB USING(JOB_ID);
SELECT * FROM TABLE_SUBQUERY2;
DESC TABLE_SUBQUERY2;

--일부 컬럼명만 바꾸고 싶을때
CREATE TABLE PART_LIST2 --(DNAME, JTITLE, ENAME ) -- SELECT 절 항목과 갯수가 일치하지 않음
AS
SELECT DEPT_NAME DNAME, JOB_TITLE JTITLE, EMP_NAME ENAME, EMP_ID 
FROM EMPLOYEE LEFT JOIN                    
      DEPARTMENT USING(DEPT_ID)
LEFT JOIN JOB USING(JOB_ID)
ORDER BY 1, 2;

SELECT * FROM PART_LIST2;
DESC PART_LIST2;

--제약 조건이 설정된 테이블 만들기
CREATE TABLE PHONEBOOK(
    ID CHAR(3) , --기본키 설정 (PK_PBID 저장이름)
    PNAME VARCHAR(20) CONSTRAINT NN_PBNAME NOT NULL, --널 사용못함 (NN_PBNAME 저장이름)
    PHONE VARCHAR2(15) CONSTRAINT NN_PBPHONE NOT NULL, -- NULL 사용못함 중복값 사용못함
    ADDRESS VARCHAR(100) DEFAULT '서울시 구로구', --기본값 지정
    CONSTRAINT PK_PBID PRIMARY KEY ( ID) ,
    CONSTRAINT UN_PBPHONE UNIQUE (PHONE)
);
INSERT INTO PHONEBOOK
VALUES ('A', '카리나', '010-2323-4422', DEFAULT);
INSERT INTO PHONEBOOK
VALUES ('A01', '윈터', '010-1223-4444', '서울시 마포구');
SELECT * FROM PHONEBOOK;

-----------------------------------------------------
--데이터 딕녀너리
DESC USER_CONSTRAINTS; --제약조건 관련 딕셔너리 조회

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE,
        TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME LIKE 'PHONEBOOK';

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE,
        TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME LIKE 'EMPLOYEE';
--딕셔너리에 저장되는 제약조건의 종류(CONSTRAINT_TYPE), 유형
--P : PRIMARY KEY
--U : UNIQUE
--C : CHECK, NOT NULL
--R : REFERENCES / FOREIGN KEY
---------------------------------------------------------------------------------
-- 서브쿼리를 가지고 테이블을 만들 때, 데이터는 저장하지 않고 구조만 복사하고자 한다면
-- 서브쿼리 WHERE 절에 1 = 0 라고 기술하면 데이터는 복사하지 않고 구조만 복사한다.
CREATE TABLE DEPT_COPY
AS
SELECT *
FROM DEPARTMENT
WHERE 1 LIKE 0; --DEPARTMENT 테이블의 구조만 복사

SELECT * FROM DEPT_COPY;
DESC DEPT_COPY;

--서브쿼리로 새 테이블으 만들 때, 컬럼명을 바꾸면서 제약조건도 추가할 수 있다.
--주의사항 : (1) FOREIGN KEY 제약조건을 추가할 수 없다.
--(2) 서브쿼리의 각 컬럼별 결과값과 맞추어서 제약조건을 추가해야한다.
--   기록되어 있는 컬럼의 값을 보고 맞추어 제약조건을 추가해야한다.
CREATE TABLE TABLE_SUBQUERY3 (
    EID PRIMARY KEY, --원래 기본키로 설정되어있기때문에 상관없음
    ENAME ,
    SAL CHECK (SAL > 2000000), --ERROR 서브쿼리 결과값과 맞지 않음(2백만보다 적게 받는 급여가 존재)
    DNAME,
    JTITLE NOT NULL --ERROR : 현재 서브쿼리 결과 값에 NULL이 있음
)
AS
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE LEFT JOIN
      DEPARTMENT USING(DEPT_ID)
LEFT JOIN JOB USING(JOB_ID)
--CHECK (SAL > 2000000) 해결조치
WHERE SALARY > 2000000
-- JTITLE NOT NULL 해결조치
AND JOB_TITLE IS NOT NULL;

SELECT * FROM TABLE_SUBQUERY3;
DESC TABLE_SUBQUERY3;

--데이터 딕셔너리 
--사용자가 생성한 테이블 정보 : USER_TABLES, USER_CATALOGS, USER_OBJECTS
SELECT * FROM USER_TABLES;
--사용자가 만든 제약조건 정보 : USER_CONSTRAINTS, USER_CONS_COLUMNS
SELECT * FROM USER_CONS_COLUMNS;

---NATURAL JOIN
SELECT *
FROM EMPLOYEE NATURAL JOIN
DEPARTMENT; --DEPRATMENT에 PK DEPT_ID를 이용해서 조인한다.

----------------------------------------------------------------------------------------
/* DML (DATA Manipulation Language : 데이터 조작어)
  INSERT, UPDATE, DELETE 문, TRUNCATE 문
  테이블에 데이터를 기록 저장하거나(행 추가), 기록된 데이터를 수정하거나, 행을 삭제하는 구문
  INSERT 문 : 행 추가(값 기록 저장 용도)
  UPDATE 문 : 값을 수정(행 갯수에는 변환이 없다)
  DELETE 문 :  행을 삭제 (행 갯수가 줄어듬), 복구가 가능하다 (ROLLBACK)
  TRUNCATE 문 : 테이블의 모든 행을 삭제 BUT 복구가 안된다.
*/

/*******************
    UPDATE 문
    구문 : UPDATE table_name
          SET column_name(값 수정할 컬럼명) = value (서브쿼리 사용가능, DEFAULT옵션 값 사용가능)
        [ WHERE condition (생략가능) / 서브쿼리 사용가능]; -> 생략하면 모든 행을 수정
    사용형식 : UPDATE 테이블명
              SET 값 수정할 컬럼명 = 수정할 값 ...
              WHERE 컬럼명 연산자 추출값;
    ※주의 사항 :  WHERE 절이 생략되면, 테이블 전체 컬럼의 값이 수정된다.
    참고 : SET 절의 수정할 값 자리에 서브쿼리 사용 가능하며,
          WHERE 절에도 찾을 값 대신 서브쿼리 사용할수 있다.
***********************************************************/
CREATE TABLE COPY
AS
SELECT * FROM DEPARTMENT;

SELECT * FROM COPY;

UPDATE COPY
SET DEPT_NAME = '인사팀'; --WHERE 절이 생략되면 해당 컬럼의 전체 값의 수정된다!!

--방금 사용한 DML 구문은 실행취소 할수 있다.
ROLLBACK; --명령어

-- 부서코드 10의 부서명을 인사팀으로 바꾼다면
UPDATE COPY
SET DEPT_NAME = '인사팀'
WHERE DEPT_ID LIKE '10';

--UPDATE 문의 서브쿼리 사용할 수 있음
--SET 절과 WHERE 절에 사용가능
-- 심하균 직원의 직급코드와 급여를 수정
-- 바꿀 값 성해교 직원의 같은 직급 같은 급여로 수정
SELECT JOB_ID, SALARY --J7, 1900000
FROM EMPLOYEE
WHERE EMP_NAME LIKE '성해교';

SELECT JOB_ID, SALARY
FROM EMPLOYEE -- NULL, 23000000
WHERE EMP_NAME LIKE '심하균';

UPDATE EMPLOYEE
SET JOB_ID = 'J7', SALARY = 1900000
WHERE EMP_NAME LIKE '심하균';

-- 서브쿼리 적용
UPDATE EMPLOYEE
SET JOB_ID = (SELECT JOB_ID FROM EMPLOYEE WHERE EMP_NAME LIKE '성해교'), --단일행
    SALARY = (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME LIKE '성해교')
WHERE EMP_NAME LIKE '심하균';
ROLLBACK;

-- 다중열 서브쿼리로 바꾼다면
UPDATE EMPLOYEE
SET (JOB_ID, SALARY) = (SELECT JOB_ID, SALARY
                       FROM EMPLOYEE
                       WHERE EMP_NAME LIKE '성해교')
WHERE EMP_NAME LIKE '심하균';

--테이블 생성시 컬럼에 DEFAULT 설정을 한 경우에는 INSERT 또는 UPDATE 할시에
--기록할 값 또는 수정할 값 대신에 DEFAULT 키워드를 사용해 DEFAULT값을 사용한다.

-- 수정 전 확인
SELECT EMP_NAME, MARRIAGE
FROM EMPLOYEE
WHERE EMP_ID LIKE '210'; -- 감우섭 , Y 

--수정
UPDATE EMPLOYEE
SET MARRIAGE = DEFAULT
WHERE EMP_ID LIKE '210';

--수정 후확인
SELECT EMP_NAME, MARRIAGE
FROM EMPLOYEE
WHERE EMP_ID LIKE '210';

ROLLBACK;

--UPDATE 문에서 WHERE 절에서의 서브쿼리 사용
UPDATE EMPLOYEE
SET BONUS_PCT = 0.3
WHERE DEPT_ID LIKE (SELECT DEPT_ID
                    FROM DEPARTMENT
                    WHERE DEPT_NAME LIKE '해외영업2팀');
--확인
SELECT EMP_NAME, DEPT_ID, BONUS_PCT
FROM EMPLOYEE
WHERE DEPT_ID LIKE (SELECT DEPT_ID
                    FROM DEPARTMENT
                    WHERE DEPT_NAME LIKE '해외영업2팀');
                    
ROLLBACK;
-----------------------------------------------------------------------------
/* INSERT 문 
  테이블에 새로운 행을 추가할 때 사용한다 : 행 갯수가 늘어남
  테이블에 데이터를 기록 저장하기 위해 사용
  사용 형식 : INSERT INTO 테이블명 (값을 기록할 컬럼명,.......)
             VALUES (나열된 컬럼에 기록할 값...)
  ※ 만약 값을 기록할 컬럼명 나열이 생략되면, 테이블이 가진 모든 컬럼에 값을 기록한다는 의미이다.
  ※ 주의사항 : 나열된 컬럼과 기록할 값의 갯수가 일치해야하며, 순서, 자료형도 일치해야 된다.
      논리적 오류도 주의해야한다 (EMP_NO <주민번호>인데 <= 홍길동 이라고 기록하면 안된다.)
      또한 FK로 제약조건이 설정된 컬럼에 제공하는 값이랑 다른 값을 쓰는 조건에 위배해서도 안된다.
*/
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, SALARY, BONUS_PCT,
                        EMAIL, PHONE, HIRE_DATE, JOB_ID, MARRIAGE, MGR_ID, DEPT_ID)
VALUES ('555', '811225-2345678', '카리나', 200000, 1.5, 'karina@kkk.com', '01099992222',
        '20/03/25', 'J4', DEFAULT, '101', '50'); --ERROR가 안나지만 논리적 오류 
        --이름이 들어갈자리에 주민번호를 넣어 나중에 값을 조회할 때 힘들다.

SELECT * FROM EMPLOYEE WHERE EMP_ID LIKE '555';

ROLLBACK; --INSERT 취소

--INSERT 시 값 대신에 NULL 과 DEFAULT를 사용할수 있다.
--EMP_ID, EMP_NAME, EMP_NO, SALARY, BONUS_PCT,
--EMAIL, PHONE, HIRE_DATE, JOB_ID, MARRIAGE, MGR_ID, DEPT_ID
INSERT INTO EMPLOYEE
VALUES ('456', '오징어', '940501-1032456', 'squid@kkk.com', NULL, NULL, 'J4', NULL, NULL, DEFAULT, '', '');
         
SELECT * FROM EMPLOYEE;

ROLLBACK;

--서브 쿼리를 이용해서 INSERT 할수 있다.
--VALUES 키워드를 사용하지 않는다.
CREATE TABLE EMP(
    EMP_ID CHAR(3),
    EMP_NAME VARCHAR2(20),
    DEPT_NAME VARCHAR2(20)
);

INSERT INTO EMP
(SELECT EMP_ID, EMP_NAME, DEPT_NAME
 FROM EMPLOYEE
 LEFT JOIN DEPARTMENT USING(DEPT_ID) ); 
 
SELECT * FROM EMP;

--DELETE 문
--테이블의 행을 삭제하는 구문
--DELETE FROM 테이블명
--WHERE 삭제를 위한 조건 ※ WHERE절이 생략되면 테이블의 모든 행이 삭제됨

SELECT * FROM COPY;

DELETE FROM COPY;

ROLLBACK; --DELETE 복구

--TRUNCATE 문
--테이블이 가진 모든 행을 삭제한다 BUT 복구가 불가능하다.
TRUNCATE TABLE COPY; 
SELECT * FROM COPY;
ROLLBACK; --복구가 안됨

---------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
/* 테이블 : CREATE TABLE, ALTER TABLE, DROP TABLE
   뷰 : CREATE VIEW, DROP VIEW
   시퀀스 : CREATE SEQUENCE, ALTER SEQUENCE, DROP SEQUENCE
   인덱스 : CREATE INDEX, DROP INDEX
*/
--테이블 수정
--컬럼을 추가 / 삭제, 제약조건을 추가 /삭제
--컬럼 자료형 변경 (자료형 크기도 변경 가능)
--테이블명, 컬럼명, 제약조건 이름 변경
--컬럼에 DEFAULT 값 변경 가능
DROP TABLE DEPT_COPY;

CREATE TABLE DEPT_COPY
AS
SELECT * FROM DEPARTMENT;

--컬럼 추가 
ALTER TABLE DEPT_COPY 
ADD (LNAME VARCHAR2(40) );
--컬럼 추가 확인 
SELECT * FROM DEPT_COPY;
DESC DEPT_COPY;

--컬럼 추가시 DEFAULT값도 정해줄 수 있다.
ALTER TABLE DEPT_COPY
ADD (CNAME VARCHAR2(30) DEFAULT '미국');

--제약조건 추가 
CREATE TABLE EMP2
AS
SELECT * FROM EMPLOYEE;
--서브쿼리를 이용한 테이블 생성시에는
--컬럼명, 자료형(크기), NOT NULL 제약조건, DATA 만 복사가 된다
--나머지 PRIMARY KEY, CHECT, FOREIGN KEY, DEFAULT 값 등 제약조건들은 복사가 되지않는다.
SELECT * FROM EMP2;
DESC EMP2;

ALTER TABLE EMP2
ADD (CONSTRAINT PK_EP_ID PRIMARY KEY (EMP_ID));

ALTER TABLE EMP2
ADD (CONSTRAINT UN_EP_NO UNIQUE (EMP_NO));

-- NOT NULL은 ADD로 추가할수 없다.
-- 상태를 변경하는 의미이므로 MODIFY로 NULLABLE을  NO상태로 바꾸는것
ALTER TABLE EMP2
ADD NOT NULL(HIRE_DATE); --ERROR

ALTER TABLE EMP2
MODIFY (HIRE_DATE NOT NULL); -- NULL 을 -> NOT NULL로 상태 변경
DESC EMP2;

--컬럼에 자료형을 바꾼다면
--값이 비어 있는 컬럼은 아무 자료형으로나 변경 가능하다
--하지만 값이 기록되어 있는 컬럼에 경우에는 문자형만 문자형끼리 변환 가능하다. CHAR <=> VARCHAR2
--크기는 같거나 크게 변경이 가능하다 크기를 줄이는 것은 불가능!!
ALTER TABLE EMP2
MODIFY (EMP_ID VARCHAR2(10));
ALTER TABLE EMP2
MODIFY (EMP_NAME CHAR(20));

--DEFAULT 값도 변경 가능하다
CREATE TABLE EMP3(
    EMP_ID CHAR(3),
    EMP_NAME VARCHAR2(20),
    ADDR1 VARCHAR2(20) DEFAULT '서울',
    ADDR2 VARCHAR2(100)
);
INSERT INTO EMP3
VALUES('A01', '사기꾼', DEFAULT, '압구정동');
INSERT INTO EMP3
VALUES('A02', '마기꾼', DEFAULT, '망원동');
INSERT INTO EMP3
VALUES('A03', '도박꾼', DEFAULT, '현석동');
SELECT * FROM EMP3; --이미 기록 된 DEFAULT값은 바뀌지 않는다. 바꿀려면 UPDATE로 바꿔야한다.

--DEFAULT 값 변경
ALTER TABLE EMP3
MODIFY (ADDR1 DEFAULT '부산'); --설정을 바꾼거지 기록된값을 바꾼것이 아니다.

INSERT INTO EMP3
VALUES('A05', '도굴꾼', DEFAULT, '광안리동');

--컬럼 삭제
ALTER TABLE DEPT_COPY
DROP COLUMN CNAME; --컬럼 1개 제거

DESC DEPT_COPY;

ALTER TABLE DEPT_COPY
DROP (LOC_ID, LNAME); -- 컬럼을 여러개 제거시

--데이터테이블 테이블은 최소 1개의 컬럼을 가지고 있어야한다.
--컬럼이 없는 테이블은 존재할 수 없다.
--모든 컬럼을 제거 할 순 없다.
ALTER TABLE DEPT_COPY
DROP(DEPT_ID, DEPT_NAME); --ERROR 컬럼을 다 제거를 못한다.

CREATE TABLE TB1(); --ERROR 컬럼이 1개도 없는 테이블은 생성도 못한다(최소 1개 필요!)

--※컬럼 제거시 주의사항 
--다른 테이블에서 FOREIGN KEY 제약조건으로 참조되고 있는 컬럼(부모키)은 삭제 할수없다.
--DELETE OPTION 은 기본값이 RESTRICTED 이다.(NO ACTION 삭제 불가능)
ALTER TABLE DEPARTMENT
DROP (DEPT_ID); --부모키는 삭제 못하는 것이 기본!! / 사용하는 테이블에서 삭제해야 가능

--(모든)제약 조건이 설정된 컬럼은 삭제할 수 없다.
CREATE TABLE TB1 (
    TPK NUMBER PRIMARY KEY,
    TFK NUMBER REFERENCES TB1,
    COL1 NUMBER,
    CHECK (TPK > 0 AND COL1 > 0)
);
ALTER TABLE TB1
DROP (TPK);

ALTER TABLE TB1
DROP (COL1);

DESC TB1;
--제약조건도 함꼐 삭제하고 싶으면 CASCADE 를 써준다
ALTER TABLE TB1
DROP (TPK) CASCADE CONSTRAINTS;

ALTER TABLE TB1 
DROP COLUMN COL1 CASCADE CONSTRAINTS;


---------------------------------------------------
CREATE TABLE CONSTRAINT_EMP2(
    EID CHAR(3),
    ENAME VARCHAR2(20) CONSTRAINT NNENAME2 NOT NULL,
    ENO CHAR(14) CONSTRAINT NNENO2 NOT NULL,
    EMAIL VARCHAR2(25),
    PHONE VARCHAR2(12),
    HIRE_DATE DATE DEFAULT SYSDATE,
    JID CHAR(2),
    SALARY NUMBER,
    BONUS_PCT NUMBER,
    MARRIAGE CHAR(1) DEFAULT 'N',
    MID CHAR(3),
    DID CHAR(2),
    CONSTRAINT PKEID2 PRIMARY KEY (EID),
    CONSTRAINT UNENO2 UNIQUE(ENO),
    CONSTRAINT UNEMAIL2 UNIQUE(EMAIL),
    CONSTRAINT FKJID2 FOREIGN KEY (JID) REFERENCES JOB ON DELETE SET NULL,
    CONSTRAINT CHK2 CHECK (MARRIAGE IN ('Y', 'N')),
    CONSTRAINT FKMID2 FOREIGN KEY(MID) REFERENCES CONSTRAINT_EMP2 ON DELETE SET NULL,
    CONSTRAINT FKDID2 FOREIGN KEY(DID) REFERENCES DEPARTMENT ON DELETE CASCADE   
);

--제약조건 1개 제거
ALTER TABLE CONSTRAINT_EMP2
DROP CONSTRAINT CHK2;

--사용자가 만든 제약조건 조회 : USER_CONSTRAINTS
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CONSTRAINT_EMP2';

--제약조건 여러 개 제거
ALTER TABLE CONSTRAINT_EMP2
DROP CONSTRAINT FKJID2
DROP CONSTRAINT FKMID2
DROP CONSTRAINT FKDID2;

--NOT NULL 제약 조건은 삭제가 아니라 변경이다.
--NOT NULL 을 NULL로 바꿈
ALTER TABLE CONSTRAINT_EMP2
MODIFY (ENAME NULL, ENO NULL);

--USER_CONSTRAINTS 딕셔너리 : 컬럼정보 없음
--컬럼별 제약조건을 관리하는 데이터 딕셔너리 : USER_CONS_COLUMNS
DESC USER_CONS_COLUMNS;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, COLUMN_NAME, 
        DELETE_RULE, SEARCH_CONDITION
FROM USER_CONSTRAINTS JOIN
USER_CONS_COLUMNS USING (CONSTRAINT_NAME, TABLE_NAME)
WHERE TABLE_NAME = 'CONSTRAINT_EMP2';

--이름 바꾸기 : 테이블명, 컬럼명, 제약조건이름
CREATE TABLE TB_EXAM(
    COL1 CHAR(3) PRIMARY KEY,
    ENAME VARCHAR2(20),
    FOREIGN KEY (COL1) REFERENCES EMPLOYEE
);
DESC TB_EXAM;
--컬럼명 바꾸기
ALTER TABLE TB_EXAM
RENAME COLUMN COL1 TO EMPID;
ALTER TABLE TB_EXAM
RENAME COLUMN ENAME TO TBNAME;

--제약 조건 이름 바꾸기 
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, COLUMN_NAME, 
        DELETE_RULE, SEARCH_CONDITION
FROM USER_CONSTRAINTS JOIN
USER_CONS_COLUMNS USING (CONSTRAINT_NAME, TABLE_NAME)
WHERE TABLE_NAME = 'TB_EXAM';

ALTER TABLE TB_EXAM
RENAME CONSTRAINT SYS_C008013 TO PK_TBE_EID;
ALTER TABLE TB_EXAM
RENAME CONSTRAINT SYS_C008018 TO PK_TBE_EMPID;
ALTER TABLE TB_EXAM
RENAME CONSTRAINT SYS_C008014 TO FK_TBE_ENAME;
ALTER TABLE TB_EXAM
RENAME CONSTRAINT SYS_C008019 TO FK_TBE_TBNAME;

--테이블 이름 바꾸기
ALTER TABLE TB_EXAM
RENAME TO TB_SAMPLE1;
ALTER TABLE TB_EXAM
RENAME TO SAMPLE_EXAM;
--또는
RENAME TB_SAMPLE1 TO TB_SAMPLE;
RENAME SAMPLE_EXAM TO TB_SAMPLE;
---------------
--테이블 삭제 
--DROP TABLE 테이블명 [필요하다면 제약조건들도 함께 지우기 CASCADE CONSTRAINTS]
DROP TABLE TB_SAMPLE;

--참조되는 테이블 (즉, 부모키가 있는 테이블 FOREIGN KEY 설정) 은 제거 못한다

CREATE TABLE DEPT(
    DID CHAR(2) PRIMARY KEY,
    DNAME VARCHAR(10) --EM5에 참조되고 있다.
);
CREATE TABLE EMP5(
    EID CHAR(3) PRIMARY KEY,
    ENAME VARCHAR2(10) ,
    DID CHAR(2) REFERENCES DEPT
);
DROP TABLE DEPT; --ERROR : EMP5에서 참조하고 있으므로 제거를 못한다.
--> 제거하려면 DEPT에 대한 REFERENCES 제약 조건을 함께 제거해야한다. 
DROP TABLE DEPT CASCADE CONSTRAINTS;
DROP TABLE EMP5;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, COLUMN_NAME, 
        DELETE_RULE, SEARCH_CONDITION
FROM USER_CONSTRAINTS JOIN
USER_CONS_COLUMNS USING (CONSTRAINT_NAME, TABLE_NAME)
WHERE TABLE_NAME = 'EMP5';

SELECT CONSTRAINT_NAME 제약조건이름, CONSTRAINT_TYPE 제약조건종류,
        COLUMN_NAME 컬럼이름, DELETE_RULE 삭제옵션, SEARCH_CONDITION,
FROM USER_CONSTRAINTS JOIN
     USER_CONS_COLUMNS  USING(CONSTRAINT_NAME, TABLE_NAME)
WHERE TABLE_NAME LIKE 'DEPT';

SELECT *
FROM USER_CONSTRAINTS;
