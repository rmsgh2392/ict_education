-- DAY8_DDL & DML

-- DDL (Data Definition Language : ������ ���Ǿ�)
-- �����ͺ��̽� ��ü�� ����/����/���ſ� ���Ǵ� SQL ��ɾ� ������
-- ��ɾ� : CREATE(����), ALTER(����), DROP(����)
-- �����ͺ��̽� ��ü : ���̺�(TABLE), ��(VIEW), ������(SEQUENCE), �ε���(INDEX)

-- ���̺� ����� : CREATE TABLE
/* �ۼ� ���� : 
CREATE TABLE ���̺�� (
    �÷���   �ڷ���(ũ��) [DEFAULT �÷��� ����� �⺻��],
    �÷���   �ڷ���(ũ��) [������������],
    �÷���   �ڷ���(ũ��) [CONSTRAINT �̸�  ������������],   -- �÷� �����̶�� ��
    �÷���   �ڷ���(ũ��) DEFAULT �⺻�� CONSTRAINT �����̸� ������������,
    �÷���   �ڷ���(ũ��) [CONSTRAINT �����̸�] ��������1 [CONSTRAINT �����̸�] ��������2,
    -- �÷� ������ ������ �������Ǹ� ���� ������ ���� ����.  : ���̺� �����̶�� ��
    ������������ (������ �÷���),
    CONSTRAINT �������̸� ������������ (������ �÷���)
);
*/

CREATE TABLE TEST ();  -- ERROR : �÷��� ���� ���̺��� ���� �� ����

CREATE TABLE TEST (
    USERID  VARCHAR2(20),
    USERPWD  VARCHAR2(20),
    USERNAME VARCHAR2(30),  -- �������� ũ�� ���� �ݵ�� ǥ��
    AGE  NUMBER,  -- ũ������ ���� ����, �⺻ 7�ڸ���
    ENROLL_DATE DATE  -- ũ������ ����
);

CREATE TABLE ORDERS (
    ORDERNO CHAR(4),
    CUSTNO  CHAR(4),
    ORDERDATE  DATE  DEFAULT SYSDATE,
    SHIPDATE  DATE,
    SHIPADDRESS VARCHAR2(40),
    QUANTITY  NUMBER
);

-- �÷��� ���� �ޱ� : COMMENT ON COLUMN ���� �����
-- COMMENT ON COLUMN ���̺��.�÷��� IS '����';
COMMENT ON COLUMN ORDERS.ORDERNO IS '�ֹ���ȣ';
COMMENT ON COLUMN ORDERS.CUSTNO IS '����ȣ';
COMMENT ON COLUMN ORDERS.ORDERDATE IS '�ֹ�����';
COMMENT ON COLUMN ORDERS.SHIPDATE IS '�������';
COMMENT ON COLUMN ORDERS.SHIPADDRESS IS '����ּ�';
COMMENT ON COLUMN ORDERS.QUANTITY IS '�ֹ�����';

-- *****************************************************************
-- ���Ἲ �������ǵ� (CONSTRAINTS)
-- ���̺� ������(��)�� ���(INSERT) | ����(UPDATE)�� �� �ùٸ� ���� ��ϵǵ��� �˻��ϴ� ���
-- ���̺��� ����� �������� �ŷڼ��� ���̱� ���� ����� : ������ ���Ἲ
-- �������� ���� : NOT NULL, UNIQUE, PRIMARY KEY, CHECK, FOREIGN KEY
-- �̸����� ������ : CONSTRAINT �������̸� ������������ -- �÷�����
-- �̸����� ������ : CONSTRAINT �������̸� ������������ (������ �÷���)  -- ���̺���
-- �̸� ������ �����Ǹ� �ڵ����� �̸��� ������ : SYS_C******** �� ������
-- ���̺�������, ���� ���� �÷��� ��� �ϳ��� ���������� ������ ���� ���� (����Ű ��� ��)
--      CONSTRAINT �������̸� ������������ (�÷���, �÷���, �÷���, ......)  -- ���̺���

-- DML (Data Manipulation Language : ������ ���۾�)
-- ��ɾ� : INSERT, UPDATE, DELETE

-- INSERT �� : ���ο� ���� �߰���
/* ������� : 
INSERT INTO ���̺�� [(�÷���, �÷���, ....)]
VALUES (����� ��, ����� ��, ....);
���ǻ��� : �÷� ���� ������ ���缭 ���� ����ؾ� ��. ������ �÷��� ����� ���� �ڷ����� ������ ��ġ�ؾ� ��
���� : ���̺��� ��ü �÷��� ���� ����� ���� �÷��� ������ ������ ���� ����
*/

-- TEST ���̺� �� ���
SELECT * FROM TEST;
SELECT COUNT(*) FROM TEST;

INSERT INTO TEST (USERID, USERPWD, USERNAME, AGE, ENROLL_DATE)
VALUES ('user007', 'pass007', 'ȫ�浿', 27, SYSDATE);

INSERT INTO TEST
VALUES ('user008', 'pass008', '��ö��', 32, TO_DATE('20201225', 'RRRRMMDD'));

-- ��������(CONSTRAINT) : NOT NULL ----------------------------------------------------------
-- �÷��� �ݵ�� ���� ����ؾ� �� �� ������ (�ʼ� �Է� �׸��� �÷�)
-- �÷��� NULL(�� ĭ) ��� �� �Ѵٴ� �ǹ���.
-- �÷����������� ������ �� ����. (���̺������� ���� �� ��)

CREATE TABLE TESTNN (
    NNID  NUMBER(5)  NOT NULL,   -- �÷�����, �������� �̸� ���� (SYS_C.......)
    NN_NAME  VARCHAR2(20)
);

INSERT INTO TESTNN (NNID, NN_NAME)
VALUES (1, '����Ŭ');

INSERT INTO TESTNN
VALUES (NULL, '�ڹ�');  -- NOT NULL �������� �����. ����

INSERT INTO TESTNN (NN_NAME)  -- ���ܵ� �÷��� NULL �� ��
VALUES ('ORACLE');  -- �� �߰�, NOT NULL �������� �����, ����

INSERT INTO TESTNN
VALUES (2, NULL);   -- �� �߰�

INSERT INTO TESTNN (NNID)
VALUES (3);  -- �� �߰�

SELECT * FROM TESTNN;

-- NOT NULL : ���̺��� ���� Ȯ��
CREATE TABLE TESTNN2 (
    NN_ID  NUMBER(5),
    NN_NAME VARCHAR2(20),
    -- ���̺���
    CONSTRAINT NN_TN2_ID NOT NULL (NN_ID)  -- ����
);  -- NOT NULL �� ���̺������� ���� �� ��

--  �ذ�
CREATE TABLE TESTNN2 (
    NN_ID  NUMBER(5) CONSTRAINT NN_TN2_ID NOT NULL,
    NN_NAME VARCHAR2(20)
);

-- �������� : UNIQUE ----------------------------------------------------------------------------
-- �÷��� �ߺ���(���� �� �ι� ���)�� ���� ����������.
-- �ߺ� ����� ���� �˻� ���
-- �÷�����, ���̺��� �� �� ��� ����
-- NULL ����� �� ����

CREATE TABLE TESTUN (
    UN_ID  CHAR(3)  UNIQUE,
    UN_NAME VARCHAR2(10)  NOT NULL
);

INSERT INTO TESTUN VALUES ('AAA', '����Ŭ');
INSERT INTO TESTUN VALUES ('AAA', '�ڹ�');  -- ��ϵǾ� �ִ� �� �ߺ� ��� : ����
INSERT INTO TESTUN VALUES (NULL, '�ڹ�');

SELECT * FROM TESTUN;

-- ���̺������� ����
CREATE TABLE TESTUN2 (
    UN_ID  CHAR(3),
    UN_NAME VARCHAR2(10)  CONSTRAINT NN_TUN2_NAME NOT NULL,
    -- ���̺���
    --UNIQUE (UN_ID)
    CONSTRAINT UN_TUN2_ID UNIQUE (UN_ID)
);

-- UNIQUE ���������� ���̺������� ����Ű(���� ���� �÷��� ���)�� ������ ���� ����
CREATE TABLE TESTUN3 (
    UN_ID CHAR(3),
    UN_NAME VARCHAR2(10)  NOT NULL,
    UN_CODE  CHAR(2),
    CONSTRAINT UN_TUN3_COMP  UNIQUE (UN_ID, UN_NAME)  -- ����Ű
);
-- ���� ���� �÷��� ��� �ϳ��� ���������� ������ ����,
-- ������ �÷������� �ϳ��� �ܾ�� ���� �ߺ��� �Ǵ���.

INSERT INTO TESTUN3 VALUES ('100', '����Ŭ', '01');
INSERT INTO TESTUN3 VALUES ('200', '����Ŭ', '01');
-- �ߺ� �Ǵ� : '100 ����Ŭ'  != '200 ����Ŭ'
INSERT INTO TESTUN3 VALUES ('200', '����Ŭ', '02'); -- ����
-- �ߺ� �Ǵ� : '200 ����Ŭ' = '200 ����Ŭ'

-- UNIQUE ����Ű�� ���� NULL ����
INSERT INTO TESTUN3 VALUES (NULL, '����Ŭ', '03');
INSERT INTO TESTUN3 VALUES ('200', NULL, '03');  -- NOT NULL �������� �����

SELECT * FROM TESTUN3;

-- �������� : PRIMARY KEY ---------------------------------------------------------------------
-- �⺻Ű ��� ��. (�����ͺ��̽� ����ȭ ���������� IDENTIFIER (�ĺ���)�� ����)
-- ���̺��� �� ���� ������ ã�� ���� �̿��ϴ� �÷��� �ǹ���
-- NOT NULL + UNIQUE
-- �� ���̺� �� ���� ����� �� ����.

CREATE TABLE TESTPK (
    PID  NUMBER  PRIMARY KEY,
    PNAME  VARCHAR2(15)  NOT NULL,
    PDATE  DATE
);

INSERT INTO TESTPK VALUES (1, 'ȫ�浿', '15/03/12');
INSERT INTO TESTPK VALUES (2, '������', TO_DATE('17/05/10'));
INSERT INTO TESTPK VALUES (NULL, '�̼���', SYSDATE);  -- ERROR : NULL
INSERT INTO TESTPK VALUES (2, '�̼���', SYSDATE);  -- ERROR : UNIQUE(�ߺ�)

SELECT * FROM TESTPK;

-- ���̺�� 1���� ����
CREATE TABLE TESTPK2 (
    PID NUMBER CONSTRAINT PK_TP2_ID  PRIMARY KEY,
    PNAME VARCHAR2(15)  PRIMARY KEY
);  -- ERROR

-- PRIMARY KEY ���������� �÷�����, ���̺��� �� �� ���� ������
CREATE TABLE TESTPK2 (
    PID NUMBER  CONSTRAINT PK_TP2_ID  PRIMARY KEY,  -- �÷�����
    PNAME  VARCHAR2(15),
    PDATE  DATE
);

CREATE TABLE TESTPK3 (
    PID  NUMBER,
    PNAME  VARCHAR2(15),
    PDATE  DATE,
    -- ���̺���
    CONSTRAINT PK_TPK3_ID  PRIMARY KEY (PID)
);

-- PRIMARY KEY �� ����Ű�� ������ �� ����.
-- ���̺������� ����Ű ������
CREATE TABLE TESTPK4 (
    PID   NUMBER,
    PNAME VARCHAR2(15),
    PDATE  DATE,
    CONSTRAINT PK_TPK4_COMP  PRIMARY KEY (PID, PNAME)
);

INSERT INTO TESTPK4 VALUES ('100', '����Ŭ', SYSDATE);
-- ����Ű�� ������ �� ���� �ܾ�� �����ϰ� �ߺ��� �Ǵ��ϸ� ��
INSERT INTO TESTPK4 VALUES ('100', '����Ŭ', SYSDATE);  -- '100 ����Ŭ' = '100 ����Ŭ' : ����
-- NULL ��� �� ��
INSERT INTO TESTPK4 VALUES (NULL, '�ڹ�', SYSDATE);  -- ERROR
INSERT INTO TESTPK4 VALUES ('200', NULL, SYSDATE);  -- ERROR

SELECT * FROM TESTPK4;

-- �������� : CHECK --------------------------------------------------------------------------
-- �÷��� ��ϵǴ� ���� ������ ������ �� �����
-- �÷�����, ���̺��� �� �� ���� ������
-- [CONSTRAINT �����̸� ] CHECK (�÷��� ������ ���Ѱ�)
-- ���Ѱ��� �ݵ�� ���ͷ�(��)�� ����� �� ����. �Լ� ��� �� �� (���� ������ �ٲ�� ���� ��� �� ��)

CREATE TABLE TESTCHK (
    C_NAME  VARCHAR2(15)  CONSTRAINT NN_TCK_NAME  NOT NULL,
    C_PRICE  NUMBER(5)  CHECK (C_PRICE BETWEEN 1 AND 99999),
    C_LEVEL  CHAR(1)  CHECK (C_LEVEL IN ('A', 'B', 'C'))
);

INSERT INTO TESTCHK VALUES ('������21', 6500, 'A');
INSERT INTO TESTCHK VALUES ('LG G7', 1250000, 'B');  -- ERROR : C_PRICE �� ���� �ʰ�
INSERT INTO TESTCHK VALUES ('LG G7', 0, 'B'); -- ERROR : C_PRICE �� ���� �ʰ�
INSERT INTO TESTCHK VALUES ('LG G7', 7500, 'D');  -- ERROR : C_LEVEL 
INSERT INTO TESTCHK VALUES ('LG G7', 7500, 'a');  -- ERROR : C_LEVEL 

SELECT * FROM TESTCHK;

-- ���Ѱ� ����, AND, OR ���
CREATE TABLE TESTCHK2 (
    C_NAME  VARCHAR2(15 CHAR) PRIMARY KEY,
    C_PRICE  NUMBER(5)  CHECK (C_PRICE >= 1 AND C_PRICE <= 99999),
    C_LEVEL  CHAR(1)  CHECK (C_LEVEL = 'A' OR C_LEVEL = 'B' OR C_LEVEL = 'C'),
    --C_DATE   DATE  CHECK (C_DATE < SYSDATE)  -- ERROR : ���Ѱ��� �ٲ�� �Լ��� ��� �� ��
    C_DATE  DATE CHECK (C_DATE > TO_DATE('16/01/01', 'YYYY/MM/DD'))
);

-- �������� :  FOREIGN KEY (�ܷ�Ű | ����Ű) ------------------------------------------------------------------------
-- �ٸ�(����) ���̺��� �����ϴ� ���� ��Ͽ� ����� �� �ִ� �÷� ������ �����
-- FOREIGN KEY �������� �������� ���̺� ���̿� ����(RELATIONAL)�� ������
-- �÷�����, ���̺��� �� �� ���� ������
-- �÷����� : 
-- �÷��� �ڷ���(ũ��) [CONSTRAINT �����̸�] REFERENCES ���������̺�� [(�������÷���)]
-- ���̺��� : 
-- [CONSTRAINT �����̸�] FOREIGN KEY (������ �÷���) REFERENCES ���������̺�� [(�������÷���)]
-- (�������÷���) �����ϸ�, �������̺�(���������̺��� ����)�� �⺻Ű(PRIMARY KEY) �÷��� ����Ѵٴ� �ǹ���
-- REFERENCES �� �÷�(�������÷�)�� �ݵ�� PRIMARY KEY | UNIQUE ���������� �����Ǿ�� ��.
-- ��������� �ǹ� : �����Ǵ� ���� ��Ͽ� ����� �� ����. �������� �ʴ� ���� ����ϸ� ������
-- NULL �� ����� �� ����

CREATE TABLE TESTFK (
    EMP_ID  CHAR(3) REFERENCES EMPLOYEE,
    DEPT_ID CHAR(2) CONSTRAINT FK_TFK_DID REFERENCES DEPARTMENT (DEPT_ID),
    JOB_ID  CHAR(2),
    -- ���̺���
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

-- �������̺��� �����÷��� �ݵ�� PK �̰ų� UNIQUE ������ �Ǿ�� ��
CREATE TABLE TEST_NOPK (
    ID  CHAR(3),
    NAME  VARCHAR2(15)
);

CREATE TABLE TESTFK2 (
    FID  CHAR(3)  REFERENCES TEST_NOPK,  -- �����÷� �����Ǹ� �ڵ����� PK �÷��� ������ : ERROR
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
    FID  CHAR(3)  REFERENCES TEST_NOPK3,  -- PK �÷� �ڵ� ����
    FNAME  VARCHAR2(15) REFERENCES TEST_NOPK3 (NAME)
);

-- �ǽ�
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

-- �⺻������ FOREIGN KEY ���������� �����Ǹ�, ���� �����ϴ� �������̺��� �÷����� �Ժη� ���� �� ��
-- �����÷�(�θ�Ű)�� ���� �ڽķ��ڵ� �ʿ��� ���ǰ� ������ ���� �� ��
-- ��, EMPLOYEE.DEPT_ID �� ��ϵ� '90' �μ��ڵ尡 ������, DEPARTMENT.DEPT_ID �� '90' �μ��� ���� ���Ѵٴ� �ǹ���.

-- DML : DELETE �� 
-- �� ���� ������ (�� ������ �پ��)
-- ������� : DELETE FROM ���̺�� WHERE �÷��� �񱳿����� ���������ǰ�;
-- ���ǿ� �ش�Ǵ� ���� �ִ� ���� �����϶�� �ǹ���.

DELETE FROM DEPARTMENT
WHERE DEPT_ID = '90';  -- ���� �Ұ���, ERROR

-- �ʿ�ÿ� FOREIGN KEY �������� �����ÿ� �̸� ���� �ɼ�(���� ���)�� �߰��� �� ����
-- �θ�Ű�� ������ �� �ְ� ��
-- ON DELETE SET NULL : �θ�Ű�� �����Ǹ�, �ڽķ��ڵ�(�� ����÷�)�� ���� NULL �� �ٲ�
-- ON DELETE CASCADE : �θ�Ű�� �����Ǹ�, �ڽķ��ڵ尡 �ִ� ���� ���� ������
-- ON DELETE RESTRICTED : �⺻����. ���� �Ұ����� �ǹ���

CREATE TABLE PRODUCT_STATE (
    PSTATE  CHAR(1)  PRIMARY KEY,
    PCOMMENT VARCHAR2(10)
);

INSERT INTO PRODUCT_STATE VALUES ('A', '�ְ��');
INSERT INTO PRODUCT_STATE VALUES ('B', '����');
INSERT INTO PRODUCT_STATE VALUES ('C', '����');

SELECT * FROM PRODUCT_STATE;

-- �ڽķ��ڵ尡 �ִ� ���̺�
CREATE TABLE PRODUCT (
    PNAME  VARCHAR2(20)  PRIMARY KEY,
    PRICE  NUMBER  CHECK (PRICE > 0),
    PSTATE  CHAR(1)  REFERENCES PRODUCT_STATE ON DELETE SET NULL
);

INSERT INTO PRODUCT VALUES ('�����ó�Ʈ', 1250000, 'A');
INSERT INTO PRODUCT VALUES ('G9', 650000, 'C');
INSERT INTO PRODUCT VALUES ('������S21', 1000000, 'B');

SELECT * FROM PRODUCT;

SELECT * 
FROM PRODUCT
LEFT JOIN PRODUCT_STATE USING (PSTATE);

-- ON DELETE SET NULL : �θ�Ű�� �����Ǹ� �ڽķ��ڵ� ���� NULL �� �ٲ�
DELETE FROM PRODUCT_STATE
WHERE PSTATE = 'C';

SELECT * FROM PRODUCT_STATE;  -- �θ�Ű
SELECT * FROM PRODUCT; -- �ڽķ��ڵ�

-- ���� ��� : ROLLBACK (TCL : Transaction Controll Language)
ROLLBACK;

-- ON DELETE CASCADE : �θ�Ű�� �ڽķ��ڵ� �Բ� ����
CREATE TABLE PRODUCT2 (
    PNAME  VARCHAR2(20)  PRIMARY KEY,
    PRICE  NUMBER  CHECK (PRICE > 0),
    PSTATE  CHAR(1)  REFERENCES PRODUCT_STATE ON DELETE CASCADE
);

INSERT INTO PRODUCT2 VALUES ('�����ó�Ʈ', 1250000, 'A');
INSERT INTO PRODUCT2 VALUES ('G9', 650000, 'C');
INSERT INTO PRODUCT2 VALUES ('������S21', 1000000, 'B');

SELECT * FROM PRODUCT2;

-- ON DELETE CASCADE
DELETE FROM PRODUCT_STATE
WHERE PSTATE = 'A';

SELECT * FROM PRODUCT_STATE;  -- �θ�Ű ���� Ȯ��
SELECT * FROM PRODUCT2; -- �ڽķ��ڵ� �� �Բ� ���� Ȯ��

-- �θ�Ű(�������÷�)�� ����Ű(���� ���� �÷��� �ϳ��� ���� ��)�̸�
-- FOREIGN KEY �������� �����ϴ� �÷�(�ڽķ��ڵ�)�� ���� ����Ű���� ��
-- ����Ű�� ����Ű�� ��� �� ��, ����Ű�� FOREIGN KEY �������ǿ��� ����Ű�� ���� ���� ����

CREATE TABLE TEST_COMP (
    ID  NUMBER,
    NAME  VARCHAR2(10),
    PRIMARY KEY (ID, NAME)  -- ����Ű
);

INSERT INTO TEST_COMP VALUES (100, 'ORACLE');
INSERT INTO TEST_COMP VALUES (200, 'ORACLE');
INSERT INTO TEST_COMP VALUES (200, 'JAVA');

SELECT * FROM TEST_COMP;

CREATE TABLE TESTFK4 (
    FID  NUMBER,
    FNAME  VARCHAR2(10),
    --FOREIGN KEY (FID) REFERENCES TEST_COMP (ID)  -- ����Ű�� ���� ����Ű�� ��� �� ��
    FOREIGN KEY (FID, FNAME) REFERENCES TEST_COMP -- ����Ű�� ����Ű�� �����ؾ� ��
);
