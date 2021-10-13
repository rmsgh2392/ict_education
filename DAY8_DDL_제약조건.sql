-- DAY8_DDL & DML

-- DDL (Data Definition Language : 데이터 정의어)
-- 데이터베이스 객체를 생성/변경/제거에 사용되는 SQL 명령어 제공함
-- 명령어 : CREATE(생성), ALTER(변경), DROP(제거)
-- 데이터베이스 객체 : 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE), 인덱스(INDEX)

-- 태이블 만들기 : CREATE TABLE
/* 작성 형식 : 
CREATE TABLE 테이블명 (
    컬럼명   자료형(크기) [DEFAULT 컬럼에 사용할 기본값],
    컬럼명   자료형(크기) [제약조건종류],
    컬럼명   자료형(크기) [CONSTRAINT 이름  제약조건종류],   -- 컬럼 레벨이라고 함
    컬럼명   자료형(크기) DEFAULT 기본값 CONSTRAINT 저장이름 제약조건종류,
    컬럼명   자료형(크기) [CONSTRAINT 저장이름] 제약조건1 [CONSTRAINT 저장이름] 제약조건2,
    -- 컬럼 구성한 다음에 제약조건만 따로 지정할 수도 있음.  : 테이블 레벨이라고 함
    제약조건종류 (적용할 컬럼명),
    CONSTRAINT 저장할이름 제약조건종류 (적용할 컬럼명)
);
*/

CREATE TABLE TEST ();  -- ERROR : 컬럼이 없는 테이블은 만들 수 없음

CREATE TABLE TEST (
    USERID  VARCHAR2(20),
    USERPWD  VARCHAR2(20),
    USERNAME VARCHAR2(30),  -- 문자형은 크기 지정 반드시 표기
    AGE  NUMBER,  -- 크기지정 생략 가능, 기본 7자리임
    ENROLL_DATE DATE  -- 크기지정 없음
);

CREATE TABLE ORDERS (
    ORDERNO CHAR(4),
    CUSTNO  CHAR(4),
    ORDERDATE  DATE  DEFAULT SYSDATE,
    SHIPDATE  DATE,
    SHIPADDRESS VARCHAR2(40),
    QUANTITY  NUMBER
);

-- 컬럼에 설명 달기 : COMMENT ON COLUMN 구문 사용함
-- COMMENT ON COLUMN 테이블명.컬럼명 IS '설명';
COMMENT ON COLUMN ORDERS.ORDERNO IS '주문번호';
COMMENT ON COLUMN ORDERS.CUSTNO IS '고객번호';
COMMENT ON COLUMN ORDERS.ORDERDATE IS '주문일자';
COMMENT ON COLUMN ORDERS.SHIPDATE IS '배송일자';
COMMENT ON COLUMN ORDERS.SHIPADDRESS IS '배송주소';
COMMENT ON COLUMN ORDERS.QUANTITY IS '주문수량';

-- *****************************************************************
-- 무결성 제약조건들 (CONSTRAINTS)
-- 테이블에 데이터(값)가 기록(INSERT) | 변경(UPDATE)될 때 올바른 값이 기록되도록 검사하는 기능
-- 테이블의 저장된 데이터의 신뢰성을 높이기 위한 기술임 : 데이터 무결성
-- 제약조건 종류 : NOT NULL, UNIQUE, PRIMARY KEY, CHECK, FOREIGN KEY
-- 이름으로 관리됨 : CONSTRAINT 저장할이름 제약조건종류 -- 컬럼레벨
-- 이름으로 관리됨 : CONSTRAINT 저장할이름 제약조건종류 (적용할 컬럼명)  -- 테이블레벨
-- 이름 지정이 생략되면 자동으로 이름이 지정됨 : SYS_C******** 의 형식임
-- 테이블레벨에서, 여러 개의 컬럼을 묶어서 하나의 제약조건을 지정할 수도 있음 (복합키 라고 함)
--      CONSTRAINT 저장할이름 제약조건종류 (컬럼명, 컬럼명, 컬럼명, ......)  -- 테이블레벨

-- DML (Data Manipulation Language : 데이터 조작어)
-- 명령어 : INSERT, UPDATE, DELETE

-- INSERT 문 : 새로운 행을 추가함
/* 사용형식 : 
INSERT INTO 테이블명 [(컬럼명, 컬럼명, ....)]
VALUES (기록할 값, 기록할 값, ....);
주의사항 : 컬럼 나열 순서에 맞춰서 값을 기술해야 함. 나열된 컬럼과 기술할 값의 자료형과 갯수가 일치해야 함
참고 : 테이블의 전체 컬럼에 값을 기록할 때는 컬럼명 나열을 생략할 수도 있음
*/

-- TEST 테이블에 값 기록
SELECT * FROM TEST;
SELECT COUNT(*) FROM TEST;

INSERT INTO TEST (USERID, USERPWD, USERNAME, AGE, ENROLL_DATE)
VALUES ('user007', 'pass007', '홍길동', 27, SYSDATE);

INSERT INTO TEST
VALUES ('user008', 'pass008', '김철수', 32, TO_DATE('20201225', 'RRRRMMDD'));

-- 제약조건(CONSTRAINT) : NOT NULL ----------------------------------------------------------
-- 컬럼에 반드시 값을 기록해야 될 때 적용함 (필수 입력 항목인 컬럼)
-- 컬럼에 NULL(빈 칸) 사용 못 한다는 의미임.
-- 컬럼레벨에서만 설정할 수 있음. (테이블레벨에서 설정 못 함)

CREATE TABLE TESTNN (
    NNID  NUMBER(5)  NOT NULL,   -- 컬럼레벨, 제약조건 이름 없음 (SYS_C.......)
    NN_NAME  VARCHAR2(20)
);

INSERT INTO TESTNN (NNID, NN_NAME)
VALUES (1, '오라클');

INSERT INTO TESTNN
VALUES (NULL, '자바');  -- NOT NULL 제약조건 위배됨. 에러

INSERT INTO TESTNN (NN_NAME)  -- 제외된 컬럼은 NULL 이 됨
VALUES ('ORACLE');  -- 행 추가, NOT NULL 제약조건 위배됨, 에러

INSERT INTO TESTNN
VALUES (2, NULL);   -- 행 추가

INSERT INTO TESTNN (NNID)
VALUES (3);  -- 행 추가

SELECT * FROM TESTNN;

-- NOT NULL : 테이블레벨 설정 확인
CREATE TABLE TESTNN2 (
    NN_ID  NUMBER(5),
    NN_NAME VARCHAR2(20),
    -- 테이블레벨
    CONSTRAINT NN_TN2_ID NOT NULL (NN_ID)  -- 에러
);  -- NOT NULL 은 테이블레벨에서 설정 못 함

--  해결
CREATE TABLE TESTNN2 (
    NN_ID  NUMBER(5) CONSTRAINT NN_TN2_ID NOT NULL,
    NN_NAME VARCHAR2(20)
);

-- 제약조건 : UNIQUE ----------------------------------------------------------------------------
-- 컬럼의 중복값(같은 값 두번 기록)을 막는 제약조건임.
-- 중복 기록을 막는 검사 기능
-- 컬럼레벨, 테이블레벨 둘 다 사용 가능
-- NULL 사용할 수 있음

CREATE TABLE TESTUN (
    UN_ID  CHAR(3)  UNIQUE,
    UN_NAME VARCHAR2(10)  NOT NULL
);

INSERT INTO TESTUN VALUES ('AAA', '오라클');
INSERT INTO TESTUN VALUES ('AAA', '자바');  -- 기록되어 있는 값 중복 기록 : 에러
INSERT INTO TESTUN VALUES (NULL, '자바');

SELECT * FROM TESTUN;

-- 테이블레벨에서 설정
CREATE TABLE TESTUN2 (
    UN_ID  CHAR(3),
    UN_NAME VARCHAR2(10)  CONSTRAINT NN_TUN2_NAME NOT NULL,
    -- 테이블레벨
    --UNIQUE (UN_ID)
    CONSTRAINT UN_TUN2_ID UNIQUE (UN_ID)
);

-- UNIQUE 제약조건은 테이블레벨에서 복합키(여러 개의 컬럼을 묶어서)로 설정할 수도 있음
CREATE TABLE TESTUN3 (
    UN_ID CHAR(3),
    UN_NAME VARCHAR2(10)  NOT NULL,
    UN_CODE  CHAR(2),
    CONSTRAINT UN_TUN3_COMP  UNIQUE (UN_ID, UN_NAME)  -- 복합키
);
-- 여러 개의 컬럼을 묶어서 하나의 제약조건을 설정한 경우는,
-- 묶여진 컬럼값들을 하나의 단어로 보고 중복을 판단함.

INSERT INTO TESTUN3 VALUES ('100', '오라클', '01');
INSERT INTO TESTUN3 VALUES ('200', '오라클', '01');
-- 중복 판단 : '100 오라클'  != '200 오라클'
INSERT INTO TESTUN3 VALUES ('200', '오라클', '02'); -- 에러
-- 중복 판단 : '200 오라클' = '200 오라클'

-- UNIQUE 복합키에 대한 NULL 적용
INSERT INTO TESTUN3 VALUES (NULL, '오라클', '03');
INSERT INTO TESTUN3 VALUES ('200', NULL, '03');  -- NOT NULL 제약조건 위배됨

SELECT * FROM TESTUN3;

-- 제약조건 : PRIMARY KEY ---------------------------------------------------------------------
-- 기본키 라고 함. (데이터베이스 정규화 과정에서는 IDENTIFIER (식별자)를 말함)
-- 테이블에서 한 행의 정보를 찾기 위해 이용하는 컬럼을 의미함
-- NOT NULL + UNIQUE
-- 한 테이블에 한 번만 사용할 수 있음.

CREATE TABLE TESTPK (
    PID  NUMBER  PRIMARY KEY,
    PNAME  VARCHAR2(15)  NOT NULL,
    PDATE  DATE
);

INSERT INTO TESTPK VALUES (1, '홍길동', '15/03/12');
INSERT INTO TESTPK VALUES (2, '김유신', TO_DATE('17/05/10'));
INSERT INTO TESTPK VALUES (NULL, '이순신', SYSDATE);  -- ERROR : NULL
INSERT INTO TESTPK VALUES (2, '이순신', SYSDATE);  -- ERROR : UNIQUE(중복)

SELECT * FROM TESTPK;

-- 테이블당 1번만 설정
CREATE TABLE TESTPK2 (
    PID NUMBER CONSTRAINT PK_TP2_ID  PRIMARY KEY,
    PNAME VARCHAR2(15)  PRIMARY KEY
);  -- ERROR

-- PRIMARY KEY 제약조건은 컬럼레벨, 테이블레벨 둘 다 설정 가능함
CREATE TABLE TESTPK2 (
    PID NUMBER  CONSTRAINT PK_TP2_ID  PRIMARY KEY,  -- 컬럼레벨
    PNAME  VARCHAR2(15),
    PDATE  DATE
);

CREATE TABLE TESTPK3 (
    PID  NUMBER,
    PNAME  VARCHAR2(15),
    PDATE  DATE,
    -- 테이블레벨
    CONSTRAINT PK_TPK3_ID  PRIMARY KEY (PID)
);

-- PRIMARY KEY 도 복합키로 설정할 수 있음.
-- 테이블레벨에서 복합키 설정함
CREATE TABLE TESTPK4 (
    PID   NUMBER,
    PNAME VARCHAR2(15),
    PDATE  DATE,
    CONSTRAINT PK_TPK4_COMP  PRIMARY KEY (PID, PNAME)
);

INSERT INTO TESTPK4 VALUES ('100', '오라클', SYSDATE);
-- 복합키는 값들을 한 개의 단어로 생각하고 중복을 판단하면 됨
INSERT INTO TESTPK4 VALUES ('100', '오라클', SYSDATE);  -- '100 오라클' = '100 오라클' : 에러
-- NULL 사용 못 함
INSERT INTO TESTPK4 VALUES (NULL, '자바', SYSDATE);  -- ERROR
INSERT INTO TESTPK4 VALUES ('200', NULL, SYSDATE);  -- ERROR

SELECT * FROM TESTPK4;

-- 제약조건 : CHECK --------------------------------------------------------------------------
-- 컬럼에 기록되는 값에 조건을 설정할 때 사용함
-- 컬럼레벨, 테이블레벨 둘 다 설정 가능함
-- [CONSTRAINT 저장이름 ] CHECK (컬럼명 연산자 제한값)
-- 제한값은 반드시 리터럴(값)만 사용할 수 있음. 함수 사용 못 함 (사용될 때마다 바뀌는 값은 사용 못 함)

CREATE TABLE TESTCHK (
    C_NAME  VARCHAR2(15)  CONSTRAINT NN_TCK_NAME  NOT NULL,
    C_PRICE  NUMBER(5)  CHECK (C_PRICE BETWEEN 1 AND 99999),
    C_LEVEL  CHAR(1)  CHECK (C_LEVEL IN ('A', 'B', 'C'))
);

INSERT INTO TESTCHK VALUES ('갤럭시21', 6500, 'A');
INSERT INTO TESTCHK VALUES ('LG G7', 1250000, 'B');  -- ERROR : C_PRICE 값 범위 초과
INSERT INTO TESTCHK VALUES ('LG G7', 0, 'B'); -- ERROR : C_PRICE 값 범위 초과
INSERT INTO TESTCHK VALUES ('LG G7', 7500, 'D');  -- ERROR : C_LEVEL 
INSERT INTO TESTCHK VALUES ('LG G7', 7500, 'a');  -- ERROR : C_LEVEL 

SELECT * FROM TESTCHK;

-- 제한값 지정, AND, OR 사용
CREATE TABLE TESTCHK2 (
    C_NAME  VARCHAR2(15 CHAR) PRIMARY KEY,
    C_PRICE  NUMBER(5)  CHECK (C_PRICE >= 1 AND C_PRICE <= 99999),
    C_LEVEL  CHAR(1)  CHECK (C_LEVEL = 'A' OR C_LEVEL = 'B' OR C_LEVEL = 'C'),
    --C_DATE   DATE  CHECK (C_DATE < SYSDATE)  -- ERROR : 제한값이 바뀌는 함수는 사용 못 함
    C_DATE  DATE CHECK (C_DATE > TO_DATE('16/01/01', 'YYYY/MM/DD'))
);

-- 제약조건 :  FOREIGN KEY (외래키 | 참조키) ------------------------------------------------------------------------
-- 다른(참조) 테이블이 제공하는 값만 기록에 사용할 수 있는 컬럼 지정시 사용함
-- FOREIGN KEY 제약조건 설정으로 테이블 사이에 관계(RELATIONAL)가 형성됨
-- 컬럼레벨, 테이블레벨 둘 다 설정 가능함
-- 컬럼레벨 : 
-- 컬럼명 자료형(크기) [CONSTRAINT 저장이름] REFERENCES 값제공테이블명 [(값제공컬럼명)]
-- 테이블레벨 : 
-- [CONSTRAINT 저장이름] FOREIGN KEY (적용할 컬럼명) REFERENCES 값제공테이블명 [(값제공컬럼명)]
-- (값제공컬럼명) 생략하면, 참조테이블(값제공테이블을 말함)의 기본키(PRIMARY KEY) 컬럼을 사용한다는 의미임
-- REFERENCES 할 컬럼(값제공컬럼)은 반드시 PRIMARY KEY | UNIQUE 제약조건이 설정되어야 함.
-- 제약사항의 의미 : 제공되는 값만 기록에 사용할 수 있음. 제공되지 않는 값을 기록하면 에러남
-- NULL 은 사용할 수 있음

CREATE TABLE TESTFK (
    EMP_ID  CHAR(3) REFERENCES EMPLOYEE,
    DEPT_ID CHAR(2) CONSTRAINT FK_TFK_DID REFERENCES DEPARTMENT (DEPT_ID),
    JOB_ID  CHAR(2),
    -- 테이블레벨
    CONSTRAINT FK_TFK_JID FOREIGN KEY (JOB_ID) REFERENCES JOB (JOB_ID)
);

INSERT INTO TESTFK VALUES ('100', '90', 'J4');
INSERT INTO TESTFK VALUES ('333', '90', 'J4');  -- ERROR, EMP_ID
INSERT INTO TESTFK VALUES ('210', '70', 'J4');  -- ERROR, DEPT_ID
INSERT INTO TESTFK VALUES ('210', '80', 'j4');  -- ERROR, JOB_ID
INSERT INTO TESTFK VALUES (NULL, '80', 'J4');
INSERT INTO TESTFK VALUES ('124', NULL, 'J7');
INSERT INTO TESTFK VALUES ('124', '30', NULL);
INSERT INTO TESTFK VALUES (NULL, NULL, NULL);

SELECT * FROM TESTFK;

-- 참조테이블의 참조컬럼은 반드시 PK 이거나 UNIQUE 설정이 되어야 함
CREATE TABLE TEST_NOPK (
    ID  CHAR(3),
    NAME  VARCHAR2(15)
);

CREATE TABLE TESTFK2 (
    FID  CHAR(3)  REFERENCES TEST_NOPK,  -- 참조컬럼 생략되면 자동으로 PK 컬럼이 참조됨 : ERROR
    FNAME  VARCHAR2(15)
);

CREATE TABLE TEST_NOPK2 (
    ID  CHAR(3) PRIMARY KEY,
    NAME  VARCHAR2(15)
);

CREATE TABLE TESTFK2 (
    FID  CHAR(3)  REFERENCES TEST_NOPK2,  
    FNAME  VARCHAR2(15)
);

CREATE TABLE TEST_NOPK3 (
    ID  CHAR(3) PRIMARY KEY,
    NAME  VARCHAR2(15) UNIQUE
);

CREATE TABLE TESTFK3 (
    FID  CHAR(3)  REFERENCES TEST_NOPK3,  -- PK 컬럼 자동 참조
    FNAME  VARCHAR2(15) REFERENCES TEST_NOPK3 (NAME)
);

-- 실습
CREATE TABLE CONSTRAINT_EMP (
    EID CHAR(3) CONSTRAINT PKEID PRIMARY KEY,
    ENAME VARCHAR2(20) CONSTRAINT NENAME NOT NULL,
    ENO CHAR(14) CONSTRAINT NENO NOT NULL CONSTRAINT UENO UNIQUE,
    EMAIL VARCHAR2(25) CONSTRAINT UEMAIL UNIQUE,
    PHONE VARCHAR2(12),
    HIRE_DATE DATE DEFAULT SYSDATE,
    JID CHAR(2) CONSTRAINT FKJID REFERENCES JOB ON DELETE SET NULL,
    SALARY NUMBER,
    BONUS_PCT NUMBER,
    MARRIAGE CHAR(1) DEFAULT 'N' CONSTRAINT CHK CHECK (MARRIAGE IN ('Y','N')),
    MID CHAR(3) CONSTRAINT FKMID REFERENCES CONSTRAINT_EMP ON DELETE SET NULL,
    DID CHAR(2),
    CONSTRAINT FKDID FOREIGN KEY (DID) REFERENCES DEPARTMENT ON DELETE CASCADE
);

-- 기본적으로 FOREIGN KEY 제약조건이 설정되면, 값을 제공하는 참조테이블의 컬럼값은 함부로 삭제 못 함
-- 참조컬럼(부모키)의 값이 자식레코드 쪽에서 사용되고 있으면 삭제 못 함
-- 즉, EMPLOYEE.DEPT_ID 에 기록된 '90' 부서코드가 있으면, DEPARTMENT.DEPT_ID 의 '90' 부서는 삭제 못한다는 의미임.

-- DML : DELETE 문 
-- 행 삭제 구문임 (행 갯수가 줄어듦)
-- 사용형식 : DELETE FROM 테이블명 WHERE 컬럼명 비교연산자 삭제할조건값;
-- 조건에 해당되는 값이 있는 행을 삭제하라는 의미임.

DELETE FROM DEPARTMENT
WHERE DEPT_ID = '90';  -- 삭제 불가능, ERROR

-- 필요시에 FOREIGN KEY 제약조건 설정시에 미리 삭제 옵션(삭제 방식)을 추가할 수 있음
-- 부모키를 삭제할 수 있게 됨
-- ON DELETE SET NULL : 부모키가 삭제되면, 자식레코드(값 사용컬럼)의 값을 NULL 로 바꿈
-- ON DELETE CASCADE : 부모키가 삭제되면, 자식레코드가 있는 행을 같이 삭제함
-- ON DELETE RESTRICTED : 기본값임. 삭제 불가능을 의미함

CREATE TABLE PRODUCT_STATE (
    PSTATE  CHAR(1)  PRIMARY KEY,
    PCOMMENT VARCHAR2(10)
);

INSERT INTO PRODUCT_STATE VALUES ('A', '최고급');
INSERT INTO PRODUCT_STATE VALUES ('B', '보통');
INSERT INTO PRODUCT_STATE VALUES ('C', '저급');

SELECT * FROM PRODUCT_STATE;

-- 자식레코드가 있는 테이블
CREATE TABLE PRODUCT (
    PNAME  VARCHAR2(20)  PRIMARY KEY,
    PRICE  NUMBER  CHECK (PRICE > 0),
    PSTATE  CHAR(1)  REFERENCES PRODUCT_STATE ON DELETE SET NULL
);

INSERT INTO PRODUCT VALUES ('갤럭시노트', 1250000, 'A');
INSERT INTO PRODUCT VALUES ('G9', 650000, 'C');
INSERT INTO PRODUCT VALUES ('갤럭시S21', 1000000, 'B');

SELECT * FROM PRODUCT;

SELECT * 
FROM PRODUCT
LEFT JOIN PRODUCT_STATE USING (PSTATE);

-- ON DELETE SET NULL : 부모키가 삭제되면 자식레코드 값을 NULL 로 바꿈
DELETE FROM PRODUCT_STATE
WHERE PSTATE = 'C';

SELECT * FROM PRODUCT_STATE;  -- 부모키
SELECT * FROM PRODUCT; -- 자식레코드

-- 삭제 취소 : ROLLBACK (TCL : Transaction Controll Language)
ROLLBACK;

-- ON DELETE CASCADE : 부모키와 자식레코드 함께 삭제
CREATE TABLE PRODUCT2 (
    PNAME  VARCHAR2(20)  PRIMARY KEY,
    PRICE  NUMBER  CHECK (PRICE > 0),
    PSTATE  CHAR(1)  REFERENCES PRODUCT_STATE ON DELETE CASCADE
);

INSERT INTO PRODUCT2 VALUES ('갤럭시노트', 1250000, 'A');
INSERT INTO PRODUCT2 VALUES ('G9', 650000, 'C');
INSERT INTO PRODUCT2 VALUES ('갤럭시S21', 1000000, 'B');

SELECT * FROM PRODUCT2;

-- ON DELETE CASCADE
DELETE FROM PRODUCT_STATE
WHERE PSTATE = 'A';

SELECT * FROM PRODUCT_STATE;  -- 부모키 삭제 확인
SELECT * FROM PRODUCT2; -- 자식레코드 행 함께 삭제 확인

-- 부모키(값제공컬럼)가 복합키(여러 개의 컬럼을 하나로 묶은 것)이면
-- FOREIGN KEY 제약조건 설정하는 컬럼(자식레코드)도 같은 복합키여야 함
-- 복합키를 단일키로 사용 못 함, 단일키를 FOREIGN KEY 제약조건에서 복합키로 만들 수도 없음

CREATE TABLE TEST_COMP (
    ID  NUMBER,
    NAME  VARCHAR2(10),
    PRIMARY KEY (ID, NAME)  -- 복합키
);

INSERT INTO TEST_COMP VALUES (100, 'ORACLE');
INSERT INTO TEST_COMP VALUES (200, 'ORACLE');
INSERT INTO TEST_COMP VALUES (200, 'JAVA');

SELECT * FROM TEST_COMP;

CREATE TABLE TESTFK4 (
    FID  NUMBER,
    FNAME  VARCHAR2(10),
    --FOREIGN KEY (FID) REFERENCES TEST_COMP (ID)  -- 복합키를 따로 단일키로 사용 못 함
    FOREIGN KEY (FID, FNAME) REFERENCES TEST_COMP -- 복합키는 복합키로 설정해야 함
);
