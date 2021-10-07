-- DAY4. SELECT3

-- ������ �Լ� ��� ���� ----------------------------

-- LTRIM('���ڿ����ͷ�' | ���ڰ� ��ϵ� �÷���, '�����ҹ��ڵ�')
-- ���ڿ��� ���ʿ� �ִ� ���ڸ� ������. (������ ���ڰ� �ƴ� �ٸ� ���ڰ� ������ TRIM �����)
-- RTRIM('���ڿ����ͷ�' | ���ڰ� ��ϵ� �÷���, '�����ҹ��ڵ�')
-- ���ڿ��� �����ʿ� �ִ� ���ڸ� ������. (������ ���ڰ� �ƴ� �ٸ� ���ڰ� ������ TRIM �����)

SELECT '       0123456ABCDabxyORACLExxxxyyyyzyx532     ',
        LTRIM('       0123456ABCDabxyORACLExxxxyyyyzyx532     '),
        LTRIM('       0123456ABCDabxyORACLExxxxyyyyzyx532     ', ' '),
        LTRIM('       0123456ABCDabxyORACLExxxxyyyyzyx532     ', ' 0123456789'),
        LTRIM('       0123456ABCDabxyORACLExxxxyyyyzyx532     ', ' 0123456ABCDybax')
FROM DUAL;

SELECT '       0123456ABCDabxyORACLExxxxyyyyzyx532     ',
        RTRIM('       0123456ABCDabxyORACLExxxxyyyyzyx532     '),
        RTRIM('       0123456ABCDabxyORACLExxxxyyyyzyx532     ', ' '),
        RTRIM('       0123456ABCDabxyORACLExxxxyyyyzyx532     ', ' 0123456789'),
        RTRIM('       0123456ABCDabxyORACLExxxxyyyyzyx532     ', ' 0123456789xyz')
FROM DUAL;

-- TRIM(LEADING | TRAILING | BOTH '�����ҹ����ϳ�' FROM '���ڸ��ͷ�' | �÷���)
-- �⺻�� ������ ���� �����ϴ� �Լ� (�⺻�� BOTH ��)
-- �����ҹ��� ������ ���鹮�� ���Ÿ� �ǹ���
SELECT 'aaORACLEaa',
        TRIM('a' FROM 'aaORACLEaa'),
        TRIM(LEADING 'a' FROM 'aaORACLEaa'),
        TRIM(TRAILING 'a' FROM 'aaORACLEaa'),
        TRIM(BOTH 'a' FROM 'aaORACLEaa')
FROM DUAL;

-- SUBSTR('���ڸ��ͷ�' | �÷���, ������ ������ġ, ������ ���ڼ�)
-- ������ ������ġ : ���(�տ��������� ��ġ), ����(�ڿ��������� ��ġ)
-- ������ ���ڼ� : �����Ǹ� ���� �������� �ǹ���
SELECT 'ORACLE 18C',
        SUBSTR('ORACLE 18C', 5),
        SUBSTR('ORACLE 18C', 8, 2),
        SUBSTR('ORACLE 18C', -7, 3)
FROM DUAL;

-- �������� �ֹι�ȣ���� ����, ����, ������ ���� �и� ��ȸ
-- ��Ī ����
SELECT EMP_NO,
        SUBSTR(EMP_NO, 1, 2) ����,
        SUBSTR(EMP_NO, 3, 2) ����,
        SUBSTR(EMP_NO, 5, 2) ����
FROM EMPLOYEE;

-- ��¥ �����Ϳ��� SUBSTR ����� �� ����
-- �������� �Ի��Ͽ��� �Ի�⵵, �Ի��, �Ի����� �и� ��ȸ
SELECT HIRE_DATE,
        SUBSTR(HIRE_DATE, 1, 2) �Ի�⵵,
        SUBSTR(HIRE_DATE, 4, 2) �Ի��,
        SUBSTR(HIRE_DATE, 7, 2) �ϻ���
FROM EMPLOYEE;

-- SUBSTRB('���ڸ��ͷ�' | �÷���, ������ ���۹���Ʈ��ġ, ������ ����Ʈ)
SELECT SUBSTR('ORACLE', 3, 2),  -- AC
        SUBSTRB('ORACLE', 3, 2),  --AC
        SUBSTR('����Ŭ', 2, 2),   --��Ŭ
        SUBSTRB('����Ŭ', 4, 6)
FROM DUAL;

-- UPPER('���ڸ��ͷ�' | ���ڰ� ��ϵ� �÷���) : �������� �� �빮�ڷ� �ٲٴ� �Լ�
-- LOWER('���ڸ��ͷ�' | ���ڰ� ��ϵ� �÷���) : �������� �� �ҹ��ڷ� �ٲٴ� �Լ�
-- INITCAP('���ڸ��ͷ�' | ���ڰ� ��ϵ� �÷���) : �������� �� ù���ڸ� �빮�ڷ� �������� �ҹ��ڷ� �ٲٴ� �Լ�
SELECT UPPER('ORACLE'), UPPER('oracle'),
        LOWER('ORACLE'), LOWER('oracle'),
        INITCAP('ORACLE'), INITCAP('oracle')
FROM DUAL;

-- �Լ� ��ø ��� : �Լ� �ȿ� �Լ��� ����� �� ����  ------------------------------------------------

-- ���� �������� �̸�, ���̵� ��ȸ
-- ���̵�� �̸��Ͽ��� �и� ������
SELECT EMP_NAME �̸�, EMAIL �̸���, 
       SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) ���̵�
FROM EMPLOYEE;

-- ���� ���̺��� �̸�, �ֹι�ȣ ��ȸ
-- �ֹι�ȣ�� ������ϼ����� ���̰� �ϰ� ���ڸ��� '*' �� ó���� : 781225-1******
SELECT EMP_NAME �̸�,
        RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') �ֹι�ȣ
FROM EMPLOYEE;

-- ���� ó�� �Լ� ********************************************************************************
-- ROUND(), TRUNC(), FLOOR(), ABS(), MOD()

-- ROUND(���� | ���ڰ� ��ϵ� �÷��� | ����, �ݿø��� �ڸ���)
-- �������� �ڸ��� ���� 5�̻��̸� �ڵ� �ݿø���
-- �ݿø��� �ڸ��� : ����̸� �Ҽ��� �Ʒ� �ڸ��� �ǹ��� (�� �ڸ����� ǥ����)
-- �ݿø��� �ڸ��� : �����̸� �Ҽ��� ���� ������ �ڸ��� �ǹ��� (�ش� �ڸ����� �ø� | ���� ó����)

SELECT 123.456,
        ROUND(123.456),   --123
        ROUND(123.456, 0), --123
        ROUND(123.456, 1), --123.5
        ROUND(123.456, -1) --120
FROM DUAL;

-- ���� �������� ���, �̸�, �޿�, ���ʽ�����Ʈ, ���ʽ�����Ʈ�� ����� ���� ��ȸ
-- ������ ��Ī ó�� : 1��޿�
-- ������ õ�������� �ݿø���
SELECT EMP_ID ���, EMP_NAME �̸�, SALARY �޿�, BONUS_PCT ���ʽ�����Ʈ,
        ROUND(((SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12), -4) "1��޿�"
FROM EMPLOYEE;

-- TRUNC(���� | ���ڰ� ��ϵ� �÷��� | ����, �ڸ���) : �����Լ�
-- �ڸ��� : �����Ǹ� 0��. (0 �� �Ҽ��� ��ġ��)
-- ������ �ڸ��� ��(���) �Ǵ� ������ �ڸ���(����)�� ���� ������ �Լ���. (�ݿø� ����)
SELECT 145.678, 
        TRUNC(145.678), -- 145
        TRUNC(145.678, 0), --145
        TRUNC(145.678, 1), --145.6
        TRUNC(145.678, -1), --140
        TRUNC(145.678, -3)  --0
FROM DUAL;

-- ���� �������� �޿��� ����� ��ȸ
-- 10�������� ������
SELECT AVG(SALARY), TRUNC(AVG(SALARY), -2)
FROM EMPLOYEE;

-- FLOOR(���� | ���ڰ� ��ϵ� �÷��� | ����)
-- ���� ����� �Լ� (�Ҽ��� �Ʒ��� ������ �Լ�)
SELECT ROUND(123.56), TRUNC(123.56), FLOOR(123.56)
FROM DUAL;

-- ABS(���� | ���ڰ� ��ϵ� �÷��� | ����)
-- ���밪 ó�� �Լ� (����� �״��, ������ ����� �ٲ�)
SELECT ABS(123), ABS(-123)
FROM DUAL;

-- �Ի��� - ����, ���� - �Ի��� ��ȸ : ��Ī�� �ٹ��ϼ�
-- �ٹ��ϼ��� ������ ó��, ��� ����� ó��
-- ���� ��¥ ���ϴ� �Լ� : SYSDATE
SELECT HIRE_DATE - SYSDATE �ٹ��ϼ�,
        SYSDATE - HIRE_DATE �ٹ��ϼ�,
        ABS(FLOOR(HIRE_DATE - SYSDATE)) �ٹ��ϼ�,
        ABS(FLOOR(SYSDATE - HIRE_DATE)) �ٹ��ϼ�
FROM EMPLOYEE;

-- MOD(���� ���, ���� ��)
-- �������� ������ ���� ��ȯ�ϴ� �Լ�
-- �ڹ�ó�� ������ % ������ ��� �� ��
SELECT FLOOR(25 / 7) ��, MOD(25, 7) ������ 
FROM DUAL;

-- ���� �������� ����� Ȧ���� ������ ��ȸ
-- ���, �̸�
SELECT EMP_ID ���, EMP_NAME �̸�
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) = 1;

-- ��¥ ó�� �Լ� **************************************************************************

-- SYSDATE �Լ�
-- �ý������� ���� ���� ��¥�� �ð��� ��ȸ�� ��

SELECT SYSDATE
FROM DUAL;

-- ����Ŭ������ ȯ�漳��, �����ͺ��̽� ��ü ���� �������� ��� ���� �����ϰ� ����
-- ������ ��ųʸ� (Data Dictionary : ������ ����) ������ ���̺� ���·� ���� ����Ǹ鼭 �����Ǳ� ����
-- ������ ��ųʸ��� DB �ý����� ������, ����ڴ� �մ� �� ����
-- ����ڴ� ����� ������ ��ȸ�ؼ� �� ���� ����

-- ȯ�漳���� ���õ� ������ ��ųʸ����� ���� ������ �Ϻ� ������ �� ����.
SELECT *
FROM SYS.nls_session_parameters;

-- ��¥ ����� ���õ� ���� ���� ��ȸ
SELECT VALUE
FROM SYS.NLS_SESSION_PARAMETERS
WHERE PARAMETER = 'NLS_DATE_FORMAT';

-- ��¥ ������ �����Ѵٸ�
ALTER SESSION
SET NLS_DATE_FORMAT = 'DD-MON-RR';

-- Ȯ��
SELECT SYSDATE
FROM DUAL;

-- ���� �������� ����
ALTER SESSION
SET NLS_DATE_FORMAT = 'RR/MM/DD';

-- ADD_MONTHS('��¥���ͷ�' | ��¥�� ��ϵ� �÷���, ���ϱ��� ������)
-- ���� �������� ���� ��¥�� ��ȯ��

-- ���� ��¥���� 10�� �� ��¥��?
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 120)
FROM DUAL;

-- ���� �������� �Ի��� ���� 20��� ��¥ ��ȸ
-- ���, �̸�, �Ի���, 20��� ��¥
SELECT EMP_ID ���, EMP_NAME �̸�, HIRE_DATE �Ի���, 
        ADD_MONTHS(HIRE_DATE, 240) "20��� ��¥"
FROM EMPLOYEE;

-- ������ �� �ٹ������ 20�� �̻�� ���� ���� ��ȸ
-- ���, �̸�, �μ��ڵ�, �����ڵ�, �Ի���
SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_ID �μ��ڵ�, JOB_ID �����ڵ�, HIRE_DATE �Ի���
FROM EMPLOYEE
WHERE ADD_MONTHS(HIRE_DATE, 240) < SYSDATE;

-- MONTHS_BETWEEN('��¥���ͷ�' | ��¥�� ��ϵ� �÷��� | ��¥�Լ�, '��¥���ͷ�' | ��¥�� ��ϵ� �÷��� | ��¥�Լ�)
-- �� ��¥�� ���� ���� ���̸� ��ȯ��

-- �������� �̸�, �Ի���, ��������� �ٹ��ϼ�, �ٹ�������, �ٹ���� ��ȸ
-- ��� ���������� ó����
SELECT EMP_NAME �̸�, HIRE_DATE �Ի���,
        FLOOR(SYSDATE - HIRE_DATE) �ٹ��ϼ�,
        FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) �ٹ�������,
        FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) �ٹ����
FROM EMPLOYEE;

-- NEXT_DAY('��¥���ͷ�' | ��¥�� ��ϵ� �÷���, '�����̸�')
-- ������ ��¥ ���� ��¥���� ���� ����� ���� ������ ��¥�� ��ȯ��
-- ���� DBMS �� ���� 'KOREAN' �̹Ƿ� �����̸��� �ѱ۷� ��� ��
-- ����� �����̸� ����ϸ� ������

SELECT SYSDATE, NEXT_DAY(SYSDATE, '�Ͽ���')
FROM DUAL;

SELECT SYSDATE, NEXT_DAY(SYSDATE, 'SUNDAY')
FROM DUAL;  -- ERROR

-- ȯ�漳������ ��� ��� ������ ��
ALTER SESSION
SET NLS_LANGUAGE = AMERICAN;

ALTER SESSION
SET NLS_LANGUAGE = KOREAN;

-- LAST_DAY('��¥���ͷ�' | ��¥�� ��ϵ� �÷���)
-- ������ ��¥�� ���� ���� ������ ��¥(DATE)�� ��ȯ��
SELECT SYSDATE, LAST_DAY(SYSDATE)
FROM DUAL;

-- ���� �������� �̸�, �Ի���, �Ի��� ���� �ٹ��ϼ� ��ȸ
-- �ָ� ���� �ϼ�
SELECT EMP_NAME �̸�, HIRE_DATE �Ի���,
        LAST_DAY(HIRE_DATE) - HIRE_DATE "�Ի� ù�� �ٹ��ϼ�"
FROM EMPLOYEE;

-- ���� ��¥ ��ȸ �Լ�
SELECT SYSDATE, SYSTIMESTAMP,
        CURRENT_DATE, CURRENT_TIMESTAMP
FROM DUAL;

-- EXTRACT(���������� FROM ��¥)
-- ��¥ �����Ϳ��� ���ϴ� ������ �����ؼ� ��ȯ�ϴ� �Լ���.
-- ������ ���� : YEAR, MONTH, DAY, HOUR, MINUTE, SECOND

-- ���� ��¥���� �⵵, ��, �� ���� ����
SELECT SYSDATE, 
        EXTRACT(YEAR FROM SYSDATE),
        EXTRACT(MONTH FROM SYSDATE),
        EXTRACT(DAY FROM SYSDATE)
FROM DUAL;

-- ������ �̸�, �Ի���, �ٹ����1, �ٹ����2 ��ȸ
-- �ٹ������ ���� ��¥ �������� ����� : EXTRACT, MONTHS_BETWEEN ���� ����� ��
-- �ٹ������ ������ ó����
SELECT EMP_NAME �̸�, HIRE_DATE �Ի���,
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) "�ٹ����1",
        FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) "�ٹ����2"
FROM EMPLOYEE;

-- ����ȯ �Լ� ***********************************************************
-- NUMBER, DATE, CHARACTER ���� Ÿ���� �ٲٴ� �Լ�

-- �ڵ�����ȯ ���
SELECT 25 + '10'   -- NUMBER + CHARACTER --> �ڵ����� NUMBER �� �ٲ�(�ڵ�����ȯ)
FROM DUAL;

-- �������ȯ
SELECT 25 + TO_NUMBER('10')
FROM DUAL;

SELECT *
FROM EMPLOYEE
--WHERE EMP_ID = 100;  -- CHAR = NUMBER  --> CHAR �ڵ�����ȯ��
WHERE EMP_ID = TO_CHAR(100);  -- �������ȯ

-- �ڵ�����ȯ�� �� �Ǵ� ��� ==> ����ȯ�� ����ؾ� ��
SELECT SYSDATE - '15/03/25'  -- DATE - CHARACTER : �ڵ�����ȯ �� ��
FROM DUAL;  -- ERROR

SELECT SYSDATE - TO_DATE('15/03/25') -- �������ȯ
FROM DUAL;

-- TO_CHAR() �Լ� --------------------------------------------------------------------
-- ����(NUMBER)�� ��¥(DATE)�� ���� ��� ����(FORMAT : �������) ������ ����ϴ� �Լ�
-- NUMBER + FORMAT ==> CHARACTER (������ ����� ���ڿ��� ��ȯ��)
-- DATE + FORMAT ==> CHARACTER (������ ����� ���ڿ��� ��ȯ��)

-- ���ڿ� ���� �����ϴ� TO_CHAR() �Լ� ���
-- ������� : TO_CHAR(���ڰ� | ���ڰ� ��ϵ� �÷���, '���������빮�ڿ�')
-- �ַ� ��ȭ���� ǥ��, õ����������, �Ҽ��� ǥ��, �Ǽ��� ������ ������(���п� ǥ��)���� ǥ��

SELECT EMP_NAME �̸�,
        TO_CHAR(SALARY, 'L99,999,999') �޿�,
        TO_CHAR(NVL(BONUS_PCT, 0), '90.00') ���ʽ�����Ʈ
FROM EMPLOYEE;

-- ��¥�� ���� �����ϴ� TO_CHAR() �Լ� ���
-- ������� : TO_CHAR('��¥������' | ��¥�� ��ϵ� �÷���, '�����������ڿ�')
-- ����� �ú��� �б� ���� ����|���� ���� ��� ó���� �� �����

-- �⵵ ��� ����
SELECT SYSDATE,
        TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'RRRR'),
        TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'RR'),
        TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- �⵵ ��� ���� + '������ ���ڿ�'
-- '' �ȿ� '' �� ����� �� ���� ���� ����ǥ �ȿ� ū ����ǥ�� ����� �����
SELECT SYSDATE,
        TO_CHAR(SYSDATE, 'YYYY "��"'), TO_CHAR(SYSDATE, 'RRRR "��"'),
        TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'RR'),
        TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- ���� ���� ����
SELECT SYSDATE,
        TO_CHAR(SYSDATE, 'YYYY "��" MM "��"'), TO_CHAR(SYSDATE, 'RRRR "��" fmMM "��"'),
        TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'RM'),
        TO_CHAR(SYSDATE, 'MONTH'), TO_CHAR(SYSDATE, 'MON')
FROM DUAL;

-- ��¥�� ���� ����
SELECT SYSDATE,
        TO_CHAR(SYSDATE, '"1�����" DDD "��°"'),
        TO_CHAR(SYSDATE, '"������" DD "��°"'),
        TO_CHAR(SYSDATE, '"�ֱ���" D "��°"')
FROM DUAL;

-- �б�� ���� ����
SELECT SYSDATE,
        TO_CHAR(SYSDATE, 'Q "�б�"'),
        TO_CHAR(SYSDATE, 'DAY'),
        TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

-- ���� �������� �̸�, �Ի��� ��ȸ
-- �Ի����� ���� ������ : '2016�� 05�� 19�� (��)' 
SELECT EMP_NAME �̸�,
        TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��" "("DY")"') �Ի���,
        TO_CHAR(HIRE_DATE, 'YYYY"��" MON DD"��" "("DY")"') �Ի���
FROM EMPLOYEE;









