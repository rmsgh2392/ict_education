-- DAY6_SELECT5

-- ORDER BY �� ------------------------------------------------------------------------------
-- ������� : ORDER BY ���ı���1 ��������, ���ı���2 ��������, ........
-- �����ġ : SELECT ���� ���� �������� �����
-- ��������� ���� �������� �۵���
-- ���ı��� : SELECT ���� ������ �÷��� | �÷���Ī | �÷��������� (1���� ������)
-- �������� : ASC(��������, �⺻���̹Ƿ� ������ �� ����), DESC(��������)
-- ù��° ���� �Ŀ� ���ı��� �÷����� ���� ���� ���� ��, �ι�° ���ı������� ���� ���� �ִ� ��鸸 �������� �� ����.

-- ���� �������� �μ��ڵ尡 50�̰ų� NULL�� ������ ��ȸ
-- �̸�, �޿� ��ȸ
-- �޿����� �������������ϰ�, ���� �޿��� ���ؼ��� �̸����� ������������ ó����
SELECT EMP_NAME �̸�, SALARY �޿�
FROM EMPLOYEE
WHERE DEPT_ID = '50' OR DEPT_ID IS NULL
--ORDER BY SALARY DESC, EMP_NAME ASC;
--ORDER BY �޿� DESC, �̸�;
ORDER BY 2 DESC, 1;

-- 2003�� 1�� 1�� ���� �Ի��� ���� ��ȸ
-- �̸�, �Ի���, �μ��ڵ�, �޿� : ��Ī ó��
-- �μ��ڵ� ��� �������������ϰ�, ���� �μ��ڵ��϶��� �Ի��� ���� ������������, �Ի����� ������ �̸� ���� ������������ ó����
SELECT EMP_NAME �̸�, HIRE_DATE �Ի���, DEPT_ID �μ��ڵ�, SALARY �޿�
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('20030101', 'RRRRMMDD')
--ORDER BY DEPT_ID DESC NULLS LAST, HIRE_DATE, EMP_NAME;
--ORDER BY �μ��ڵ� DESC NULLS LAST, �Ի���, �̸�;
ORDER BY 3 DESC NULLS LAST, 2, 1;

-- ORDER BY ���� NULL ��ġ ���� ����
-- ORDER BY ���ı��� �������� NULLS LAST : NULL �� �ִ� ���� �Ʒ��ʿ� ��ġ
-- [�⺻] : ORDER BY ���ı��� �������� NULLS FIRST : NULL �� �ִ� ���� ���ʿ� ��ġ

-- GROUP BY �� --------------------------------------------------------------------------------------------
-- ���� ������ ���� �� ��ϵ� �÷��� ���� �׷��� ���� �� ����
-- ������� : GROUP BY �÷��� | �׷����� ���� ����
-- ������ : ���� ������ �׷캰�� ��� ���� �׷��Լ��� �����ϱ� ���� �����
-- �����ġ : WHERE �� �Ʒ��� �����
-- ������� : WHERE �� ������ �����
-- SELECT �� ���� GROUP BY���� ����ǹǷ�, SELECT ���� ��Ī�� ������ ����� �� ����

-- ��ϰ� Ȯ��
SELECT EMP_NAME, SALARY, DEPT_ID
FROM EMPLOYEE;

SELECT DISTINCT DEPT_ID
FROM EMPLOYEE;

-- �μ��� �޿� �հ� ��ȸ
SELECT DEPT_ID �μ��ڵ�, SUM(SALARY) "�μ��� �޿��հ�"
FROM EMPLOYEE
GROUP BY DEPT_ID
ORDER BY �μ��ڵ� NULLS LAST;

-- ���޺� �޿��� �հ�, �޿��� ���, ������ ��ȸ
-- �޿��� ����� õ�������� �ݿø� ó����
-- �����ڵ忡 ���� ������������ ó���� (NULL �� �Ʒ��ʿ� ��ġ��)
SELECT JOB_ID �����ڵ�, SUM(SALARY) ���޺��޿��հ�,
        ROUND(AVG(SALARY), -4) ���޺��޿����, 
        COUNT(*) ������
FROM EMPLOYEE
GROUP BY JOB_ID
ORDER BY JOB_ID NULLS LAST;

-- GROUP BY ������ �׷����� ���� ������ ����� ���� ����
-- ���� �������� ������ �޿��հ�, �޿����(õ�������� �ݿø���), ������ ��ȸ
-- ������ ���� ������������ ó����
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '����', '3', '����', '����') ����,
        SUM(SALARY) �������޿��հ�,
        ROUND(AVG(SALARY), -4) �������޿����,
        COUNT(*) ������
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), '1', '����', '3', '����', '����')
ORDER BY ����;

-- GROUP BY �� ��갪�� �߿��� ������ �����ϴ� ���� ��󳻾� �� ����?
-- �� : �μ��� �޿��հ� �� ���� ū���� ���� �μ��ڵ�� �޿��հ� ��ȸ
SELECT /*DEPT_ID,*/ MAX(SUM(SALARY))  -- 7��, 1�� : ������� ������ �ٸ� - ����
FROM EMPLOYEE
GROUP BY DEPT_ID;

-- HAVING �� --------------------------------------------------------
-- GROUP BY �� ���� ��ġ�� �����
-- �׷����� ���鿡 ���� �׷��Լ� ���� ������� ���� ����ó���� ���� �����
-- ������� : HAVING �׷��Լ�(�׷����� �÷���) �񱳿����� �񱳰�

-- �μ��� �޿��հ� �� ���� ū���� ���� �μ��ڵ�� �޿��հ� ��ȸ
SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID
--HAVING SUM(SALARY) = 18100000;
--HAVING SUM(SALARY) = MAX(SUM(SALARY);  -- ERROR : ���������� �ذ�
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY)) 
                        FROM EMPLOYEE
                        GROUP BY DEPT_ID);

-- �μ��� �޿��հ� ���� 9�鸸�� �ʰ��ϴ� �μ��� �޿��հ踦 ��ȸ
SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID
HAVING SUM(SALARY) > 9000000;

-- �м� �Լ�(Analytic Function) ---------------------------------------------------------
-- �Ϲ��Լ��� ��������� �ٸ�

-- RANK() �Լ� : �ش� �÷��� ��ü���鿡���� ���� ����(���) ��ȯ��
-- �÷����� ���(����) �ű涧 �����
-- ���� 1 : �� ��ü�� ������ �ű� ���
--      RANK() OVER (ORDER BY �����ű� �÷��� ���Ĺ��)
-- ���� 2 : Ư�� ���� ������ ��ȸ�� ���
--      RANK(������ �˰��� �ϴ� ��) WITHIN GROUP (ORDER BY �����ű� �÷��� ���Ĺ��)

-- 1. �޿��� ���� �޴� ������ ������ �ű�ٸ�...
SELECT EMP_NAME, SALARY, 
        RANK() OVER (ORDER BY SALARY DESC) ����
FROM EMPLOYEE
ORDER BY ����;

-- 2. �޿� 230���� ���������������� �� ��ü �޿� �� �� ����?
SELECT RANK(2300000) WITHIN GROUP (ORDER BY SALARY DESC) ����
FROM EMPLOYEE;

-- ROLLUP() �Լ�
-- GROUP BY �������� �����
-- �׷캰�� ��� ����� ����� ���� ������� �߰����踦 ǥ���� �� �����

SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID;

SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_ID);

SELECT DEPT_ID, SUM(SALARY), MAX(SALARY), MIN(SALARY), ROUND(AVG(SALARY), -4)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID);

-- �ǽ� : �μ��ڵ�� �����ڵ带 �Բ� �׷��� ����, �޿��� �հ踦 ����
-- ROLLUP �����
-- NULL ĭ�� ������
SELECT DEPT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID, JOB_ID);

SELECT DEPT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID), ROLLUP(JOB_ID);

SELECT DEPT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY ROLLUP(JOB_ID), ROLLUP(DEPT_ID);

SELECT DEPT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY CUBE(DEPT_ID, JOB_ID);

-- ROWID
-- ���̺� ������ ��� ����� (INSERT ������ �� �߰���) �ڵ����� �ο���.
-- DBMS �� �ڵ����� ������. ����ڰ� ���� �� ��, ��ȸ Ȯ�θ� �� �� ����.
SELECT EMP_ID, ROWID
FROM EMPLOYEE;

-- ************************************************************************
-- ���� (JOIN)
-- ���� ���� ���̺��� �ϳ��� ���ļ� ū ���̺��� ���� ���� �ʿ��� �÷����� ��ȸ�ϴ� �����.
-- ����Ŭ ���뱸���� ANSI ǥ�ر������� �ۼ��� �� ����
-- ������ �⺻�� EQUAL JOIN ��. : �� ���̺��� ���� ���� ���� �÷��� �̿��ؼ�, ��ġ�ϴ� ������ �����ϴ� ������.

-- ����Ŭ ���뱸�� : ����Ŭ������ �����.
-- ������ ���̺���� FROM ���� ������. => FROM ���̺��1, ���̺��2, ���̺��3, .........
-- ��ĥ ������ WHERE ���� �ۼ���. => WHERE ���̺��1.�÷��� = ���̺��2.�÷���

SELECT *
FROM EMPLOYEE, DEPARTMENT
WHERE EMPLOYEE.DEPT_ID = DEPARTMENT.DEPT_ID;
-- 20��. EMPLOYEE �� DEPT_ID �� NULL �� ������ ���ο��� ���ܵ�. 

SELECT *
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_ID = DEPT_ID;  -- ���� ����

-- ���ν� ���̺���� ��Ī(ALIAS)�� ���� �� ����
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;

-- �����̸��� �μ����� ��ȸ
SELECT EMP_NAME, E.DEPT_ID, DEPT_NAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;

-- ANSI ǥ�ر���
-- ��� DBMS �� �������� ����ϴ� ǥ�ر�����.
-- ���� ó���� ���� ������ FROM �� �ٷ� �Ʒ��� ������ �ۼ��� 
SELECT *
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID);

-- �����̸�, �μ��ڵ�, �μ��� ��ȸ
SELECT EMP_NAME, DEPT_ID, DEPT_NAME
FROM EMPLOYEE
/*INNER*/ JOIN DEPARTMENT USING (DEPT_ID);

-- JOIN USING : �� ���̺��� ������ �÷����� ���� �� �����.
-- JOIN ON : �� ���̺��� ������ �÷����� �ٸ� �� �����. ��, ���� ��ġ�ؾ� ��
SELECT *
FROM DEPARTMENT
JOIN LOCATION ON (LOC_ID = LOCATION_ID);  -- ��ģ ����� ����Ŭ ���뱸���� ����

SELECT *
FROM DEPARTMENT D, LOCATION L
WHERE D.LOC_ID = L.LOCATION_ID;

-- �μ��ڵ�, �μ���, �ٹ������� ��ȸ
SELECT DEPT_ID, DEPT_NAME, LOC_DESCRIBE
FROM DEPARTMENT
JOIN LOCATION ON (LOC_ID = LOCATION_ID); 

SELECT DEPT_ID, DEPT_NAME, LOC_DESCRIBE
FROM DEPARTMENT D, LOCATION L
WHERE D.LOC_ID = L.LOCATION_ID;

-- �ǽ� : ���, �̸�, ���޸� ��ȸ
-- ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, E.JOB_ID, JOB_TITLE
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID;

-- ANSI ǥ�ر���
SELECT EMP_ID, EMP_NAME, JOB_ID, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID);

-- ������ �⺻�� INNER EQUAL JOIN ��. (EQU JOIN �̶�� ��)
-- �������� ����Ǵ� �÷��� ���� ��ġ�ϴ� ��鸸 ������ ��.
-- ��ġ�ϴ� ���� ���� ���� ���ο��� ���ܵ�.

-- ����, ��ġ�ϴ� ���� ���� �൵ ������ ����� ���Խ�Ű�� �ʹٸ�, OUTER EQUAL JOIN �� ����ϸ� ��.
-- OUTER JOIN �̶�� �� (EQUAL JOIN �� => ���̺� ���� ���� �߰��ؼ� EQUAL �� �ǰ� ������ ����� �����ϴ� �����)

-- OUTER JOIN ---------------------------------------------
-- EMPLOYEE ���̺��� ���� ��� ��(���� ��ü)�� ���ο� ���Խ�Ű���� �� ���

-- ����Ŭ ���뱸��
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID(+);

-- ANSI ǥ�ر���
SELECT *
FROM EMPLOYEE 
LEFT /*OUTER*/ JOIN DEPARTMENT USING (DEPT_ID);

-- DEPARTMENT ���̺��� ���� ��� ���� ���ο� ���Խ�Ű���� �� ���
-- ����Ŭ ���뱸��
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID(+) = D.DEPT_ID;

-- ANSI ǥ�ر���
SELECT *
FROM EMPLOYEE 
RIGHT /*OUTER*/ JOIN DEPARTMENT USING (DEPT_ID);

-- �� ���̺��� ��ġ���� �ʴ� ���� ��� ���ο� ���Խ�Ű���� �� ���
-- FULL OUTER JOIN �̶�� ��

-- ANSI ǥ�ر���
SELECT *
FROM EMPLOYEE
FULL /*OUTER*/ JOIN DEPARTMENT USING (DEPT_ID);  -- 23��

-- ����Ŭ ���뱸���� FULL OUTER JOIN �� ǥ���� �� ����
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID(+) = D.DEPT_ID(+);  -- ERROR

-- CROSS JOIN -----------------------------------------------------------
-- �� ���̺��� ������ �÷��� ���� ��쿡 �����
-- N���� X M���� �� ����� �������

-- ANSI ǥ�ر���
SELECT *
FROM LOCATION
CROSS JOIN COUNTRY;

-- ����Ŭ ���뱸��
SELECT *
FROM LOCATION, COUNTRY;

-- NON EQUAL JOIN
-- �����ϴ� �÷��� ���� ��ġ�ϴ� ��찡 �ƴ�, ���� ������ �ش�Ǵ� ����� �����ϴ� ����� ����
 
 -- �������� �޿��� ���� �޿������ �ű���� �� ���
 -- EMPLOYEE, SAL_GRADE NON-EQU JOIN
SELECT *
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN LOWEST AND HIGHEST);

-- SELF JOIN ---------------------------------------------------------------
-- ���� ���̺��� �ι� �����ϴ� ���
-- ���� ���̺� ���� �ٸ� �÷��� �ܷ�Ű(FOREIGN KEY)�� �����ϰ� �ִ� ��쿡 ����� �� ����
-- EMP_ID : ������ ���, MGR_ID : �������� ������ ��� (EMP_ID ������)
-- ���� �߿� �������� ������ �ǹ��� : MGR_ID

-- ANSI ǥ�ر��� : ���̺� ��Ī ����ؾ� ��, JOIN ON �����
SELECT *
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.MGR_ID = M.EMP_ID);

-- ����Ŭ ���뱸��
SELECT *
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MGR_ID = M.EMP_ID;

-- �����̸��� �������̸� ��ȸ
-- ANSI
SELECT E.EMP_NAME �����̸�, M.EMP_NAME �������̸�
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.MGR_ID = M.EMP_ID);

-- ����Ŭ ���뱸��
SELECT E.EMP_NAME �����̸�, M.EMP_NAME �������̸�
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MGR_ID = M.EMP_ID;

-- N���� ���̺� ���� : ���� ������ �߿���
-- ù��°�� �ι�°�� ���εǰ� ����, ���ΰ���� ����°�� ���εǴ� ������.
SELECT EMP_NAME, JOB_TITLE, DEPT_NAME, LOC_DESCRIBE, COUNTRY_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID)
JOIN COUNTRY USING (COUNTRY_ID);

-- ������ �븮�̸鼭, �ƽþ������� �ٹ��ϴ� ���� ��ȸ
-- ���, �̸�, ���޸�, �μ���, �ٹ�������, �޿� 
-- ����Ŭ ���뱸�� : 
SELECT EMP_ID ���, EMP_NAME �̸�, JOB_TITLE ���޸�, DEPT_NAME �μ���, LOC_DESCRIBE �ٹ�������, SALARY �޿�
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE E.JOB_ID = J.JOB_ID
AND E.DEPT_ID = D.DEPT_ID
AND D.LOC_ID = L.LOCATION_ID
AND JOB_TITLE = '�븮' AND LOC_DESCRIBE LIKE '�ƽþ�%';

-- ANSI ǥ�ر��� : 
SELECT EMP_ID ���, EMP_NAME �̸�, JOB_TITLE ���޸�, DEPT_NAME �μ���, LOC_DESCRIBE �ٹ�������, SALARY �޿�
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID)
WHERE JOB_TITLE = '�븮' AND LOC_DESCRIBE LIKE '�ƽþ�%';


-- JOIN �������� --------------------------------------------------------------------------------------------------
-- ����Ŭ ���뱸���� ANSI ǥ�ر��� ���� �ۼ��� ��.

-- 1. 2020�� 12�� 25���� ���� �������� ��ȸ�Ͻÿ�.
SELECT TO_CHAR(TO_DATE('20201225', 'RRRRMMDD'), 'DAY')
FROM DUAL;


-- 2. �ֹι�ȣ�� 60��� ���̸鼭 ������ �����̰�, ���� �达�� �������� 
-- �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�.

-- ����Ŭ ���뱸��

-- ANSI ǥ�ر���


-- 3. ���� ���̰� ���� ������ 
-- ���, �����, ����, �μ���, ���޸��� ��ȸ�Ͻÿ�.

--������ �ּҰ� ��ȸ
    

-- ��ȸ�� ������ �ּҰ��� �̿��� ������ ���� ��ȸ��
-- outer join �ʿ���.

-- ����Ŭ ���뱸��

-- ANSI ǥ�ر���



-- 4. �̸��� '��'�ڰ� ���� �������� 
-- ���, �����, �μ����� ��ȸ�Ͻÿ�.

-- ����Ŭ ���뱸��

-- ANSI ǥ�ر���




-- 5. �ؿܿ������� �ٹ��ϴ� 
-- �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�.

-- ����Ŭ ���뱸��

-- ANSI ǥ�ر���




-- 6. ���ʽ�����Ʈ�� �޴� �������� 
-- �����, ���ʽ�����Ʈ, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.

-- ����Ŭ ���뱸��

-- ANSI ǥ�ر���




-- 7. �μ��ڵ尡 20�� �������� 
-- �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.

-- ����Ŭ ���뱸��

-- ANSI ǥ�ر���




-- 8. ���޺� ������ �ּұ޿�(MIN_SAL)���� ���� �޴� ��������
-- �����, ���޸�, �޿�, ������ ��ȸ�Ͻÿ�.
-- ������ ���ʽ�����Ʈ�� �����Ͻÿ�.

-- ����Ŭ ���뱸��

-- ANSI ǥ�ر���




-- 9 . �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �������� 
-- �����(emp_name), �μ���(dept_name), ������(loc_describe),
--  ������(country_name)�� ��ȸ�Ͻÿ�.

-- ����Ŭ ���뱸��

-- ANSI ǥ�ر���



-- 10. ���� �μ��� �ٹ��ϴ� �������� 
-- �����, �μ��ڵ�, �����̸�, �μ��ڵ带 ��ȸ�Ͻÿ�.
-- self join ���

-- ����Ŭ ���뱸��

-- ANSI ǥ�ر���





-- 11. ���ʽ�����Ʈ�� ���� ������ �߿��� 
-- �����ڵ尡 J4�� J7�� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�.

-- ����Ŭ ���뱸��

-- ANSI ǥ�ر���






-- 12. �ҼӺμ��� 50 �Ǵ� 90�� ������ 
-- ��ȥ�� ������ ��ȥ�� ������ ���� ��ȸ�Ͻÿ�.




