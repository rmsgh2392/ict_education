-- DAY3. SELECT 2

-- ���� 1 : 
-- �޿��� 2�鸸�̻� 4�鸸������ ������
-- ���, �̸�, �޿�, �����ڵ�, �μ��ڵ� ��ȸ
-- ��Ī ���
SELECT EMP_ID ���, EMP_NAME �̸�, SALARY �޿�, JOB_ID �����ڵ�, DEPT_ID �μ��ڵ�
FROM EMPLOYEE
WHERE SALARY >= 2000000 AND SALARY <= 4000000;

-- ���� 2 : 
-- �Ի����� 1995�� 1�� 1�Ϻ��� 2000�� 12�� 31�� ���̿� �Ի��� ������
-- ���, �̸�, �Ի���, �μ��ڵ� ��ȸ
-- ��Ī ���
-- ��¥ �����ʹ� ��ϵ� ����� ��ġ�ǰ� �ۼ��ϸ� ��
-- ���� ����ǥ���� ��� ǥ���� : '1995/01/01' �Ǵ� '95/01/01'
SELECT EMP_ID ���, EMP_NAME �̸�, HIRE_DATE �Ի���, DEPT_ID �μ��ڵ�
FROM EMPLOYEE
WHERE HIRE_DATE >= '95/01/01' AND HIRE_DATE <= '00/12/31';

-- ���� ������ : || (�ڹ��� println("��¸޼���" + ��°�) ������ ��������)
-- SELECT ������ ��ȸ�� �÷������� ���� ó���� �ؼ� �ϳ��� ������ ����ų�
-- �÷��� �ڿ� ���� ���� ǥ���� �� �̿��� �� ����
SELECT EMP_NAME || ' ������ �޿��� ' || SALARY || '�� �Դϴ�.' AS �޿�����
FROM EMPLOYEE
WHERE DEPT_ID = '90';

-- ���� 3 : 
-- 2000�� 1�� 1�� ���Ŀ� �Ի��� ��ȥ�� ������
-- �̸�, �Ի���, �����ڵ�, �μ��ڵ�, �޿�, ��ȥ���� ��ȸ
-- ��Ī ���
-- �Ի糯¥ �ڿ� ' �Ի�' ���� ���� �����
-- �޿��� �ڿ��� '(��)' ���� ���� �����
-- ��ȥ���� �� ���ͷ� ����� : '��ȥ' ���� ä��
SELECT EMP_NAME �̸�, HIRE_DATE || ' �Ի�' �Ի���, JOB_ID �����ڵ�, DEPT_ID �μ��ڵ�, 
        SALARY || '(��)' �޿�, '��ȥ' ��ȥ����
FROM EMPLOYEE
WHERE HIRE_DATE >= '00/01/01' AND MARRIAGE = 'Y';

-- BETWEEN AND ������
-- WHERE �÷��� BETWEEN ������ AND ū��
-- �÷��� ���� ������ �̻��̸鼭 ū�������� ����� ����. ��� �ǹ���.
-- WHERE �÷��� >= ������ AND �÷��� <= ū��  �� ���� �ǹ��� ��������.

SELECT EMP_NAME �̸�, SALARY �޿�
FROM EMPLOYEE
--WHERE SALARY >= 3500000 AND SALARY <= 5500000;
WHERE SALARY BETWEEN 3500000 AND 5500000;

SELECT EMP_ID ���, EMP_NAME �̸�, HIRE_DATE �Ի���, DEPT_ID �μ��ڵ�
FROM EMPLOYEE
--WHERE HIRE_DATE >= '95/01/01' AND HIRE_DATE <= '00/12/31';
WHERE HIRE_DATE BETWEEN '95/01/01' AND '00/12/31';

-- LIKE ������
-- ���ڿ����� ���� ������ �����ؼ�, ���ϰ� ��ġ�ϴ� ���ڿ��� ��� �� ����ϴ� ��������.
-- WHERE �÷��� LIKE '��������'
-- �������Ͽ� ���ϵ�ī�� ���� ����� : % (0���̻��� ����), _ (���� ���ڸ�)

-- ���� �达�� ���� ���� ��ȸ
-- ���, �̸�, �ֹι�ȣ, ��ȭ��ȣ : ��Ī ����
SELECT EMP_ID ���, EMP_NAME �̸�, EMP_NO �ֹι�ȣ, PHONE ��ȭ��ȣ
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- ���� �̸��� '��' �ڰ� ���ԵǾ� �ִ� ���� ���� ��ȸ
-- �̸�, �ֹι�ȣ, ��ȭ��ȣ, ��ȥ���� : ��Ī ����
SELECT EMP_NAME �̸�, EMP_NO �ֹι�ȣ, PHONE ��ȭ��ȣ, MARRIAGE ��ȥ����
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

-- ��ȭ��ȣ�� ����(4��° �ڸ���)�� '9'�� �����ϴ� ���� ���� ��ȸ
-- �̸�, ��ȭ��ȣ : ��Ī ����
SELECT EMP_NAME �̸�, PHONE ��ȭ��ȣ
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- ���� : 
-- ������ ������ ���� ��ȸ
-- �ֹι�ȣ 8��° ���ڰ� 1�̸� ����, 2�̸� ������.
-- ���, �̸�, �ֹι�ȣ, ��ȭ��ȣ : ��Ī ��ȸ
SELECT EMP_ID ���, EMP_NAME �̸�, EMP_NO �ֹι�ȣ, PHONE ��ȭ��ȣ
FROM EMPLOYEE
WHERE EMP_NO LIKE '_______2%';

-- �̸��Ͽ��� ���̵� �κ��� �� �߿��� ��ϵ� '_' �� ���ڰ� 3���ڷ� ������ ���� ���� ��ȸ
-- �̸�, �̸���
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
--WHERE EMAIL LIKE '____%';
WHERE EMAIL LIKE '___\_%' ESCAPE '\';
-- ��ϰ��� '_'�� ���ϵ�ī�� '_' �� ������ �� �� => ���ϵ�ī�� '_'�� �ؼ���
-- ��ϰ��� �����ϱ� ���ؼ� ESCAPE OPTION �� ����ϸ� ��
-- ��Ϲ��� �տ� ��ȣ�� �ϳ� ǥ����
-- '�������ϱ�ȣ��Ϲ���' ESCAPE '��ȣ'

-- NOT LIKE 
-- ������ ������ ���� ��ȸ
-- �ֹι�ȣ 8��° ���ڰ� 1�̸� ����, 2�̸� ������.
-- ���, �̸�, �ֹι�ȣ, ��ȭ��ȣ : ��Ī ��ȸ
SELECT EMP_ID ���, EMP_NAME �̸�, EMP_NO �ֹι�ȣ, PHONE ��ȭ��ȣ
FROM EMPLOYEE
--WHERE EMP_NO LIKE '_______2%';
--WHERE EMP_NO NOT LIKE '_______2%';
WHERE NOT EMP_NO LIKE '_______2%';

-- IS NULL ������
-- WHERE �÷��� IS NULL
-- �ش� �÷��� ���� ���� ����� ����. �� �ǹ���
-- �÷��� = NULL : ������

-- �μ��� ���޵� �������� ���� ���� ��ȸ
-- ���, �̸�, �����ڵ�, �μ��ڵ�
SELECT EMP_ID, EMP_NAME, JOB_ID, DEPT_ID
FROM EMPLOYEE
WHERE DEPT_ID IS NULL AND JOB_ID IS NULL;
--WHERE DEPT_ID = NULL;  -- ����� �� ������ ������.

-- ���ʽ�����Ʈ�� ���� ���� ��ȸ
-- ���, �̸�, �μ��ڵ�, ���ʽ�����Ʈ
SELECT EMP_ID, EMP_NAME, DEPT_ID, BONUS_PCT
FROM EMPLOYEE
WHERE BONUS_PCT IS NULL OR BONUS_PCT = 0.0;

-- IS NOT NULL ������
-- WHERE �÷��� IS NOT NULL
-- �÷��� ���� ��ϵ� (���� �ƴ�) �ǹ���

-- �μ��� �������� �ʾҴµ�, �����ڴ� �ִ� ���� ��ȸ
-- ���, �̸�, �����ڻ��, �μ��ڵ�
SELECT EMP_ID, EMP_NAME, MGR_ID, DEPT_ID
FROM EMPLOYEE
WHERE DEPT_ID IS NULL AND MGR_ID IS NOT NULL;  -- 0 ��

-- �μ��� ���� �����ڵ� ���� ����
SELECT EMP_ID, EMP_NAME, MGR_ID, DEPT_ID
FROM EMPLOYEE
WHERE DEPT_ID IS NULL AND MGR_ID IS NULL;

-- �μ��� ���µ� ���ʽ�����Ʈ�� �޴� ���� ��ȸ
-- ���, �̸�, ���ʽ�����Ʈ, �μ��ڵ�
SELECT EMP_ID, EMP_NAME, BONUS_PCT, DEPT_ID
FROM EMPLOYEE
WHERE DEPT_ID IS NULL AND BONUS_PCT IS NOT NULL;

-- IN ������
-- WHERE �÷��� IN (�񱳰�1, �񱳰�2, ....)
-- WHERE �÷��� = �񱳰�1 OR �÷��� = �񱳰�2 OR .....

-- 90 �Ǵ� 20�� �μ��� �ٹ��ϴ� ���� ��ȸ
SELECT *
FROM EMPLOYEE
--WHERE DEPT_ID = '90' OR DEPT_ID = '20';
WHERE DEPT_ID IN ('90', '20');

-- ������ �켱 ������ ���� ����
-- 60, 90�� �μ��� �Ҽӵ� ������ �� �޿� 300�� ���� ���� �޴� ���� ��ȸ
-- ���, �μ��ڵ�, �޿�
SELECT EMP_ID, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE DEPT_ID = '60' OR DEPT_ID = '90'
AND SALARY > 3000000;  -- AND �� OR ���� �켱������ ����. ����� Ʋ����.

-- �ذ� : () �� ��� �ذ�
SELECT EMP_ID, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE (DEPT_ID = '60' OR DEPT_ID = '90')
AND SALARY > 3000000; 

-- �ذ� : IN ������ ���
SELECT EMP_ID, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE DEPT_ID IN ('60', '90')
AND SALARY > 3000000; 

-- **************************************************************************
--SELECT ��������
--
--1. �μ��ڵ尡 90�̸鼭, �����ڵ尡 J2�� �������� ���, �̸�, �μ��ڵ�, �����ڵ�, �޿� ��ȸ��
--   ��Ī ������
SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_ID �μ��ڵ�, JOB_ID �����ڵ�, SALARY �޿�
FROM EMPLOYEE
WHERE DEPT_ID = '90' AND JOB_ID = 'J2';

--2. �Ի����� '1982-01-01' �����̰ų�, �����ڵ尡 J3 �� �������� ���, �̸�, ������ ���, ���ʽ�����Ʈ ��ȸ��
SELECT EMP_ID ���, EMP_NAME �̸�, MGR_ID �����ڻ��, BONUS_PCT ���ʽ�����Ʈ
FROM EMPLOYEE
WHERE HIRE_DATE >= '82/01/01' OR JOB_ID = 'J3';

--3. �����ڵ尡 J4�� �ƴ� �������� �޿��� ���ʽ�����Ʈ�� ����� ������ ��ȸ��.
--  ��Ī ������, ���, �����, �����ڵ�, ����(��)
--  ��, ���ʽ�����Ʈ�� null �� ���� 0���� �ٲپ� ����ϵ��� ��.
SELECT EMP_ID ���, EMP_NAME �����, JOB_ID �����ڵ�, 
        (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 || ' (��)' ����
FROM EMPLOYEE
WHERE JOB_ID != 'J4';

--4. ���ʽ�����Ʈ�� 0.1 �̻� 0.2 ������ �������� ���, �����, �̸���, �޿�, ���ʽ�����Ʈ ��ȸ��
SELECT EMP_ID ���, EMP_NAME �����, EMAIL �̸���, SALARY �޿�, BONUS_PCT ���ʽ�����Ʈ
FROM EMPLOYEE
WHERE BONUS_PCT BETWEEN 0.1 AND 0.2;
-- WHERE BONUS_PCT >= 0.1 AND BONUS_PCT <= 0.2;

--5. ���ʽ�����Ʈ�� 0.1 ���� �۰ų�(�̸�), 0.2 ���� ����(�ʰ�) �������� ���, �����, ���ʽ�����Ʈ, �޿�, �Ի��� ��ȸ��
SELECT EMP_ID ���, EMP_NAME �����, EMAIL �̸���, SALARY �޿�, BONUS_PCT ���ʽ�����Ʈ
FROM EMPLOYEE
WHERE BONUS_PCT NOT BETWEEN 0.1 AND 0.2;

--6. '1982-01-01' ���Ŀ� �Ի��� �������� �����, ���ʽ�����Ʈ, �޿� ��ȸ��
SELECT EMP_NAME �̸�, BONUS_PCT ���ʽ�����Ʈ, SALARY �޿�
FROM EMPLOYEE
WHERE HIRE_DATE >= '82/01/01';

--7. ���ʽ�����Ʈ�� 0.1, 0.2 �� �������� ���, �����, ���ʽ�����Ʈ, ��ȭ��ȣ ��ȸ��
SELECT EMP_ID ���, EMP_NAME �̸�, BONUS_PCT ���ʽ�����Ʈ, PHONE ��ȭ��ȣ
FROM EMPLOYEE
WHERE BONUS_PCT IN (0.1, 0.2);

--8. ���ʽ�����Ʈ�� 0.1�� 0.2�� �ƴ� �������� ���, �����, ���ʽ�����Ʈ, �ֹι�ȣ ��ȸ��
SELECT EMP_ID ���, EMP_NAME �̸�, BONUS_PCT ���ʽ�����Ʈ, PHONE ��ȭ��ȣ
FROM EMPLOYEE
WHERE BONUS_PCT NOT IN (0.1, 0.2);

--9. ���� '��'���� �������� ���, �����, �Ի��� ��ȸ��
--  ��, �Ի��� ���� �������� ������
SELECT EMP_ID ���, EMP_NAME �����, HIRE_DATE �Ի���
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%'
ORDER BY HIRE_DATE ASC;

--10. �ֹι�ȣ 8��° ���� '2'�� ������ ���, �����, �ֹι�ȣ, �޿��� ��ȸ��
--  ��, �޿� ���� �������� ������
SELECT EMP_ID ���, EMP_NAME �����, EMP_NO �ֹι�ȣ, SALARY �޿�
FROM EMPLOYEE
WHERE EMP_NO LIKE '_______2%'
ORDER BY SALARY DESC;

-- **********************************************************************************
-- �Լ� (FUNCTION)
-- �÷��� ��ϵ� ���� �о ó���� ����� ��ȯ�ϴ� ������.
-- �Լ���(�÷���) ���� �����
-- ������ �Լ��� �׷��Լ��� ���е�.
-- ������ �Լ� : ���� ���� N���̸�, ��ȯ���� N����
-- �׷� �Լ� : ���� ���� N���̸� ��ȯ���� 1����

-- �׷��Լ� : SUM, AVG, MAX, MIN, COUNT

-- SUM(�÷���) | SUM(DISTINCT �÷���)
-- �÷��� ��ϵ� ������ �հ踦 ���ؼ� ������

-- �ҼӺμ��� '50'�̰ų� �μ��� �������� ���� �������� �޿� �հ� ��ȸ
SELECT SUM(SALARY), SUM(DISTINCT SALARY)
FROM EMPLOYEE
WHERE DEPT_ID = '50' OR DEPT_ID IS NULL;

-- AVG(�÷���) | AVG(DISTINCT �÷���)
-- ����� ���ؼ� ��ȯ��

-- �ҼӺμ��� 50 �Ǵ� 90 �Ǵ� NULL �� �������� ���ʽ� ��� ��ȸ
SELECT AVG(BONUS_PCT) �⺻���, -- /4
        AVG(DISTINCT BONUS_PCT) �ߺ��������, -- /3
        AVG(NVL(BONUS_PCT, 0)) NULL�������  -- /10
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90') OR DEPT_ID IS NULL;

-- MAX(�÷���) | MAX(DISTINCT �÷���)
-- �÷��� ��ϵ� ���� �� ���� ū ���� ������
-- MIN(�÷���) | MIN(DISTINCT �÷���)
-- �÷��� ��ϵ� ���� �� ���� ���� ���� ������
-- ������(CHAR, VARCHAR2, LONG, CLOB), ������(NUMBER), ��¥��(DATE) : ��� �ڷ����� ����� �� ����

-- �μ��ڵ尡 50 �Ǵ� 90�� �������� �����ڵ��� �ִ밪, �ּҰ�, �Ի����� �ִ밪, �ּҰ�, �޿��� �ִ밪, �ּҰ��� ��ȸ
SELECT MAX(JOB_ID), MIN(JOB_ID),
        MAX(HIRE_DATE), MIN(HIRE_DATE),
        MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90');

-- COUNT(*) | COUNT(�÷���) | COUNT(DISTINCT �÷���)
-- * : ���̺��� ��ü �� ���� ��ȯ��
-- �÷��� : NULL �� ������ ��ϰ��� �హ�� ��ȯ��

SELECT COUNT(*), COUNT(DEPT_ID), COUNT(DISTINCT DEPT_ID)
FROM EMPLOYEE;

-- 50�� �μ��� �ҼӵǾ��ų� �μ��� �������� ���� ���� �� �ľ�
SELECT COUNT(*), -- NULL ���Ե� ��ü �హ��
        COUNT(DEPT_ID) -- NULL ���ܵ� �హ��
FROM EMPLOYEE
WHERE DEPT_ID = '50' OR DEPT_ID IS NULL;

-- �׷��Լ��� SELECT ��, HAVING �������� ����� �� ����.
-- �׷��Լ��� WHERE �������� ��� �� �� : WHERE ���� �� �྿ ���� �񱳸� �ϱ� ������

-- �� ������ �޿� ��պ��� �޿��� ���� �޴� ���� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > AVG(SALARY);  -- ERROR

-- �ذ� 1 : �޿� ����� ���� ���� ����, �� ���� WHERE ������ �����
SELECT AVG(SALARY)
FROM EMPLOYEE;   -- 2961818.18181818181818181818181818181818

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > 2961818;

-- �ذ� 2 : ���������� ���
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);

-- ������ �Լ��� �׷��Լ��� SELECT ���� �Բ� ��� �� ��
-- ORDB (Object Relational DataBase) : ��ü ������ �����ͺ��̽�
-- 2���� ���̺� ������ ���� �����͸� ǥ����. (�簢���̾�� ��)
SELECT UPPER(EMAIL), SUM(SALARY)   -- ERROR
FROM EMPLOYEE;

-- ������ �Լ� (SINGLE ROW FUNCTION) **************************************************

-- ���ڿ� �Լ� --------------------------------------------------------------------------------------------

-- LENGTH('���ڿ����ͷ�' | ���ڰ� ��ϵ� �÷���)
-- ���� ������ ��ȯ��

SELECT LENGTH('ORACLE'), LENGTH('����Ŭ')
FROM DUAL;
-- ���̺� �������� �ܼ��� ����� ����� SELECT �ϴ� ��쿡 ����(DUMMY) ���̺��� FROM ���� ����� �� ����.
-- ����Ŭ���� ������

SELECT 23 + 5 
FROM DUAL;

SELECT EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;

-- LENGTHB('���ڿ����ͷ�' | ���ڰ� ��ϵ� �÷���)
-- ��� ������ ����Ʈ ũ�⸦ ��ȯ��
SELECT LENGTH('ORACLE'), LENGTHB('ORACLE'),
        LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL;
-- ��ǻ�Ϳ����� �ѱ��� �⺻ 1���ڰ� 2����Ʈ��.
-- eXpress Edition ��ǰ���� �ѱ� 1���ڸ� 3����Ʈ �Ҵ��ϰ� ����.


-- INSTR('���ڿ����ͷ�' | ���ڰ� ��ϵ� �÷���, ã������, ã�� ������ġ, ���°����) �Լ�

-- �̸��Ͽ��� '@' ������ ��ġ ��ȸ
SELECT EMAIL, INSTR(EMAIL, '@')
FROM EMPLOYEE;

-- �̸��Ͽ��� '@'���� �ٷ� �ڿ� �ִ� 'k' ������ ��ġ�� ��ȸ
-- ��, �ڿ��� �˻��Ѵٸ�
SELECT EMAIL, INSTR(EMAIL, 'k', -1, 3)
FROM EMPLOYEE;

-- �Լ� ��ø ��� ������ : �Լ� �ȿ� �Լ� ���
-- �̸��Ͽ��� '.' ���� �ٷ� �ڿ� �ִ� 'c' ������ ��ġ�� ��ȸ
-- ��, '.' ���� �ٷ� �ձ��ں��� �˻� �����ϵ��� ��
SELECT EMAIL, INSTR(EMAIL, 'c', INSTR(EMAIL, '.') - 1)
FROM EMPLOYEE;

-- LPAD('���ڿ����ͷ�' | ���ڰ� ��ϵ� �÷���, ����� �ʺ� ���ڼ�, ���¿��� ä�﹮��)
-- ä�﹮�ڰ� �����Ǹ� �⺻���� ' ' (���鹮��)��
-- LPAD() : ���� ä���, RPAD() : ������ ä���
SELECT EMAIL ����, LENGTH(EMAIL) �������ڼ�,
        LPAD(EMAIL, 20, '*') ä�����,
        LENGTH(LPAD(EMAIL, 20, '*')) �������
FROM EMPLOYEE;

SELECT EMAIL ����, LENGTH(EMAIL) �������ڼ�,
        RPAD(EMAIL, 20, '*') ä�����,
        LENGTH(RPAD(EMAIL, 20, '*')) �������
FROM EMPLOYEE;



