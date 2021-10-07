--LTRIM, RTRIM�Լ� ��� ��
SELECT '       01234414ABCDabxcxORACLEexxxxbz94220      ',
        LTRIM('       0123456ABCDabxcxORACLEexxxxbz942     '),
        LTRIM('       0123456ABCDabxcxORACLEexxxxbz942      ',' '),
        LTRIM('       0123456ABCDabxcxORACLEexxxxbz942      ', ' 0123456'),
        LTRIM('       0123456ABCDabxcxORACLEexxxxbz942      ', ' 0123456ABCDabxyz')
FROM DUAL;

SELECT '       01234414ABCDabxcxORACLEexxxxbz94220      ',
        RTRIM('       0123456ABCDabxcxORACLEexxxxbz942     '),
        RTRIM('       0123456ABCDabxcxORACLEexxxxbz942      ',' '),
        RTRIM('       0123456ABCDabxcxORACLEexxxxbz942      ', ' 0123456'),
        RTRIM('       0123456ABCDabxcxORACLEexxxxbz942      ', ' 0123456ABCDabxyz')
FROM DUAL;

SELECT LTRIM('123123TECH','123')
FROM DUAL;

--TRIM(LEADING | TRAILING | BOTH '������ ���� �ϳ�!' FROM '���ڸ��ͷ�' | �÷���)
--�⺻������ ��������� ǥ�ø� ���ϸ� �⺻�� ������ ���ڸ� �����Ѵ�. (�⺻�� BOTH)
--������ ����! -> LTRIM�� RTRIM�� �ٸ���!
SELECT 'aaORACLEaa',
       TRIM('a' FROM 'aaORACLEaa'),
       TRIM(LEADING 'a' FROM 'aaORACLEaa'),
       TRIM(TRAILING 'a' FROM 'aaORACLEaa'),
       TRIM(BOTH 'a' FROM 'aaORACLEaa')
FROM DUAL;

--SUBSTR() ��� ��
SELECT 'ORACLE 18EXPRESS',
        SUBSTR('ORACLE 18EXPRESS', 7),
        SUBSTR('ORACLE 18EXPRESS', 8, 2),
        SUBSTR('ORACLE 18EXPRESS', -11, 2)
FROM DUAL;

SELECT EMAIL, SUBSTR(EMAIL, 7)
FROM EMPLOYEE;

SELECT EMAIL, SUBSTR(EMAIL, -7, 3)
FROM EMPLOYEE;

SELECT EMP_NO �ֹι�ȣ,
       SUBSTR(EMP_NO, 1, 2) || '���',
       SUBSTR(EMP_NO, 3, 2) || '��',
       SUBSTR(EMP_NO, 5, 2) || '��',
       SUBSTR(EMP_NO, 8, 1) || '����(1:����, 2:����)'
FROM EMPLOYEE;

--��¥�����͵� SUBSTR��밡��
SELECT HIRE_DATE, EMP_NAME,
       SUBSTR(HIRE_DATE, 1, 2) || '��' �Ի�⵵,
       SUBSTR(HIRE_DATE, 4, 2) || '��' �Ի��,
       SUBSTR(HIRE_DATE, 7, 2) || '��' �Ի���
FROM EMPLOYEE;

SELECT ROUND(125.3131, -1)
FROM DUAL;

SELECT SUBSTR('ORACLE', 3, 2),
        SUBSTRB('ORACLE', 3, 2),
        SUBSTR('����Ŭ', 2, 2),
        SUBSTRB('����Ŭ', 4, 6)
FROM DUAL;

--�Լ� ��ø ��� :  �Լ��ȿ� �Լ��� ����� �� ����
SELECT EMP_NAME �̸�, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) ���̵� 
FROM EMPLOYEE;

SELECT EMP_NAME �̸�, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') �ֹι�ȣ
FROM EMPLOYEE; --14���� �ڸ��� LENGTH(EMP_NO)�ε� ��ü �����ϴ�.

SELECT EMP_NAME, EMAIL,
        LPAD(SUBSTR(EMP_NO, 7, 14), 14, '*')
FROM EMPLOYEE;

SELECT EMAIL, RTRIM(EMAIL, '@kcom.')
FROM EMPLOYEE;

SELECT 123.456,
        ROUND(123.456),
        ROUND(123.456, 1), --�Ҽ��� ù��¥������ ǥ���ϰ� ��°�ڸ����� ������
        ROUND(123.456, 2),
        ROUND(123.456, -1)
FROM DUAL;

--���� õ�������� �ݿø�
SELECT EMP_ID, EMP_NAME, SALARY, BONUS_PCT,
       ROUND(((SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12), -4) "1�� �޿�"
FROM EMPLOYEE;

SELECT 145.678,
        TRUNC(145.678),
        TRUNC(145.678, 0),
        TRUNC(145.678, 1),
        TRUNC(145.678, 3),
        TRUNC(145.678, -1),
        TRUNC(145.678, -2)
FROM DUAL;

SELECT AVG(SALARY), TRUNC(AVG(SALARY), -2)
FROM EMPLOYEE;

SELECT FLOOR(AVG(SALARY))
FROM EMPLOYEE;

SELECT TRUNC(ABS(-1234.56), -1)
FROM DUAL;

--��¥���굵 �����ϴ�.
SELECT SYSDATE - HIRE_DATE �ٹ��ϼ�,
        HIRE_DATE - SYSDATE �ٹ��ϼ�,
       ABS(FLOOR(HIRE_DATE - SYSDATE)) �ٹ��ϼ�,
       ABS(FLOOR(SYSDATE - HIRE_DATE)) �ٹ��ϼ�
FROM EMPLOYEE;

SELECT FLOOR(25 / 7) ��, MOD(25, 7) ������
FROM DUAL;

SELECT EMP_ID, EMP_NAME  --EMP_ID�� ����Ÿ���ε� ����� �ڵ�����ȯ�� ���ش�.
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) LIKE 1;

SELECT SYSDATE
FROM DUAL;

SELECT * 
FROM SYS.nls_session_parameters;

--��¥ ���˰� ���õ� ���� ���� ��ȸ
SELECT VALUE
FROM SYS.NLS_SESSION_PARAMETERS
WHERE PARAMETER LIKE 'NLS_DATE_FORMAT';

--�Ϻ� �������� �������� �׷��ٸ� ���� ������ �����Ѵٸ�.
--������ �̷��� �Լ��� ���˼����� �ٲٸ� �ȵȴ� 
--�Լ��� �̿��ؼ� �ٲ۴�.
ALTER SESSION
SET NLS_DATE_FORMAT = 'DD-MON-RR';

SELECT SYSDATE
FROM DUAL;

ALTER SESSION
SET NLS_DATE_FORMAT = 'RR/MM/DD';

SELECT ADD_MONTHS('10/01/01', 10)
FROM DUAL;

SELECT EMP_NAME, HIRE_DATE,
        ADD_MONTHS(HIRE_DATE, 240)
FROM EMPLOYEE;
-- ���ó�¥ 10��� ��¥��?
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 120)
FROM DUAL;

SELECT EMP_ID ���, EMP_NAME �̸�,
       HIRE_DATE �Ի���, ADD_MONTHS(HIRE_DATE, 240) "20�� �ڳ�¥"
FROM EMPLOYEE;

--20���̻� �ٹ��� ����� ��ȸ
SELECT EMP_ID ���, EMP_NAME �̸�,
        DEPT_ID �μ��ڵ�, JOB_ID �����ڵ�,
        HIRE_DATE
FROM EMPLOYEE
WHERE ADD_MONTHS(HIRE_DATE, 240) < SYSDATE;

SELECT EMP_NAME �̸�, HIRE_DATE �Ի���,
       FLOOR(SYSDATE - HIRE_DATE) �ٹ��ϼ�,
       FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) �ٹ�������,
       FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) �ٹ����
FROM EMPLOYEE;

SELECT SYSDATE,  NEXT_DAY(SYSDATE, '�Ͽ���')
FROM DUAL;

SELECT SYSDATE, NEXT_DAY(SYSDATE, 'SUNDAY')
FROM DUAL; -- ERROR

ALTER SESSION
SET NLS_LANGUAGE = KOREAN; --����� �ٲٰ� ������ AMERICAN

SELECT LAST_DAY(SYSDATE)
FROM DUAL;

--�Ի��� ���� �ٹ��ϼ� ��ȸ
SELECT EMP_NAME �̸�, HIRE_DATE �Ի���,
       LAST_DAY(HIRE_DATE) - HIRE_DATE �ٹ��ϼ�
FROM EMPLOYEE;

SELECT SYSDATE, SYSTIMESTAMP,
       CURRENT_DATE, CURRENT_TIMESTAMP
FROM DUAL;

SELECT SYSDATE,
       EXTRACT(YEAR FROM SYSDATE) �⵵,
       EXTRACT(MONTH FROM SYSDATE) ��,
       EXTRACT(DAY FROM SYSDATE) ��
FROM DUAL;

--������ �̸� �Ի��� �ٹ���� ��ȸ
SELECT EMP_NAME, HIRE_DATE,
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) �ٹ����
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE,
       FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12 ) �ٹ���� --�� �ٹ����
FROM EMPLOYEE;

-- �ڵ�����ȯ�� ���� ����ȯ�� �� �ʿ� ����
-- SELECT 25 + '12' FROM DUAL; (�ڵ� ����ȯ)
-- SELECT 25 + TO_NUMBER('12') FROM DUAL; (����� ����ȯ)
-- �⺻������ ��ǻ�� CPU�� ���� ������ Ÿ���� ������ ����Ѵ�.
-- �ڵ� ����ȯ�� �ȵǴ� ���
-- SYSDATE - '15/01/03' ->(ERROR) DATE - CHAR : �ڵ�����ȯ�� �ȵ� X
-- �׷� ��������� ����ȯ�� ������Ѵ�.
-- SYSDATE - TO_DATE('15/01/03') ����! ������ 00/00/00 ��������Ѵ�. 

SELECT EMP_ID, EMP_NAME,
        TO_CHAR(NVL(BONUS_PCT, 0), '90.00') ���ʽ�����Ʈ,
        TO_CHAR(SALARY, '99,999,999L') �޿� 
FROM EMPLOYEE;
--9�� �� �ڸ��� ������ ���� 0�� ���ָ� 0���� ä��
--09.999.999 => ��� 09,000,000 / 99.999.999 => ��� 9,000,000

--�����, �ú���, �б�, ����, ����/���ĵ��� ���
SELECT HIRE_DATE,
        TO_CHAR(HIRE_DATE, 'YEAR-RM-fmDD'),
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') -- Y�� R�� ǥ���� �� �ִ�.
FROM EMPLOYEE;

SELECT TO_CHAR(SYSDATE, 'Q"�б�"'),
        TO_CHAR(SYSDATE, 'YYYY-MON-fmDD"��" PM HH:MI:SS')
FROM DUAL;
--�⵵������ ����
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE, 'YEAR'),
       TO_CHAR(SYSDATE, ' YYYY"��" ')      
FROM DUAL;
--���� ���� ����
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'fmMM'),
       TO_CHAR(SYSDATE, 'RM')
FROM DUAL;
--��¥������ ����
SELECT SYSDATE,
       TO_CHAR(SYSDATE, '"1�����" DDD "�Ϥ�"'),
       TO_CHAR(SYSDATE, '"������" DD "��°"'),
       TO_CHAR(SYSDATE, '"�ֱ���" D "��°"')
FROM DUAL;
--���� ����
SELECT SYSDATE,
      TO_CHAR(SYSDATE, 'DAY'),
      TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

--�̸� �Ի��� ��ȸ / �Ի��� �������� : 2016�� 05�� 19��(��)
SELECT EMP_NAME || '���� �Ի�����' || ' ' || TO_CHAR(HIRE_DATE,'YYYY"��" MONTH DD"��""("DY")"')
FROM EMPLOYEE;
