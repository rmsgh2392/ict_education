--DDL & DML--
/*DDL( DATABASE Definition Language  : ������ ���Ǿ�)
  �����ͺ��̽� ��ü�� ����/����/���� �� ���Ǵ� SQL ��ɾ �����Ѵ�.
  ��ɾ� : CREATE (��ü ������), ALTER( ��ü �����), DROP( ��ü ���Ž�)
  �����ͺ��̽� ��ü : ���̺�(TABLE), ��(VIEW), ������(SEQUENCE), �ε���(INDEX)...(������ ���ν���, Ʈ���Ű� ����)
*/

-- ���̺� ����
-- �ۼ����� : CREATE TABLE ���̺� ��(. . . . .);
-- CREATE TABLE ���̺� ��(
--    �÷���  �ڷ���(ũ��) [DEFAULT �÷��� ����� �⺻ ���� �����ټ� �ִ� (��������)] ,
--    �÷���  �ڷ���(ũ��) [�������� ������ ���],
--    �÷���  �ڷ���(ũ��) [CONSTRAINT �̸� ������������], -- �÷�����
--    �÷���  �ڷ���(ũ��) DEFAULT �⺻�� CONSTRAINT �����̸� ������������(�� ���� �� ����),
--    �÷���  �ڷ���(ũ��) [CONSTRAINT �����̸�] ��������1 [CONSTRAINT �����̸�] ��������2 ������ ���� <= �÷����� ��������,
--  -> �÷��� �� ������ ������ �������Ǹ� ���� ������ �� �ִ�. : ���̺� ���� ��������
--  -> ������������ (������ �÷���)
--  -> CONSTRAINT �������̸� ������������ (������ �÷���)
-- );
--
CREATE TABLE TEST(); --ERROR : �ּ� 1�� �̻��� �÷��� �������� ���̺��� ���� �� �ִ�.

CREATE TABLE TEST(
    USER_ID VARCHAR2(20) PRIMARY KEY,
    USER_PWD VARCHAR2(20),
    USER_NAME VARCHAR2(30), -- �������� ũ�� ���� �ݵ�� ǥ��
    AGE NUMBER,       --���ڴ� ũ�� ���� ���� �����ϸ� �⺻�� 7�ڸ�
    ENROLL_DATE DATE  --����Ʈ�� ��¥���� ���� ũ���������� �ʴ´�
);
CREATE TABLE TEMP(
    TEMP_ID VARCHAR2(20),
    TEMP_PWD VARCHAR(20),
    TEMP_NAME VARCHAR(30),
    AGE NUMBER, 
    ENROLL_DATE DATE
);
COMMENT ON COLUMN TEMP.TEMP_ID IS '���̵�';
COMMENT ON COLUMN TEMP.TEMP_PWD IS '��й�ȣ';
COMMENT ON COLUMN TEMP.TEMP_NAME IS '�̸�';
COMMENT ON COLUMN TEMP.AGE IS '����';
COMMENT ON COLUMN TEMP.ENROLL_DATE IS '�����ѳ�¥';

CREATE TABLE ORDERS(
    ORDER_NO CHAR(4),
    CUST_NO CHAR(4),
    ORDER_DATE DATE DEFAULT SYSDATE,
    DELIVER_DATE DATE,
    DELIVER_ADDRESS VARCHAR2(40),
    QUANTITY NUMBER
);
--�÷��� ���� �ޱ�  : COMMENT ON COLUMN ���� ���
-- COMMENT ON COLUMN ���̺��.�÷��� IS '����';
COMMENT ON COLUMN ORDERS.ORDER_NO IS '�ֹ���ȣ';
COMMENT ON COLUMN ORDERS.CUST_NO IS '����ȣ';
COMMENT ON COLUMN ORDERS.ORDER_DATE IS '�ֹ���¥';
COMMENT ON COLUMN ORDERS.DELIVER_DATE IS '��۳�¥';
COMMENT ON COLUMN ORDERS.DELIVER_ADDRESS IS '����ּ�';
COMMENT ON COLUMN ORDERS.QUANTITY IS '�ֹ�����';


/*���Ἲ �������ǵ� (CONSTRAINTS)
-- ���̺� ������(��)�� ���(INSET) | ���� (UPDATE)�� �� �ùٸ� ���� ��ϵǵ��� �˻��ϴ� ���
-- ���̺��� ������ �������� �ŷڼ��� ���̱� ���� ��� �� �������� ���Ἲ�� Ȯ��
-- �̸����� �����ȴ� : CONSTRAINT ������ �̸� �������� ���� --�÷�����
--                   CONSTRAINT ������ �̸� �������� ���� (������ �÷���) -- ���̺� ����
-- ���� �̸��� �����Ǹ� �ڵ����� �̸��� �����ȴ� SYS_C*******�� �����̴�.
-- ���̺������� ���� ���� �÷����� ��� �ϳ��� ���������� ���� �� ���� �ִ�. �̰��� ����Ű ����Ѵ�.
-- CONSTRAINT ������ �̸� �������� ���� (������ �÷���, �÷���, �÷���,......) --���̺���(����Ű)
-- ���������� ������ 5������ �����Ѵ�.
-- 1. NOT NULL (ONLY �÷�����)
-- 2. UNIQUE (�÷�����, ���̺���)
-- 3. PRIMARY KEY (�÷�����, ���̺���)
-- 4. CHECK (�÷�����, ���̺���)
-- 5. FOREIGN KEY (�÷�����, ���̺���)
*/
-----------------------------------------------------
--DML(Data Manipulation Language : ������ ���۾�)
--��ɾ� : INSERT, DELETE, UPDATE

--INSERT �� ��� ���� 
--INSERT INTO ���̺�� [(�÷���, �÷��� ....)]
--VALUES (����� ��, ����� ��....)
--���ǻ��� : �÷� ���� ������ ���� ���� ����ؾ��ϸ� ������ �÷��� ����� ���� �ڷ����� ������ ��ġ�ؾ��Ѵ�.
--���� : ���̺��� ��ü �÷��� ���� ����� ������ �÷��� ������ ������ �� �ִ�.
SELECT * FROM TEST;
SELECT COUNT(*) FROM TEST;

INSERT INTO TEST 
VALUES('rmsgh2392', '1234', '��Ʈ', 24, '20120423');

INSERT INTO TEST (USER_ID, USER_PWD)
VALUES('google02', '1234');

INSERT INTO TEST (USER_ID, USER_PWD, USER_NAME, AGE, ENROLL_DATE)
VALUES('google01', 'google444', 'ī����', 20, SYSDATE);

INSERT INTO TEST (USER_ID, USER_PWD, USER_NAME, AGE, ENROLL_DATE)
VALUES('google03', 'google444', '����', 20, TO_DATE('20201225', 'RRRRMMDD'));

--------------------------------------------------------------------------
--�������� : NOT NULL 
--�÷��� �ݵ�� ���� ����ؾ� �� �� �����Ѵ�.(�ʼ� �Է� �׸��� �÷�)
--�÷��� NULL(�� ĭ)�� ��� ���Ѵ�.
--�÷����������� ���� ����!! ( ���̺� �������� �����ϸ� ERROR��)

CREATE TABLE TESTNN(
    NN_ID NUMBER(5) CONSTRAINT NNID NOT NULL, --�÷�����, �������� �̸��� ������(SYS_C*****)
    NN_NAME VARCHAR(20)   
);
INSERT INTO TESTNN(NN_ID, NN_NAME)
VALUES(1, 'JAVA');

INSERT INTO TESTNN
VALUES(NULL, 'JAVASCRIPT'); -- ����� �ȵȴ�. NOT NULL ���������� �����Ǿ� �ֱ� ������ ���������� ������ ����

INSERT INTO TESTNN (NN_NAME)
VALUES('�ڹٽ�ũ��Ʈ'); --INSERT�� ���� �߰��ϱ� ������ ���ܵ� �÷��� NULL�� ��
                      --NN_ID��  NULL���� ��ϵǱ� ������ NOT NULL �������� �����
INSERT INTO TESTNN
VALUES (2, NULL); -- NN_NAME���� NOT NULL ���������� �����Ǿ����� �ʱ� ������ NULL���� ����Ҽ� �ִ�.

INSERT INTO TESTNN(NN_ID)
VALUES (1);

SELECT * FROM TESTNN;

--NOT NULL : ���̺� ���� ���� Ȯ��--
CREATE TABLE TESTNN2(
    NN_ID NUMBER(5),
    NN_NAME VARCHAR(20),
    CONSTRAINT NN_TN2_ID NOT NULL (NN_ID) --���̺� �������� NOT NULL
); --> ERROR :  �� ������ ���̺� ���������� NOT NULL�� �������Ѵ�!

--�ذ��� : �÷��������� ����������
CREATE TABLE TESTNN2(
    NN_ID NUMBER(5) CONSTRAINT NN_TN2_ID NOT NULL,
    NN_NAME VARCHAR(20)
); 

-- �������� : UNIQUE --
-- �÷��� �ߺ� ��(���� ���� �ι� ���)�� ���� ���������̴�.
-- �ߺ� ����� ���� �˻� ���
-- �÷�����, ���̺� ���� �� �� ��� �����ϴ�.
-- NULL ��밡�� 

CREATE TABLE TESTUN(
    UN_ID CHAR(3) UNIQUE, --�÷�����
    UN_PWD VARCHAR(20),
    UN_NAME VARCHAR2(10) NOT NULL
);
INSERT INTO TESTUN
VALUES ('AAA', '123124', 'HOOK');
INSERT INTO TESTUN
VALUES ('BBB', '123124', 'YGX');
INSERT INTO TESTUN
VALUES ('AAA', '123124', 'LACHICA'); --��ϵǾ� �ִ� �� �ߺ� ���(UN_ID) : ERROR
INSERT INTO TESTUN
VALUES (NULL, '123124','HOLYBANG'); --UNIQUE �������ǿ��� NULL �� ��� ����

SELECT * FROM TESTUN;

CREATE TABLE TESTUN2(
    UN_ID CHAR(3) ,
    UN_PWD VARCHAR(20),
    UN_NAME VARCHAR2(10) CONSTRAINT NN_TU2_NAME NOT NULL,
    --���̺��� �������� ����
    CONSTRAINT UNI_TU2_ID UNIQUE(UN_ID)
    --�̸��� �������ָ� UNIQUE(UN_ID) 
);
--UNIQUE ���������� ���̺� ���� �������� ����Ű�� ���� �� �� �ִ�.
--����Ű�� �������� �÷��� ��� ����
--������ �÷������� �ϳ��� �ܾ�� ���� �ߺ��� �Ǵ��Ѵ�.!!!
--UNIQUE(UN_ID, UN_NAME)
CREATE TABLE TESTUN3(
    UN_ID CHAR(3) ,
    UN_NAME VARCHAR2(10) NOT NULL, -- UN_NAME�� ���������� NOT NULL + UNIQUE ������ ������
    UN_CODE CHAR(2),
    --���̺��� �������� ����(����Ű)
    CONSTRAINT UNI_TU3_COMP UNIQUE (UN_ID, UN_NAME) --����Ű
    -- �ΰ��� ��� �ϳ��� ���������� �ɰڴ� 
);

INSERT INTO TESTUN3(UN_ID, UN_NAME)
VALUES ('AA', 'JAVA'); 
INSERT INTO TESTUN3(UN_ID, UN_NAME)
VALUES ('BB', 'JAVA'); --����Ű�� UNIQUE(UN_ID, UN_NAME)���� ���� �س��� ������ 
                    --�ߺ� �Ǵ� : ('AA', 'JAVA') <> ('BB', 'JAVA)'
                    -- ('AA', 'JAVA')�� �Ѵܾ�� ���ٸ� ('BB', 'JAVA)' �ٸ��� ������ �ߺ��� �ȵȴ�.
INSERT INTO TESTUN3(UN_ID, UN_NAME)
VALUES ('BB', 'JAVA');  --ERROR �ߺ� �Ǵ� : ('BB', 'JAVA') == ('BB', 'JAVA)'

INSERT INTO TESTUN3(UN_ID, UN_NAME)
VALUES (NULL, 'NODE_JS'); --UNIQUE ����Ű�� ���� NULL���� 

INSERT INTO TESTUN3(UN_ID, UN_NAME)
VALUES ('AA', NULL); --ERROR : UN_NAME���� NOT NULL ���������� �����

INSERT INTO TESTUN3(UN_ID, UN_NAME)
VALUES ('AA', 'NODE_JS');

SELECT * FROM TESTUN3;
-------------------------------------------------------
--*PRIMARY KEY*--
-- �⺻Ű��� �ϸ� �����ͺ��̽� ����ȭ ���������� IDENTIFIER (�ĺ���)��� �Ѵ�.
-- ���̺��� �� ���� ������ ã�� ���� �̿��ϴ� �÷��� �ǹ��Ѵ�.
-- NOTNULL + UNIQUE �� ���� �ǹ̸� ������ �ִ�.
-- �� ���̺� 1���� ����� �� �ִ�.
CREATE TABLE TESTPK(
    TP_ID CHAR(3) ,
    TP_PWD VARCHAR2(20),
    TP_NAME VARCHAR(20) NOT NULL,
    TP_DATE DATE,
    CONSTRAINT PK_TK_ID PRIMARY KEY (TP_ID)
);

INSERT INTO TESTPK
VALUES (1, '1234', '�ù���', '20/04/20');

INSERT INTO TESTPK
VALUES (2, '111', '���߸�', TO_DATE('93/05/22'));

INSERT INTO TESTPK
VALUES (NULL, '222', 'ȿ������', SYSDATE); --ERROR : PK�� NULL���� �����Ѵ�.

INSERT INTO TESTPK
VALUES (2, '333', '����', SYSDATE); --ERROR : UNIQUE(�ߺ�) ���� ���� ��� ���Ѵ�. ������ ��!!

SELECT * FROM TESTPK;

CREATE TABLE TESTPK2(
    PID NUMBER CONSTRAINT PK_TP2_PID PRIMARY KEY,
    PNAME VARCHAR2(15) PRIMARY KEY
); -- PRIMARY KEY �� �ѹ� �ۿ� ���� ���Ѵ�.!!!

CREATE TABLE TESTPK2(
    PID NUMBER CONSTRAINT PK_TP2_ID PRIMARY KEY ,
    PNAME VARCHAR(20),
    PDATE DATE
);

--PRIMARY KEY �������ǵ� ����Ű�� ����
CREATE TABLE TESTPK3(
    PID NUMBER,
    PNAME VARCHAR2(30),
    PDATE DATE,
    CONSTRAINT PK_TPK3_COMP PRIMARY KEY (PID, PNAME)
);
INSERT INTO TESTPK3(PID, PNAME)
VALUES (1, 'ġŲ');
INSERT INTO TESTPK3(PID, PNAME)
VALUES (1, 'ġŲ'); --ERROR : �̹� (1, 'ġŲ') �̶�� ���� �ֱ� ������ �ߺ��˻翡 �ɸ���.
INSERT INTO TESTPK3(PID, PNAME)
VALUES (1, '�����ݶ�'); -- (1, 'ġŲ') != (1, '�����ݶ�') ���� �� �ܾ�� ����ϱ� ������
                     -- 1�̶�� ���ڰ� �ߺ��Ǿ �ڿ� �̸��� �ٸ��Ƿ� ��ϰ����ϴ�.
INSERT INTO TESTPK3(PID, PNAME)
VALUES (1, NULL); --ERROR : PRIMARY KEY�� ����Ű�� ���� �Ǿ��־ 
                 --�Ѱ��� NULL���� ������� ���Ѵ�.
INSERT INTO TESTPK3(PID, PNAME)
VALUES (NULL, '�����ݶ�'); --ERROR


SELECT * FROM TESTPK3;

--* CHECK �������� *
-- ���̺� ������ �÷��� ��ϵǴ� ���� ������ ���� �Ҷ� ����Ѵ�.
-- �÷� LEVEL, ���̺� LEVEL �� �� ���� �����ϴ�.
-- ������� : [ CONSTRAINT �����̸�(��������) ] CHECK (�÷��� ������ ���Ѱ�)
-- ���� ���� �ݵ�� ���ͷ�(��)�� ����� �� �ִ�. �Լ� ��� �Ұ���!
-- ���� ���� ������ �ٲ�� ���� ��� ���Ѵ�!!
CREATE TABLE TESTCHK(
    C_NAME VARCHAR2(15) CONSTRAINT NN_TCK_NAME NOT NULL,
    C_PRICE NUMBER(5) CONSTRAINT CK_TCK_PRICE CHECK (C_PRICE BETWEEN 1 AND 99999),
    C_LEVEL CHAR(1) CONSTRAINT CK_TCK_LEVEL CHECK (C_LEVEL IN ('A', 'B', 'C') )
);
INSERT INTO TESTCHK
VALUES ('������13pro', 90000, 'A');
INSERT INTO TESTCHK
VALUES ('LG G7' , 1240000, 'B'); --ERROR : C_PRICE�� ���� ���� ���� �ʰ��ؼ� ������
INSERT INTO TESTCHK
VALUES('����������', 0, 'A'); --ERROR :C_PRICE �� ���� �ʰ�
INSERT INTO TESTCHK
VALUES ('�������ø�', 88900, 'Z'); -- ERROR : C_LEVEL�� ������ ������ (A, B, C)�� �� �� ����
INSERT INTO TESTCHK
VALUES ('������', 1234, 'a');  --C_LEVEL�� �빮�ڸ� �ü� �ִ� ���� ��/�ҹ��� ������ ��Ȯ�� �ؾ���!

SELECT * FROM TESTCHK;

--���� �� ����, AND, OR���
CREATE TABLE TESTCHK2(
    CNAME VARCHAR2(15 CHAR) CONSTRAINT PK_TCK_CNAME PRIMARY KEY,
    -- �⺻�� ����Ʈ ũ�������� CHAR�� �����ֹǷ� ���� ���� ũ�⸦ ������ �� �ִ�.
    C_PRICE NUMBER(5) CHECK (C_PRICE >= 1 AND C_PRICE <= 99999),
    C_LEVEL CHAR(1) CHECK (C_LEVEL LIKE 'A' OR C_LEVEL LIKE 'B' OR C_LEVEL LIKE 'C'),
    --C_DATE DATE CHECK (C_DATE < SYSDATE) --���Ѱ� SYSDATE()�� ����ɶ����� �ٲ�� ������ ��� ����
                                        --���� �� �ڸ����� ������ ���� ��������Ѵ�.
    C_DATE DATE CHECK (C_DATE > TO_DATE('90/01/01', 'YYYY/MM/DD'))
    --TO_DATE()���� ��¥ ������ ����Ŭ ���� ó�� 90/01/01ó�� �Ǿ������� 2���ڿ��� 4���ڷ� ��ȯ �����ϴ�.
);
----------------------------------------------------------
-- �������� FOREIGN KEY REFERENCE (�ܷ�Ű, �ܺ�Ű, ����Ű)
-- �ٸ�(����) ���̺��� �����ϴ� ���� ��Ͽ� ����� �� �ִ� �÷��̴�.
-- FOREIGN KEY �������ǿ� ���ؼ� ���̺� ���� ����(RELATIONSHIP)�� ���������(����).
-- �÷�LEVEL, ���̺�LEVEL���� ���� �����ϴ� BUT Ű���尡 �޶�����.
-- �÷�LEVEL : �÷��� �ڷ���(ũ��) [CONSTRAINT �����̸�] REFERENCES ���� �����̺�� [ (������ �÷���) ]
-- ���̺�LEVEL : [CONSTRAINT �����̸�] FOREIGN KEY (���� �� �÷���) REFERENCES �� ���� ���̺�� [ (�� ���� �÷���) ]
-- [�� ���� �÷���] �� �����ϸ� �������̺�(�� ���� ���̺�)�� �⺻Ű(PRIMARY KEY�� ������)�� ����Ѵٴ� �ǹ��̴�.
-- REFERENCES �� �÷��� �ݵ�� PRIMARY KEY �Ǵ� UNIQUE ���������� �����Ǿ� �־���Ѵ�.
-- FOREIGN KEY ���� �� ������� : ���� �Ǵ� ���� ��Ͽ� ����� �� �ִ�.
-- �ٽ� ���� �������� �ʴ� ���� ����ϸ� ERROR���� NULL �� ��밡���ϴ�.
-- PRIMARY KEY�� 1���� �������������� FOREIGN KEY�� �������.
CREATE TABLE TESTFK(
    EMP_ID CHAR(3) REFERENCES EMPLOYEE, --[ (EMP_ID) ] �ڵ����� PRIMARY KEY�� ������ �÷��� ����
    DEPT_ID CHAR(2) CONSTRAINT FK_TFK_DID REFERENCES DEPARTMENT (DEPT_ID),
    JOB_ID CHAR(2),
    CONSTRAINT FK_TFK_JID FOREIGN KEY (JOB_ID) REFERENCES JOB (JOB_ID)
);
INSERT INTO TESTFK
VALUES ('100', '50', 'J4'); -- �����ϴ� ���̺� �����ϴ� ���� ����� ��� �ҽ� �������� ��밡���ϴ�.
INSERT INTO TESTFK
VALUES ('333', '90', 'J7'); -- �������� �ʴ� ���� ����� ��� �ҽ� ERROR����(�θ�Ű�� ����)
                        -- ����ϴ� ���̺��� �ڽķ��ڵ� EMP_ID
INSERT INTO TESTFK
VALUES ('210', '70', 'J2'); --ERROR : DEPT_ID (�������� �ʴ� ��)

INSERT INTO TESTFK
VALUES ('101', '20', 'j4'); --ERROR : JOB_ID ���� ��/�ҹ��ڸ� �����ؼ� ����ؾ��Ѵ�.( J4 != j4 )

INSERT INTO TESTFK
VALUES (NULL, '80', 'J1'); --NULL�� ��밡��

INSERT INTO TESTFK
VALUES ('124', NULL, 'J2');

INSERT INTO TESTFK
VALUES ('101', '90', NULL);

INSERT INTO TESTFK
VALUES (NULL, NULL, NULL);

SELECT * 
FROM TESTFK LEFT JOIN
      DEPARTMENT USING(DEPT_ID);
      
-- �������̺��� �����÷��� �ݵ�� PK�̰ų� UNIQUE ������ �Ǿ���Ѵ�.
CREATE TABLE TEST_NOPK(
    ID CHAR(3),
    NAME VARCHAR2(15)
);

CREATE TABLE TESTFK2(
    ID CHAR(3) REFERENCES TEST_NOPK, --���� �÷��� �����ϸ� �ڵ����� PK �÷��� �����Ѵ�.
    FNAME VARCHAR(15) -- PK �Ǵ� UNIQUE�� �����Ƿ� ERROR
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
    ID CHAR(3) REFERENCES TEST_NOPK2, --PK�÷��� ����
    FNAME VARCHAR(15) REFERENCES TEST_NOPK3 (NAME) --UNIQUE�������� ������ �÷� ����
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

-- �⺻������ FOREIGN KEY ���������� �����Ǹ�, ���� �����ϴ� �������̺��� �÷����� �Ժη� ���� ���Ѵ�.
-- �����÷�(�θ�Ű) ���� �ڽķ��ڵ� �ʿ��� ���ǰ� ������ ���� ���Ѵ�.
-- ��, EMPLOYEE.DEPT_ID �� ��ϵ� '90' �μ��ڵ尡 ������ DEPARTMENT.DEPT_ID�� '90'�μ��� �������Ѵ�.

-- DML : DELETE �� (�� ���� ���� )
-- DELETE�� �Ѱ��� ���� ���ϰ� �� �� �� �� ��ü�� ������ �ϴ� ��ɾ� (�Ѱ��� �����ϰ� ������ UPDATE�� NULLó��)
-- DELETE  FROM ���̺�� [ WHERE �÷��� �񱳿����� ������ ���ǰ� ];
-- ���ǿ� �ش�Ǵ� ���� �ִ� ���� �����ϴ� �ǹ�

DELETE FROM DEPARTMENT --ERROR : �Ժη� ������ ����
WHERE DEPT_ID LIKE '90'; --�ڽ� ���ڵ� �ʿ��� ��� �ϰ� �����Ƿ� �θ�Ű�� ���� �� ����! (�����Ұ���)

-- �ʿ�� FOREIGN KEY �������� ���� �� �̸� ���� �ɼ�(���� ����)�� �߰��� �� �ִ�.
-- �θ�Ű�� ������ �� �ְ� ��
-- ���� �ɼ� 
-- ON DELETE SET NULL : �θ�Ű�� ���� �Ǹ� �ڽ� ���ڵ�(�� ��� �÷�)�� ���� NULL�� �ٲ۴�.
-- ON DELETE CASCADE(�Բ� ����) : �θ�Ű�� ���� �Ǹ� �ڽķ��ڵ尡 �ִ� ���� ���� �����Ѵ�.
-- ON DELETE RESTRICTED : �⺻��, ���� �Ұ���

CREATE TABLE PRODUCT_STATE(
    PSTATE CHAR(1) PRIMARY KEY,
    PCOMMENT VARCHAR2(15)
);
INSERT INTO PRODUCT_STATE VALUES('A', '�ְ��');
INSERT INTO PRODUCT_STATE VALUES('B', '���');
INSERT INTO PRODUCT_STATE VALUES('C', '�߱�');
INSERT INTO PRODUCT_STATE VALUES('D', '����');

SELECT * FROM PRODUCT_STATE;


CREATE TABLE PRODUCT(
    PNAME VARCHAR2(20) PRIMARY KEY,
    PRICE NUMBER CHECK (PRICE > 0),
    PSTATE CHAR(1) REFERENCES PRODUCT_STATE ON DELETE SET NULL
);
INSERT INTO PRODUCT VALUES('�����ó�Ʈ', 12350000, 'B');
INSERT INTO PRODUCT VALUES('������Z�ø�', 2300000, 'C');
INSERT INTO PRODUCT VALUES('������13PRO', 30000000, 'A');

SELECT * FROM PRODUCT;

SELECT *
FROM PRODUCT LEFT JOIN
PRODUCT_STATE USING(PSTATE);

-- ON DELETE SET NULL : �θ�Ű�� �����Ǹ� �ڽ� ���ڵ� ���� NULL�� �ٲ�
DELETE FROM PRODUCT_STATE
WHERE PSTATE LIKE 'C';

SELECT * FROM PRODUCT_STATE; --�θ�Ű
SELECT * FROM PRODUCT; --�ڽķ��ڵ�
SELECT * FROM PRODUCT;
--���� ��� : ROLLBACK (TCL : Transaction Controll langage)
ROLLBACK;
---------------------------------------------------------
-- ON DELETE CASCADE : �θ�Ű�� �ڽ� ���ڵ� �Բ� ����
CREATE TABLE PRODUCT2(
    PNAME VARCHAR2(20) PRIMARY KEY,
    PRICE NUMBER CHECK (PRICE > 0),
    PSTATE CHAR(1) REFERENCES PRODUCT_STATE ON DELETE CASCADE
);
INSERT INTO PRODUCT2
VALUES('�����ó�Ʈ', 12350000, 'B');
INSERT INTO PRODUCT2
VALUES('������Z�ø�', 2300000, 'C');
INSERT INTO PRODUCT2
VALUES('������13PRO', 30000000, 'A');

SELECT * FROM PRODUCT2;

DELETE FROM PRODUCT_STATE
WHERE PSTATE LIKE 'A';

SELECT * FROM PRODUCT_STATE; -- �θ�Ű ���� Ȯ��
SELECT * FROM PRODUCT2; -- �ڽķ��ڵ� �� �Բ� ���� Ȯ��


-----------------------------------------------------------
--�θ�Ű (�� �����÷�)�� ����Ű(���� ���� �÷��� �ϳ��� ���� ��)�̸� 
--FOREIGN KEY �������� �����ϴ� �÷� (�ڽķ��ڵ�)�� ���� ����Ű�̿����Ѵ�.
--����Ű�� ����Ű�� ��� ���Ѵ� ����Ű�� FOREIGN KEY �������ǿ��� ����Ű�� ���� ���� ����.

CREATE TABLE TEST_COMP(
    ID NUMBER,
    NAME VARCHAR2(20),
    PRIMARY KEY (ID, NAME) --����Ű

);
INSERT INTO TEST_COMP VALUES ('100', 'JAVA');
INSERT INTO TEST_COMP VALUES ('200', 'JAVA');
INSERT INTO TEST_COMP VALUES ('200', 'ORACLE');
SELECT * FROM TEST_COMP;

CREATE TABLE TEST_FK4(
    FID NUMBER,
    FNAME VARCHAR2(20),
    --FOREIGN KEY (FID) REFERENCES TEST_COMP (ID) --�θ�Ű�� ����Ű�ε� �ڽķ��ڵ�� ���� Ű�� �����Ѵ�.
    FOREIGN KEY (FID, FNAME)  REFERENCES TEST_COMP --����Ű�� ���� ����Ű�� ���� �����ؾ���
);