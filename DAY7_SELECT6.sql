-- DAY7_SELECT6

-- JOIN 연습문제 --------------------------------------------------------------------------------------------------
-- 오라클 전용구문과 ANSI 표준구문 각각 작성할 것.

-- 1. 2020년 12월 25일이 무슨 요일인지 조회하시오.
SELECT TO_CHAR(TO_DATE('20201225', 'RRRRMMDD'), 'DAY')
FROM DUAL;


-- 2. 주민번호가 60년대 생이면서 성별이 여자이고, 성이 김씨인 직원들의 
-- 사원명, 주민번호, 부서명, 직급명을 조회하시오.

-- 오라클 전용구문
SELECT EMP_NAME, EMP_NO, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.DEPT_ID = D.DEPT_ID(+)
AND EMP_NO LIKE '6%'
AND SUBSTR(EMP_NO, 8, 1) IN ('2', '4')
AND EMP_NAME LIKE '김%';

-- ANSI 표준구문
SELECT EMP_NAME, EMP_NO, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE EMP_NO LIKE '6%'
AND SUBSTR(EMP_NO, 8, 1) IN ('2', '4')
AND EMP_NAME LIKE '김%';

-- 3. 가장 나이가 적은 직원의 
-- 사번, 사원명, 나이, 부서명, 직급명을 조회하시오.

--나이의 최소값 조회
SELECT MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) 나이
FROM EMPLOYEE;  -- 31

-- 조회한 나이의 최소값을 이용해 직원의 정보 조회함
-- outer join 필요함.

-- 오라클 전용구문
SELECT EMP_ID 사번, EMP_NAME 이름, 
        MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) 나이, 
        DEPT_NAME 부서명, JOB_TITLE 직급명
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.DEPT_ID = D.DEPT_ID(+)
GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
HAVING MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12))  = 31;

-- ANSI 표준구문
SELECT EMP_ID 사번, EMP_NAME 이름, 
        MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) 나이, 
        DEPT_NAME 부서명, JOB_TITLE 직급명
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
HAVING MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12))  = 31;

-- 서브쿼리를 사용할 경우 -----------------------------------------------------------------------------
SELECT EMP_ID 사번, EMP_NAME 이름, 
        MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) 나이, 
        DEPT_NAME 부서명, JOB_TITLE 직급명
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
HAVING MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 
        'RRMM')) / 12))  = (SELECT MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) 나이
                            FROM EMPLOYEE);

-- 인라인뷰와 RANK() 함수 사용
SELECT 사번, 이름, 나이, 부서명, 직급명
FROM (SELECT EMP_ID 사번, EMP_NAME 이름, 
                TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12) 나이,
                DEPT_NAME 부서명, JOB_TITLE 직급명,
                RANK() OVER (ORDER BY TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12) ASC) 순위
        FROM EMPLOYEE
        LEFT JOIN JOB USING (JOB_ID)
        LEFT JOIN DEPARTMENT USING (DEPT_ID))
WHERE 순위 = 1; --  TOP-1 분석


-- 4. 이름에 '성'자가 들어가는 직원들의 
-- 사번, 사원명, 부서명을 조회하시오.

-- 오라클 전용구문
SELECT EMP_ID, EMP_NAME, DEPT_NAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID(+)
AND EMP_NAME LIKE '%성%';

-- ANSI 표준구문
SELECT EMP_ID, EMP_NAME, DEPT_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE EMP_NAME LIKE '%성%';


-- 5. 해외영업팀에 근무하는 
-- 사원명, 직급명, 부서코드, 부서명을 조회하시오.

-- 오라클 전용구문
SELECT EMP_NAME, JOB_TITLE, E.DEPT_ID, DEPT_NAME
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.DEPT_ID = D.DEPT_ID(+)
AND DEPT_NAME LIKE '해외영업%'
ORDER BY 4;

-- ANSI 표준구문
SELECT EMP_NAME, JOB_TITLE, DEPT_ID, DEPT_NAME
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE DEPT_NAME LIKE '해외영업%'
ORDER BY 4;


-- 6. 보너스포인트를 받는 직원들의 
-- 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.

-- 오라클 전용구문
SELECT EMP_NAME, BONUS_PCT, DEPT_NAME, LOC_DESCRIBE
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_ID = D.DEPT_ID(+)
AND D.LOC_ID = L.LOCATION_ID(+)
AND (BONUS_PCT IS NOT NULL OR BONUS_PCT != 0.0);

-- ANSI 표준구문
SELECT EMP_NAME, BONUS_PCT, DEPT_NAME, LOC_DESCRIBE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN LOCATION ON (LOC_ID = LOCATION_ID)
WHERE BONUS_PCT IS NOT NULL OR BONUS_PCT != 0.0;


-- 7. 부서코드가 20인 직원들의 
-- 사원명, 직급명, 부서명, 근무지역명을 조회하시오.

-- 오라클 전용구문
SELECT EMP_NAME, JOB_TITLE, DEPT_NAME, LOC_DESCRIBE
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.DEPT_ID = D.DEPT_ID(+)
AND D.LOC_ID = L.LOCATION_ID(+)
AND E.DEPT_ID = '20';

-- ANSI 표준구문
SELECT EMP_NAME, JOB_TITLE, DEPT_NAME, LOC_DESCRIBE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN LOCATION ON (LOC_ID = LOCATION_ID)
WHERE DEPT_ID = '20';


-- 8. 직급별 연봉의 최소급여(MIN_SAL)보다 많이 받는 직원들의
-- 사원명, 직급명, 급여, 연봉을 조회하시오.
-- 연봉은 보너스포인트를 적용하시오.

-- 오라클 전용구문
SELECT EMP_NAME, JOB_TITLE, SALARY, 
        (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 연봉
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID(+)
AND (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 > MIN_SAL;

-- ANSI 표준구문
SELECT EMP_NAME, JOB_TITLE, SALARY, 
        (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 연봉
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 > MIN_SAL;


-- 9 . 한국(KO)과 일본(JP)에 근무하는 직원들의 
-- 사원명(emp_name), 부서명(dept_name), 지역명(loc_describe),
--  국가명(country_name)을 조회하시오.

-- 오라클 전용구문
SELECT EMP_NAME, DEPT_NAME, LOC_DESCRIBE, COUNTRY_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, COUNTRY C
WHERE E.DEPT_ID = D.DEPT_ID
AND D.LOC_ID = L.LOCATION_ID
AND L.COUNTRY_ID = C.COUNTRY_ID
AND L.COUNTRY_ID IN ('KO', 'JP');

-- ANSI 표준구문
SELECT EMP_NAME, DEPT_NAME, LOC_DESCRIBE, COUNTRY_NAME
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID)
JOIN COUNTRY USING (COUNTRY_ID)
WHERE COUNTRY_ID IN ('KO', 'JP');


-- 10. 같은 부서에 근무하는 직원들의 
-- 사원명, 부서코드, 동료이름, 부서코드를 조회하시오.
-- self join 사용

-- 오라클 전용구문
SELECT E.EMP_NAME 이름, E.DEPT_ID 소속부서,
        M.EMP_NAME 동료이름, M.DEPT_ID 동료부서
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.EMP_NAME != M.EMP_NAME
AND E.DEPT_ID = M.DEPT_ID
ORDER BY E.EMP_NAME;

-- ANSI 표준구문 : 테이블 별칭 사용시에는 ON 사용함
SELECT E.EMP_NAME 이름, E.DEPT_ID 소속부서,
        M.EMP_NAME 동료이름, M.DEPT_ID 동료부서
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.EMP_NAME != M.EMP_NAME AND E.DEPT_ID = M.DEPT_ID)
ORDER BY E.EMP_NAME;


-- 11. 보너스포인트가 없는 직원들 중에서 
-- 직급코드가 J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.

-- 오라클 전용구문
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.JOB_ID IN ('J4', 'J7') AND (BONUS_PCT IS NULL OR BONUS_PCT = 0.0);

-- ANSI 표준구문
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE JOB_ID IN ('J4', 'J7') AND (BONUS_PCT IS NULL OR BONUS_PCT = 0.0);



-- 12. 소속부서가 50 또는 90인 직원중 
-- 기혼인 직원과 미혼인 직원의 수를 조회하시오.
SELECT DECODE(MARRIAGE, 'Y', '기혼', 'N', '미혼') 결혼여부,
        COUNT(*) 직원수
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90')
GROUP BY DECODE(MARRIAGE, 'Y', '기혼', 'N', '미혼')
ORDER BY 1;

-- ***************************************************************************************************
-- 집합 연산자 (SET OPERATOR)
-- UNION, UNION ALL, INTERSECT, MINUS
-- 각 SELECT 문의 실행 결과(결과집합 - RESULTSET)를 하나로 표현하기 위해 사용함
-- 합집합 : UNION, UNION ALL - 두 개의 RESULTSET 결과를 하나로 합침
--        UNION (합칠 때 중복행은 하나만 선택함), UNION ALL(중복행을 모두 포함함)
-- 교집합 : INTERSECT - 두 개의 RESULTSET 결과에서 겹치는(중복 일치되는) 행을 선택함
-- 차집합 : MINUS - 첫번째 RESULTSET 결과에서 두번째 RESULTSET 과 겹치는 행을 제외한 나머지 행을 선택함

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE  -- 22행
UNION  -- 25행 (중복행은 1개만 선택)
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;  -- 4행

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE  -- 22행
UNION ALL  -- 26행 (중복행도 다 포함)
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;  -- 4행

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE  -- 22행
INTERSECT  -- 1행 : 중복행 1개만 선택
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;  -- 4행

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE  -- 22행
MINUS  -- 21행 (두번째 쿼리와 중복되는 행을 뺌)
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;  -- 4행 : 중복행 1개 존재.

-- SET 연산자 사용시 주의사항
-- 각 쿼리문의 SELECT 절의 컬럼 갯수와 각 컬럼별 자료형이 반드시 같아야 함
-- 갯수는 더미 컬럼(DUMMY COLUMN - NULL 칸)을 사용할 수 있음

-- 갯수 불일치
SELECT EMP_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_ID = '20'
UNION
SELECT DEPT_NAME, DEPT_ID, NULL -- DUMMY COLUMN
FROM DEPARTMENT
WHERE DEPT_ID = '20';

-- 각 컬럼별 자료형 불일치
SELECT EMP_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_ID = '20'
UNION
SELECT NULL, DEPT_NAME, DEPT_ID
FROM DEPARTMENT
WHERE DEPT_ID = '20';

-- 활용 : 각각 조회한 결과를 한 테이블로 보여지게 할 때 주로 이용할 수 있음
-- 50번 부서에 소속된 직원 중 관리자와 일반 직원을 따로 조회해서 하나로 합쳐라.
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = '50';

SELECT EMP_ID, EMP_NAME, '관리자' 구분
FROM EMPLOYEE
WHERE EMP_ID = '141' AND DEPT_ID = '50'
UNION
SELECT EMP_ID, EMP_NAME, '직원' 구분
FROM EMPLOYEE
WHERE EMP_ID <> '141' AND DEPT_ID = '50'
ORDER BY 3, 1;

SELECT 'SQL을 공부하고 있습니다.', 3 순서 FROM DUAL
UNION
SELECT '우리는 지금 ', 1 FROM DUAL
UNION
SELECT '아주 재미있게 ', 2 FROM DUAL
ORDER BY 2;

-- SET 연산자와 JOIN 의 관계
SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
INTERSECT
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;

-- 각 쿼리문의 SELECT 절에 선택된 컬럼명이 동일한 경우에 조인구문으로 바꿀 수 있음.
-- USING (EMP_ID, ROLE_NAME) 사용할 수 있음
-- (104 SE) = (104 SE) : 같다
-- (104 SE-ANLY) != (104 SE) : 다르다

-- 조인 구문으로 바꾼다면
SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
JOIN ROLE_HISTORY USING (EMP_ID, ROLE_NAME);

-- SET 연산자와 IN 연산자의 관계
-- UNION 과 IN 이 같은 결과를 만들 수도 있음.
-- 집합 연산자에 대한 쿼리문의 SELECT 절의 컬럼들이 같고, 참조하는 테이블이 같고
-- WHERE 조건절의 비교값만 다른 경우에 IN 으로 바꿀 수 있음

-- 직급이 대리 또는 사원인 직원의 이름, 직급명 조회
-- 직급순 오름차순정렬, 같은 직급은 이름순 오름차순정렬 처리함
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE IN ('대리', '사원')
ORDER BY 2, 1;

-- UNION 사용 구문으로 바꾼다면.
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '대리'
UNION
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '사원'
ORDER BY 2, 1;

-- ***************************************************************************
-- SUBQUERY (서브쿼리)
/*
    함수(리턴값이 있는 함수())  => 안에 사용된 함수가 먼저 실행이 되고, 리턴한 값을 바깥 함수가 사용하는 구조임
    SELECT 구문에서도 컬럼명 비교연산자 비교값  <--- 비교값을 알아내기 위한 SELECT문을 비교값 자리에 바로 사용할 수 있음
    컬럼명 비교연산자 (비교값 알아내기 위한 SELECT 구문) <--- 서브쿼리(내부쿼리)라고 함
    바깥 SELECT 문을 메인쿼리(외부쿼리)라고 함
*/

-- 나승원과 같은 부서에 근무하는 직원 조회
-- 1. 나승원의 부서코드 조회
SELECT DEPT_ID  -- 50
FROM EMPLOYEE
WHERE EMP_NAME = '나승원';

-- 2. 조회된 값을 사용해서 직원 정보 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_ID = '50';

-- 서브쿼리 사용 구문 변경
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_ID = (SELECT DEPT_ID 
                  FROM EMPLOYEE
                  WHERE EMP_NAME = '나승원');

-- 서브쿼리의 유형
-- 단일행 서브쿼리, 다중행 서브쿼리, 다중열 서브쿼리, 다중행 다중열 서브쿼리, 
-- 상호연관 서브쿼리, 스칼라 서브쿼리
-- 서브쿼리 유형에 따라 서브쿼리 앞에 사용하는 연산자가 다름. **

-- 단일행 (SINGLE ROW) 서브쿼리
-- 서브쿼리 실행 결과값이 한 개인 경우 (값 1개)
-- 단일행 서브쿼리 앞에는 일반 비교연산자 사용할 수 있음.
-- >, <, >=, <=, =, !=(<>, ^=)

-- 예 : 나승원과 직급이 같으면서 나승원보다 급여를 많이 받는 직원 조회
-- 1. 나승원 직급 조회
SELECT JOB_ID  -- J5
FROM EMPLOYEE
WHERE EMP_NAME = '나승원';

-- 2. 나승원 급여 조회
SELECT SALARY  -- 2300000
FROM EMPLOYEE
WHERE EMP_NAME = '나승원';

-- 3. 비교값으로 사용
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMPLOYEE
WHERE JOB_ID = 'J5'
AND SALARY > 2300000;

-- 서브쿼리 구문으로 변경
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMPLOYEE
WHERE JOB_ID = (SELECT JOB_ID  -- J5
                FROM EMPLOYEE
                WHERE EMP_NAME = '나승원')
AND SALARY > (SELECT SALARY  -- 2300000
                FROM EMPLOYEE
                WHERE EMP_NAME = '나승원');

-- 직원 중에서 최저 급여를 받는 직원 명단 조회
-- 1. 최저 급여 
SELECT MIN(SALARY)
FROM EMPLOYEE;

-- 2. 직원 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY = 1500000;

-- WHERE 절에 그룹함수 사용 못 함 ==> 서브쿼리로 해결
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
-- WHERE SALARY = MIN(SALARY);
WHERE SALARY = (SELECT MIN(SALARY)
                 FROM EMPLOYEE);

-- HAVING 절에서도 서브쿼리 사용할 수 있음.
-- 예 : 부서별 급여합계 중 가장 큰값에 대한 부서명과 급여합계 조회
SELECT DEPT_NAME, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY DEPT_ID, DEPT_NAME
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))  -- 18100000
                        FROM EMPLOYEE
                        GROUP BY DEPT_ID);

-- 서브쿼리는 SELECT, FROM, WHERE, HAVING 에서 주로 사용할 수 있음.

-- 다중행 서브쿼리 (MULTIPLE ROW SUBQUERY)
-- 서브쿼리의 결과행의 갯수가 여러 개인 경우 (값이 여러 개)
-- 다중행 서브쿼리 앞에는 일반 비교연산자 사용 못 함
-- 여러 개의 값을 비교할 수 있는 연산자 사용해야 함 : IN, ANY, ALL

-- 예 : 각 부서별로 급여가 제일 작은 직원 정보 조회
-- 1. 부서별 급여 최소값 조회
SELECT MIN(SALARY)  -- 7행
FROM EMPLOYEE
GROUP BY DEPT_ID;

-- 2. 메인쿼리에 적용
SELECT EMP_ID, EMP_NAME, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)  -- 7행
                FROM EMPLOYEE
                GROUP BY DEPT_ID);  -- 에러 : 연산자 잘못 사용
                
-- 서브쿼리가 만든 여러 개의 값들을 모두 한번씩 비교해서 같은지를 확인하려면,
-- 컬럼명 IN (값, 값, 값, ....) ==> 컬럼명 IN (다중행 서브쿼리)
-- 컬럼값 = 비교값1 OR 컬럼값 = 비교값2 OR 컬럼값 = 비교값3 OR ..........
-- 컬럼값이 여러 개의 값 중에서 일치하는 값이 있다면 컬럼값을 선택함
SELECT EMP_ID, EMP_NAME, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MIN(SALARY)  -- 7행
                FROM EMPLOYEE
                GROUP BY DEPT_ID);

-- 컬럼명 NOT IN (다중행 서브쿼리)
-- NOT (컬럼값 = 비교값1 OR 컬럼값 = 비교값2 OR 컬럼값 = 비교값3 OR ..........)
-- 컬럼값이 여러 개의 값 중에서 일치하는 값이 없다면 (일치하는 값이 아닌)

-- 예 : 관리자인 직원과 관리자가 아닌 직원 정보 별도로 조회해서 합쳐라.
-- 관리자 사번 조회
SELECT DISTINCT MGR_ID  -- 6행
FROM EMPLOYEE
WHERE MGR_ID IS NOT NULL;

-- 직원 정보에서 관리자만 조회
SELECT EMP_ID, EMP_NAME, '관리자' 구분
FROM EMPLOYEE
WHERE EMP_ID IN (SELECT DISTINCT MGR_ID  -- 6행
                    FROM EMPLOYEE
                    WHERE MGR_ID IS NOT NULL)
UNION
SELECT EMP_ID, EMP_NAME, '직원' 구분
FROM EMPLOYEE
WHERE EMP_ID NOT IN (SELECT DISTINCT MGR_ID  -- 6행
                    FROM EMPLOYEE
                    WHERE MGR_ID IS NOT NULL)
ORDER BY 3, 1;

-- SELECT 절에서도 서브쿼리 사용할 수 있음
-- 함수 계산식 안에서 주로 사용됨
SELECT EMP_ID, EMP_NAME,
        CASE WHEN EMP_ID IN (SELECT MGR_ID FROM EMPLOYEE) THEN '관리자'
        ELSE '직원'
        END 구분
FROM EMPLOYEE
ORDER BY 3, 1;

-- 컬럼명 > ANY (다중행 서브쿼리) : 가장 작은 값보다 큰
-- 컬럼명 < ANY (다중행 서브쿼리) : 가장 큰값보다 작은
-- 컬럼명 > (값1, 값2, 값3, ....) => 컬럼명 > 값1 OR 컬럼명 > 값2 OR 컬럼명 > 값3 OR .........
-- 컬럼명 <(값1, 값2, 값3, ....) => 컬럼명 < 값1 OR 컬럼명 < 값2 OR 컬럼명 < 값3 OR .........

-- 예 : 대리 직급의 직원 중에서 과장 직급의 급여의 최소값보다 급여를 많이 받는 직원 조회
SELECT EMP_ID, EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '대리'
AND SALARY > ANY (SELECT SALARY
                    FROM EMPLOYEE
                    JOIN JOB USING (JOB_ID)
                    WHERE JOB_TITLE = '과장');

-- 컬럼명 > ALL (다중행 서브쿼리) : 가장 큰 값보다 큰
-- 컬럼명 < ALL (다중행 서브쿼리) : 가장 작은값보다 작은
-- 컬럼명 > (값1, 값2, 값3, ....) => 컬럼명 > 값1 AND 컬럼명 > 값2 AND 컬럼명 > 값3 AND .........
-- 컬럼명 <(값1, 값2, 값3, ....) => 컬럼명 < 값1 AND 컬럼명 < 값2 AND 컬럼명 < 값3 AND .........
-- 예 : 모든 과장들의 급여보다 더 많은 급여를 받는 대리 직원 조회
SELECT EMP_ID, EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '대리'
AND SALARY > ALL (SELECT SALARY
                    FROM EMPLOYEE
                    JOIN JOB USING (JOB_ID)
                    WHERE JOB_TITLE = '과장');
                    
-- 서브쿼리의 사용 위치 : SELECT 절, FROM 절, WHERE 절, GROUP BY 절, HAVING 절, ORDER BY 절
-- INSERT 문, UPDATE 문, CREATE TABLE 문, CREATE VIEW 문
                    
-- 자기 직급의 평균 급여를 받는 직원 조회
-- 1. 직급별 급여평균 조회
SELECT JOB_ID, TRUNC(AVG(SALARY), -5)
FROM EMPLOYEE
GROUP BY JOB_ID;
                    
-- 2. 서브쿼리에 적용
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE SALARY IN (SELECT TRUNC(AVG(SALARY), -5)
                    FROM EMPLOYEE
                    GROUP BY JOB_ID);

-- 다중행 다중열 서브쿼리
-- 서브쿼리 SELECT 절에 항목이 여러 개인 경우 : 다중 열 (MULTIPLE COLUMN)
-- (비교컬럼명, 비교컬럼명) 비교연산자 (다중열 서브쿼리)
-- 서브쿼리 SELECT 절의 항목(컬럼) 갯수와 자료형을 맞추어서 비교해야 함
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE (JOB_ID, SALARY) IN (SELECT JOB_ID, TRUNC(AVG(SALARY), -5)
                            FROM EMPLOYEE
                            GROUP BY JOB_ID);

-- FROM 절에서 서브쿼리 사용할 수 있음 : 테이블 대신에 사용함
-- FROM (서브쿼리) 별칭  <--- 별칭(ALIAS)가 테이블명을 대신함
-- FROM 절에서 사용된 서브쿼리가 만든 결과집합을 인라인뷰(INLINE VIEW)라고 함
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM (SELECT JOB_ID, TRUNC(AVG(SALARY), -5) JOBAVG
        FROM EMPLOYEE
        GROUP BY JOB_ID) V  -- 인라인 뷰
JOIN EMPLOYEE E ON (V.JOBAVG = E.SALARY AND NVL(V.JOB_ID, ' ') = NVL(E.JOB_ID, ' '))
LEFT JOIN JOB J ON  (E.JOB_ID = J.JOB_ID)
ORDER BY 3, 2;

-- 서브쿼리의 종류
-- 단일행 서브쿼리, 다중행 서브쿼리, 다중행 다중열 서브쿼리, 상[호연]관 서브쿼리, 스칼라 서브쿼리
-- 대부분의 서브쿼리는 서브쿼리가 만들어 낸 결과값을 메인쿼리가 사용하는 방식임.
-- 상관쿼리는 서브쿼리가 메인쿼리의 값을 가져다가 결과를 만드는 구조임.
-- 그러므로 메인쿼리의 값이 바뀌면 서브쿼리의 결과도 달라지게 됨. => 상호연관 서브쿼리라고 함

-- 자기 직급의 평균 급여를 받는 직원 조회 :상호연관 서브쿼리를 사용한 경우
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_ID = J.JOB_ID)
WHERE SALARY = (SELECT TRUNC(AVG(SALARY), -5)
                 FROM EMPLOYEE
                 WHERE JOB_ID = E.JOB_ID)
ORDER BY 3 DESC NULLS LAST;

-- EXISTS / NOT EXISTS 연산자
-- 상호연관 서브쿼리 문 앞에서만 사용함
-- 서브쿼리가 만든 결과가 존재하는지 물어볼 때는 EXISTS 사용
-- 서브쿼리의 SELECT 절에 컬럼 기술하면 안 됨. NULL 사용할 것.

-- 예 : 관리자인 직원들 조회
SELECT EMP_ID, EMP_NAME, '관리자' 구분
FROM EMPLOYEE E
WHERE EXISTS (SELECT NULL
                FROM EMPLOYEE
                WHERE E.EMP_ID = MGR_ID);
                
-- 관리자가 아닌 직원들 조회
SELECT EMP_ID, EMP_NAME, '직원' 구분
FROM EMPLOYEE E
WHERE NOT EXISTS (SELECT NULL
                FROM EMPLOYEE
                WHERE E.EMP_ID = MGR_ID);

-- 스칼라 서브쿼리
-- 단일행 서브쿼리 + 상호연관서브쿼리
-- 예 : 이름, 부서코드, 급여, 해당 직원이 소속된 부서의 급여평균 조회
SELECT EMP_NAME, DEPT_ID, SALARY, 
        (SELECT TRUNC(AVG(SALARY), -5)
        FROM EMPLOYEE
        WHERE DEPT_ID = E.DEPT_ID) AVGSAL
FROM EMPLOYEE E;

-- CASE 표현식을 사용한 스칼라 서브쿼리
-- 부서의 근무지역이 'OT' 이면 '지역팀', 아니면 '본사팀' 으로 표시 조회
SELECT EMP_ID, EMP_NAME,
        CASE WHEN DEPT_ID = (SELECT DEPT_ID
                                FROM DEPARTMENT
                                WHERE LOC_ID = 'OT')
        THEN '지역팀'
        ELSE '본사팀'
        END 소속
FROM EMPLOYEE
ORDER BY 소속 DESC;

-- ORDER BY 절에 스칼라 서브쿼리 사용 예
-- 직원이 소속된 부서의 부서명이 큰 값부터 정렬해서 직원 정보 조회
SELECT EMP_ID, EMP_NAME, DEPT_ID, HIRE_DATE
FROM EMPLOYEE E
ORDER BY (SELECT DEPT_NAME
            FROM DEPARTMENT
            WHERE DEPT_ID = E.DEPT_ID) DESC;

-- TOP-N 분석 --------------------------------------------------------
-- 상위 몇 개, 하위 몇 개를 조회하는 것
-- 인라인 뷰와 RANK() 함수를 이용하는 방법과 
-- ROWNUM 을 이용한 TOP-N 분석이 있음

-- 1. 인라인 뷰와 RANK() 함수를 이용한 TOP-N 분석
-- 직원 정보에서 급여를 가장 많이 받는 직원 5명 조회
-- 이름, 급여, 순위
SELECT *
FROM (SELECT EMP_NAME, SALARY, RANK() OVER (ORDER BY SALARY DESC) 순위
       FROM EMPLOYEE)
WHERE 순위 <= 5;       

-- 2. ROWNUM 을 이용한 TOP-N 분석
-- ORDER BY 한 결과에 ROWNUM 을 붙임 ==> 서브쿼리를 이용해야 함
-- ROWNUM : 행번호를 의미함, WHERE 처리 후에 자동으로 부여됨

-- 확인
SELECT ROWNUM, EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE -- 각 행 앞에 ROWNUM 표시됨
ORDER BY SALARY DESC;

-- 급여 많이 받는 직원 3명 조회
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM < 4  -- WHERE 절 다음에 ROWNUM 부여됨
ORDER BY SALARY DESC; -- 틀린 결과 나옴

-- 해결 : 정렬하고 나서 ROWNUM 이 부여되게끔 하면 됨
-- 인라인 뷰 사용
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT *
       FROM EMPLOYEE
       ORDER BY SALARY DESC)  -- 정렬 후에 ROWNUM 이 부여됨
WHERE ROWNUM < 4;       









