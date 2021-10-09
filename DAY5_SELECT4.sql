-- DAY5_SELECT4

-- ��¥ ������ �񱳿���� ���ǻ��� : 
-- ����� '100'�� ������ �̸��� �Ի��� ��ȸ
-- �Ի����� ��� ������ ������ : '2021-10-08 ���� 14:25:30'
SELECT EMP_NAME �̸�, 
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD AM HH24:MI:SS') �Ի���
FROM EMPLOYEE
WHERE EMP_ID = '100';  -- �Ի��Ͽ� ��¥�� �ð��� ���� ��ϵ� ������

-- �ٸ� �������� �Ի��� ������ Ȯ��
SELECT EMP_NAME �̸�, 
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD AM HH24:MI:SS') �Ի���
FROM EMPLOYEE;  -- �ٸ� �������� �Ի����� ��¥�� ��ϵ� ������

-- ��¥�� �ð��� ���� ��ϵ� ��쿡�� �񱳿���� ��¥�� ������ ���� �� ����
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
--WHERE EMP_ID = '100';
WHERE HIRE_DATE = '90/04/01';  -- ����� ������ ����
-- '90/04/01 13:30:30' = '90/04/01'  FALSE ��

-- �ذ��� 1
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'YY/MM/DD') = '90/04/01';
-- �ذ��� 2
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE LIKE '90/04/01%';
-- �ذ��� 3
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE SUBSTR(HIRE_DATE, 1, 8) = '90/04/01';

-- TO_DATE() �Լ� --------------------------------------------------
-- ������� : TO_DATE('���ڸ��ͷ�' | ������������ ��ϵ� �÷���, '���� ���ڸ��� ��������')
-- ���� : ������ ���ڼ��� ���乮�� ���ڼ��� ��ġ�ؾ� ��
-- TO_CHAR() �� ����(�������)�� �ǹ̰� �ٸ�
-- TO_DATE() �� ������ ���� ������ ��¥ �������� �ٲ������ �����ϴ� ������ ��

SELECT TO_DATE( '20100101', 'YYYYMMDD') 
FROM DUAL;  -- DATE ������ ��ȯ�Ǹ� '10/01/01' �� ǥ����

SELECT TO_CHAR( '20100101', 'YYYY, MON') 
FROM DUAL;  -- ���� : '20100101' �� DATE ���� �ƴ�. TO_CHAR() �� ���� ������ �� ����
-- TO_CHAR(NUMBER TYPE | DATE TYPE, 'FORMAT') �����.

-- �ذ��� : �������� ��¥������ �ٲ� ���� ���� ������
SELECT TO_CHAR( TO_DATE( '20100101', 'YYYYMMDD'), 'YYYY, MON') 
FROM DUAL;

SELECT TO_DATE( '041030 143000', 'YYMMDD HH24MISS' ) 
FROM DUAL;  -- �ð��� ���� ������ 12�ð����̸� HH, 24�ð����̸� HH24�� ������, ������ ���鵵 ���߾�� ��

SELECT TO_CHAR( TO_DATE( '041030 143000', 'YYMMDD HH24MISS' ), 'DD-MON-YY HH:MI:SS PM' ) 
FROM DUAL;  -- ������ �����ڸ��� ���߾�� ��

SELECT TO_DATE( '980630', 'YYMMDD' ) 
FROM DUAL;

SELECT TO_CHAR( TO_DATE( '980630', 'YYMMDD' ), 'YYYY.MM.DD') 
FROM DUAL;

-- ��¥�� ��ȯ�� ���ǻ��� : ��¥�� �ð� ���� �ȿ� ���� ���� DATE ������ �ٲ�
SELECT TO_DATE('20221235', 'YYYYMMDD')
FROM DUAL;  -- ���� : 35���� ���� ���̹Ƿ�...

-- 2022�� 10�� 9���� ������?
SELECT TO_CHAR(TO_DATE('20221009', 'YYYYMMDD'), 'DY')
FROM DUAL;

-- �����ͺ��̽� ��¥ ����� ���� ���ڰ��� ���� TO_DATE() ���� FORMAT �����ص� ��
SELECT TO_CHAR(TO_DATE('22/10/09'), 'DY')
FROM DUAL;

-- �⵵ ��ȯ�� RR �� YY ����� ����  ------------------------------------------------------------------
-- ���ڸ� �⵵�� ���ڸ� �⵵�� �ٲ� ��
-- ���� �⵵ 21�⵵(50���� ����) �� ��
-- �ٲ� �⵵�� 50�̸��̸� 2000�⵵�� ����
-- �ٲ� �⵵�� 50�̻��̸� 1900�⵵�� ����

SELECT HIRE_DATE, 
        TO_CHAR(HIRE_DATE, 'RRRR'),
        TO_CHAR(HIRE_DATE, 'YYYY')
FROM EMPLOYEE;

-- ���� �⵵�� �ٲ� �⵵�� �� �� 50�̸��̸�, Y | R �ƹ��ų� ����ص� ��
SELECT TO_CHAR(TO_DATE('160505', 'YYMMDD'), 'YYYY-MM-DD'),
        TO_CHAR(TO_DATE('160505', 'RRMMDD'), 'RRRR-MM-DD'),
        TO_CHAR(TO_DATE('160505', 'RRMMDD'), 'YYYY-MM-DD'),
        TO_CHAR(TO_DATE('160505', 'YYMMDD'), 'RRRR-MM-DD')
FROM DUAL;

-- ���� �⵵�� 50�̸��̰�, �ٲ� �⵵�� 50�̻��� ��
-- TO_DATE() ���� �⵵�� �ٲ� �� Y ���� ���� ���� 2000�⵵ �����
-- R ����ϸ� �������� 1900�⵵�� �����
SELECT TO_CHAR(TO_DATE('970320', 'YYMMDD'), 'YYYY-MM-DD'),  -- 2000�� ����
        TO_CHAR(TO_DATE('970320', 'RRMMDD'), 'RRRR-MM-DD'), -- 1900�� ����
        TO_CHAR(TO_DATE('970320', 'RRMMDD'), 'YYYY-MM-DD'), -- 1900�� ����
        TO_CHAR(TO_DATE('970320', 'YYMMDD'), 'RRRR-MM-DD')  -- 2000�� ����
FROM DUAL;

-- ��� : ���ڸ� ��¥�� �ٲ� �� �⵵�� 'R' ����ϸ� ��
-- 2�ڸ����� 4�ڸ��� ������ �ƹ��ų� ����ϸ� ��

-- TO_NUMBER('������ ����') ---------------------------------------
-- ���������ڸ� ����(NUMBER) �� �ٲ�
SELECT EMP_NAME, EMP_NO,
        SUBSTR(EMP_NO,1,6)AS �պκ�,
        SUBSTR(EMP_NO,8) AS �޺κ�,
        TO_NUMBER( SUBSTR(EMP_NO,1,6) ) + TO_NUMBER( SUBSTR(EMP_NO,8) ) AS ���
FROM EMPLOYEE
WHERE EMP_ID = '101';

-- ��Ÿ�Լ� ************************************************************
-- NVL() �Լ�
-- ������� : NVL(�÷���, �÷����� NULL�� �� �ٲ� ��)
SELECT EMP_NAME, BONUS_PCT, DEPT_ID, JOB_ID
FROM EMPLOYEE;

SELECT EMP_NAME,
        NVL(BONUS_PCT, 0.0),
        NVL(DEPT_ID, '00'),
        NVL(JOB_ID, 'J0')
FROM EMPLOYEE;

-- NVL2() �Լ�  -----------------------------------------------------------------------------
-- ������� : NVL2(�÷���, �ٲܰ�1, �ٲܰ�2)
-- �ش� �÷��� ���� ������ �ٲܰ�1�� �����ϰ�, NULL�̸� �ٲܰ�2�� �����ϴ� �Լ���

-- ���� �������� ���ʽ�����Ʈ�� 0.2 �̸��̰ų� NULL �� �������� ��ȸ��
-- ���, �̸�, ���ʽ�����Ʈ, ���溸�ʽ�����Ʈ(��Ī ó��)
-- ���溸�ʽ�����Ʈ�� ���ʽ�����Ʈ �÷��� ���� ������ 0.15�� �ٲٰ�, ������ 0.05�� �ٲ�
SELECT EMP_ID ���, EMP_NAME �̸�, BONUS_PCT ���ʽ�����Ʈ,
        NVL2(BONUS_PCT, 0.15, 0.05) ���溸�ʽ�����Ʈ
FROM EMPLOYEE
WHERE BONUS_PCT < 0.2 OR BONUS_PCT IS NULL;

-- DECODE() �Լ� ---------------------------------------------------------------------------------
-- ������� : DECODE(���� | �÷���, ��1����, ���ð�1, ��2����, ���ð�2, ...........[, ���õ� ���� ��� �ƴ� �� ���ð�])
-- ���α׷����� switch ���� ���� ���� �����.

-- 50�� �μ��� �Ҽӵ� �������� �̸��� ���� ��ȸ
-- ���� ���� : �ֹι�ȣ 8��° ���� 1, 3�̸� ����, 2, 4�̸� ���ڷ� ��� ó��
SELECT EMP_NAME �̸�, 
        DECODE(SUBSTR(EMP_NO, 8, 1), '1', '����', '2', '����', '3', '����', '4', '����') ����
FROM EMPLOYEE
WHERE DEPT_ID = '50';

-- DECODE �� DEFAULT �� ���
SELECT EMP_NAME �̸�, 
        DECODE(SUBSTR(EMP_NO, 8, 1), '1', '����', '3', '����', '����') ����
FROM EMPLOYEE
WHERE DEPT_ID = '50';

-- ���� �̸��� �ش� ������ �������� ����� ��ȸ
SELECT EMP_NAME, MGR_ID
FROM EMPLOYEE;

-- �����ڻ���� NULL �̸� '000' �� �ٲ�
-- 1. NVL() ���
SELECT EMP_NAME, NVL(MGR_ID, '000')
FROM EMPLOYEE;
-- 2. DECODE() ���
SELECT EMP_NAME, DECODE(MGR_ID, NULL, '000', MGR_ID)
FROM EMPLOYEE;

-- ���޺� �޿� �λ���� �ٸ� ��
-- 1. DECODE() ����� ���
SELECT EMP_NAME, JOB_ID, SALARY,
        TO_CHAR(DECODE(JOB_ID, 
                        'J7', SALARY * 1.1,
                        'J6', SALARY * 1.15,
                        'J5', SALARY * 1.2,
                        SALARY * 1.05), 'L99,999,999') �λ�޿�
FROM EMPLOYEE;

-- 2. CASE ǥ������ ���� if���� ���� ���� ������ ����
-- PL-SQL ������.
SELECT EMP_NAME, JOB_ID, SALARY,
        CASE JOB_ID
            WHEN 'J7' THEN SALARY * 1.1
            WHEN 'J6' THEN SALARY * 1.15
            WHEN 'J5' THEN SALARY * 1.2
            ELSE SALARY * 1.05
        END �λ�޿�
FROM EMPLOYEE;

-- CASE ǥ������ ���� if��ó��  ����� ���� ����
-- ������ �޿��� ��� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY,
        CASE WHEN SALARY <= 3000000 THEN '�ʱ�'
              WHEN SALARY <= 4000000 THEN '�߱�'
              ELSE '���'
        END ����
FROM EMPLOYEE
ORDER BY ����; -- ������������ ó����


--�Լ� �������� *****************************************************************************
--
--1. ������� �ֹι�ȣ�� ��ȸ��
--  ��, �ֹι�ȣ 9��° �ڸ����� �������� '*'���ڷ� ä��
--  �� : ȫ�浿 771120-1******

SELECT EMP_NAME ������, 
        RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') �ֹι�ȣ
FROM EMPLOYEE;

--2. ������, �����ڵ�, ����(��) ��ȸ
--  ��, ������ ��57,000,000 ���� ǥ�õǰ� ��
--     ������ ���ʽ�����Ʈ�� ����� 1��ġ �޿���
 
SELECT EMP_NAME ������, NVL(DEPT_ID, '����') �����ڵ�, 
        TO_CHAR(SALARY * 12, 'L999,999,999') "����(��)"
FROM EMPLOYEE;
 
--3. �μ��ڵ尡 50, 90�� ������ �߿��� 2004�⵵�� �Ի��� ���� ��ȸ��.
--	��� ����� �μ��ڵ� �Ի���

SELECT EMP_ID ���, EMP_NAME �����, DEPT_ID �μ��ڵ�, HIRE_DATE �Ի���
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90') AND HIRE_DATE LIKE '04/%';

--4. ������, �Ի���, �Ի��� ���� �ٹ��ϼ� ��ȸ
--  ��, �ָ��� ������

SELECT EMP_NAME ������, HIRE_DATE �Ի���, 
        LAST_DAY(HIRE_DATE) - HIRE_DATE "�Ի��� ���� �ٹ��ϼ�"
FROM EMPLOYEE;

--5. ������, �μ��ڵ�, �������, ����(��) ��ȸ
--  ��, ��������� �ֹι�ȣ���� �����ؼ�, 
--     ������ ������ �����Ϸ� ��µǰ� ��.
--  ���̴� �ֹι�ȣ���� �����ؼ� ��¥�����ͷ� ��ȯ�� ����, �����

SELECT EMP_NAME ������, DEPT_ID �μ��ڵ�,
		SUBSTR(EMP_NO, 1, 2) || '��' || SUBSTR(EMP_NO, 3,2) || '��' || SUBSTR(EMP_NO, 5,2) || '��' �������,
		EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) "����(��)"
FROM EMPLOYEE;

--6. �������� �Ի��Ϸ� ���� �⵵�� ������, �� �⵵�� �Ի��ο����� ���Ͻÿ�.
--  �Ʒ��� �⵵�� �Ի��� �ο����� ��ȸ�Ͻÿ�.
--  => to_char, decode, sum ���
--
--	-------------------------------------------------------------
--	��ü������   2001��   2002��   2003��   2004��
--	-------------------------------------------------------------

SELECT COUNT(*) ��ü������,
		SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), 2001, 1, 0)) "2001��",
        SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), 2002, 1, 0)) "2002��",
        SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), 2003, 1, 0)) "2003��",
        SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), 2004, 1, 0)) "2004��"
FROM EMPLOYEE;

--7.  �μ��ڵ尡 50�̸� �ѹ���, 60�̸� ��ȹ��, 90�̸� �����η� ó���Ͻÿ�.
--   ��, �μ��ڵ尡 50, 60, 90 �� ������ ������ ��ȸ��
--  => case ���
--	�μ��ڵ� ���� �������� ������.
-- �μ��ڵ�, �μ���(��Ī ó��)

SELECT DEPT_ID �μ��ڵ�, 
        CASE DEPT_ID WHEN '50' THEN '�ѹ���'
                    WHEN '60' THEN '��ȹ��'
                    WHEN '90' THEN '������' 
        END AS "�μ���"
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '60', '90') 
ORDER BY DEPT_ID ASC;






















