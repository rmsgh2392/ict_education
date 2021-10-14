-- DAY9_DDL_DML2

-- ���������� ����ؼ� �� ���̺��� ���� �� ����

-- 90�� �μ��� ��������� EMP_COPY90 ���̺� ���� ó���Ѵٸ�...
CREATE TABLE EMP_COPY90
AS 
SELECT * FROM EMPLOYEE
WHERE DEPT_ID = '90';

SELECT * FROM EMP_COPY90;

-- �� ������ ���, �̸�, �޿�, �μ���, ���޸��� ��ȸ�ؼ�
-- TABLE_SUBQUERY1 ���̺� ���� ó���ϴ� ������ �ۼ� �����Ͻÿ�.
CREATE TABLE TABLE_SUBQUERY1
AS
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID);

-- Ȯ��
SELECT * FROM TABLE_SUBQUERY1;

-- DESCRIBE ��ɾ� (���Ӹ� : DESC)
-- DESCRIBE ���̺��;   �Ǵ� DESC ���̺��;
-- ���̺��� ���� ������ Ȯ���� �� ���� : �÷���, �ڷ���, NULLABLE ��
DESC EMP_COPY90;

-- ���������� �̿��ؼ� ���� ���̺��� ������ ���,
-- �÷���, �ڷ���, NOT NULL ���������� �״�� ���簡 ��
-- ������ ���������� ������� �ʴ´�.
CREATE TABLE EMP_COPY
AS
SELECT * FROM EMPLOYEE;

SELECT * FROM EMP_COPY;
DESC EMP_COPY;

-- ���� : 
-- ���, �̸�, �޿�, ���޸�, �μ���, �ٹ�������, �Ҽӱ����� ��ȸ�� �����
-- EMP_LIST ���̺� ������. (��ü ���� �������� ��)
CREATE TABLE EMP_LIST
AS
SELECT EMP_ID, EMP_NAME, SALARY, JOB_TITLE, DEPT_NAME, LOC_DESCRIBE, COUNTRY_NAME
FROM EMPLOYEE 
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN LOCATION ON (LOC_ID = LOCATION_ID)
LEFT JOIN COUNTRY USING (COUNTRY_ID);

-- Ȯ��
SELECT * FROM EMP_LIST;
DESCRIBE EMP_LIST;

-- �ǽ� 1 : EMPLOYEE ���̺��� ���� �������� ������ ��󳻼�
-- EMP_MAN ���̺� ������
CREATE TABLE EMP_MAN
AS
SELECT * FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3');

SELECT * FROM EMP_MAN;
DESC EMP_MAN;

-- ���� �������� ������ ��󳻼�, EMP_FEMAIL ���̺� ������
CREATE TABLE EMP_FEMALE
AS
SELECT * FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

SELECT * FROM EMP_FEMALE;
DESC EMP_FEMALE;

-- �ǽ� 2 : �μ����� ���ĵ� ������ ����� PART_LIST ���̺� ������
-- DEPT_NAME, JOB_TITLE, EMP_NAME, EMP_ID ������ ������ (�μ��� ���� ������������, ���޸� ��������)
-- ������ ���̺��� �� �÷��� �ּ�(COMMENT) �ޱ�
CREATE TABLE PART_LIST
AS
SELECT DEPT_NAME, JOB_TITLE, EMP_NAME, EMP_ID
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
ORDER BY DEPT_NAME ASC, 2;

SELECT * FROM PART_LIST;

COMMENT ON COLUMN PART_LIST.DEPT_NAME IS '�μ��̸�';
COMMENT ON COLUMN PART_LIST.JOB_TITLE IS '�����̸�';
COMMENT ON COLUMN PART_LIST.EMP_NAME IS '�����̸�';
COMMENT ON COLUMN PART_LIST.EMP_ID IS '���';

DESC PART_LIST;

-- ���������� �� ���̺� ���� ��, �÷����� �ٲ� �� ����.
-- ���ǻ��� : �������� SELECT ���� �÷� ������ �ٲ� �÷����� ������ ��ġ�ؾ� ��
/*
CREATE TABLE ���̺�� (�ٲ��÷���, .....)
AS ��������;
*/
CREATE TABLE TABLE_SUBQUERY2 (���, �̸�, �޿�, �μ���, ���޸�)
AS
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID);

SELECT * FROM TABLE_SUBQUERY2;
DESCRIBE TABLE_SUBQUERY2;

-- �Ϻ� �÷��� �ٲٰ��� �Ѵٸ�, SELECT ���� ��Ī ó����
CREATE TABLE PART_LIST2 --(DNAME, JTITLE, ENAME) : SELECT ���� �׸�� ������ ��ġ���� ������ ������
AS
SELECT DEPT_NAME DNAME, JOB_TITLE JTITLE, EMP_NAME ENAME, EMP_ID
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
ORDER BY DEPT_NAME ASC, 2;

SELECT * FROM PART_LIST2;
DESCRIBE PART_LIST2;

-- �ǽ� : ���������� ������ ���̺� �����
-- ���̺�� : PHONEBOOK
-- �÷��� :  ID  CHAR(3) �⺻Ű(�����̸� : PK_PBID)
--         PNAME      VARCHAR2(20)  �� ������.
--                                 (NN_PBNAME) 
--         PHONE      VARCHAR2(15)  �� ������
--                                 (NN_PBPHONE)
--                                 �ߺ��� �Է¸���
--                                 (UN_PBPHONE)
--         ADDRESS    VARCHAR2(100) �⺻�� ������
--                                 '����� ���α�'

-- NOT NULL�� �����ϰ�, ��� ���̺� �������� ������.

CREATE TABLE PHONEBOOK (
    ID CHAR(3),
    PNAME VARCHAR2(20)  CONSTRAINT NN_PBNAME NOT NULL,
    PHONE VARCHAR2(15)  CONSTRAINT NN_PBPHONE NOT NULL,
    ADDRESS VARCHAR2(100) DEFAULT '����� ���α�',
    CONSTRAINT PK_PBID PRIMARY KEY (ID),
    CONSTRAINT UN_PBPHONE UNIQUE (PHONE)
);

INSERT INTO PHONEBOOK 
VALUES ('A01', 'ȫ�浿', '010-1234-5678', DEFAULT);

SELECT * FROM PHONEBOOK;

-- ������ ��ųʸ� (������ ����)
-- ����ڰ� ������ ��� �����ͺ��̽� ��ü ������ ���̺� ���·� �ڵ� ��������Ǵ� ����
-- ��ȸ�� �� �� �ְ�, ������ �� ��
-- DBMS �ý��ۿ� ���� �ڵ� �����ǰ� ����
-- ���� ���, ����ڰ� ������ �������ǵ� �ڵ� ���� �����ǰ� ���� : USER_CONSTRAINTS

DESCRIBE USER_CONSTRAINTS;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'PHONEBOOK';

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMPLOYEE';

-- CONSTRAINT_TYPE (�������� ����)
-- P : PRIMARY KEY
-- U : UNIQUE
-- C : CHECK, NOT NULL
-- R : FOREIGN KEY

-- ���������� ������ ���̺��� ���� ��, �����ʹ� �������� �ʰ� ������ �����ϰ��� �Ѵٸ�
-- �������� WHERE ���� 1 = 0 ��� ����ϸ� ��
CREATE TABLE DEPT_COPY
AS
SELECT * FROM DEPARTMENT
WHERE 1 = 0;  -- ���̺� ������ ������

SELECT * FROM DEPT_COPY;
DESC DEPT_COPY;

-- ���������� �� ���̺� ���� ��, �÷����� �ٲٸ鼭 �������ǵ� �߰��� �� ����
-- FOREIGN KEY ���������� �߰��� �� ����
-- ���ǻ��� : ���������� �� �÷��� ������� ���߾ ���������� �߰��ؾ� ��

CREATE TABLE TABLE_SUBQUERY3 (
    EID PRIMARY KEY,
    ENAME,
    SAL CHECK (SAL > 2000000),  -- ERROR : �������� ������� ���� ���� (2�鸸���� ���� ���� ���� ��ϵǾ� ����)
    DNAME,
    JTITLE NOT NULL  -- ERROR : ���� �÷��� NULL �� ����
)
AS
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
-- CHECK (SAL > 2000000) �ذ� ��ġ
WHERE SALARY > 2000000
-- NOT NULL �ذ� ��ġ
AND JOB_TITLE IS NOT NULL;

-- ������ ��ųʸ�
-- ����ڰ� ������ ���̺� ���� : USER_TABLES, USER_CATALOGS, USER_OBJECTS
SELECT * FROM USER_TABLES;

-- ����ڰ� ���� �������� ���� : USER_CONSTRAINTS, USER_CONS_COLUMNS
SELECT * FROM USER_CONSTRAINTS;

-- JOIN ����
-- INNER JOIN, OUTER JOIN, CROSS JOIN, SELF JOIN, NATURAL JOIN

-- NATURAL JOIN
-- ������ �÷����� ������ �������� ����
-- ������ ���̺��� �⺻Ű(PRIMARY KEY)�� �̿��� EQUAL + INNER JOIN ��
SELECT *
FROM EMPLOYEE
NATURAL JOIN DEPARTMENT;

-- *************************************************************************
-- DML (Data Manipulation Language : ������ ���۾�)
-- INSERT, UPDATE, DELETE ��, TRUNCATE ��
-- ���̺� �����͸� ��� �����ϰų�(�� �߰�), ��ϵ� �����͸� �����ϰų�, ���� �����ϴ� ����
-- INSERT �� : �� �߰� (�� ��� ����)
-- UPDATE �� : �� ���� (�� ���� ��ȭ����)
-- DELETE �� : �� ���� (�� ���� �پ��), ���� ����
-- TRUNCATE �� : ���̺��� ��� ���� ������ (���� �� ��)

-- UPDATE ��
/*
������� : 
UPDATE ���̺��
SET ���������÷��� = �����Ұ�, �÷��� = �����Ұ�, .........
WHERE �÷��� ������ ���Ⱚ;

���ǻ��� : WHERE ���� �����Ǹ�, ���̺� ��ü �÷��� ���� ������.
���� : SET ���� ������ �� �ڸ��� �������� ����� �� ����.
      WHERE ���� ã���� ��� �������� ����� �� ����.
*/

CREATE TABLE DCOPY
AS
SELECT * FROM DEPARTMENT;

SELECT * FROM DCOPY;

UPDATE DCOPY
SET DEPT_NAME = '�λ���';
-- WHERE ���� �����Ǹ� �ش� �÷� ��ü ���� ������

-- ��� ����� DML ���� ���� ���
ROLLBACK;

-- �μ��ڵ� 10�� �μ����� �λ������� �ٲ۴ٸ�
UPDATE DCOPY
SET DEPT_NAME = '�λ���'
WHERE DEPT_ID = '10';

SELECT * FROM DCOPY;

-- UPDATE ���� �������� ����� �� ����
-- SET ���� WHERE ���� ��� ������

-- ���ϱ� ������ �����ڵ�� �޿��� ����
-- ���ر� ������ ���� ����, ���� �޿��� ���� ó�� �Ͻÿ�.
SELECT JOB_ID, SALARY  -- J7 1900000
FROM EMPLOYEE
WHERE EMP_NAME = '���ر�';

SELECT JOB_ID, SALARY  -- NULL 2300000
FROM EMPLOYEE
WHERE EMP_NAME = '���ϱ�';

UPDATE EMPLOYEE
SET JOB_ID = 'J7', SALARY = 1900000
WHERE EMP_NAME = '���ϱ�';

SELECT * FROM EMPLOYEE
WHERE EMP_NAME IN ('���ر�', '���ϱ�');

ROLLBACK;  -- UPDATE ���

-- ���������� �����Ѵٸ�...
UPDATE EMPLOYEE
SET JOB_ID = (SELECT JOB_ID FROM EMPLOYEE
              WHERE EMP_NAME = '���ر�'), 
    SALARY = (SELECT SALARY FROM EMPLOYEE
              WHERE EMP_NAME = '���ر�')
WHERE EMP_NAME = '���ϱ�';

-- ���������� ���߿� ���������� �ٲ۴ٸ�...
UPDATE EMPLOYEE
SET (JOB_ID, SALARY) = (SELECT JOB_ID, SALARY 
                        FROM EMPLOYEE
                        WHERE EMP_NAME = '���ر�')    
WHERE EMP_NAME = '���ϱ�';

-- ���̺� �����ÿ� �÷��� DEFAULT ������ �� ��쿡�� INSERT | UPDATE �ÿ�
-- ����� �� | ������ �� ��ſ� DEFAULT Ű���带 ����� �� ����.

-- ���� �� Ȯ��
SELECT EMP_NAME, MARRIAGE  -- ���켷 Y
FROM EMPLOYEE
WHERE EMP_ID = '210';

-- ����
UPDATE EMPLOYEE
SET MARRIAGE = DEFAULT
WHERE EMP_ID = '210';

-- ���� �� Ȯ��
SELECT EMP_NAME, MARRIAGE  -- ���켷 N
FROM EMPLOYEE
WHERE EMP_ID = '210';

ROLLBACK;

-- UPDATE �� WHERE ������ �������� ���
-- �ؿܿ���2�� �������� ���ʽ�����Ʈ�� ��� 0.3 ���� �����Ͻÿ�.
UPDATE EMPLOYEE
SET BONUS_PCT = 0.3
WHERE DEPT_ID = (SELECT DEPT_ID
                  FROM DEPARTMENT
                  WHERE DEPT_NAME = '�ؿܿ���2��');

-- Ȯ��
SELECT EMP_NAME, DEPT_ID, BONUS_PCT
FROM EMPLOYEE
WHERE DEPT_ID = (SELECT DEPT_ID
                  FROM DEPARTMENT
                  WHERE DEPT_NAME = '�ؿܿ���2��');

ROLLBACK;

-- INSERT ��
-- ���̺� ���ο� ���� �߰��� �� ����� : �� ������ �þ
-- ���̺� �����͸� ��� �����ϱ� ���� �����
/*
INSERT INTO ���̺�� (����� �÷���, ..........)
VALUES (������ �÷��� ����� ��, ........)

�÷��� ������ �����Ǹ�, ���̺��� ���� ��� �÷��� ���� ����Ѵٴ� �ǹ���
���ǻ��� : ������ �÷��� ����� ���� ������ ��ġ�ؾ� ��, ����, �ڷ����� ��ġ�ؾ� ��.
        ���� ������ �����ؾ� �� (EMP_NO <= 'ȫ�浿' ��ϵǸ� �ȵ�)
*/
-- ���� ���� ����
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, HIRE_DATE, JOB_ID, SALARY, 
                        BONUS_PCT, MARRIAGE, MGR_ID, DEPT_ID)
VALUES ('900', '811225-2345678', '������', 'oyua@kkk.com', '01012345678', '06/01/01', 'J7', 2500000, 0, 'N', '176', '90');                        

SELECT * FROM EMPLOYEE
WHERE EMP_ID = '900';

ROLLBACK;  -- INSERT ���

-- INSERT �� �� ��ſ� NULL �� DEFAULT �� ����� �� �ִ�.
INSERT INTO EMPLOYEE
VALUES ('840', '������', '870115-2345678', 'hajiun@kkk.com', NULL, '07/06/15', 'J7', NULL, NULL, DEFAULT, '', DEFAULT);
-- DEFAULT �� �������� ���� �÷��� DEFAULT ����ϸ� NULL ó����.

SELECT * FROM EMPLOYEE;

ROLLBACK;

-- ���������� �̿��ؼ� INSERT �� �� �ִ�.
-- VALUES Ű���� ������� �ʴ´�.
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

-- DELETE ��
-- ���̺��� ���� �����ϴ� ����
/*
DELETE FROM ���̺��
WHERE ������ ���� ����;
*/

-- WHERE ���� �����Ǹ�, ���̺��� ��� ���� ������
SELECT * FROM DCOPY;

DELETE FROM DCOPY;
ROLLBACK;  -- DELETE �� ������ �� ����

-- TRUNCATE ��
-- ���̺��� ���� ��� ���� ������
-- ���� �� ��
TRUNCATE TABLE DCOPY;  -
SELECT * FROM DCOPY;
ROLLBACK;  -- ���� �� ��

-- DDL (Data Definition Language : ������ ���Ǿ�)
-- CREATE, ALTER, DROP
-- �����ͺ��̽� ��ü�� �����, �����ϰ�, �����ϴ� ������
-- ���̺� : CREATE TABLE, ALTER TABLE, DROP TABLE
-- �� : CREATE VIEW, DROP VIEW
-- ������ : CREATE SEQUENCE, ALTER SEQUENCE, DROP SEQUENCE
-- �ε��� : CREATE INDEX, DROP INDEX

-- ���̺� ����
-- �÷� �߰�/����, �������� �߰�/����
-- �÷� �ڷ��� ���� (�ڷ��� ũ�� ���� ����)
-- ���̺��, �÷���, �������� �̸� ����
-- DEFAULT �� ����

-- DEPT_COPY ���̺� ����
DROP TABLE DEPT_COPY;

CREATE TABLE DEPT_COPY
AS
SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- �÷� �߰�
-- ���̺� ������ �÷� �ۼ��� �����ϰ� �ۼ��ϸ� ��
ALTER TABLE DEPT_COPY
ADD ( LNAME VARCHAR2(40) );

-- Ȯ��
SELECT * FROM DEPT_COPY;
DESC DEPT_COPY;

ALTER TABLE DEPT_COPY
ADD ( CNAME  VARCHAR2(30) DEFAULT '�ѱ�' );

-- Ȯ��
SELECT * FROM DEPT_COPY;
DESC DEPT_COPY;

-- �������� �߰�
CREATE TABLE EMP2
AS
SELECT * FROM EMPLOYEE;
-- ���������� �̿��� ���̺� �����ÿ���
-- �÷���, �ڷ���(ũ��), NOT NULL ��������, DATA �� �����
-- ������ �������ǵ�� DEFAULT �� ���� �� ��

-- Ȯ��
SELECT * FROM EMP2;
DESC EMP2;

ALTER TABLE EMP2
ADD PRIMARY KEY (EMP_ID);

ALTER TABLE EMP2
ADD CONSTRAINT E2_UNENO UNIQUE (EMP_NO);

-- NOT NULL �� ADD �� �߰��� �� ����
-- MODIFY �� NULLABLE �� NO ���·� �ٲٴ� ����
ALTER TABLE EMP2
ADD NOT NULL (HIRE_DATE);  --ERROR

ALTER TABLE EMP2
MODIFY ( HIRE_DATE NOT NULL );

DESC EMP2;

-- �÷� �ڷ��� ����
-- ���� ��� �ִ� �÷��� �ƹ� �ڷ������γ� ���� ������
-- ���� ��ϵǾ� �ִ� ��쿡�� �������� ���������� ��ȯ ������. CHAR <==> VARCHAR2
-- ũ��� ���ų� ũ�� ������ �� ����
ALTER TABLE EMP2
MODIFY (EMP_ID VARCHAR2(3),
         EMP_NAME CHAR(20) );

DESC EMP2;

-- DEFAULT �� ����
CREATE TABLE EMP3 (
    EMP_ID  CHAR(3),
    EMP_NAME  VARCHAR2(20),
    ADDR1  VARCHAR2(20)  DEFAULT '����',
    ADDR2  VARCHAR2(100)
);

INSERT INTO EMP3 VALUES ('A01', '������', DEFAULT, '÷�絿');
INSERT INTO EMP3 VALUES ('A02', '�̺���', DEFAULT, '���ﵿ');

SELECT * FROM EMP3;

ALTER TABLE EMP3
MODIFY ( ADDR1  DEFAULT '���' );

INSERT INTO EMP3 VALUES ('B03', '�ӽ¿�', DEFAULT, '���ڵ�');

SELECT * FROM EMP3;

-- �÷� ����
ALTER TABLE DEPT_COPY
DROP COLUMN CNAME;  -- �÷� 1�� ����

DESC DEPT_COPY;

ALTER TABLE DEPT_COPY
DROP ( LOC_ID, LNAME );  -- �÷� ���� �� ����

DESC DEPT_COPY;

-- �����ͺ��̽� ���̺��� �ּ� 1���� �÷��� ������ �־�� ��
-- �÷��� ���� ���̺��� ������ �� ����
-- ��� �÷��� ������ ���� ����
ALTER TABLE DEPT_COPY
DROP (DEPT_ID, DEPT_NAME);  -- ERROR

CREATE TABLE TB1 ();  -- ERROR

-- �÷� ���Ž� �ٸ� ���̺��� FOREIGN KEY ������������ �����ǰ� �ִ� �÷�(�θ�Ű)�� ������ �� ����
-- DELETE OPTION �� �⺻���� RESTRICTED ��. (���� �Ұ���)
ALTER TABLE DEPARTMENT
DROP (DEPT_ID);  -- ERROR

-- ���������� ������ �÷��� ������ �� ����.
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

-- �������ǵ� �Բ� ����(CASCADE) �ϸ� ��
ALTER TABLE TB1
DROP (TPK) CASCADE CONSTRAINTS;

DESC TB1;

ALTER TABLE TB1
DROP COLUMN COL1 CASCADE CONSTRAINTS;

-- �������� ����
-- �������� ����� ���̺� �����
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

-- �������� 1�� ����
ALTER TABLE CONSTRAINT_EMP2
DROP CONSTRAINT CHK2;

-- ������ ��ųʸ��� Ȯ��
-- ����ڰ� ���� �������� ��ȸ : USER_CONSTRAINTS
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CONSTRAINT_EMP2';

-- �������� ���� �� ����
ALTER TABLE CONSTRAINT_EMP2
DROP CONSTRAINT FKJID2
DROP CONSTRAINT FKMID2
DROP CONSTRAINT FKDID2;

-- NOT NULL ���������� ������ �ƴ϶� ������
-- NOT NULL �� NULL �� �ٲ�
ALTER TABLE CONSTRAINT_EMP2
MODIFY (ENAME NULL, ENO NULL);

-- USER_CONSTRAINTS ��ųʸ� : �÷� ���� ����
-- �÷��� ���������� �����ϴ� ������ ��ųʸ� : USER_CONS_COLUMNS
DESC USER_CONS_COLUMNS;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, COLUMN_NAME, 
        DELETE_RULE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
JOIN USER_CONS_COLUMNS USING (CONSTRAINT_NAME, TABLE_NAME)
WHERE TABLE_NAME = 'CONSTRAINT_EMP2';

-- �̸� �ٲٱ� : ���̺��, �÷���, �������� �̸�
CREATE TABLE TB_EXAM (
    COL1  CHAR(3)  PRIMARY KEY,
    ENAME  VARCHAR2(20),
    FOREIGN KEY (COL1) REFERENCES EMPLOYEE
);

DESC TB_EXAM;

-- �÷��� �ٲٱ�
ALTER TABLE TB_EXAM
RENAME COLUMN COL1 TO EMPID;

DESC TB_EXAM;

-- �������� �̸� �ٲٱ�
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, COLUMN_NAME, 
        DELETE_RULE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
JOIN USER_CONS_COLUMNS USING (CONSTRAINT_NAME, TABLE_NAME)
WHERE TABLE_NAME = 'TB_EXAM';

ALTER TABLE TB_EXAM
RENAME CONSTRAINT SYS_C007444 TO PK_TBE_EID;

ALTER TABLE TB_EXAM
RENAME CONSTRAINT SYS_C007445 TO FK_TBE_EID;

-- ���̺� �̸� �ٲٱ�
ALTER TABLE TB_EXAM RENAME TO TB_SAMPLE1;
-- �Ǵ�
RENAME TB_SAMPLE1 TO TB_SAMPLE;

-- ���̺� �����ϱ�
-- DROP TABLE ���̺�� [CASCADE CONSTRAINTS];
DROP TABLE TB_SAMPLE;

-- �����Ǵ� ���̺�(FOREIGN KEY ������ ���� �θ�Ű�� �ִ� ���̺�) �� ���� �� ��
CREATE TABLE DEPT (
    DID CHAR(2) PRIMARY KEY,
    DNAME VARCHAR2(10)
);

CREATE TABLE EMP5 (
    EID  CHAR(3) PRIMARY KEY,
    ENAME VARCHAR2(10),
    DID CHAR(2) REFERENCES DEPT
);

DROP TABLE DEPT;  -- EMP5 ���� �����ϰ� ����. ���� �� ��
-- DEPT �� ���� REFERENCES ���������� �Բ� �����ϸ� ��
DROP TABLE DEPT CASCADE CONSTRAINTS;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, COLUMN_NAME, 
        DELETE_RULE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
JOIN USER_CONS_COLUMNS USING (CONSTRAINT_NAME, TABLE_NAME)
WHERE TABLE_NAME = 'EMP5';

