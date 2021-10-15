/*
  TCL (Transaction Controll Langage : Ʈ����� �����)
  Ʈ����� ���� : commit, rollback, savepoint
  Ʈ����� ���� : DB �ȿ����� Ʈ����� ������ ù�� ° DML��뱸��, DDL ��뱸��
*/

ALTER TABLE EMPLOYEE
DISABLE CONSTRAINT FK_MGRID; --DDL�� ���Ǹ� Ʈ����� (1) �� ����!! ---START---------------- �Ǵ� Ʈ������� �������� �ֵ�.
-- DISABLE CONSTRAINT FK_MGRID �������� �˻� ��Ȱ��ȭ 
-- ����Ŭ ������ ���� ��Ȱ��ȭ �Ǿ �������� �˻簡 �۵��Ǵ� ��찡 �ִ�.
-- �ذ��� : �������� ���� > DML ���� > �ٽ� �������� �߰��ؾ���
--ALTER TABLE EMPLOYEE
--DROP CONSTRAINT FK_MGRID; -- �������� ����

--DML ����

--ALTER TABLE EMPLOYEE --�������� �ٽ� �߰�
--ADD CONSTRAINT FK_MGRID FOREIGN KEY (MGR_ID) REFERENCES EMPLOYEE;

SAVEPOINT S0;

INSERT INTO DEPARTMENT --DML : ù�� ° DDL������ Ʈ����� �ȿ����� DML�� ���� Ʈ��������� ����.
VALUES ('40', 'ȫ����', 'A1');

SELECT * FROM DEPARTMENT;

SAVEPOINT S1;

SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_ID IS NULL; -- �μ���ȣ�� NULL�� ���� : 2�� 

UPDATE EMPLOYEE
SET DEPT_ID = '40'
WHERE DEPT_ID IS NULL; -- �μ���ȣ�� NULL�� ���� 40���� ����

SELECT COUNT(*)
FROM EMPLOYEE 
WHERE DEPT_ID LIKE '40'; -- 2�� 

SAVEPOINT S2;

DELETE FROM EMPLOYEE
WHERE DEPT_ID LIKE '40'; -- ��������� �ϳ��� Ʈ����� (1) �̴� (���� DDL����) 
-- COMMIT ��ɾ DDL ������ �ۼ��� ���� ������ Ʈ������� ��� ����Ǹ� 
-- �����Ϸ��� COMMIT; �̳� DDL ����(ALTER , CREATE, DROP) �� �ۼ��ϴ� ������ Ʈ����� (1)�� ���ᰡ �ȴ�.
-- ���� SQL/DEVELOPER�� �ڵ� Ŀ�ԵǱ� ������ ����� ������ �ڹٶ� ������ ���ø����̼��� ���� �� �ݵ�� 
-- COMMIT��ɾ ROLLLBACK ��ɾ �ۼ��� ��� �� ������ �۾���(Ʈ�����) �� �����ϰ�, �Ǵ� ������ ���� ����ϰ�
-- �ϴ� �۾��� ����� �Ѵ� !!!

--ROLLBACK; -- ó�� Ʈ����� ���� �ߴ� �������� ��� ��Ŵ
ROLLBACK TO S2; --SAVEPOINT S2 �ؿ� �ִ� DELETE ������ �ּҰ� �Ǿ��� !! / �������� ����ض�� �ǹ�!

SELECT COUNT(*)
FROM EMPLOYEE 
WHERE DEPT_ID LIKE '40'; -- 2�� : DELETE ���

ROLLBACK TO S1; -- SAVEPOINT S1 �ؿ� �ִ� UPDATE ���� ���

SELECT COUNT(*)
FROM EMPLOYEE 
WHERE DEPT_ID LIKE '40'; -- 0�� : UPDATE ���

ROLLBACK TO S0; -- SAVEPOINT S0 �ؿ� �ִ� INSERT ���� ���

SELECT * FROM DEPARTMENT; -- INSERT ���

/* *���ü� ���� : LOCK(���)
    SQL/DEBELOPER �� 2���� ��� �׽�Ʈ
*/
--���� 1
SELECT EMP_ID, EMP_NAME, MARRIAGE 
FROM EMPLOYEE
WHERE EMP_ID LIKE '124';

UPDATE EMPLOYEE
SET MARRIAGE = 'Y'
WHERE EMP_ID LIKE '124';

COMMIT; --�������� ����� �ٸ� ����ڰ� ����� ������ ��ȸ �� �� �ִ�
        --Ŀ���� ���ϸ� ���ÿ� �������� �� �ٸ� ����ڰ� ����� ������ ���� ���Ѵ�.
-----------------------------------------------------        
/* *������ SEQUENCE : �ڵ� (����) ���� �߻���
    ���������� ���� ���� �ڵ����� �߻��ϴ� �����ͺ��̽� ��ü�̴�
    �ڱ������ : CREATE SEQUENCE ������ �̸�
                [STRAT WITH ���� ����] --> ������ �⺻ �� 1, 1���� ����
                [INCREMENT BY ����ġ] --> ������ �⺻ �� 1 , 1������
                [MAXVALUE �ִ� �� | NOMAXVALUE] --> �����Ǹ� NOMAXVALUE �⺻�� �ִ� �󸶱��� ������ų�ų�
                [MINVALUE �ּ� �� | NOMINVALUE] --> �����Ǹ� NOMINVALUE �⺻��
                [CYCLE | NOCYCLE] --> �����Ǹ� NOCYCLE�� �⺻ ��
                [CACHE ������ ���� | NOCATCH] --> CACHE (2 ~ 20) ���� ���� �� ������ (�⺻ �� 20)
*/

--������ �����
CREATE SEQUENCE SEQ_EMPID
START WITH 300 -- ���� �� : 300���� ����
INCREMENT BY 5 -- ���� �� : 5�� �����ϰڴ�.
MAXVALUE 310 -- 310 ���� ���ڸ� �����Ѵ�.
NOCYCLE -- 310 ������ ���̻� ���� ���ϰڴ�.
NOCACHE; -- �޸𸮿� �̸� ���ڸ� �������� �ʰڴ�.

--������ ��ųʸ��� �����
DESCRIBE USER_SEQUENCES;

SELECT * FROM USER_SEQUENCES;

--������ ��� : ������ �̸�.NEXTVAL �� ����ؾ� ���ڰ� �߻��Ѵ�.
-- INSERT ������ �� ��Ͻÿ� ����Ѵ�.
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --4�� ° ����� �� ERROR�� ���� => NOCYCLE�� �����߱� ������
SELECT SEQ_EMPID.CURRVAL FROM DUAL;
DROP SEQUENCE SEQ_EMPID;

CREATE SEQUENCE SEQ_EMPID2
START WITH 5
INCREMENT BY 5
MAXVALUE 15
CYCLE -- �� ��ȯ�� ������ 1���� ���� (START WITH�� ���� 5���� �����ϴ� ���� �ƴϴ�.)
NOCACHE;

SELECT * FROM USER_SEQUENCES;
SELECT SEQ_EMPID2.NEXTVAL FROM DUAL; --5, 10, 15, 1 , 6 , 11 , 1, 6, 11. . . . .
SELECT SEQ_EMPID2.CURRVAL FROM DUAL;

--������ �����
--���ο� ���ڸ� �߻� : �������̸�.NEXTVAL
--���� ������ ���� Ȯ�� : �������̸�.CURRVAL (�عݵ�� NEXTVAL �ѹ� ���� �Ŀ� ����ؾ��Ѵ�!!)

CREATE SEQUENCE SEQ_EMPID3
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

SELECT SEQ_EMPID3.CURRVAL FROM DUAL; --ERROR 
-- NEXTVAL�� �ѹ��� ������� ���� ���¿����� CURRVAL�� ����� �� ����.
SELECT SEQ_EMPID3.NEXTVAL FROM DUAL;
SELECT SEQ_EMPID3.CURRVAL FROM DUAL;

--������ ��� : �ַ� INSERT ���� ���
CREATE SEQUENCE SEQID
START WITH 300
INCREMENT BY 1
MAXVALUE 999
NOCYCLE
CACHE 5;

INSERT INTO EMPLOYEE (EMP_ID, EMP_NO, EMP_NAME)
VALUES (TO_CHAR(SEQ_EMPID3.NEXTVAL), '201225-1012345' , '����');
INSERT INTO EMPLOYEE (EMP_ID, EMP_NO, EMP_NAME)
VALUES (TO_CHAR(SEQID.NEXTVAL), '201225-1012333' , 'ī����');

SELECT * FROM EMPLOYEE
ORDER BY EMP_ID DESC;

--������ ���� 
--������ ��ü ������ START WITH(���� ��)�� ������ ���ϰ� �������� ��� ������ �����ϴ�.
--START WITH�� �����ϰ� ������ SEQUENCE ��ü�� ����� �ٽ� �������Ѵ�.
--�������� ���� �� ���� ������ ���� ���ÿ� ����ȴ�.
-- ALTER SEQUENCE ������ �̸�
-- [INCREMENT BY ����ġ]
-- [MAXVALUE �ִ밪 | NOMAXVALUE]
-- [MINVALUE �ּҰ� | NOMINVALUE]
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

SELECT * FROM USER_SEQUENCES; --��ųʸ� ��ȸ

--������ ���� : DROP SEQUENCE �������̸�
DROP SEQUENCE SEQID2;

/* �� (VIEW)
  SELECT �������� �����ϴ� ��ü
  �ۼ��� : CREATE OR REPLACE VIEW ���̸�
          AS ��������(SELECT ��) <-- �信 ���� �� SELECT ������
*/
--ó�� ����� ���� �߻��ϸ� ������ ������ ���� �ο��޾ƾ��Ѵ�.
--���Ѻο� : GRANT VIEW TO c##student
CREATE OR REPLACE VIEW V_EMP_DEPT90
AS
SELECT EMP_NAME, DEPT_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE 
LEFT JOIN DEPARTMENT USING(DEPT_ID)
LEFT JOIN JOB USING(JOB_ID)
WHERE DEPT_ID LIKE '90';

--��ųʸ��� �� ��ü Ȯ�� : USER_VIEWS
SELECT * FROM USER_VIEWS;
--SELECT ������ ���� Ȯ��

--�� ��� : ���̺�ó�� ����Ѵ�.(�ζ��κ�� �۵���)
SELECT * FROM V_EMP_DEPT90; 

---------------------------------------------------------------------
/* INDEX (�ε���)
  SELECT ���� ó�� �ӵ��� ����Ű�� ���ؼ� �÷��� �����ϴ� ��ü
  �ش� �÷� ������ ��ȸ �� �� �˻� �ӵ�(���� ã�� �ӵ�)�� ���� �ϱ� ���� �̿��ϴ� ��ü(�������� ������ �ƴ�) [�����ѵ����Ͱ� ������ ȿ������]
  �������� : CREATE [UNIQUE] INDEX �ε��� �̸�
            ON ���̺�� (�÷��� �Ǵ� �Լ�����) �Ϲ������� �÷��� 
*/
--UNIQUE INDEX : UNIQUE �������ǰ� ���� �ǹ̿� INDEX
CREATE UNIQUE INDEX IDX_DNM
ON DEPARTMENT (DEPT_NAME);

--NONUNIQUE INDEX
CREATE INDEX IDX_JID
ON EMPLOYEE (JOB_ID);

--�ε��� ��ü ����
DROP INDEX IDX_JID;

--�ε��� ��ü�� ������ ��ųʸ����� ������ : USER_INDEXES, USER_CATALOGS, USER_OBJECTS
--�÷��� ���� �ε��� ������ Ȯ�� ���� : USER_IND_COLUMNS
SELECT INDEX_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME LIKE 'EMPLOYEE';

