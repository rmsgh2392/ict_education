-- DAY7_SELECT6

-- JOIN �������� --------------------------------------------------------------------------------------------------
-- ����Ŭ ���뱸���� ANSI ǥ�ر��� ���� �ۼ��� ��.

-- 1. 2020�� 12�� 25���� ���� �������� ��ȸ�Ͻÿ�.
SELECT TO_CHAR(TO_DATE('20201225', 'RRRRMMDD'), 'DAY')
FROM DUAL;


-- 2. �ֹι�ȣ�� 60��� ���̸鼭 ������ �����̰�, ���� �达�� �������� 
-- �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�.

-- ����Ŭ ���뱸��
SELECT EMP_NAME, EMP_NO, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.DEPT_ID = D.DEPT_ID(+)
AND EMP_NO LIKE '6%'
AND SUBSTR(EMP_NO, 8, 1) IN ('2', '4')
AND EMP_NAME LIKE '��%';

-- ANSI ǥ�ر���
SELECT EMP_NAME, EMP_NO, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE EMP_NO LIKE '6%'
AND SUBSTR(EMP_NO, 8, 1) IN ('2', '4')
AND EMP_NAME LIKE '��%';

-- 3. ���� ���̰� ���� ������ 
-- ���, �����, ����, �μ���, ���޸��� ��ȸ�Ͻÿ�.

--������ �ּҰ� ��ȸ
SELECT MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) ����
FROM EMPLOYEE;  -- 31

-- ��ȸ�� ������ �ּҰ��� �̿��� ������ ���� ��ȸ��
-- outer join �ʿ���.

-- ����Ŭ ���뱸��
SELECT EMP_ID ���, EMP_NAME �̸�, 
        MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) ����, 
        DEPT_NAME �μ���, JOB_TITLE ���޸�
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.DEPT_ID = D.DEPT_ID(+)
GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
HAVING MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12))  = 31;

-- ANSI ǥ�ر���
SELECT EMP_ID ���, EMP_NAME �̸�, 
        MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) ����, 
        DEPT_NAME �μ���, JOB_TITLE ���޸�
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
HAVING MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12))  = 31;

-- ���������� ����� ��� -----------------------------------------------------------------------------
SELECT EMP_ID ���, EMP_NAME �̸�, 
        MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) ����, 
        DEPT_NAME �μ���, JOB_TITLE ���޸�
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
HAVING MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 
        'RRMM')) / 12))  = (SELECT MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) ����
                            FROM EMPLOYEE);

-- �ζ��κ�� RANK() �Լ� ���
SELECT ���, �̸�, ����, �μ���, ���޸�
FROM (SELECT EMP_ID ���, EMP_NAME �̸�, 
                TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12) ����,
                DEPT_NAME �μ���, JOB_TITLE ���޸�,
                RANK() OVER (ORDER BY TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12) ASC) ����
        FROM EMPLOYEE
        LEFT JOIN JOB USING (JOB_ID)
        LEFT JOIN DEPARTMENT USING (DEPT_ID))
WHERE ���� = 1; --  TOP-1 �м�


-- 4. �̸��� '��'�ڰ� ���� �������� 
-- ���, �����, �μ����� ��ȸ�Ͻÿ�.

-- ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, DEPT_NAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID(+)
AND EMP_NAME LIKE '%��%';

-- ANSI ǥ�ر���
SELECT EMP_ID, EMP_NAME, DEPT_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE EMP_NAME LIKE '%��%';


-- 5. �ؿܿ������� �ٹ��ϴ� 
-- �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�.

-- ����Ŭ ���뱸��
SELECT EMP_NAME, JOB_TITLE, E.DEPT_ID, DEPT_NAME
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.DEPT_ID = D.DEPT_ID(+)
AND DEPT_NAME LIKE '�ؿܿ���%'
ORDER BY 4;

-- ANSI ǥ�ر���
SELECT EMP_NAME, JOB_TITLE, DEPT_ID, DEPT_NAME
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE DEPT_NAME LIKE '�ؿܿ���%'
ORDER BY 4;


-- 6. ���ʽ�����Ʈ�� �޴� �������� 
-- �����, ���ʽ�����Ʈ, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.

-- ����Ŭ ���뱸��
SELECT EMP_NAME, BONUS_PCT, DEPT_NAME, LOC_DESCRIBE
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_ID = D.DEPT_ID(+)
AND D.LOC_ID = L.LOCATION_ID(+)
AND (BONUS_PCT IS NOT NULL OR BONUS_PCT != 0.0);

-- ANSI ǥ�ر���
SELECT EMP_NAME, BONUS_PCT, DEPT_NAME, LOC_DESCRIBE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN LOCATION ON (LOC_ID = LOCATION_ID)
WHERE BONUS_PCT IS NOT NULL OR BONUS_PCT != 0.0;


-- 7. �μ��ڵ尡 20�� �������� 
-- �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.

-- ����Ŭ ���뱸��
SELECT EMP_NAME, JOB_TITLE, DEPT_NAME, LOC_DESCRIBE
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.DEPT_ID = D.DEPT_ID(+)
AND D.LOC_ID = L.LOCATION_ID(+)
AND E.DEPT_ID = '20';

-- ANSI ǥ�ر���
SELECT EMP_NAME, JOB_TITLE, DEPT_NAME, LOC_DESCRIBE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN LOCATION ON (LOC_ID = LOCATION_ID)
WHERE DEPT_ID = '20';


-- 8. ���޺� ������ �ּұ޿�(MIN_SAL)���� ���� �޴� ��������
-- �����, ���޸�, �޿�, ������ ��ȸ�Ͻÿ�.
-- ������ ���ʽ�����Ʈ�� �����Ͻÿ�.

-- ����Ŭ ���뱸��
SELECT EMP_NAME, JOB_TITLE, SALARY, 
        (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 ����
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID(+)
AND (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 > MIN_SAL;

-- ANSI ǥ�ر���
SELECT EMP_NAME, JOB_TITLE, SALARY, 
        (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 ����
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 > MIN_SAL;


-- 9 . �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �������� 
-- �����(emp_name), �μ���(dept_name), ������(loc_describe),
--  ������(country_name)�� ��ȸ�Ͻÿ�.

-- ����Ŭ ���뱸��
SELECT EMP_NAME, DEPT_NAME, LOC_DESCRIBE, COUNTRY_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, COUNTRY C
WHERE E.DEPT_ID = D.DEPT_ID
AND D.LOC_ID = L.LOCATION_ID
AND L.COUNTRY_ID = C.COUNTRY_ID
AND L.COUNTRY_ID IN ('KO', 'JP');

-- ANSI ǥ�ر���
SELECT EMP_NAME, DEPT_NAME, LOC_DESCRIBE, COUNTRY_NAME
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID)
JOIN COUNTRY USING (COUNTRY_ID)
WHERE COUNTRY_ID IN ('KO', 'JP');


-- 10. ���� �μ��� �ٹ��ϴ� �������� 
-- �����, �μ��ڵ�, �����̸�, �μ��ڵ带 ��ȸ�Ͻÿ�.
-- self join ���

-- ����Ŭ ���뱸��
SELECT E.EMP_NAME �̸�, E.DEPT_ID �ҼӺμ�,
        M.EMP_NAME �����̸�, M.DEPT_ID ����μ�
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.EMP_NAME != M.EMP_NAME
AND E.DEPT_ID = M.DEPT_ID
ORDER BY E.EMP_NAME;

-- ANSI ǥ�ر��� : ���̺� ��Ī ���ÿ��� ON �����
SELECT E.EMP_NAME �̸�, E.DEPT_ID �ҼӺμ�,
        M.EMP_NAME �����̸�, M.DEPT_ID ����μ�
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.EMP_NAME != M.EMP_NAME AND E.DEPT_ID = M.DEPT_ID)
ORDER BY E.EMP_NAME;


-- 11. ���ʽ�����Ʈ�� ���� ������ �߿��� 
-- �����ڵ尡 J4�� J7�� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�.

-- ����Ŭ ���뱸��
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.JOB_ID IN ('J4', 'J7') AND (BONUS_PCT IS NULL OR BONUS_PCT = 0.0);

-- ANSI ǥ�ر���
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE JOB_ID IN ('J4', 'J7') AND (BONUS_PCT IS NULL OR BONUS_PCT = 0.0);



-- 12. �ҼӺμ��� 50 �Ǵ� 90�� ������ 
-- ��ȥ�� ������ ��ȥ�� ������ ���� ��ȸ�Ͻÿ�.
SELECT DECODE(MARRIAGE, 'Y', '��ȥ', 'N', '��ȥ') ��ȥ����,
        COUNT(*) ������
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90')
GROUP BY DECODE(MARRIAGE, 'Y', '��ȥ', 'N', '��ȥ')
ORDER BY 1;

-- ***************************************************************************************************
-- ���� ������ (SET OPERATOR)
-- UNION, UNION ALL, INTERSECT, MINUS
-- �� SELECT ���� ���� ���(������� - RESULTSET)�� �ϳ��� ǥ���ϱ� ���� �����
-- ������ : UNION, UNION ALL - �� ���� RESULTSET ����� �ϳ��� ��ħ
--        UNION (��ĥ �� �ߺ����� �ϳ��� ������), UNION ALL(�ߺ����� ��� ������)
-- ������ : INTERSECT - �� ���� RESULTSET ������� ��ġ��(�ߺ� ��ġ�Ǵ�) ���� ������
-- ������ : MINUS - ù��° RESULTSET ������� �ι�° RESULTSET �� ��ġ�� ���� ������ ������ ���� ������

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE  -- 22��
UNION  -- 25�� (�ߺ����� 1���� ����)
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;  -- 4��

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE  -- 22��
UNION ALL  -- 26�� (�ߺ��൵ �� ����)
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;  -- 4��

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE  -- 22��
INTERSECT  -- 1�� : �ߺ��� 1���� ����
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;  -- 4��

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE  -- 22��
MINUS  -- 21�� (�ι�° ������ �ߺ��Ǵ� ���� ��)
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;  -- 4�� : �ߺ��� 1�� ����.

-- SET ������ ���� ���ǻ���
-- �� �������� SELECT ���� �÷� ������ �� �÷��� �ڷ����� �ݵ�� ���ƾ� ��
-- ������ ���� �÷�(DUMMY COLUMN - NULL ĭ)�� ����� �� ����

-- ���� ����ġ
SELECT EMP_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_ID = '20'
UNION
SELECT DEPT_NAME, DEPT_ID, NULL -- DUMMY COLUMN
FROM DEPARTMENT
WHERE DEPT_ID = '20';

-- �� �÷��� �ڷ��� ����ġ
SELECT EMP_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_ID = '20'
UNION
SELECT NULL, DEPT_NAME, DEPT_ID
FROM DEPARTMENT
WHERE DEPT_ID = '20';

-- Ȱ�� : ���� ��ȸ�� ����� �� ���̺�� �������� �� �� �ַ� �̿��� �� ����
-- 50�� �μ��� �Ҽӵ� ���� �� �����ڿ� �Ϲ� ������ ���� ��ȸ�ؼ� �ϳ��� ���Ķ�.
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = '50';

SELECT EMP_ID, EMP_NAME, '������' ����
FROM EMPLOYEE
WHERE EMP_ID = '141' AND DEPT_ID = '50'
UNION
SELECT EMP_ID, EMP_NAME, '����' ����
FROM EMPLOYEE
WHERE EMP_ID <> '141' AND DEPT_ID = '50'
ORDER BY 3, 1;

SELECT 'SQL�� �����ϰ� �ֽ��ϴ�.', 3 ���� FROM DUAL
UNION
SELECT '�츮�� ���� ', 1 FROM DUAL
UNION
SELECT '���� ����ְ� ', 2 FROM DUAL
ORDER BY 2;

-- SET �����ڿ� JOIN �� ����
SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
INTERSECT
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;

-- �� �������� SELECT ���� ���õ� �÷����� ������ ��쿡 ���α������� �ٲ� �� ����.
-- USING (EMP_ID, ROLE_NAME) ����� �� ����
-- (104 SE) = (104 SE) : ����
-- (104 SE-ANLY) != (104 SE) : �ٸ���

-- ���� �������� �ٲ۴ٸ�
SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
JOIN ROLE_HISTORY USING (EMP_ID, ROLE_NAME);

-- SET �����ڿ� IN �������� ����
-- UNION �� IN �� ���� ����� ���� ���� ����.
-- ���� �����ڿ� ���� �������� SELECT ���� �÷����� ����, �����ϴ� ���̺��� ����
-- WHERE �������� �񱳰��� �ٸ� ��쿡 IN ���� �ٲ� �� ����

-- ������ �븮 �Ǵ� ����� ������ �̸�, ���޸� ��ȸ
-- ���޼� ������������, ���� ������ �̸��� ������������ ó����
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE IN ('�븮', '���')
ORDER BY 2, 1;

-- UNION ��� �������� �ٲ۴ٸ�.
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '�븮'
UNION
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '���'
ORDER BY 2, 1;

-- ***************************************************************************
-- SUBQUERY (��������)
/*
    �Լ�(���ϰ��� �ִ� �Լ�())  => �ȿ� ���� �Լ��� ���� ������ �ǰ�, ������ ���� �ٱ� �Լ��� ����ϴ� ������
    SELECT ���������� �÷��� �񱳿����� �񱳰�  <--- �񱳰��� �˾Ƴ��� ���� SELECT���� �񱳰� �ڸ��� �ٷ� ����� �� ����
    �÷��� �񱳿����� (�񱳰� �˾Ƴ��� ���� SELECT ����) <--- ��������(��������)��� ��
    �ٱ� SELECT ���� ��������(�ܺ�����)��� ��
*/

-- ���¿��� ���� �μ��� �ٹ��ϴ� ���� ��ȸ
-- 1. ���¿��� �μ��ڵ� ��ȸ
SELECT DEPT_ID  -- 50
FROM EMPLOYEE
WHERE EMP_NAME = '���¿�';

-- 2. ��ȸ�� ���� ����ؼ� ���� ���� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_ID = '50';

-- �������� ��� ���� ����
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_ID = (SELECT DEPT_ID 
                  FROM EMPLOYEE
                  WHERE EMP_NAME = '���¿�');

-- ���������� ����
-- ������ ��������, ������ ��������, ���߿� ��������, ������ ���߿� ��������, 
-- ��ȣ���� ��������, ��Į�� ��������
-- �������� ������ ���� �������� �տ� ����ϴ� �����ڰ� �ٸ�. **

-- ������ (SINGLE ROW) ��������
-- �������� ���� ������� �� ���� ��� (�� 1��)
-- ������ �������� �տ��� �Ϲ� �񱳿����� ����� �� ����.
-- >, <, >=, <=, =, !=(<>, ^=)

-- �� : ���¿��� ������ �����鼭 ���¿����� �޿��� ���� �޴� ���� ��ȸ
-- 1. ���¿� ���� ��ȸ
SELECT JOB_ID  -- J5
FROM EMPLOYEE
WHERE EMP_NAME = '���¿�';

-- 2. ���¿� �޿� ��ȸ
SELECT SALARY  -- 2300000
FROM EMPLOYEE
WHERE EMP_NAME = '���¿�';

-- 3. �񱳰����� ���
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMPLOYEE
WHERE JOB_ID = 'J5'
AND SALARY > 2300000;

-- �������� �������� ����
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMPLOYEE
WHERE JOB_ID = (SELECT JOB_ID  -- J5
                FROM EMPLOYEE
                WHERE EMP_NAME = '���¿�')
AND SALARY > (SELECT SALARY  -- 2300000
                FROM EMPLOYEE
                WHERE EMP_NAME = '���¿�');

-- ���� �߿��� ���� �޿��� �޴� ���� ��� ��ȸ
-- 1. ���� �޿� 
SELECT MIN(SALARY)
FROM EMPLOYEE;

-- 2. ���� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY = 1500000;

-- WHERE ���� �׷��Լ� ��� �� �� ==> ���������� �ذ�
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
-- WHERE SALARY = MIN(SALARY);
WHERE SALARY = (SELECT MIN(SALARY)
                 FROM EMPLOYEE);

-- HAVING �������� �������� ����� �� ����.
-- �� : �μ��� �޿��հ� �� ���� ū���� ���� �μ���� �޿��հ� ��ȸ
SELECT DEPT_NAME, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY DEPT_ID, DEPT_NAME
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))  -- 18100000
                        FROM EMPLOYEE
                        GROUP BY DEPT_ID);

-- ���������� SELECT, FROM, WHERE, HAVING ���� �ַ� ����� �� ����.

-- ������ �������� (MULTIPLE ROW SUBQUERY)
-- ���������� ������� ������ ���� ���� ��� (���� ���� ��)
-- ������ �������� �տ��� �Ϲ� �񱳿����� ��� �� ��
-- ���� ���� ���� ���� �� �ִ� ������ ����ؾ� �� : IN, ANY, ALL

-- �� : �� �μ����� �޿��� ���� ���� ���� ���� ��ȸ
-- 1. �μ��� �޿� �ּҰ� ��ȸ
SELECT MIN(SALARY)  -- 7��
FROM EMPLOYEE
GROUP BY DEPT_ID;

-- 2. ���������� ����
SELECT EMP_ID, EMP_NAME, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)  -- 7��
                FROM EMPLOYEE
                GROUP BY DEPT_ID);  -- ���� : ������ �߸� ���
                
-- ���������� ���� ���� ���� ������ ��� �ѹ��� ���ؼ� �������� Ȯ���Ϸ���,
-- �÷��� IN (��, ��, ��, ....) ==> �÷��� IN (������ ��������)
-- �÷��� = �񱳰�1 OR �÷��� = �񱳰�2 OR �÷��� = �񱳰�3 OR ..........
-- �÷����� ���� ���� �� �߿��� ��ġ�ϴ� ���� �ִٸ� �÷����� ������
SELECT EMP_ID, EMP_NAME, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MIN(SALARY)  -- 7��
                FROM EMPLOYEE
                GROUP BY DEPT_ID);

-- �÷��� NOT IN (������ ��������)
-- NOT (�÷��� = �񱳰�1 OR �÷��� = �񱳰�2 OR �÷��� = �񱳰�3 OR ..........)
-- �÷����� ���� ���� �� �߿��� ��ġ�ϴ� ���� ���ٸ� (��ġ�ϴ� ���� �ƴ�)

-- �� : �������� ������ �����ڰ� �ƴ� ���� ���� ������ ��ȸ�ؼ� ���Ķ�.
-- ������ ��� ��ȸ
SELECT DISTINCT MGR_ID  -- 6��
FROM EMPLOYEE
WHERE MGR_ID IS NOT NULL;

-- ���� �������� �����ڸ� ��ȸ
SELECT EMP_ID, EMP_NAME, '������' ����
FROM EMPLOYEE
WHERE EMP_ID IN (SELECT DISTINCT MGR_ID  -- 6��
                    FROM EMPLOYEE
                    WHERE MGR_ID IS NOT NULL)
UNION
SELECT EMP_ID, EMP_NAME, '����' ����
FROM EMPLOYEE
WHERE EMP_ID NOT IN (SELECT DISTINCT MGR_ID  -- 6��
                    FROM EMPLOYEE
                    WHERE MGR_ID IS NOT NULL)
ORDER BY 3, 1;

-- SELECT �������� �������� ����� �� ����
-- �Լ� ���� �ȿ��� �ַ� ����
SELECT EMP_ID, EMP_NAME,
        CASE WHEN EMP_ID IN (SELECT MGR_ID FROM EMPLOYEE) THEN '������'
        ELSE '����'
        END ����
FROM EMPLOYEE
ORDER BY 3, 1;

-- �÷��� > ANY (������ ��������) : ���� ���� ������ ū
-- �÷��� < ANY (������ ��������) : ���� ū������ ����
-- �÷��� > (��1, ��2, ��3, ....) => �÷��� > ��1 OR �÷��� > ��2 OR �÷��� > ��3 OR .........
-- �÷��� <(��1, ��2, ��3, ....) => �÷��� < ��1 OR �÷��� < ��2 OR �÷��� < ��3 OR .........

-- �� : �븮 ������ ���� �߿��� ���� ������ �޿��� �ּҰ����� �޿��� ���� �޴� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '�븮'
AND SALARY > ANY (SELECT SALARY
                    FROM EMPLOYEE
                    JOIN JOB USING (JOB_ID)
                    WHERE JOB_TITLE = '����');

-- �÷��� > ALL (������ ��������) : ���� ū ������ ū
-- �÷��� < ALL (������ ��������) : ���� ���������� ����
-- �÷��� > (��1, ��2, ��3, ....) => �÷��� > ��1 AND �÷��� > ��2 AND �÷��� > ��3 AND .........
-- �÷��� <(��1, ��2, ��3, ....) => �÷��� < ��1 AND �÷��� < ��2 AND �÷��� < ��3 AND .........
-- �� : ��� ������� �޿����� �� ���� �޿��� �޴� �븮 ���� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '�븮'
AND SALARY > ALL (SELECT SALARY
                    FROM EMPLOYEE
                    JOIN JOB USING (JOB_ID)
                    WHERE JOB_TITLE = '����');
                    
-- ���������� ��� ��ġ : SELECT ��, FROM ��, WHERE ��, GROUP BY ��, HAVING ��, ORDER BY ��
-- INSERT ��, UPDATE ��, CREATE TABLE ��, CREATE VIEW ��
                    
-- �ڱ� ������ ��� �޿��� �޴� ���� ��ȸ
-- 1. ���޺� �޿���� ��ȸ
SELECT JOB_ID, TRUNC(AVG(SALARY), -5)
FROM EMPLOYEE
GROUP BY JOB_ID;
                    
-- 2. ���������� ����
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE SALARY IN (SELECT TRUNC(AVG(SALARY), -5)
                    FROM EMPLOYEE
                    GROUP BY JOB_ID);

-- ������ ���߿� ��������
-- �������� SELECT ���� �׸��� ���� ���� ��� : ���� �� (MULTIPLE COLUMN)
-- (���÷���, ���÷���) �񱳿����� (���߿� ��������)
-- �������� SELECT ���� �׸�(�÷�) ������ �ڷ����� ���߾ ���ؾ� ��
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE (JOB_ID, SALARY) IN (SELECT JOB_ID, TRUNC(AVG(SALARY), -5)
                            FROM EMPLOYEE
                            GROUP BY JOB_ID);

-- FROM ������ �������� ����� �� ���� : ���̺� ��ſ� �����
-- FROM (��������) ��Ī  <--- ��Ī(ALIAS)�� ���̺���� �����
-- FROM ������ ���� ���������� ���� ��������� �ζ��κ�(INLINE VIEW)��� ��
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM (SELECT JOB_ID, TRUNC(AVG(SALARY), -5) JOBAVG
        FROM EMPLOYEE
        GROUP BY JOB_ID) V  -- �ζ��� ��
JOIN EMPLOYEE E ON (V.JOBAVG = E.SALARY AND NVL(V.JOB_ID, ' ') = NVL(E.JOB_ID, ' '))
LEFT JOIN JOB J ON  (E.JOB_ID = J.JOB_ID)
ORDER BY 3, 2;

-- ���������� ����
-- ������ ��������, ������ ��������, ������ ���߿� ��������, ��[ȣ��]�� ��������, ��Į�� ��������
-- ��κ��� ���������� ���������� ����� �� ������� ���������� ����ϴ� �����.
-- ��������� ���������� ���������� ���� �����ٰ� ����� ����� ������.
-- �׷��Ƿ� ���������� ���� �ٲ�� ���������� ����� �޶����� ��. => ��ȣ���� ����������� ��

-- �ڱ� ������ ��� �޿��� �޴� ���� ��ȸ :��ȣ���� ���������� ����� ���
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_ID = J.JOB_ID)
WHERE SALARY = (SELECT TRUNC(AVG(SALARY), -5)
                 FROM EMPLOYEE
                 WHERE JOB_ID = E.JOB_ID)
ORDER BY 3 DESC NULLS LAST;

-- EXISTS / NOT EXISTS ������
-- ��ȣ���� �������� �� �տ����� �����
-- ���������� ���� ����� �����ϴ��� ��� ���� EXISTS ���
-- ���������� SELECT ���� �÷� ����ϸ� �� ��. NULL ����� ��.

-- �� : �������� ������ ��ȸ
SELECT EMP_ID, EMP_NAME, '������' ����
FROM EMPLOYEE E
WHERE EXISTS (SELECT NULL
                FROM EMPLOYEE
                WHERE E.EMP_ID = MGR_ID);
                
-- �����ڰ� �ƴ� ������ ��ȸ
SELECT EMP_ID, EMP_NAME, '����' ����
FROM EMPLOYEE E
WHERE NOT EXISTS (SELECT NULL
                FROM EMPLOYEE
                WHERE E.EMP_ID = MGR_ID);

-- ��Į�� ��������
-- ������ �������� + ��ȣ������������
-- �� : �̸�, �μ��ڵ�, �޿�, �ش� ������ �Ҽӵ� �μ��� �޿���� ��ȸ
SELECT EMP_NAME, DEPT_ID, SALARY, 
        (SELECT TRUNC(AVG(SALARY), -5)
        FROM EMPLOYEE
        WHERE DEPT_ID = E.DEPT_ID) AVGSAL
FROM EMPLOYEE E;

-- CASE ǥ������ ����� ��Į�� ��������
-- �μ��� �ٹ������� 'OT' �̸� '������', �ƴϸ� '������' ���� ǥ�� ��ȸ
SELECT EMP_ID, EMP_NAME,
        CASE WHEN DEPT_ID = (SELECT DEPT_ID
                                FROM DEPARTMENT
                                WHERE LOC_ID = 'OT')
        THEN '������'
        ELSE '������'
        END �Ҽ�
FROM EMPLOYEE
ORDER BY �Ҽ� DESC;

-- ORDER BY ���� ��Į�� �������� ��� ��
-- ������ �Ҽӵ� �μ��� �μ����� ū ������ �����ؼ� ���� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_ID, HIRE_DATE
FROM EMPLOYEE E
ORDER BY (SELECT DEPT_NAME
            FROM DEPARTMENT
            WHERE DEPT_ID = E.DEPT_ID) DESC;

-- TOP-N �м� --------------------------------------------------------
-- ���� �� ��, ���� �� ���� ��ȸ�ϴ� ��
-- �ζ��� ��� RANK() �Լ��� �̿��ϴ� ����� 
-- ROWNUM �� �̿��� TOP-N �м��� ����

-- 1. �ζ��� ��� RANK() �Լ��� �̿��� TOP-N �м�
-- ���� �������� �޿��� ���� ���� �޴� ���� 5�� ��ȸ
-- �̸�, �޿�, ����
SELECT *
FROM (SELECT EMP_NAME, SALARY, RANK() OVER (ORDER BY SALARY DESC) ����
       FROM EMPLOYEE)
WHERE ���� <= 5;       

-- 2. ROWNUM �� �̿��� TOP-N �м�
-- ORDER BY �� ����� ROWNUM �� ���� ==> ���������� �̿��ؾ� ��
-- ROWNUM : ���ȣ�� �ǹ���, WHERE ó�� �Ŀ� �ڵ����� �ο���

-- Ȯ��
SELECT ROWNUM, EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE -- �� �� �տ� ROWNUM ǥ�õ�
ORDER BY SALARY DESC;

-- �޿� ���� �޴� ���� 3�� ��ȸ
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM < 4  -- WHERE �� ������ ROWNUM �ο���
ORDER BY SALARY DESC; -- Ʋ�� ��� ����

-- �ذ� : �����ϰ� ���� ROWNUM �� �ο��ǰԲ� �ϸ� ��
-- �ζ��� �� ���
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT *
       FROM EMPLOYEE
       ORDER BY SALARY DESC)  -- ���� �Ŀ� ROWNUM �� �ο���
WHERE ROWNUM < 4;       









