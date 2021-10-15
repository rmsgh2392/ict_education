-- DAY10_TCL_DDL2

-- TCL (Transaction Controll Language : Ʈ����� �����)
-- Ʈ����� ���� : commit, rollback, savepoint
-- Ʈ����� ���� : ù��° DML ���, DDL ���

ALTER TABLE EMPLOYEE
DISABLE CONSTRAINT FK_MGRID;  -- DDL ��� : Ʈ����� 1 ���� -------------------------------------------------------------
-- ����Ŭ ������ ���� ��Ȱ��ȭ�Ǿ �������� �˻簡 �۵��Ǵ� ��찡 ����
-- �ذ��� : �������� ������ > DML ���� > �������� �߰���

-- �������� ����
--ALTER TABLE EMPLOYEE
--DROP CONSTRAINT FK_MGRID;

-- DML ������ ����

-- �������� �ٽ� �߰���
--ALTER TABLE EMPLOYEE
--ADD CONSTRAINT FK_MGRID FOREIGN KEY (MGR_ID) REFERENCES EMPLOYEE;

SAVEPOINT S0;

INSERT INTO DEPARTMENT 
VALUES ('40', '��ȹ������', 'A1');

SELECT * FROM DEPARTMENT;

SAVEPOINT S1;

SELECT COUNT(*) 
FROM EMPLOYEE
WHERE DEPT_ID IS NULL;  -- 2�� Ȯ��

UPDATE EMPLOYEE
SET DEPT_ID = '40'
WHERE DEPT_ID IS NULL;

SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_ID = '40';  -- 2��

SAVEPOINT S2;

DELETE FROM EMPLOYEE
WHERE DEPT_ID = '40';

SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_ID = '40';  -- 0��  ---------------- Ʈ����� 1 ��� ����

ROLLBACK TO S2;

SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_ID = '40';  -- 2��  : DELETE ���

ROLLBACK TO S1;

SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_ID = '40';  -- 0��  : UPDATE ���

ROLLBACK TO S0;

SELECT * FROM DEPARTMENT;  -- INSERT ���

-- ���ü� ���� : LOCK (���)
-- �𺧷��� �� 2�� ��� �׽�Ʈ��
-- ���� 1
SELECT EMP_ID, EMP_NAME, MARRIAGE
FROM EMPLOYEE
WHERE EMP_ID = '124';

UPDATE EMPLOYEE
SET MARRIAGE = 'Y'
WHERE EMP_ID = '124';

COMMIT;

-- ***********************************************************
-- ������ (SEQUENCE)
-- �ڵ� ���� ��ȣ �߻���
-- ���������� ���� ���� �ڵ����� �߻��ϴ� ��ü��
/*
���� �ۼ� ���� : 
CREATE SEQUENCE �������̸�
[START WITH ���ۼ���]  -- ������ �⺻���� 1 (1���� ����)
[INCREMENT BY ����ġ]  -- ������ �⺻���� 1 (1�� ����)
[MAXVALUE �ִ밪 | NOMAXVALUE] 
[MINVALUE �ּҰ� | NOMINVALUE]
[CYCLE | NOCYCLE]
[CACHE �����Ұ��� | NOCACHE]  -- CACHE 2 ~ 20 (�⺻���� 20)
*/

-- ������ ����� 1
CREATE SEQUENCE SEQ_EMPID
START WITH 300  -- ���۰� : 300���� ����
INCREMENT BY 5 -- ������ : 5�� ����
MAXVALUE 310   -- 310 ���� ����
NOCYCLE   -- 310 ���� �� �� �̻� ���� �� ��
NOCACHE;  -- �޸𸮿� �̸� ���ڸ� �������� ����

-- ������ ��ųʸ��� �����
DESCRIBE USER_SEQUENCES;

SELECT * FROM USER_SEQUENCES;

-- ������ ��� : �������̸�.NEXTVAL �� ����ؾ� ���ڰ� �߻���
-- INSERT ������ �� ��Ͻÿ� �����
SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
-- 4ȸ ���� ���� �߻��� (NOCYCLE �̱� ����)

-- ������ ����� 2
CREATE SEQUENCE SEQ_EMPID2
START WITH 5
INCREMENT BY 5
MAXVALUE 15
CYCLE  -- �� ��ȯ�ÿ��� ������ 1���� ���۵�.
NOCACHE;

-- ��� Ȯ��
SELECT SEQ_EMPID2.NEXTVAL FROM DUAL;  -- 5, 10, 15, 1, 6, 11, 1, 6, 11, ......

-- ������ ����� : 
-- ���ο� ���� �߻� : �������̸�.NEXTVAL
-- ���� ������ ���� Ȯ�� : �������̸�.CURRVAL  (�ݵ�� NEXTVAL �ѹ� ������ ������ ����ؾ� ��)
SELECT SEQ_EMPID2.CURRVAL FROM DUAL;

CREATE SEQUENCE SEQ_EMPID3
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

SELECT SEQ_EMPID3.CURRVAL FROM DUAL;  -- ERROR
-- NEXTVAL �ѹ��� ������� ���� ���¿����� CURRVAL ����� �� ����

SELECT SEQ_EMPID3.NEXTVAL FROM DUAL;
SELECT SEQ_EMPID3.CURRVAL FROM DUAL;

-- ������ ��� : �ַ� INSERT �ÿ� �����
CREATE SEQUENCE SEQID
START WITH 300
INCREMENT BY 1
MAXVALUE 999
NOCYCLE
CACHE 5;

INSERT INTO EMPLOYEE (EMP_ID, EMP_NO, EMP_NAME)
VALUES (TO_CHAR(SEQID.NEXTVAL), '841205-1234567', '����ǥ');

SELECT * FROM EMPLOYEE
ORDER BY EMP_ID DESC;

-- ������ ����
/*
- START WITH �� ���� �� ��, �������� ��� ������ �� ����
- STRAT WITH �� �ٲٷ���, ������ ��ü �����ϰ� �ٽ� ������ؾ� ��
- ���� ������ ���� ���ÿ� �����

ALTER TABLE �������̸�
[INCREMENT BY ����ġ]
[MAXVALUE �ִ밪 | NOMAXVALUE]
[MINVALUE �ּҰ� | NOMINVALUE]
[CYCLE | NOCYCLE]
[CACHE ���尹�� | NOCACHE];
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

-- ������ ���� : DROP SEQUENCE �������̸�;
DROP SEQUENCE SEQID2;

SELECT * FROM USER_SEQUENCES;

-- *********************************************************************************
-- VIEW (��)
-- SELECT �������� �����ϴ� ��ü��
/*
�ۼ���� : 
CREATE OR REPLACE VIEW ���̸�
AS ��������;   -- �信 ������ SELECT ����
*/

CREATE OR REPLACE VIEW V_EMP_DEPT90
AS
SELECT EMP_NAME, DEPT_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE DEPT_ID = '90';

-- ó�� ����� "insufficient privileges" ���� �߻��ϸ�
-- �����ڰ���(����ڰ����� ���� ����)�� ���� �ο��޾ƾ� ��.
-- system �������� ���� : 
GRANT CREATE VIEW TO c##student;

-- ��ųʸ��� �� ��ü Ȯ�� : USER_VIEWS
SELECT * FROM USER_VIEWS;
-- SELECT ������ ���� Ȯ����

-- �� ��� : ���̺�ó�� ����� (�ζ��κ�� �۵���)
SELECT * FROM V_EMP_DEPT90;

-- *******************************************
-- �ε��� (INDEX)
-- SELECT ���� ó�� �ӵ��� ����Ű�� ���ؼ� �÷��� �����ϴ� ��ü��.
-- �ش� �÷������� ��ȸ�� �� �˻� �ӵ��� �����ϱ� ���ؼ� �̿��ϴ� ��ü��. (������ ���� �� �ƴ�.)
/*
CREATE [UNIQUE] INDEX �ε����̸�
ON ���̺�� (�÷���)
*/

-- UNIQUE INDEX : UNIQUE �������ǰ� ���� �ǹ̷� ����
CREATE UNIQUE INDEX IDX_DNM
ON DEPARTMENT (DEPT_NAME);

-- NONUNIQUE INDEX
CREATE INDEX IDX_JID
ON EMPLOYEE (JOB_ID);

-- �ε��� ����
DROP INDEX IDX_JID;

-- �ε����� ������ ��ųʸ����� ������ : USER_INDEXES, USER_CATALOGS, USER_OBJECTS
-- �÷��� ���� �ε��� ���� : USER_IND_COLUMNS
SELECT INDEX_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'EMPLOYEE';

