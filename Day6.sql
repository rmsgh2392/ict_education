SELECT EMP_ID, ROLE_NAME, START_DATE
FROM EMPLOYEE RIGHT JOIN ROLE_HISTORY
USING(EMP_ID);
--�޿� ��������, �̸� ��������
SELECT EMP_NAME �̸�, SALARY �޿�
FROM EMPLOYEE
WHERE DEPT_ID LIKE '50'
OR DEPT_ID IS NULL
ORDER BY 2 DESC, 1;
--2004�� 1�� 1�� ���� �Ի��� ���� ��ȸ
SELECT EMP_NAME �̸�, HIRE_DATE �Ի���, 
        DEPT_ID �μ��ڵ�, SALARY �޿�
FROM  EMPLOYEE
WHERE HIRE_DATE > TO_DATE('20040101', 'RRRRMMDD')
ORDER BY �μ��ڵ� DESC NULLS LAST, 2, �̸�;

--�μ��� �޿� �հ� ��ȸ
SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID
ORDER BY 1 NULLS LAST;

SELECT JOB_ID, SUM(SALARY) �޿��հ�,
        ROUND(AVG(SALARY), -4) �޿����,
        COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_ID
ORDER BY JOB_ID NULLS LAST;

SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '��') ����,
        SUM(SALARY) "������ �޿��հ�",
        ROUND(AVG(SALARY), -4) "������ �޿����",
        COUNT(*) ������
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '��');


SELECT DEPT_ID, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_ID
ORDER BY 1;

SELECT DEPT_ID, COUNT(DECODE(MARRIAGE, 'Y', 1))
FROM EMPLOYEE
GROUP BY DEPT_ID, DECODE(MARRIAGE, 'Y', 1)
ORDER BY 1;

-- �μ��� �޿��հ��� ���� ū���� ���� �μ��ڵ�� �޿��հ� ��ȸ
SELECT DEPT_ID �μ���,
        SUM(SALARY) �μ����޿��հ�
FROM EMPLOYEE
GROUP BY DEPT_ID
--HAVING SUM(SALARY) LIKE 18100000;
--�������� ��� ��
--���������� ���� ����ǰ� ���� ���� ���� ������ ǥ���� ��
HAVING SUM(SALARY) LIKE (SELECT MAX(SUM(SALARY)) FROM EMPLOYEE GROUP BY DEPT_ID); 
--�񱳰� �ڸ����� �Լ��� ����� ���ϰ� ���� ��������� ������Ѵ�.
--SUM(SALARY) = MAX(SUM(SALARY)) --ERROR: �������� ���

--�μ��� �޿��հ� 9�鸸 �ʰ� �ϴ� �μ��� �޿��հ� ��ȸ
SELECT DEPT_ID, SUM(SALARY), JOB_ID
FROM EMPLOYEE
GROUP BY DEPT_ID, JOB_ID
HAVING SUM(SALARY) > 9000000;

--�޿��� ���� �޴� ������ ������ �ű�ٸ�??
SELECT EMP_NAME, SALARY,
        RANK() OVER (ORDER BY SALARY DESC) ����
FROM EMPLOYEE
ORDER BY ����;

--�޿� 350������ �������� ���� ���� �� ��ü �޿��� �� ����??
SELECT RANK(3500000) WITHIN GROUP(ORDER BY SALARY DESC) ����
FROM EMPLOYEE;

--ROLLUP �Լ�
SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID;

SELECT DEPT_ID, SUM(SALARY), MAX(SALARY)�μ�������ū�޿�, MIN(SALARY)�μ������������޿�,
        ROUND(AVG(SALARY), -4)�μ�����ձ޿�
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID);

--�μ��ڵ�� �����ڵ带 �԰� �׷��� ���� �޿��� �հ踦 ����
--ROLLUP���, NULLĭ ����
SELECT DEPT_ID, JOB_ID, SUM(SALARY)�޿��հ�
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL 
AND JOB_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID, JOB_ID);
--�� ���谡 �߰��̳� ���� ���� ���� ��� ROLLUP�Լ� ���
SELECT DEPT_ID, JOB_ID, SUM(SALARY)�޿��հ�
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL
AND JOB_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID), ROLLUP(JOB_ID);
-----------------------------------------
SELECT DEPT_ID, JOB_ID, SUM(SALARY)�޿��հ�
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL
AND JOB_ID IS NOT NULL
GROUP BY ROLLUP(JOB_ID), ROLLUP(DEPT_ID);

SELECT DEPT_ID, JOB_ID, SUM(SALARY)�޿��հ�
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL 
AND JOB_ID IS NOT NULL
GROUP BY CUBE(DEPT_ID, JOB_ID); --�� ���谡 ���� ���� �ö󰡴� ��찡 CUBE�Լ�

SELECT EMP_ID, ROWID
FROM EMPLOYEE;

--================================
SELECT EMP_NAME, DEPT_NAME, DEPT_ID
FROM EMPLOYEE RIGHT JOIN DEPARTMENT
USING(DEPT_ID);

--����Ŭ ���뱸�� : ����Ŭ������ ���-------------------------
SELECT *
FROM EMPLOYEE, DEPARTMENT
WHERE EMPLOYEE.DEPT_ID LIKE DEPARTMENT.DEPT_ID;

SELECT E.EMP_NAME, D.DEPT_NAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID LIKE D.DEPT_ID;
--EMPLOYEE�� DEPT_ID�� NULL���� DEPARTMENT DEPT_ID�� ��ġ�ϴ� ���� ����
--���ο��� ����

--ANSIǥ�� ����------------------------------------------------
SELECT *
FROM EMPLOYEE JOIN DEPARTMENT
USING(DEPT_ID);

SELECT EMP_NAME, DEPT_ID, DEPT_NAME
FROM EMPLOYEE JOIN DEPARTMENT
USING(DEPT_ID);

SELECT EMP_NAME, DEPT_ID, DEPT_NAME
FROM EMPLOYEE LEFT JOIN DEPARTMENT
USING(DEPT_ID)

SELECT D.DEPT_ID, D.DEPT_NAME, D.LOC_ID, R.LOC_DESCRIBE
FROM DEPARTMENT D, LOCATION R
WHERE D.LOC_ID LIKE R.LOCATION_ID;

SELECT D.DEPT_ID, D.DEPT_NAME, D.LOC_ID, L.LOC_DESCRIBE
FROM DEPARTMENT D JOIN LOCATION L
ON D.LOC_ID LIKE L.LOCATION_ID;

SELECT E.EMP_NAME, D.DEPT_NAME, L.LOCATION_ID, L.LOC_DESCRIBE
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_ID LIKE D.DEPT_ID AND D.LOC_ID LIKE L.LOCATION_ID;

SELECT EMP_NAME, LOC_ID
FROM EMPLOYEE2 JOIN DEPARTMENT
USING(DEPT_ID, LOC_ID);


--���, �̸�, ���޸� ��ȸ
SELECT EMP_ID ���, EMP_NAME �̸�, JOB_TITLE ���޸�
FROM EMPLOYEE JOIN JOB 
USING(JOB_ID); --ANSIǥ�� USING()

SELECT E.EMP_ID, E.EMP_NAME, J.JOB_TITLE
FROM EMPLOYEE E JOIN JOB J
ON E.JOB_ID LIKE J.JOB_ID; --ANSIǥ�� ON 

SELECT E.EMP_ID, E.EMP_NAME, E.JOB_TITLE
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID LIKE J.JOB_ID; --ORACLEǥ��

--OUTER JOIN ����Ŭ ���뱸��
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID LIKE D.DEPT_ID(+);

--OUTER JOIN ANSI ǥ�ر���
SELECT * 
FROM EMPLOYEE LEFT JOIN DEPARTMENT
USING(DEPT_ID);

SELECT *
FROM EMPLOYEE RIGHT JOIN DEPARTMENT
USING(DEPT_ID);

-- �� ���̺��� ��ġ���� �ʴ� ���� ��� ���ο� ���Խ�Ű���� �� ���
-- ANSIǥ��
SELECT * 
FROM EMPLOYEE FULL /*OUTER*/ JOIN DEPARTMENT
USING(DEPT_ID);

--CROSS JOIN 
-- ANSI ǥ�ر���
SELECT *
FROM LOCATION CROSS JOIN COUNTRY;

--ORACLE ���� ����
SELECT * 
FROM LOCATION, COUNTRY;

--NON EQUAL JOIN
--�������� �޿��� ���� �޿� ����� �ű���� �� ���
SELECT *
FROM EMPLOYEE JOIN SAL_GRADE 
ON (SALARY BETWEEN LOWEST AND HIGHEST);

--SELF JOIN
--���� ���̺��� �ι� �����ϴ� ���
--���� ���̺� ���� �ٸ� �÷��� �ܷ�Ű�� �����ϰ� �ִ� ��쿡 ��밡��
--ANSIǥ��
SELECT E.EMP_NAME ����,
        M.EMP_NAME ������
FROM EMPLOYEE E JOIN EMPLOYEE M
ON(E.MGR_ID LIKE M.EMP_ID);

--ORACLE ����
SELECT * 
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MGR_ID LIKE M.EMP_ID;

--���� N���� JOIN 
--JOIN�ϴ� ������ �߿��ϴ� !!
SELECT EMP_NAME, DEPT_NAME, JOB_TITLE, LOC_DESCRIBE
FROM EMPLOYEE JOIN JOB 
USING(JOB_ID)
JOIN DEPARTMENT USING(DEPT_ID)
JOIN LOCATION ON (LOC_ID LIKE LOCATION_ID);


--=======================================================================
-- JOIN ��������

-- 1. 2020�� 12�� 25���� ���� �������� ��ȸ�Ͻÿ�.
    SELECT TO_CHAR(TO_DATE('20201225', 'YYYYMMDD'), 'DAY')
    FROM DUAL;


-- 2. �ֹι�ȣ�� 60��� ���̸鼭 ������ �����̰�, 
-- ���� �达�� �������� 
-- �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�.
   SELECT TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'), 'YY') || '���' ����,
           DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '3', '��', '��') ����,
           EMP_NAME �����, EMP_NO �ֹι�ȣ, 
           DEPT_NAME �μ���, JOB_TITLE ���޸�
   FROM EMPLOYEE JOIN 
   DEPARTMENT USING(DEPT_ID) 
   JOIN JOB USING(JOB_ID)
   GROUP BY TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'), 'YY'), 
              DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '3', '��', '��'),
            EMP_NAME, EMP_NO, DEPT_NAME, JOB_TITLE
   HAVING TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'), 'YY') LIKE '6%'
   AND DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '3', '��', '��') LIKE '��'
   AND EMP_NAME LIKE '��%'; --ANSI
   
   SELECT TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'), 'YY') || '���' ����,
           DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '3', '��', '��') ����,
           EMP_NAME �����, EMP_NO �ֹι�ȣ, 
           DEPT_NAME �μ���, JOB_TITLE ���޸�
   FROM EMPLOYEE E, DEPARTMENT D, JOB J
   WHERE E.DEPT_ID LIKE D.DEPT_ID
   AND E.JOB_ID LIKE J.JOB_ID
   GROUP BY TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'), 'YY'),
           DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '3', '��', '��'),
           EMP_NAME, EMP_NO, DEPT_NAME , JOB_TITLE 
   HAVING TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'), 'YY') LIKE '6%'
   AND DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '3', '��', '��') LIKE '��'
   AND EMP_NAME LIKE '��%'; --ORACLE
   
   
   
   
    SELECT  TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'), 'YY') ���,
           DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '3', '��', '��') ����,
           EMP_NAME �����, EMP_NO �ֹι�ȣ,
           DEPT_NAME �μ���, JOB_TITLE ���޸�
   FROM EMPLOYEE LEFT JOIN DEPARTMENT USING(DEPT_ID)
   LEFT JOIN JOB USING(JOB_ID)
   WHERE TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'), 'YY') LIKE '6%'
   --WHERE SUBSTR(EMP_NO, 1, 2) LIKE '6%'
   AND DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '3', '��', '��') LIKE '��'
   -- SUBSTR(EMP_NO, 8, 1) IN ('2', '4')
   AND EMP_NAME LIKE '��%'; --ANSI
   
   SELECT TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'), 'YY') ���,
           DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '3', '��', '��') ����,
           EMP_NAME �����, EMP_NO �ֹι�ȣ,
           DEPT_NAME �μ���, JOB_TITLE ���޸�
   FROM EMPLOYEE E, DEPARTMENT D, JOB J
   WHERE E.DEPT_ID LIKE D.DEPT_ID(+)
   AND E.JOB_ID LIKE J.JOB_ID(+)
   AND TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'), 'YY') LIKE '6%'
   AND DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '3', '��', '��') LIKE '��'
   AND EMP_NAME LIKE '��%'; -- ORACLE
   


-- 3. ���� ���̰� ���� ������ 
-- ���, �����, ����, �μ���, ���޸��� ��ȸ�Ͻÿ�.
   SELECT EMP_ID ���, EMP_NAME �����, 
           MIN(TO_NUMBER(EXTRACT(YEAR FROM SYSDATE) - 
                         EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')))) ����,
           DEPT_NAME �μ���, JOB_TITLE ���޸�
   FROM EMPLOYEE LEFT JOIN DEPARTMENT USING(DEPT_ID)
   LEFT JOIN JOB USING(JOB_ID)
   GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
   HAVING MIN(TO_NUMBER(EXTRACT(YEAR FROM SYSDATE) - 
                     EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')))) 
                     LIKE (SELECT MIN(TO_NUMBER(EXTRACT(YEAR FROM SYSDATE) - 
                                                EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')))) 
                                                FROM EMPLOYEE);
                                              
    SELECT EMP_ID, EMP_NAME, 
            MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) /12 )) ����,
            DEPT_NAME, JOB_TITLE
    FROM EMPLOYEE LEFT JOIN JOB USING(JOB_ID)
    LEFT JOIN DEPARTMENT USING(DEPT_ID)
    GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
    HAVING  MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) /12 )) LIKE 31;
    
    SELECT EMP_ID, EMP_NAME, 
            MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) /12 )) ����,
            DEPT_NAME, JOB_TITLE
    FROM EMPLOYEE E, JOB J, DEPARTMENT D
    WHERE E.JOB_ID LIKE J.JOB_ID(+)
    AND E.DEPT_ID LIKE D.DEPT_ID(+)
    GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
    HAVING  MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) /12 )) LIKE 31;
   
-- ������ �ּҰ� ��ȸ
   SELECT MIN(TO_NUMBER(EXTRACT(YEAR FROM SYSDATE) 
             - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM'))))
   FROM EMPLOYEE;   
   
   SELECT MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) /12 ))
   FROM EMPLOYEE;

-- ��ȸ�� ������ �ּҰ��� �̿��� ������ ���� ��ȸ��
-- outer join �ʿ���.



-- 4. �̸��� '��'�ڰ� ���� �������� 
-- ���, �����, �μ����� ��ȸ�Ͻÿ�.
    SELECT EMP_ID ���, EMP_NAME �����,
            DEPT_NAME �μ���
    FROM EMPLOYEE LEFT JOIN DEPARTMENT
    USING(DEPT_ID)
    WHERE EMP_NAME LIKE '%��%'; --ANSI
    
    SELECT EMP_ID ���, EMP_NAME �����,
            DEPT_NAME �μ���
    FROM EMPLOYEE E, DEPARTMENT D
    WHERE E.DEPT_ID LIKE D.DEPT_ID(+)
    AND EMP_NAME LIKE '%��%'; --ORACLE


-- 5. �ؿܿ������� �ٹ��ϴ� 
-- �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�.
--�μ��� �ִµ� ������ �̽� ������ ������ �ְ� 
--������ �ִµ� �μ��� ���� ���� �����ϱ� ��ü ������ ������ ��ȸ�ؾ��ϴϱ� OUTER JOIN ���
    SELECT EMP_NAME �����, JOB_TITLE ���޸�, 
            DEPT_ID �μ��ڵ�, DEPT_NAME �μ���
    FROM EMPLOYEE LEFT JOIN DEPARTMENT
    USING(DEPT_ID)
    LEFT JOIN JOB USING(JOB_ID)
    WHERE DEPT_NAME LIKE '�ؿ�%'
    ORDER BY 4; --ANSI
    
    SELECT E.EMP_NAME �����, J.JOB_TITLE ���޸�, 
            D.DEPT_ID �μ��ڵ�, D.DEPT_NAME �μ���
    FROM EMPLOYEE E, DEPARTMENT D, JOB J
    WHERE E.DEPT_ID LIKE D.DEPT_ID(+) 
    AND E.JOB_ID LIKE J.JOB_ID(+)
    AND DEPT_NAME LIKE '�ؿ�%'
    ORDER BY 4; --ORACLE


-- 6. ���ʽ�����Ʈ�� �޴� �������� 
-- �����, ���ʽ�����Ʈ, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
    SELECT EMP_NAME �����, BONUS_PCT ���ʽ�����Ʈ,
            DEPT_NAME �μ���, LOC_DESCRIBE �ٹ�����
    FROM EMPLOYEE LEFT JOIN DEPARTMENT 
                USING(DEPT_ID)
    LEFT JOIN LOCATION ON 
                (LOC_ID LIKE LOCATION_ID)
    WHERE BONUS_PCT IS NOT NULL 
    OR BONUS_PCT NOT LIKE 0.0
    ORDER BY 2; --ANSI
    
    SELECT E.EMP_NAME �����, E.BONUS_PCT ���ʽ�����Ʈ,
            D.DEPT_NAME �μ���, L.LOC_DESCRIBE �ٹ�����
    FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
    WHERE E.DEPT_ID LIKE D.DEPT_ID(+)
    AND D.LOC_ID LIKE L.LOCATION_ID(+)
    AND (E.BONUS_PCT IS NOT NULL OR BONUS_PCT NOT LIKE 0.0)
    --�������߿� OR���� AND�����ڰ� �켱������ ����.
    ORDER BY 2; --ORACLE

-- 7. �μ��ڵ尡 20�� �������� 
-- �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
    SELECT EMP_NAME, JOB_TITLE, DEPT_ID, DEPT_NAME, LOC_DESCRIBE
    FROM EMPLOYEE LEFT JOIN JOB USING(JOB_ID)
    LEFT JOIN DEPARTMENT USING(DEPT_ID)
    LEFT JOIN LOCATION ON (LOC_ID LIKE LOCATION_ID)
    WHERE DEPT_ID LIKE '20';--ANSI
    
    SELECT E.EMP_NAME �����, J.JOB_TITLE ���޸�, 
            D.DEPT_NAME �μ���, L.LOC_DESCRIBE �ٹ�������
    FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
    WHERE E.JOB_ID LIKE J.JOB_ID(+)
    AND E.DEPT_ID LIKE D.DEPT_ID(+)
    AND D.LOC_ID LIKE L.LOCATION_ID(+)
    AND D.DEPT_ID LIKE '20'; --ORACLE


-- 8. ���޺� ������ �ּұ޿�(MIN_SAL)���� ���� �޴� ��������
-- �����, ���޸�, �޿�, ������ ��ȸ�Ͻÿ�.
-- ������ ���ʽ�����Ʈ�� �����Ͻÿ�.
    SELECT EMP_NAME �����, JOB_TITLE ���޸�, 
            SALARY �޿�, (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 ����
    FROM EMPLOYEE LEFT JOIN 
          JOB USING(JOB_ID)
    WHERE (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12  > MIN_SAL; --ANSI
    
    SELECT EMP_NAME, JOB_TITLE, SALARY, (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 ����
    FROM EMPLOYEE E, JOB J
    WHERE E.JOB_ID LIKE J.JOB_ID
    AND (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12  > J.MIN_SAL;

--===============================================
   

-- 9 . �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �������� 
-- �����(emp_name), �μ���(dept_name), ������(loc_describe),
--  ������(country_name)�� ��ȸ�Ͻÿ�.
    SELECT EMP_NAME �����, DEPT_NAME �μ���,
            LOC_DESCRIBE ������, COUNTRY_NAME ������
    FROM EMPLOYEE JOIN DEPARTMENT USING(DEPT_ID)
    JOIN LOCATION ON (LOC_ID LIKE LOCATION_ID)
    JOIN COUNTRY USING(COUNTRY_ID)
    WHERE COUNTRY_ID IN ('KO', 'JP'); --ANSI 
    
    SELECT E.EMP_NAME �����, D.DEPT_NAME �μ���,
            L.LOC_DESCRIBE ������, C.COUNTRY_NAME ������
    FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, COUNTRY C
    WHERE E.DEPT_ID LIKE D.DEPT_ID
    AND D.LOC_ID LIKE L.LOCATION_ID
    AND L.COUNTRY_ID LIKE C.COUNTRY_ID
    AND C.COUNTRY_ID IN('KO', 'JP'); --ORACLE
    
    
 

-- 10. ���� �μ��� �ٹ��ϴ� �������� 
-- �����, �μ��ڵ�, �����̸�, �μ��ڵ带 ��ȸ�Ͻÿ�.
-- self join ���
    SELECT  E.EMP_NAME �����,  E.DEPT_ID �μ��ڵ�,
             M.EMP_NAME �����̸�,   M.DEPT_ID �μ��ڵ�
    FROM EMPLOYEE E JOIN EMPLOYEE M
    ON E.DEPT_ID LIKE M.DEPT_ID
    WHERE E.EMP_NAME NOT LIKE M.EMP_NAME
    -- ON (E.EMP_NAME NOT LOKE M.EMP_NAME AND E.DEPT_ID LIKE D.DEPT_ID)
    -- ON�� �����̴ϱ� �ѹ��� ���ǵ��� �ᵵ�ȴ�.
    ORDER BY E.EMP_NAME; --ANSI
    
    SELECT E.EMP_NAME �����, E.DEPT_ID �μ��ڵ�,
            M.EMP_NAME �����̸�, M.DEPT_ID �μ��ڵ�
    FROM EMPLOYEE E, EMPLOYEE M
    WHERE E.DEPT_ID LIKE M.DEPT_ID
    AND E.EMP_NAME != M.EMP_NAME; -- ORACLE



-- 11. ���ʽ�����Ʈ�� ���� ������ �߿��� 
-- �����ڵ尡 J4�� J7�� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�.
   SELECT EMP_NAME �����, JOB_TITLE ���޸�, SALARY �޿�
   FROM EMPLOYEE LEFT JOIN JOB
   USING(JOB_ID)
   WHERE JOB_ID IN('J4', 'J7')
   AND (BONUS_PCT IS NULL OR BONUS_PCT LIKE 0.0); --ANSI

   SELECT EMP_NAME �����, JOB_TITLE ���޸�, SALARY �޿�
   FROM EMPLOYEE E, JOB J
   WHERE E.JOB_ID LIKE J.JOB_ID(+)
   AND (BONUS_PCT IS NULL OR BONUS_PCT LIKE 0.0)
   AND E.JOB_ID IN ('J4', 'J7');--ORACLE

-- 12. �ҼӺμ��� 50 �Ǵ� 90�� ������ 
-- ��ȥ�� ������ ��ȥ�� ������ ���� ��ȸ�Ͻÿ�.
    SELECT DECODE(MARRIAGE, 'Y', '��ȥ', 'N', '��ȥ') ��ȥ����,
            COUNT(*)
    FROM EMPLOYEE
    WHERE DEPT_ID IN ('50', '90')
    GROUP BY DECODE(MARRIAGE, 'Y', '��ȥ', 'N', '��ȥ');
   