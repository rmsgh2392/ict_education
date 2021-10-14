--DDL & DML--
/*DDL( DATABASE Definition Language  : 데이터 정의어)
  데이터베이스 객체를 생성/변경/제거 에 사용되는 SQL 명령어를 제공한다.
  명령어 : CREATE (객체 생성시), ALTER( 객체 변경시), DROP( 객체 제거시)
  데이터베이스 객체 : 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE), 인덱스(INDEX)...(나머지 프로시저, 트리거가 있음)
*/

-- 테이블 생성
-- 작성형식 : CREATE TABLE 테이블 명(. . . . .);
-- CREATE TABLE 테이블 명(
--    컬럼명  자료형(크기) [DEFAULT 컬럼에 사용할 기본 값을 적어줄수 있다 (생략가능)] ,
--    컬럼명  자료형(크기) [제약조건 종류를 명시],
--    컬럼명  자료형(크기) [CONSTRAINT 이름 제약조건종류], -- 컬럼레벨
--    컬럼명  자료형(크기) DEFAULT 기본값 CONSTRAINT 저장이름 제약조건종류(다 적을 수 있음),
--    컬럼명  자료형(크기) [CONSTRAINT 저장이름] 제약조건1 [CONSTRAINT 저장이름] 제약조건2 여러개 가능 <= 컬럼레벨 제약조건,
--  -> 컬럼을 다 구성한 다음에 제약조건만 따로 지정할 수 있다. : 테이블 레벨 제약조건
--  -> 제약조건종류 (적용할 컬럼명)
--  -> CONSTRAINT 저장할이름 제약조건종류 (적용할 컬럼명)
-- );
--
CREATE TABLE TEST(); --ERROR : 최소 1개 이상의 컬럼을 만들어줘야 테이블을 만들 수 있다.

CREATE TABLE TEST(
    USER_ID VARCHAR2(20) PRIMARY KEY,
    USER_PWD VARCHAR2(20),
    USER_NAME VARCHAR2(30), -- 문자형은 크기 지정 반드시 표기
    AGE NUMBER,       --숫자는 크기 지정 생략 가능하며 기본이 7자리
    ENROLL_DATE DATE  --데이트형 날짜형은 따로 크기지정하지 않는다
);
CREATE TABLE TEMP(
    TEMP_ID VARCHAR2(20),
    TEMP_PWD VARCHAR(20),
    TEMP_NAME VARCHAR(30),
    AGE NUMBER, 
    ENROLL_DATE DATE
);
COMMENT ON COLUMN TEMP.TEMP_ID IS '아이디';
COMMENT ON COLUMN TEMP.TEMP_PWD IS '비밀번호';
COMMENT ON COLUMN TEMP.TEMP_NAME IS '이름';
COMMENT ON COLUMN TEMP.AGE IS '나이';
COMMENT ON COLUMN TEMP.ENROLL_DATE IS '가입한날짜';

CREATE TABLE ORDERS(
    ORDER_NO CHAR(4),
    CUST_NO CHAR(4),
    ORDER_DATE DATE DEFAULT SYSDATE,
    DELIVER_DATE DATE,
    DELIVER_ADDRESS VARCHAR2(40),
    QUANTITY NUMBER
);
--컬럼에 설명 달기  : COMMENT ON COLUMN 구문 사용
-- COMMENT ON COLUMN 테이블명.컬럼명 IS '설명';
COMMENT ON COLUMN ORDERS.ORDER_NO IS '주문번호';
COMMENT ON COLUMN ORDERS.CUST_NO IS '고객번호';
COMMENT ON COLUMN ORDERS.ORDER_DATE IS '주문날짜';
COMMENT ON COLUMN ORDERS.DELIVER_DATE IS '배송날짜';
COMMENT ON COLUMN ORDERS.DELIVER_ADDRESS IS '배송주소';
COMMENT ON COLUMN ORDERS.QUANTITY IS '주문수량';


/*무결성 제약조건들 (CONSTRAINTS)
-- 테이블에 데이터(값)가 기록(INSET) | 변경 (UPDATE)될 때 올바른 값이 기록되도록 검사하는 기능
-- 테이블의 지정된 데이터의 신뢰성을 높이기 위한 기술 즉 데이터의 무결성을 확보
-- 이름으로 관리된다 : CONSTRAINT 저장할 이름 제약조건 종류 --컬럼레벨
--                   CONSTRAINT 저장할 이름 제약조건 종류 (적용할 컬럼명) -- 테이블 레벨
-- 만약 이름이 생략되면 자동으로 이름이 지정된다 SYS_C*******의 형식이다.
-- 테이블레벨에서 여러 개의 컬럼들을 묶어서 하나의 제약조건을 지정 할 수도 있다. 이것을 복합키 라고한다.
-- CONSTRAINT 저장할 이름 제약조건 종류 (적용할 컬럼명, 컬럼명, 컬럼명,......) --테이블레벨(복합키)
-- 제약조건의 종류는 5가지를 제공한다.
-- 1. NOT NULL (ONLY 컬럼레벨)
-- 2. UNIQUE (컬럼레벨, 테이블레벨)
-- 3. PRIMARY KEY (컬럼레벨, 테이블레벨)
-- 4. CHECK (컬럼레벨, 테이블레벨)
-- 5. FOREIGN KEY (컬럼레벨, 테이블레벨)
*/
-----------------------------------------------------
--DML(Data Manipulation Language : 데이터 조작어)
--명령어 : INSERT, DELETE, UPDATE

--INSERT 문 사용 형식 
--INSERT INTO 테이블명 [(컬럼명, 컬럼명 ....)]
--VALUES (기록할 값, 기록할 값....)
--주의사항 : 컬럼 나열 순서에 맞춰 값을 기록해야하며 나열된 컬럼과 기술할 값의 자료형과 갯수가 일치해야한다.
--참고 : 테이브의 전체 컬럼에 값을 기록할 때에는 컬럼명 나열을 생략할 수 있다.
SELECT * FROM TEST;
SELECT COUNT(*) FROM TEST;

INSERT INTO TEST 
VALUES('rmsgh2392', '1234', '루트', 24, '20120423');

INSERT INTO TEST (USER_ID, USER_PWD)
VALUES('google02', '1234');

INSERT INTO TEST (USER_ID, USER_PWD, USER_NAME, AGE, ENROLL_DATE)
VALUES('google01', 'google444', '카리나', 20, SYSDATE);

INSERT INTO TEST (USER_ID, USER_PWD, USER_NAME, AGE, ENROLL_DATE)
VALUES('google03', 'google444', '윈터', 20, TO_DATE('20201225', 'RRRRMMDD'));

--------------------------------------------------------------------------
--제약조건 : NOT NULL 
--컬럼에 반드시 값을 기록해야 될 때 적용한다.(필수 입력 항목인 컬럼)
--컬럼에 NULL(빈 칸)을 사용 못한다.
--컬럼레벨에서만 설정 가능!! ( 테이블 레벨에서 설정하면 ERROR남)

CREATE TABLE TESTNN(
    NN_ID NUMBER(5) CONSTRAINT NNID NOT NULL, --컬럼레벨, 제약조건 이름이 없으면(SYS_C*****)
    NN_NAME VARCHAR(20)   
);
INSERT INTO TESTNN(NN_ID, NN_NAME)
VALUES(1, 'JAVA');

INSERT INTO TESTNN
VALUES(NULL, 'JAVASCRIPT'); -- 기록이 안된다. NOT NULL 제약조건이 설정되어 있기 떄문에 제약조건을 위배해 에러

INSERT INTO TESTNN (NN_NAME)
VALUES('자바스크립트'); --INSERT는 행을 추가하기 때문에 제외된 컬럼은 NULL이 됨
                      --NN_ID에  NULL값이 기록되기 때문에 NOT NULL 제약조건 위배됨
INSERT INTO TESTNN
VALUES (2, NULL); -- NN_NAME에는 NOT NULL 제약조건이 설정되어있지 않기 떄문에 NULL값을 기록할수 있다.

INSERT INTO TESTNN(NN_ID)
VALUES (1);

SELECT * FROM TESTNN;

--NOT NULL : 테이블 레벨 설정 확인--
CREATE TABLE TESTNN2(
    NN_ID NUMBER(5),
    NN_NAME VARCHAR(20),
    CONSTRAINT NN_TN2_ID NOT NULL (NN_ID) --테이블 레벨에서 NOT NULL
); --> ERROR :  그 이유는 테이블 레벨에서는 NOT NULL을 설정못한다!

--해결방법 : 컬럼레벨에서 설정해주자
CREATE TABLE TESTNN2(
    NN_ID NUMBER(5) CONSTRAINT NN_TN2_ID NOT NULL,
    NN_NAME VARCHAR(20)
); 

-- 제약조건 : UNIQUE --
-- 컬럼의 중복 값(같은 값을 두번 기록)을 막는 제약조건이다.
-- 중복 기록을 막는 검사 기능
-- 컬럼레벨, 테이블 레벨 둘 다 사용 가능하다.
-- NULL 사용가능 

CREATE TABLE TESTUN(
    UN_ID CHAR(3) UNIQUE, --컬럼레벨
    UN_PWD VARCHAR(20),
    UN_NAME VARCHAR2(10) NOT NULL
);
INSERT INTO TESTUN
VALUES ('AAA', '123124', 'HOOK');
INSERT INTO TESTUN
VALUES ('BBB', '123124', 'YGX');
INSERT INTO TESTUN
VALUES ('AAA', '123124', 'LACHICA'); --기록되어 있는 값 중복 기록(UN_ID) : ERROR
INSERT INTO TESTUN
VALUES (NULL, '123124','HOLYBANG'); --UNIQUE 제약조건에도 NULL 값 기록 가능

SELECT * FROM TESTUN;

CREATE TABLE TESTUN2(
    UN_ID CHAR(3) ,
    UN_PWD VARCHAR(20),
    UN_NAME VARCHAR2(10) CONSTRAINT NN_TU2_NAME NOT NULL,
    --테이블레벨 제약조건 설정
    CONSTRAINT UNI_TU2_ID UNIQUE(UN_ID)
    --이름을 안지어주면 UNIQUE(UN_ID) 
);
--UNIQUE 제약조건은 테이블 레벨 설정에서 복합키로 설정 할 수 있다.
--복합키는 여러개의 컬럼을 묶어서 설정
--묶여진 컬럼값들을 하나의 단어로 보고 중복을 판단한다.!!!
--UNIQUE(UN_ID, UN_NAME)
CREATE TABLE TESTUN3(
    UN_ID CHAR(3) ,
    UN_NAME VARCHAR2(10) NOT NULL, -- UN_NAME은 제약조건이 NOT NULL + UNIQUE 조건이 설정됨
    UN_CODE CHAR(2),
    --테이블레벨 제약조건 설정(복합키)
    CONSTRAINT UNI_TU3_COMP UNIQUE (UN_ID, UN_NAME) --복합키
    -- 두개를 묶어서 하나의 제약조건을 걸겠다 
);

INSERT INTO TESTUN3(UN_ID, UN_NAME)
VALUES ('AA', 'JAVA'); 
INSERT INTO TESTUN3(UN_ID, UN_NAME)
VALUES ('BB', 'JAVA'); --복합키로 UNIQUE(UN_ID, UN_NAME)으로 설정 해놨기 때문에 
                    --중복 판단 : ('AA', 'JAVA') <> ('BB', 'JAVA)'
                    -- ('AA', 'JAVA')를 한단어로 본다면 ('BB', 'JAVA)' 다르기 때문에 중복이 안된다.
INSERT INTO TESTUN3(UN_ID, UN_NAME)
VALUES ('BB', 'JAVA');  --ERROR 중복 판단 : ('BB', 'JAVA') == ('BB', 'JAVA)'

INSERT INTO TESTUN3(UN_ID, UN_NAME)
VALUES (NULL, 'NODE_JS'); --UNIQUE 복합키에 대한 NULL적용 

INSERT INTO TESTUN3(UN_ID, UN_NAME)
VALUES ('AA', NULL); --ERROR : UN_NAME에는 NOT NULL 제약조건의 위배됨

INSERT INTO TESTUN3(UN_ID, UN_NAME)
VALUES ('AA', 'NODE_JS');

SELECT * FROM TESTUN3;
-------------------------------------------------------
--*PRIMARY KEY*--
-- 기본키라고 하며 데이터베이스 정규화 과정에서는 IDENTIFIER (식별자)라고 한다.
-- 테이블에서 한 행의 정보를 찾기 위해 이용하는 컬럼을 의미한다.
-- NOTNULL + UNIQUE 두 가지 의미를 가지고 있다.
-- 한 테이블에 1개만 사용할 수 있다.
CREATE TABLE TESTPK(
    TP_ID CHAR(3) ,
    TP_PWD VARCHAR2(20),
    TP_NAME VARCHAR(20) NOT NULL,
    TP_DATE DATE,
    CONSTRAINT PK_TK_ID PRIMARY KEY (TP_ID)
);

INSERT INTO TESTPK
VALUES (1, '1234', '시미즈', '20/04/20');

INSERT INTO TESTPK
VALUES (2, '111', '로잘린', TO_DATE('93/05/22'));

INSERT INTO TESTPK
VALUES (NULL, '222', '효진초이', SYSDATE); --ERROR : PK는 NULL값을 사용못한다.

INSERT INTO TESTPK
VALUES (2, '333', '엠마', SYSDATE); --ERROR : UNIQUE(중복) 같은 값을 기록 못한다. 유일한 값!!

SELECT * FROM TESTPK;

CREATE TABLE TESTPK2(
    PID NUMBER CONSTRAINT PK_TP2_PID PRIMARY KEY,
    PNAME VARCHAR2(15) PRIMARY KEY
); -- PRIMARY KEY 는 한번 밖에 설정 못한다.!!!

CREATE TABLE TESTPK2(
    PID NUMBER CONSTRAINT PK_TP2_ID PRIMARY KEY ,
    PNAME VARCHAR(20),
    PDATE DATE
);

--PRIMARY KEY 제약조건도 복합키로 설정
CREATE TABLE TESTPK3(
    PID NUMBER,
    PNAME VARCHAR2(30),
    PDATE DATE,
    CONSTRAINT PK_TPK3_COMP PRIMARY KEY (PID, PNAME)
);
INSERT INTO TESTPK3(PID, PNAME)
VALUES (1, '치킨');
INSERT INTO TESTPK3(PID, PNAME)
VALUES (1, '치킨'); --ERROR : 이미 (1, '치킨') 이라는 값이 있기 때문에 중복검사에 걸린다.
INSERT INTO TESTPK3(PID, PNAME)
VALUES (1, '제로콜라'); -- (1, '치킨') != (1, '제로콜라') 값을 한 단어로 취급하기 때문에
                     -- 1이라는 숫자가 중복되어도 뒤에 이름이 다르므로 기록가능하다.
INSERT INTO TESTPK3(PID, PNAME)
VALUES (1, NULL); --ERROR : PRIMARY KEY는 복합키로 설정 되어있어도 
                 --한개라도 NULL값을 사용하지 못한다.
INSERT INTO TESTPK3(PID, PNAME)
VALUES (NULL, '제로콜라'); --ERROR


SELECT * FROM TESTPK3;

--* CHECK 제약조건 *
-- 테이블 생성시 컬럼에 기록되는 값에 조건을 설정 할때 사용한다.
-- 컬럼 LEVEL, 테이블 LEVEL 둘 다 설정 가능하다.
-- 사용형식 : [ CONSTRAINT 저장이름(생략가능) ] CHECK (컬럼명 연산자 제한값)
-- 제한 값은 반드시 리터럴(값)만 사용할 수 있다. 함수 사용 불가능!
-- 또한 사용될 때마다 바뀌는 값은 사용 못한다!!
CREATE TABLE TESTCHK(
    C_NAME VARCHAR2(15) CONSTRAINT NN_TCK_NAME NOT NULL,
    C_PRICE NUMBER(5) CONSTRAINT CK_TCK_PRICE CHECK (C_PRICE BETWEEN 1 AND 99999),
    C_LEVEL CHAR(1) CONSTRAINT CK_TCK_LEVEL CHECK (C_LEVEL IN ('A', 'B', 'C') )
);
INSERT INTO TESTCHK
VALUES ('아이폰13pro', 90000, 'A');
INSERT INTO TESTCHK
VALUES ('LG G7' , 1240000, 'B'); --ERROR : C_PRICE에 조건 범위 값을 초과해서 에러남
INSERT INTO TESTCHK
VALUES('갤럭시폴드', 0, 'A'); --ERROR :C_PRICE 값 범위 초과
INSERT INTO TESTCHK
VALUES ('갤럭시플립', 88900, 'Z'); -- ERROR : C_LEVEL에 조건을 위배함 (A, B, C)만 올 수 있음
INSERT INTO TESTCHK
VALUES ('갤럭시', 1234, 'a');  --C_LEVEL은 대문자만 올수 있다 값은 대/소문자 구별을 명확히 해야함!

SELECT * FROM TESTCHK;

--제한 값 지정, AND, OR사용
CREATE TABLE TESTCHK2(
    CNAME VARCHAR2(15 CHAR) CONSTRAINT PK_TCK_CNAME PRIMARY KEY,
    -- 기본이 바이트 크기이지만 CHAR를 적어주므로 글자 수로 크기를 지정할 수 있다.
    C_PRICE NUMBER(5) CHECK (C_PRICE >= 1 AND C_PRICE <= 99999),
    C_LEVEL CHAR(1) CHECK (C_LEVEL LIKE 'A' OR C_LEVEL LIKE 'B' OR C_LEVEL LIKE 'C'),
    --C_DATE DATE CHECK (C_DATE < SYSDATE) --제한값 SYSDATE()는 실행될때마다 바뀌기 때문에 사용 못함
                                        --제한 값 자리에는 무조건 값을 정해줘야한다.
    C_DATE DATE CHECK (C_DATE > TO_DATE('90/01/01', 'YYYY/MM/DD'))
    --TO_DATE()에서 날짜 포맷을 오라클 형식 처럼 90/01/01처럼 되어있으면 2글자에서 4글자로 변환 가능하다.
);
----------------------------------------------------------
-- 제약조건 FOREIGN KEY REFERENCE (외래키, 외부키, 참조키)
-- 다른(참조) 테이블이 제공하는 값만 기록에 사용할 수 있는 컬럼이다.
-- FOREIGN KEY 제약조건에 의해서 테이블 간의 관계(RELATIONSHIP)가 만들어진다(형성).
-- 컬럼LEVEL, 테이블LEVEL에서 설정 가능하다 BUT 키워드가 달라진다.
-- 컬럼LEVEL : 컬럼명 자료형(크기) [CONSTRAINT 저장이름] REFERENCES 값제 공테이블명 [ (값제공 컬럼명) ]
-- 테이블LEVEL : [CONSTRAINT 저장이름] FOREIGN KEY (적용 할 컬럼명) REFERENCES 값 제공 테이블명 [ (값 제공 컬럼명) ]
-- [값 제공 컬럼명] 을 생략하면 참조테이블(값 제공 테이블)에 기본키(PRIMARY KEY로 설정된)를 사용한다는 의미이다.
-- REFERENCES 할 컬럼은 반드시 PRIMARY KEY 또는 UNIQUE 제약조건이 설정되어 있어야한다.
-- FOREIGN KEY 설정 시 제약사항 : 제공 되는 값만 기록에 사용할 수 있다.
-- 다시 말해 제공되지 않는 값을 기록하면 ERROR나며 NULL 은 사용가능하다.
-- PRIMARY KEY는 1개만 설정가능하지만 FOREIGN KEY는 상관없다.
CREATE TABLE TESTFK(
    EMP_ID CHAR(3) REFERENCES EMPLOYEE, --[ (EMP_ID) ] 자동으로 PRIMARY KEY로 설정된 컬럼이 적용
    DEPT_ID CHAR(2) CONSTRAINT FK_TFK_DID REFERENCES DEPARTMENT (DEPT_ID),
    JOB_ID CHAR(2),
    CONSTRAINT FK_TFK_JID FOREIGN KEY (JOB_ID) REFERENCES JOB (JOB_ID)
);
INSERT INTO TESTFK
VALUES ('100', '50', 'J4'); -- 제공하는 테이블에 제공하는 값을 사용해 기록 할시 문제없이 사용가능하다.
INSERT INTO TESTFK
VALUES ('333', '90', 'J7'); -- 제공하지 않는 값을 사용해 기록 할시 ERROR난다(부모키가 없음)
                        -- 사용하는 테이블을 자식레코드 EMP_ID
INSERT INTO TESTFK
VALUES ('210', '70', 'J2'); --ERROR : DEPT_ID (제공되지 않는 값)

INSERT INTO TESTFK
VALUES ('101', '20', 'j4'); --ERROR : JOB_ID 값은 대/소문자를 구분해서 기록해야한다.( J4 != j4 )

INSERT INTO TESTFK
VALUES (NULL, '80', 'J1'); --NULL은 사용가능

INSERT INTO TESTFK
VALUES ('124', NULL, 'J2');

INSERT INTO TESTFK
VALUES ('101', '90', NULL);

INSERT INTO TESTFK
VALUES (NULL, NULL, NULL);

SELECT * 
FROM TESTFK LEFT JOIN
      DEPARTMENT USING(DEPT_ID);
      
-- 참조테이블의 참조컬럼은 반드시 PK이거나 UNIQUE 설정이 되어야한다.
CREATE TABLE TEST_NOPK(
    ID CHAR(3),
    NAME VARCHAR2(15)
);

CREATE TABLE TESTFK2(
    ID CHAR(3) REFERENCES TEST_NOPK, --참조 컬럼을 생략하면 자동으로 PK 컬럼을 참조한다.
    FNAME VARCHAR(15) -- PK 또는 UNIQUE가 없으므로 ERROR
);
CREATE TABLE TEST_NOPK2(
    ID CHAR(3) PRIMARY KEY,
    NAME VARCHAR2(15)
);
DROP TABLE TESTFK2;
CREATE TABLE TESTFK2(
    ID CHAR(3) REFERENCES TEST_NOPK2,
    FNAME VARCHAR(15) 
);
CREATE TABLE TEST_NOPK3(
    ID CHAR(3) PRIMARY KEY,
    NAME VARCHAR2(15) UNIQUE
);
CREATE TABLE TESTFK3(
    ID CHAR(3) REFERENCES TEST_NOPK2, --PK컬럼을 참조
    FNAME VARCHAR(15) REFERENCES TEST_NOPK3 (NAME) --UNIQUE제약조건 설정된 컬럼 참조
);
--CREATE TABLE CONSTRAINT_EMP(
--    EID CHAR(3), CONSTRAINT PK_EID PRIMARY KEY,
--    ENAME VARCHAR2(20) CONSTRAINT NNENAME NOT NULL,
--    ENO CHAR(14) CONSTRAINT NNENO NOT NULL CONSTRAINT UNENO UNIQUE,
--    EMAIL VARCHAR(25) CONSTRAINT UNEMAIL UNIQUE,
--    PHONE VARCHAR(12),
--    HIRE_DATE DATE DEFAULT SYSDATE,
--    JID CHAR(2) CONSTRAINT FKJID REFERENCES JOB ON DELETE SET NULL,
--    SALARY NUMBER,
--    BONUS_PCT NUMBER,
--    MARRIAGE CHAR(1) DEFAULT 'N' CONSTRAINT CHKM CHECK (MERRIAGE IN ('Y', 'N') ),
--    MID CHAR(3) CONSTRAINT FKMID REFERENCES CONSTRAINT_EMP ON DELETE SET NULL,
--    DID CHAR(2),
--    CONSTRAINT FKDID FOREIGN KEY (DID) REFERENCE DEPARTMENT ON DELETE CASCADE
--);

-- 기본적으로 FOREIGN KEY 제약조건이 설정되면, 값을 제공하는 참조테이블의 컬럼값은 함부로 삭제 못한다.
-- 참조컬럼(부모키) 값이 자식레코드 쪽에서 사용되고 있으면 삭제 못한다.
-- 즉, EMPLOYEE.DEPT_ID 에 기록된 '90' 부서코드가 있으면 DEPARTMENT.DEPT_ID의 '90'부서는 삭제못한다.

-- DML : DELETE 문 (행 삭제 구문 )
-- DELETE는 한개만 삭제 못하고 행 즉 한 줄 전체를 삭제를 하는 명령어 (한개만 삭제하고 싶으면 UPDATE로 NULL처리)
-- DELETE  FROM 테이블명 [ WHERE 컬럼명 비교연산자 삭제할 조건값 ];
-- 조건에 해당되는 값이 있는 행을 삭제하는 의미

DELETE FROM DEPARTMENT --ERROR : 함부로 지우지 못함
WHERE DEPT_ID LIKE '90'; --자식 레코드 쪽에서 사용 하고 있으므로 부모키를 지울 수 없다! (삭제불가능)

-- 필요시 FOREIGN KEY 제약조건 설정 시 미리 삭제 옵션(삭제 형식)을 추가할 수 있다.
-- 부모키를 삭제할 수 있게 됨
-- 삭제 옵션 
-- ON DELETE SET NULL : 부모키가 삭제 되면 자식 레코드(값 사용 컬럼)의 값을 NULL로 바꾼다.
-- ON DELETE CASCADE(함께 삭제) : 부모키가 삭제 되면 자식레코드가 있는 행을 같이 삭제한다.
-- ON DELETE RESTRICTED : 기본값, 삭제 불가능

CREATE TABLE PRODUCT_STATE(
    PSTATE CHAR(1) PRIMARY KEY,
    PCOMMENT VARCHAR2(15)
);
INSERT INTO PRODUCT_STATE VALUES('A', '최고급');
INSERT INTO PRODUCT_STATE VALUES('B', '고급');
INSERT INTO PRODUCT_STATE VALUES('C', '중급');
INSERT INTO PRODUCT_STATE VALUES('D', '저급');

SELECT * FROM PRODUCT_STATE;


CREATE TABLE PRODUCT(
    PNAME VARCHAR2(20) PRIMARY KEY,
    PRICE NUMBER CHECK (PRICE > 0),
    PSTATE CHAR(1) REFERENCES PRODUCT_STATE ON DELETE SET NULL
);
INSERT INTO PRODUCT VALUES('갤럭시노트', 12350000, 'B');
INSERT INTO PRODUCT VALUES('갤럭시Z플립', 2300000, 'C');
INSERT INTO PRODUCT VALUES('아이폰13PRO', 30000000, 'A');

SELECT * FROM PRODUCT;

SELECT *
FROM PRODUCT LEFT JOIN
PRODUCT_STATE USING(PSTATE);

-- ON DELETE SET NULL : 부모키가 삭제되면 자식 레코드 값을 NULL로 바꿈
DELETE FROM PRODUCT_STATE
WHERE PSTATE LIKE 'C';

SELECT * FROM PRODUCT_STATE; --부모키
SELECT * FROM PRODUCT; --자식레코드
SELECT * FROM PRODUCT;
--삭제 취소 : ROLLBACK (TCL : Transaction Controll langage)
ROLLBACK;
---------------------------------------------------------
-- ON DELETE CASCADE : 부모키와 자식 레코드 함께 삭제
CREATE TABLE PRODUCT2(
    PNAME VARCHAR2(20) PRIMARY KEY,
    PRICE NUMBER CHECK (PRICE > 0),
    PSTATE CHAR(1) REFERENCES PRODUCT_STATE ON DELETE CASCADE
);
INSERT INTO PRODUCT2
VALUES('갤럭시노트', 12350000, 'B');
INSERT INTO PRODUCT2
VALUES('갤럭시Z플립', 2300000, 'C');
INSERT INTO PRODUCT2
VALUES('아이폰13PRO', 30000000, 'A');

SELECT * FROM PRODUCT2;

DELETE FROM PRODUCT_STATE
WHERE PSTATE LIKE 'A';

SELECT * FROM PRODUCT_STATE; -- 부모키 삭제 확인
SELECT * FROM PRODUCT2; -- 자식레코드 행 함께 삭제 확인


-----------------------------------------------------------
--부모키 (값 제공컬럼)가 복합키(여러 개의 컬럼을 하나로 묶은 것)이면 
--FOREIGN KEY 제약조건 설정하는 컬럼 (자식레코드)도 같은 복합키이여야한다.
--복합키를 단일키로 사용 못한다 단일키를 FOREIGN KEY 제약조건에서 복합키로 만들 수도 없다.

CREATE TABLE TEST_COMP(
    ID NUMBER,
    NAME VARCHAR2(20),
    PRIMARY KEY (ID, NAME) --복합키

);
INSERT INTO TEST_COMP VALUES ('100', 'JAVA');
INSERT INTO TEST_COMP VALUES ('200', 'JAVA');
INSERT INTO TEST_COMP VALUES ('200', 'ORACLE');
SELECT * FROM TEST_COMP;

CREATE TABLE TEST_FK4(
    FID NUMBER,
    FNAME VARCHAR2(20),
    --FOREIGN KEY (FID) REFERENCES TEST_COMP (ID) --부모키다 복합키인데 자식레코드는 단일 키라 사용못한다.
    FOREIGN KEY (FID, FNAME)  REFERENCES TEST_COMP --복합키는 같이 복합키로 같이 설정해야함
);