--������ ����ؼ� �� ���̺��� ���� �� �ִ�.

--90�� �μ��� ���� ����� EMP_COY90���̺� ����
CREATE TABLE EMP_COY90 
AS
SELECT * FROM EMPLOYEE
WHERE DEPT_ID LIKE '90'; --NOT NULL ���������� �ڵ����� ���簡 ������ 
                        -- ������ ���������� ���簡 �ȵȴ�.
SELECT * FROM EMP_COY90;

--�� ������ ���, �̸�, �޿�, �μ���, ���޸� �� ��ȸ�ؼ�
--TABLE_SUBQUERY1 ���̺� ���� ó���ϴ� ������ �ۼ� ����
CREATE TABLE TABLE_SUBQUERY1
AS
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE LEFT JOIN
      DEPARTMENT USING(DEPT_ID)
LEFT JOIN JOB USING(JOB_ID);

SELECT * FROM TABLE_SUBQUERY1;

--���̺��� ������ ������� �� ����ϴ� DESCRIBE ��ɾ�(����� : DESC)
--DESCIBE ���̺��; �Ǵ� DESC ���̺��;
--���̺��� ���� ������ Ȯ���� �� �ִ�. : �÷���, �ڷ���, �������� ���
DESCRIBE EMP_COY90;

CREATE TABLE EMP_COPY
AS
SELECT * 
FROM EMPLOYEE;

DESC EMP_COPY;

--���, �̸�, �޿�, ���޸�, �μ���, �ٹ�������, �Ҽӱ����� ��ȸ�� ��� ���̺�
--EMP_LIST ���̺� ������
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

-- ���� �������� ������ ��󳻼� ����
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

-- �μ����� ���ĵ� ������ ����� PART_LIST ���̺� ������
-- DEPT_NAME, JOB_TITLE, EMP_NAME, EMP_ID ������ ����
--������ ���̺��� �� �÷��� �ּ�(COMMENT) �ޱ�
CREATE TABLE PART_LIST
AS
SELECT DEPT_NAME, JOB_TITLE, EMP_NAME, EMP_ID --SELECT���� ������ �÷����� �״��
FROM EMPLOYEE LEFT JOIN                     --PART_LIST ���̺��� �÷����� ����.
      DEPARTMENT USING(DEPT_ID)
LEFT JOIN JOB USING(JOB_ID)
ORDER BY 1, 2;

COMMENT ON COLUMN PART_LIST.DEPT_NAME IS '�μ���';
COMMENT ON COLUMN PART_LIST.JOB_TITLE IS '���޸�';
COMMENT ON COLUMN PART_LIST.EMP_NAME IS '����̸�';
COMMENT ON COLUMN PART_LIST.EMP_ID IS '���';
SELECT * FROM PART_LIST;

--���������� �� ���̺��� ���� ��, �÷����� �ٲ� �� �ִ�.
--���ǻ���: �������� SELECT ���� �÷� ������ �ٲ� �÷����� ������ ��ġ�ؾ� �Ѵ�.
/*
CREATE TABLE ���̺�� ( �ٲ� �÷��� ...) 
AS ��������;
*/
CREATE TABLE TABLE_SUBQUERY2 (���, ����̸�, �޿�, �μ���, ���޸�)
AS
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE LEFT JOIN
      DEPARTMENT USING(DEPT_ID)
LEFT JOIN JOB USING(JOB_ID);
SELECT * FROM TABLE_SUBQUERY2;
DESC TABLE_SUBQUERY2;

--�Ϻ� �÷��� �ٲٰ� ������
CREATE TABLE PART_LIST2 --(DNAME, JTITLE, ENAME ) -- SELECT �� �׸�� ������ ��ġ���� ����
AS
SELECT DEPT_NAME DNAME, JOB_TITLE JTITLE, EMP_NAME ENAME, EMP_ID 
FROM EMPLOYEE LEFT JOIN                    
      DEPARTMENT USING(DEPT_ID)
LEFT JOIN JOB USING(JOB_ID)
ORDER BY 1, 2;

SELECT * FROM PART_LIST2;
DESC PART_LIST2;

--���� ������ ������ ���̺� �����
CREATE TABLE PHONEBOOK(
    ID CHAR(3) , --�⺻Ű ���� (PK_PBID �����̸�)
    PNAME VARCHAR(20) CONSTRAINT NN_PBNAME NOT NULL, --�� ������ (NN_PBNAME �����̸�)
    PHONE VARCHAR2(15) CONSTRAINT NN_PBPHONE NOT NULL, -- NULL ������ �ߺ��� ������
    ADDRESS VARCHAR(100) DEFAULT '����� ���α�', --�⺻�� ����
    CONSTRAINT PK_PBID PRIMARY KEY ( ID) ,
    CONSTRAINT UN_PBPHONE UNIQUE (PHONE)
);
INSERT INTO PHONEBOOK
VALUES ('A', 'ī����', '010-2323-4422', DEFAULT);
INSERT INTO PHONEBOOK
VALUES ('A01', '����', '010-1223-4444', '����� ������');
SELECT * FROM PHONEBOOK;

-----------------------------------------------------
--������ ���ʸ�
DESC USER_CONSTRAINTS; --�������� ���� ��ųʸ� ��ȸ

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE,
        TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME LIKE 'PHONEBOOK';

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE,
        TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME LIKE 'EMPLOYEE';
--��ųʸ��� ����Ǵ� ���������� ����(CONSTRAINT_TYPE), ����
--P : PRIMARY KEY
--U : UNIQUE
--C : CHECK, NOT NULL
--R : REFERENCES / FOREIGN KEY
---------------------------------------------------------------------------------
-- ���������� ������ ���̺��� ���� ��, �����ʹ� �������� �ʰ� ������ �����ϰ��� �Ѵٸ�
-- �������� WHERE ���� 1 = 0 ��� ����ϸ� �����ʹ� �������� �ʰ� ������ �����Ѵ�.
CREATE TABLE DEPT_COPY
AS
SELECT *
FROM DEPARTMENT
WHERE 1 LIKE 0; --DEPARTMENT ���̺��� ������ ����

SELECT * FROM DEPT_COPY;
DESC DEPT_COPY;

--���������� �� ���̺��� ���� ��, �÷����� �ٲٸ鼭 �������ǵ� �߰��� �� �ִ�.
--���ǻ��� : (1) FOREIGN KEY ���������� �߰��� �� ����.
--(2) ���������� �� �÷��� ������� ���߾ ���������� �߰��ؾ��Ѵ�.
--   ��ϵǾ� �ִ� �÷��� ���� ���� ���߾� ���������� �߰��ؾ��Ѵ�.
CREATE TABLE TABLE_SUBQUERY3 (
    EID PRIMARY KEY, --���� �⺻Ű�� �����Ǿ��ֱ⶧���� �������
    ENAME ,
    SAL CHECK (SAL > 2000000), --ERROR �������� ������� ���� ����(2�鸸���� ���� �޴� �޿��� ����)
    DNAME,
    JTITLE NOT NULL --ERROR : ���� �������� ��� ���� NULL�� ����
)
AS
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE LEFT JOIN
      DEPARTMENT USING(DEPT_ID)
LEFT JOIN JOB USING(JOB_ID)
--CHECK (SAL > 2000000) �ذ���ġ
WHERE SALARY > 2000000
-- JTITLE NOT NULL �ذ���ġ
AND JOB_TITLE IS NOT NULL;

SELECT * FROM TABLE_SUBQUERY3;
DESC TABLE_SUBQUERY3;

--������ ��ųʸ� 
--����ڰ� ������ ���̺� ���� : USER_TABLES, USER_CATALOGS, USER_OBJECTS
SELECT * FROM USER_TABLES;
--����ڰ� ���� �������� ���� : USER_CONSTRAINTS, USER_CONS_COLUMNS
SELECT * FROM USER_CONS_COLUMNS;

---NATURAL JOIN
SELECT *
FROM EMPLOYEE NATURAL JOIN
DEPARTMENT; --DEPRATMENT�� PK DEPT_ID�� �̿��ؼ� �����Ѵ�.

----------------------------------------------------------------------------------------
/* DML (DATA Manipulation Language : ������ ���۾�)
  INSERT, UPDATE, DELETE ��, TRUNCATE ��
  ���̺� �����͸� ��� �����ϰų�(�� �߰�), ��ϵ� �����͸� �����ϰų�, ���� �����ϴ� ����
  INSERT �� : �� �߰�(�� ��� ���� �뵵)
  UPDATE �� : ���� ����(�� �������� ��ȯ�� ����)
  DELETE �� :  ���� ���� (�� ������ �پ��), ������ �����ϴ� (ROLLBACK)
  TRUNCATE �� : ���̺��� ��� ���� ���� BUT ������ �ȵȴ�.
*/

/*******************
    UPDATE ��
    ���� : UPDATE table_name
          SET column_name(�� ������ �÷���) = value (�������� ��밡��, DEFAULT�ɼ� �� ��밡��)
        [ WHERE condition (��������) / �������� ��밡��]; -> �����ϸ� ��� ���� ����
    ������� : UPDATE ���̺��
              SET �� ������ �÷��� = ������ �� ...
              WHERE �÷��� ������ ���Ⱚ;
    ������ ���� :  WHERE ���� �����Ǹ�, ���̺� ��ü �÷��� ���� �����ȴ�.
    ���� : SET ���� ������ �� �ڸ��� �������� ��� �����ϸ�,
          WHERE ������ ã�� �� ��� �������� ����Ҽ� �ִ�.
***********************************************************/
CREATE TABLE COPY
AS
SELECT * FROM DEPARTMENT;

SELECT * FROM COPY;

UPDATE COPY
SET DEPT_NAME = '�λ���'; --WHERE ���� �����Ǹ� �ش� �÷��� ��ü ���� �����ȴ�!!

--��� ����� DML ������ ������� �Ҽ� �ִ�.
ROLLBACK; --��ɾ�

-- �μ��ڵ� 10�� �μ����� �λ������� �ٲ۴ٸ�
UPDATE COPY
SET DEPT_NAME = '�λ���'
WHERE DEPT_ID LIKE '10';

--UPDATE ���� �������� ����� �� ����
--SET ���� WHERE ���� ��밡��
-- ���ϱ� ������ �����ڵ�� �޿��� ����
-- �ٲ� �� ���ر� ������ ���� ���� ���� �޿��� ����
SELECT JOB_ID, SALARY --J7, 1900000
FROM EMPLOYEE
WHERE EMP_NAME LIKE '���ر�';

SELECT JOB_ID, SALARY
FROM EMPLOYEE -- NULL, 23000000
WHERE EMP_NAME LIKE '���ϱ�';

UPDATE EMPLOYEE
SET JOB_ID = 'J7', SALARY = 1900000
WHERE EMP_NAME LIKE '���ϱ�';

-- �������� ����
UPDATE EMPLOYEE
SET JOB_ID = (SELECT JOB_ID FROM EMPLOYEE WHERE EMP_NAME LIKE '���ر�'), --������
    SALARY = (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME LIKE '���ر�')
WHERE EMP_NAME LIKE '���ϱ�';
ROLLBACK;

-- ���߿� ���������� �ٲ۴ٸ�
UPDATE EMPLOYEE
SET (JOB_ID, SALARY) = (SELECT JOB_ID, SALARY
                       FROM EMPLOYEE
                       WHERE EMP_NAME LIKE '���ر�')
WHERE EMP_NAME LIKE '���ϱ�';

--���̺� ������ �÷��� DEFAULT ������ �� ��쿡�� INSERT �Ǵ� UPDATE �ҽÿ�
--����� �� �Ǵ� ������ �� ��ſ� DEFAULT Ű���带 ����� DEFAULT���� ����Ѵ�.

-- ���� �� Ȯ��
SELECT EMP_NAME, MARRIAGE
FROM EMPLOYEE
WHERE EMP_ID LIKE '210'; -- ���켷 , Y 

--����
UPDATE EMPLOYEE
SET MARRIAGE = DEFAULT
WHERE EMP_ID LIKE '210';

--���� ��Ȯ��
SELECT EMP_NAME, MARRIAGE
FROM EMPLOYEE
WHERE EMP_ID LIKE '210';

ROLLBACK;

--UPDATE ������ WHERE �������� �������� ���
UPDATE EMPLOYEE
SET BONUS_PCT = 0.3
WHERE DEPT_ID LIKE (SELECT DEPT_ID
                    FROM DEPARTMENT
                    WHERE DEPT_NAME LIKE '�ؿܿ���2��');
--Ȯ��
SELECT EMP_NAME, DEPT_ID, BONUS_PCT
FROM EMPLOYEE
WHERE DEPT_ID LIKE (SELECT DEPT_ID
                    FROM DEPARTMENT
                    WHERE DEPT_NAME LIKE '�ؿܿ���2��');
                    
ROLLBACK;
-----------------------------------------------------------------------------
/* INSERT �� 
  ���̺� ���ο� ���� �߰��� �� ����Ѵ� : �� ������ �þ
  ���̺� �����͸� ��� �����ϱ� ���� ���
  ��� ���� : INSERT INTO ���̺�� (���� ����� �÷���,.......)
             VALUES (������ �÷��� ����� ��...)
  �� ���� ���� ����� �÷��� ������ �����Ǹ�, ���̺��� ���� ��� �÷��� ���� ����Ѵٴ� �ǹ��̴�.
  �� ���ǻ��� : ������ �÷��� ����� ���� ������ ��ġ�ؾ��ϸ�, ����, �ڷ����� ��ġ�ؾ� �ȴ�.
      ���� ������ �����ؾ��Ѵ� (EMP_NO <�ֹι�ȣ>�ε� <= ȫ�浿 �̶�� ����ϸ� �ȵȴ�.)
      ���� FK�� ���������� ������ �÷��� �����ϴ� ���̶� �ٸ� ���� ���� ���ǿ� �����ؼ��� �ȵȴ�.
*/
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, SALARY, BONUS_PCT,
                        EMAIL, PHONE, HIRE_DATE, JOB_ID, MARRIAGE, MGR_ID, DEPT_ID)
VALUES ('555', '811225-2345678', 'ī����', 200000, 1.5, 'karina@kkk.com', '01099992222',
        '20/03/25', 'J4', DEFAULT, '101', '50'); --ERROR�� �ȳ����� ���� ���� 
        --�̸��� ���ڸ��� �ֹι�ȣ�� �־� ���߿� ���� ��ȸ�� �� �����.

SELECT * FROM EMPLOYEE WHERE EMP_ID LIKE '555';

ROLLBACK; --INSERT ���

--INSERT �� �� ��ſ� NULL �� DEFAULT�� ����Ҽ� �ִ�.
--EMP_ID, EMP_NAME, EMP_NO, SALARY, BONUS_PCT,
--EMAIL, PHONE, HIRE_DATE, JOB_ID, MARRIAGE, MGR_ID, DEPT_ID
INSERT INTO EMPLOYEE
VALUES ('456', '��¡��', '940501-1032456', 'squid@kkk.com', NULL, NULL, 'J4', NULL, NULL, DEFAULT, '', '');
         
SELECT * FROM EMPLOYEE;

ROLLBACK;

--���� ������ �̿��ؼ� INSERT �Ҽ� �ִ�.
--VALUES Ű���带 ������� �ʴ´�.
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

--DELETE ��
--���̺��� ���� �����ϴ� ����
--DELETE FROM ���̺��
--WHERE ������ ���� ���� �� WHERE���� �����Ǹ� ���̺��� ��� ���� ������

SELECT * FROM COPY;

DELETE FROM COPY;

ROLLBACK; --DELETE ����

--TRUNCATE ��
--���̺��� ���� ��� ���� �����Ѵ� BUT ������ �Ұ����ϴ�.
TRUNCATE TABLE COPY; 
SELECT * FROM COPY;
ROLLBACK; --������ �ȵ�

---------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
/* ���̺� : CREATE TABLE, ALTER TABLE, DROP TABLE
   �� : CREATE VIEW, DROP VIEW
   ������ : CREATE SEQUENCE, ALTER SEQUENCE, DROP SEQUENCE
   �ε��� : CREATE INDEX, DROP INDEX
*/
--���̺� ����
--�÷��� �߰� / ����, ���������� �߰� /����
--�÷� �ڷ��� ���� (�ڷ��� ũ�⵵ ���� ����)
--���̺��, �÷���, �������� �̸� ����
--�÷��� DEFAULT �� ���� ����
DROP TABLE DEPT_COPY;

CREATE TABLE DEPT_COPY
AS
SELECT * FROM DEPARTMENT;

--�÷� �߰� 
ALTER TABLE DEPT_COPY 
ADD (LNAME VARCHAR2(40) );
--�÷� �߰� Ȯ�� 
SELECT * FROM DEPT_COPY;
DESC DEPT_COPY;

--�÷� �߰��� DEFAULT���� ������ �� �ִ�.
ALTER TABLE DEPT_COPY
ADD (CNAME VARCHAR2(30) DEFAULT '�̱�');

--�������� �߰� 
CREATE TABLE EMP2
AS
SELECT * FROM EMPLOYEE;
--���������� �̿��� ���̺� �����ÿ���
--�÷���, �ڷ���(ũ��), NOT NULL ��������, DATA �� ���簡 �ȴ�
--������ PRIMARY KEY, CHECT, FOREIGN KEY, DEFAULT �� �� �������ǵ��� ���簡 �����ʴ´�.
SELECT * FROM EMP2;
DESC EMP2;

ALTER TABLE EMP2
ADD (CONSTRAINT PK_EP_ID PRIMARY KEY (EMP_ID));

ALTER TABLE EMP2
ADD (CONSTRAINT UN_EP_NO UNIQUE (EMP_NO));

-- NOT NULL�� ADD�� �߰��Ҽ� ����.
-- ���¸� �����ϴ� �ǹ��̹Ƿ� MODIFY�� NULLABLE��  NO���·� �ٲٴ°�
ALTER TABLE EMP2
ADD NOT NULL(HIRE_DATE); --ERROR

ALTER TABLE EMP2
MODIFY (HIRE_DATE NOT NULL); -- NULL �� -> NOT NULL�� ���� ����
DESC EMP2;

--�÷��� �ڷ����� �ٲ۴ٸ�
--���� ��� �ִ� �÷��� �ƹ� �ڷ������γ� ���� �����ϴ�
--������ ���� ��ϵǾ� �ִ� �÷��� ��쿡�� �������� ���������� ��ȯ �����ϴ�. CHAR <=> VARCHAR2
--ũ��� ���ų� ũ�� ������ �����ϴ� ũ�⸦ ���̴� ���� �Ұ���!!
ALTER TABLE EMP2
MODIFY (EMP_ID VARCHAR2(10));
ALTER TABLE EMP2
MODIFY (EMP_NAME CHAR(20));

--DEFAULT ���� ���� �����ϴ�
CREATE TABLE EMP3(
    EMP_ID CHAR(3),
    EMP_NAME VARCHAR2(20),
    ADDR1 VARCHAR2(20) DEFAULT '����',
    ADDR2 VARCHAR2(100)
);
INSERT INTO EMP3
VALUES('A01', '����', DEFAULT, '�б�����');
INSERT INTO EMP3
VALUES('A02', '�����', DEFAULT, '������');
INSERT INTO EMP3
VALUES('A03', '���ڲ�', DEFAULT, '������');
SELECT * FROM EMP3; --�̹� ��� �� DEFAULT���� �ٲ��� �ʴ´�. �ٲܷ��� UPDATE�� �ٲ���Ѵ�.

--DEFAULT �� ����
ALTER TABLE EMP3
MODIFY (ADDR1 DEFAULT '�λ�'); --������ �ٲ۰��� ��ϵȰ��� �ٲ۰��� �ƴϴ�.

INSERT INTO EMP3
VALUES('A05', '������', DEFAULT, '���ȸ���');

--�÷� ����
ALTER TABLE DEPT_COPY
DROP COLUMN CNAME; --�÷� 1�� ����

DESC DEPT_COPY;

ALTER TABLE DEPT_COPY
DROP (LOC_ID, LNAME); -- �÷��� ������ ���Ž�

--���������̺� ���̺��� �ּ� 1���� �÷��� ������ �־���Ѵ�.
--�÷��� ���� ���̺��� ������ �� ����.
--��� �÷��� ���� �� �� ����.
ALTER TABLE DEPT_COPY
DROP(DEPT_ID, DEPT_NAME); --ERROR �÷��� �� ���Ÿ� ���Ѵ�.

CREATE TABLE TB1(); --ERROR �÷��� 1���� ���� ���̺��� ������ ���Ѵ�(�ּ� 1�� �ʿ�!)

--���÷� ���Ž� ���ǻ��� 
--�ٸ� ���̺��� FOREIGN KEY ������������ �����ǰ� �ִ� �÷�(�θ�Ű)�� ���� �Ҽ�����.
--DELETE OPTION �� �⺻���� RESTRICTED �̴�.(NO ACTION ���� �Ұ���)
ALTER TABLE DEPARTMENT
DROP (DEPT_ID); --�θ�Ű�� ���� ���ϴ� ���� �⺻!! / ����ϴ� ���̺��� �����ؾ� ����

--(���)���� ������ ������ �÷��� ������ �� ����.
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
--�������ǵ� �Բ� �����ϰ� ������ CASCADE �� ���ش�
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

--�������� 1�� ����
ALTER TABLE CONSTRAINT_EMP2
DROP CONSTRAINT CHK2;

--����ڰ� ���� �������� ��ȸ : USER_CONSTRAINTS
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CONSTRAINT_EMP2';

--�������� ���� �� ����
ALTER TABLE CONSTRAINT_EMP2
DROP CONSTRAINT FKJID2
DROP CONSTRAINT FKMID2
DROP CONSTRAINT FKDID2;

--NOT NULL ���� ������ ������ �ƴ϶� �����̴�.
--NOT NULL �� NULL�� �ٲ�
ALTER TABLE CONSTRAINT_EMP2
MODIFY (ENAME NULL, ENO NULL);

--USER_CONSTRAINTS ��ųʸ� : �÷����� ����
--�÷��� ���������� �����ϴ� ������ ��ųʸ� : USER_CONS_COLUMNS
DESC USER_CONS_COLUMNS;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, COLUMN_NAME, 
        DELETE_RULE, SEARCH_CONDITION
FROM USER_CONSTRAINTS JOIN
USER_CONS_COLUMNS USING (CONSTRAINT_NAME, TABLE_NAME)
WHERE TABLE_NAME = 'CONSTRAINT_EMP2';

--�̸� �ٲٱ� : ���̺��, �÷���, ���������̸�
CREATE TABLE TB_EXAM(
    COL1 CHAR(3) PRIMARY KEY,
    ENAME VARCHAR2(20),
    FOREIGN KEY (COL1) REFERENCES EMPLOYEE
);
DESC TB_EXAM;
--�÷��� �ٲٱ�
ALTER TABLE TB_EXAM
RENAME COLUMN COL1 TO EMPID;
ALTER TABLE TB_EXAM
RENAME COLUMN ENAME TO TBNAME;

--���� ���� �̸� �ٲٱ� 
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

--���̺� �̸� �ٲٱ�
ALTER TABLE TB_EXAM
RENAME TO TB_SAMPLE1;
ALTER TABLE TB_EXAM
RENAME TO SAMPLE_EXAM;
--�Ǵ�
RENAME TB_SAMPLE1 TO TB_SAMPLE;
RENAME SAMPLE_EXAM TO TB_SAMPLE;
---------------
--���̺� ���� 
--DROP TABLE ���̺�� [�ʿ��ϴٸ� �������ǵ鵵 �Բ� ����� CASCADE CONSTRAINTS]
DROP TABLE TB_SAMPLE;

--�����Ǵ� ���̺� (��, �θ�Ű�� �ִ� ���̺� FOREIGN KEY ����) �� ���� ���Ѵ�

CREATE TABLE DEPT(
    DID CHAR(2) PRIMARY KEY,
    DNAME VARCHAR(10) --EM5�� �����ǰ� �ִ�.
);
CREATE TABLE EMP5(
    EID CHAR(3) PRIMARY KEY,
    ENAME VARCHAR2(10) ,
    DID CHAR(2) REFERENCES DEPT
);
DROP TABLE DEPT; --ERROR : EMP5���� �����ϰ� �����Ƿ� ���Ÿ� ���Ѵ�.
--> �����Ϸ��� DEPT�� ���� REFERENCES ���� ������ �Բ� �����ؾ��Ѵ�. 
DROP TABLE DEPT CASCADE CONSTRAINTS;
DROP TABLE EMP5;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, COLUMN_NAME, 
        DELETE_RULE, SEARCH_CONDITION
FROM USER_CONSTRAINTS JOIN
USER_CONS_COLUMNS USING (CONSTRAINT_NAME, TABLE_NAME)
WHERE TABLE_NAME = 'EMP5';

SELECT CONSTRAINT_NAME ���������̸�, CONSTRAINT_TYPE ������������,
        COLUMN_NAME �÷��̸�, DELETE_RULE �����ɼ�, SEARCH_CONDITION,
FROM USER_CONSTRAINTS JOIN
     USER_CONS_COLUMNS  USING(CONSTRAINT_NAME, TABLE_NAME)
WHERE TABLE_NAME LIKE 'DEPT';

SELECT *
FROM USER_CONSTRAINTS;
