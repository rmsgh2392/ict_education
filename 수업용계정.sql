--��� �̸��߿� ��,�߰�,������ ��� ���̵� '��'��� ���ڰ� ���� ����̸��� ��ȸ
--%ã����� ����%
--���ϵ�ī�� % ��� % : 0���̻��� ����
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

--�ֹι�ȣ�� ���� ��� ��ȸ 
--����Ʈī�� '_'���  _ : �Ѱ��� ���� ���
SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE
WHERE EMP_NO LIKE '_______2%';
--�ֹι�ȣ�� ���� ��� ��ȸ
SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE
WHERE EMP_NO LIKE '_______1%';
--�Ǵ� ���� ���ڸ� Ȱ���� WHERE EMP_NO NOT LIKE '_______2%'�ε� ��ȸ �� �� �ִ�.

SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___\_%' ESCAPE '\';
--ESCAPE OPTION �� ����Ͽ� ��ϵ� ���� �����Ͽ� ����ڰ� ���ϴ� ���� ��ȸ
--���� �ɼ��� ������� �ʴ´ٸ� �Ʒ��� ���� ��ȸ �Ͽ��� ��
--�̸��� �÷��� ����� '_'���� ���ϵ�ī�� '_' �� ������ �ȵǾ� ����ڰ� ���ϴ� ���� ��ȸ���� ���Ѵ�.
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';

--1. �μ��ڵ� 90 �����ڵ� J2 ��ȸ
SELECT EMP_ID ���, EMP_NAME �̸�, 
        DEPT_ID �μ��ڵ�, JOB_ID �����ڵ�, 
        SALARY �޿�
FROM EMPLOYEE
WHERE DEPT_ID LIKE '90' 
AND JOB_ID LIKE 'J2';
--2. �Ի��� 1982/01/01�����̰ų� �����ڵ� J3�� ��� ��ȸ
SELECT EMP_ID ���, EMP_NAME �̸�,
        MGR_ID "������ ���", BONUS_PCT ���ʽ�����Ʈ
FROM EMPLOYEE
WHERE HIRE_DATE > '82/01/01'
AND JOB_ID LIKE 'J3';
--3. �����ڵ� J4�� �ƴ� �������� �޿� , ���ʽ�����Ʈ�� ����� ���� ��ȸ
--���ʽ�����Ʈ�� NULL�̸� 0���� �ٲپ� ���
SELECT EMP_ID ���, EMP_NAME �����, JOB_ID �����ڵ�,
        SALARY �޿�, (SALARY + (SALARY * NVL(BONUS_PCT,0)))*12 || '(��)'
FROM EMPLOYEE
WHERE JOB_ID NOT LIKE 'J4';

--4. 0.1�̻� 0.2 ����
SELECT EMP_ID ���, EMP_NAME �����, EMAIL �̸���, SALARY �޿�, BONUS_PCT ���ʽ�����Ʈ
FROM EMPLOYEE
WHERE BONUS_PCT BETWEEN 0.1 AND 0.2 ;

--5. ���ʽ�����Ʈ 0.1���� �۰ų� 0.2 ���� ���� 
SELECT EMP_ID ���, EMP_NAME �����, BONUS_PCT ���ʽ�����Ʈ,
    SALARY �޿�, HIRE_DATE �Ի���
FROM EMPLOYEE
WHERE BONUS_PCT < 0.1 
AND BONUS_PCT > 0.2;

--6. 1982-01-01 ���� �Ի�
SELECT EMP_NAME �����, BONUS_PCT ���ʽ�����Ʈ, SALARY �޿�
FROM EMPLOYEE
WHERE HIRE_DATE >= '82/01/01';

--7. ���ʽ� ����Ʈ�� 0.1, 0.2 �� ��ȸ
SELECT EMP_ID ���, EMP_NAME �����, BONUS_PCT ���ʽ�����Ʈ, PHONE ��ȭ��ȣ
FROM EMPLOYEE
WHERE BONUS_PCT IN (0.1, 0.2);

--8.���ʽ� ����Ʈ�� 0.1, 0.2�� �ƴ� ��ȸ
SELECT EMP_ID ���, EMP_NAME �����, BONUS_PCT ���ʽ�����Ʈ, EMP_NO �ֹι�ȣ
FROM EMPLOYEE
WHERE BONUS_PCT NOT LIKE 0.1
AND BONUS_PCT NOT LIKE 0.2;

--9. ���� �̾� 
SELECT EMP_ID ���, EMP_NAME �����, HIRE_DATE �Ի���
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

--10. �ֹι�ȣ 8��° ���� 2
SELECT EMP_ID ���, EMP_NAME �����, EMP_NO �ֹι�ȣ, SALARY �޿�
FROM EMPLOYEE
WHERE EMP_NO LIKE '_______2%'
ORDER BY SALARY DESC;

--��ü ����� ���ϰ� ���ϴ� ���
SELECT ROUND(AVG(SALARY),2)
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > 2961818.18;

--���������� ����� ��ü ���� ��պ��� ���� �޴� ���
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);

--������ �Լ� �׷��Լ��� select���� �Բ� ��� ����
SELECT UPPER(EMAIL) 
FROM EMPLOYEE;

--������ �Լ� LENGTH() ���� ������ ��ȯ
SELECT LENGTH('ORACLE'), LENGTH('����Ŭ')
FROM DUAL;

SELECT EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;

SELECT INSTR('ORCLEDATABASE', 'T')
FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '@')
FROM EMPLOYEE;

SELECT EMAIL, INSTR(EMAIL, 'k', -1, 3)
FROM EMPLOYEE;

--�Լ� ��ø���� �Լ��ȿ� �Լ� ���
--�̸��� '.' ���� �ٷ� �ڿ� �ִ� 'c' ������ ��ġ�� ��ȸ
--�� '.' ���� �ٷ� �ձ��� ���� �˻� 
SELECT EMAIL, INSTR(EMAIL, 'c', INSTR(EMAIL, '.') -1)
FROM EMPLOYEE;

--LPAD, RPAD
--LPAD('���ڿ����ͷ�'|�÷���, ����� �ʺ���� ��, ���������� ä�� ����)
--����° ������ ä�﹮�ڰ� ���� �Ǹ� �⺻ ���� ���鹮�� ' ' �� ä������
--LPAD : ���ʿ� ä���, RPAD : �����ʿ� ä���
SELECT EMAIL �⺻,
        LENGTH(EMAIL) �������ڼ�,
        LPAD(EMAIL, 20, '#') ä�����,
        LENGTH(LPAD(EMAIL, 20, '#'))
FROM EMPLOYEE;

SELECT EMAIL �⺻,
        LENGTH(EMAIL) �������ڼ�,
        RPAD(EMAIL, 20, '#') ä�����,
        LENGTH(RPAD(EMAIL, 20, '#'))
FROM EMPLOYEE;



