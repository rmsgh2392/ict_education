--DECODE() IF-ELSE
--DECODE(expr, search, result [searchN, resultN], default)
SELECT EMP_NAME,
       DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��', '3', '��', '4', '��') ����
              --expr               search  
FROM EMPLOYEE;
SELECT EMP_NAME,
       DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '3', '��', '��')
FROM EMPLOYEE;
SELECT EMP_ID, EMP_NAME,
        DECODE(MGR_ID, NULL, '����', MGR_ID) ������,
        NVL(MGR_ID, '�����ڹ�ȣX')
FROM EMPLOYEE;

SELECT EMP_NAME, MGR_ID,
       CASE MGR_ID WHEN NULL THEN '����' ELSE MGR_ID END
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EMP_NO,
        CASE SUBSTR(EMP_NO, 8, 1)
            WHEN '1' THEN '��'
            WHEN '2' THEN '��'
            END
FROM EMPLOYEE;


SELECT EMP_NAME, JOB_ID, SALARY,
        TO_CHAR(DECODE(JOB_ID, 'J4', SALARY * 2,
                       'J7', SALARY * 1.2,
                       'J5', SALARY * 1.5,
                       SALARY * 0.5), '99,999,999L')
FROM EMPLOYEE;

SELECT EMP_NAME, JOB_ID, SALARY �޿�,
       CASE JOB_ID
            WHEN 'J4' THEN TO_CHAR(SALARY * 1.5 , '99,999,999L')
            WHEN 'J2' THEN TO_CHAR(SALARY * 2, '99,999,999L')
            WHEN 'J5' THEN TO_CHAR(SALARY * 1.2, '99,999,999L')
            ELSE TO_CHAR(SALARY * 0.5, '99,999,999L') END �λ�޿�
FROM EMPLOYEE
WHERE JOB_ID IN('J4','J2','J5')
ORDER BY JOB_ID DESC;

SELECT EMP_ID, EMP_NAME,
        SALARY,
        CASE WHEN SALARY <= 2000000 THEN '����'
              WHEN SALARY >= 5000000 THEN '�����'
              ELSE '�߱�' END ���
FROM EMPLOYEE;

SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL
GROUP BY DEPT_ID
ORDER BY DEPT_ID ASC;

SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��')
FROM EMPLOYEE;
----------------------------------------------------
--��¥ ������ �񱳿����� ���ǻ���
SELECT EMP_NAME, HIRE_DATE,
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD PM HH24:MI:SS')
FROM EMPLOYEE
WHERE EMP_ID LIKE '100';

SELECT EMP_NAME, HIRE_DATE,
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD PM HH24:MI:SS')
FROM EMPLOYEE; --��� �Ѽ��� ���� �ٸ� �������� ��¥�� ��ϵǾ� �ִ�.

--��¥�� �ð��� ���� ��ϵ� ��� �񱳿���� ��¥�� ������ ���� �� ����
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
--WHERE EMP_ID LIKE '100';
WHERE HIRE_DATE LIKE '90/09/01'; --ERROR ��� ������ ����
--'90/04/01 13:30:31' ����������(���� �Ⱥ���) ����Ǿ� �־ = '09/04/01' ���� �ʴ�.
--�ð��� �����ϴ� ��¥�����ʹ� �񱳿����� �ȵǰ� �ð����� ���� ����� ���ؾ���
--��¥�����͸� ������ �� FALSE�� ���� ��� ���� �Ⱥ��̴� �ð��� ����Ǿ� ������ ����!!
--�ذ���
--1.
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'YY/MM/DD')  LIKE '90/04/01';
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'YYMMDD') LIKE '900401';
--2.
SELECT EMP_NAME
FROM EMPLOYEE
WHERE HIRE_DATE LIKE '90/04/01%'; 
--���ϵ� ī�带 ����Ͽ� 90/04/01 �ڿ� �Ӱ� ������ ������� �� 
--3.
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE SUBSTR(HIRE_DATE, 1, 8) LIKE '90/04/01';

SELECT TO_DATE('20201030', 'YYYYMMDD')
FROM DUAL;
SELECT TO_CHAR('20100101', 'YYYY, MON')
FROM DUAL;
SELECT TO_CHAR(TO_DATE('20111222', 'YYYYMMDD'), 'YY"��"/MON')
FROM DUAL;
SELECT TO_DATE('041030 143030', 'YYMMDD HH24MISS')
FROM DUAL;
SELECT TO_CHAR(TO_DATE('041022 133030', 'YYMMDD HH24MISS'),
                'DD"��"-MON-YY"��" HH:MI:SS PM')
FROM DUAL;
SELECT TO_DATE('930429', 'YYMMDD')
FROM DUAL;
SELECT TO_CHAR(TO_DATE('020307', 'YYMMDD'), 'YYYY.MM.DD')
FROM DUAL;
SELECT EMP_NAME, 
        TO_CHAR(HIRE_DATE, 'YYYY"��".MON.fmDD"��"')
FROM EMPLOYEE;
--��¥ ��ȯ�� ���ǻ��� : ��¥�� �ð� ���� �ȿ� ���� ���� DATE������ ��ȯ����
SELECT TO_DATE('20161235', 'YYYYMMDD')
FROM DUAL;
--ERROR 12�� 35�� �̶�� ��¥�� �������� �ʴ� ���� �޷¿� ǥ�õǴ� ��¥�� ���
--�ð��� ���� �ð��� �������� �ʴ� ���� �Է��ϸ� ������ ����.

--2022�� 10�� 9���� ������???
SELECT TO_CHAR(TO_DATE('20221009', 'YYYYMMDD'), 'DAY')
FROM DUAL;
SELECT TO_CHAR(TO_DATE('2022/04/29'), 'DAY')
FROM DUAL;

SELECT HIRE_DATE,
        TO_CHAR(HIRE_DATE, 'RRRR'),
        TO_CHAR(HIRE_DATE, 'YYYY')
FROM EMPLOYEE;

SELECT TO_CHAR(TO_DATE('160505', 'YYMMDD'), 'RRRR'),
        TO_CHAR(TO_DATE('160505', 'RRMMDD'), 'YYYY'),
        TO_CHAR(TO_DATE('160505', 'RRMMDD'), 'YYYY'),
        TO_CHAR(TO_DATE('160505', 'YYMMDD'), 'RRRR')
FROM DUAL;

--���� �⵵�� 50�̸��̰� �ٲܳ⵵�� 50�̻��� ��
--TO_DATE() ���� �⵵�� �ٲ� �� Y ���� ���� ���� 2000�⵵ ����
--R����ϸ� �������� 1900�⵵ ����
SELECT TO_CHAR(TO_DATE('970505', 'YYMMDD'), 'RRRR'), --2000
        TO_CHAR(TO_DATE('970505', 'RRMMDD'), 'YYYY'), --1900
        TO_CHAR(TO_DATE('970505', 'RRMMDD'), 'YYYY'), --1900
        TO_CHAR(TO_DATE('970505', 'YYMMDD'), 'RRRR') --2000
FROM DUAL;
--���: ���ڸ� ��¥�� �ٲܶ� �⵵�� R ����ϸ��
-- 2�ڸ����� 4�ڸ��� ������ �ƹ��ų� ��밡��

SELECT EMP_NAME, EMP_NO,
        SUBSTR(EMP_NO, 1, 6) �պκ�,
        SUBSTR(EMP_NO, 8) �޺κ�,
        TO_NUMBER(SUBSTR(EMP_NO, 1, 6)) + TO_NUMBER(SUBSTR(EMP_NO, 8)) ���
FROM EMPLOYEE
WHERE EMP_ID LIKE '101';
--��Ÿ�Լ�------------------------
SELECT EMP_NAME, 
        NVL(BONUS_PCT, 0.0),
        NVL(DEPT_ID, '����'),
        NVL(JOB_ID, 'X')
FROM EMPLOYEE;
--NVL2() �Լ�
--������� : NVL2(�÷���, �ٲ� ��1, �ٲ� ��2)
--�ش��÷��� ���� ������ �ٲ� ��1�� �����ϰ�
--NULL�̸� �ٲ� �� 2�� �����Ѵ�.
SELECT EMP_ID ���, EMP_NAME �̸�,
        BONUS_PCT ���ʽ�����Ʈ,
        NVL2(BONUS_PCT, 0.15, 0.05) ���溸�ʽ�����Ʈ
FROM EMPLOYEE
WHERE BONUS_PCT < 0.2 
OR BONUS_PCT IS NULL;

SELECT DEPT_ID || '��' �μ�, EMP_NAME �̸�, EMP_NO �ֹι�ȣ,
        DECODE(SUBSTR(EMP_NO, 8, 1), '1', '����', '����') ����
FROM EMPLOYEE
WHERE DEPT_ID LIKE '50';

SELECT EMP_NAME ����̸�,
        MARRIAGE,
        DECODE(MARRIAGE, 'Y', '��ȥ', '��ȥ') ��ȥ����
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, SALARY,
        CASE
            WHEN TOSALARY <= 3000000 THEN '�ʱ�'
            WHEN SALARY <= 4000000 THEN '�߱�'
            ELSE '���'
        END ����
FROM EMPLOYEE
ORDER BY ���� ASC;
--=================================================================
--�Լ� ��������
--
--1. ������� �ֹι�ȣ�� ��ȸ��
--  ��, �ֹι�ȣ 9��° �ڸ����� �������� '*'���ڷ� ä��
--  �� : ȫ�浿 771120-1******
    SELECT EMP_NAME ������, EMP_NO �ֹι�ȣ,
            RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') "*�� ó���� �ֹ�"
    FROM EMPLOYEE;
--
--2. ������, �����ڵ�, ����(��) ��ȸ
--  ��, ������ ��57,000,000 ���� ǥ�õǰ� ��
--     ������ ���ʽ�����Ʈ�� ����� 1��ġ �޿���
    SELECT EMP_NAME ������, NVL(JOB_ID, '����') �����ڵ�,
            TO_CHAR((SALARY + (SALARY * NVL(BONUS_PCT, 0)) * 12), 'L99,999,999') "����(��)" 
    FROM EMPLOYEE;

--3. �μ��ڵ尡 50, 90�� ������ �߿��� 2004�⵵�� �Ի��� ������ 
--   �� ��ȸ��.
--	��� ����� �μ��ڵ� �Ի���
    SELECT EMP_ID ���, EMP_NAME �����, DEPT_ID �μ��� 
    FROM EMPLOYEE
    WHERE DEPT_ID IN ('50', '90')
    AND TO_CHAR(HIRE_DATE, 'YYYY') LIKE '2004';
    --LIKE '04%'�� ����

--4. ������, �Ի���, �Ի��� ���� �ٹ��ϼ� ��ȸ
--  ��, �ָ��� ������
    SELECT EMP_NAME, HIRE_DATE,
            LAST_DAY(HIRE_DATE) - HIRE_DATE "�Ի��� ���� �ٹ��ϼ�"
    FROM EMPLOYEE;

--5. ������, �μ��ڵ�, �������, ����(��) ��ȸ
--  ��, ��������� �ֹι�ȣ���� �����ؼ�, 
--     ������ ������ �����Ϸ� ��µǰ� ��.
--  ���̴� �ֹι�ȣ���� �����ؼ� ��¥�����ͷ� ��ȯ�� ����, �����
    SELECT EMP_NAME ������, DEPT_ID �μ��ڵ�, 
            SUBSTR(EMP_NO, 1, 2) || '��' ||
            SUBSTR(EMP_NO, 4, 2) || '��' ||
            SUBSTR(EMP_NO, 7, 2) || '��' �������,
            TO_CHAR(SYSDATE, 'RRRR') - TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'), 'RRRR') ����
    FROM EMPLOYEE;
    
    SELECT EMP_NAME �̸�, DEPT_ID �μ��ڵ�,
            SUBSTR(EMP_NO, 1, 2) || '��' || SUBSTR(EMP_NO, 3, 2) || '��' || SUBSTR(EMP_NO, 5, 2) || '��' �������,
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) "����(��)"
    FROM EMPLOYEE;
--6. �������� �Ի��Ϸ� ���� �⵵�� ������, �� �⵵�� �Ի��ο����� ���Ͻÿ�.
--  �Ʒ��� �⵵�� �Ի��� �ο����� ��ȸ�Ͻÿ�.
--  => to_char, decode, sum ���
-- �ٽ�Ǯ�� �����ϱ�!!!!!
    SELECT COUNT(*) ��ü������,
            SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '2001', 1, 0)) "2001��",
            SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '2001', 1, 0)) "2002��",
            SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '2001', 1, 0)) "2003��",
            SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '2001', 1, 0)) "2004��"
    FROM EMPLOYEE;
--	-------------------------------------------------------------
--	��ü������   2001��   2002��   2003��   2004��
--	-------------------------------------------------------------


--7.  �μ��ڵ尡 50�̸� �ѹ���, 60�̸� ��ȹ��, 90�̸� �����η� ó���Ͻÿ�.
--   ��, �μ��ڵ尡 50, 60, 90 �� ������ ������ ��ȸ��
--  => case ���
--	�μ��ڵ� ���� �������� ������.
    SELECT DEPT_ID �μ��ڵ�, 
        CASE DEPT_ID
            WHEN '50' THEN '�ѹ���'
            WHEN '60' THEN '��ȹ��'
            WHEN '90' THEN '������'
            END
    FROM EMPLOYEE
    WHERE DEPT_ID IN ('50', '60', '90')
    ORDER BY �μ��ڵ� ASC;
