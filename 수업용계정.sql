--사원 이름중에 앞,중간,마지막 어느 곳이든 '해'라는 문자가 들어가는 사원이름을 조회
--%찾고싶은 글자%
--와일드카드 % 사용 % : 0개이상의 문자
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%해%';

--주민번호로 여자 사원 조회 
--와일트카드 '_'사용  _ : 한개의 문자 취급
SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE
WHERE EMP_NO LIKE '_______2%';
--주민번호로 남자 사원 조회
SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE
WHERE EMP_NO LIKE '_______1%';
--또는 위에 여자를 활용해 WHERE EMP_NO NOT LIKE '_______2%'로도 조회 할 수 있다.

SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___\_%' ESCAPE '\';
--ESCAPE OPTION 을 사용하여 기록된 값과 구분하여 사용자가 원하는 값을 조회
--만약 옵션을 사용하지 않는다면 아래와 같이 조회 하였을 때
--이메일 컬럼에 저장된 '_'값과 와일드카드 '_' 가 구분이 안되어 사용자가 원하는 값을 조회하지 못한다.
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';

--1. 부서코드 90 직급코드 J2 조회
SELECT EMP_ID 사번, EMP_NAME 이름, 
        DEPT_ID 부서코드, JOB_ID 직급코드, 
        SALARY 급여
FROM EMPLOYEE
WHERE DEPT_ID LIKE '90' 
AND JOB_ID LIKE 'J2';
--2. 입사일 1982/01/01이후이거나 직급코드 J3인 사원 조회
SELECT EMP_ID 사번, EMP_NAME 이름,
        MGR_ID "관리자 사번", BONUS_PCT 보너스포인트
FROM EMPLOYEE
WHERE HIRE_DATE > '82/01/01'
AND JOB_ID LIKE 'J3';
--3. 직급코드 J4가 아닌 직원들의 급여 , 보너스포인트가 적용된 연봉 조회
--보너스포인트가 NULL이면 0으로 바꾸어 계산
SELECT EMP_ID 사번, EMP_NAME 사원명, JOB_ID 직급코드,
        SALARY 급여, (SALARY + (SALARY * NVL(BONUS_PCT,0)))*12 || '(원)'
FROM EMPLOYEE
WHERE JOB_ID NOT LIKE 'J4';

--4. 0.1이상 0.2 이하
SELECT EMP_ID 사번, EMP_NAME 사원명, EMAIL 이메일, SALARY 급여, BONUS_PCT 보너스포인트
FROM EMPLOYEE
WHERE BONUS_PCT BETWEEN 0.1 AND 0.2 ;

--5. 보너스포인트 0.1보다 작거나 0.2 보다 많은 
SELECT EMP_ID 사번, EMP_NAME 사원명, BONUS_PCT 보너스포인트,
    SALARY 급여, HIRE_DATE 입사일
FROM EMPLOYEE
WHERE BONUS_PCT < 0.1 
AND BONUS_PCT > 0.2;

--6. 1982-01-01 이후 입사
SELECT EMP_NAME 사원명, BONUS_PCT 보너스포인트, SALARY 급여
FROM EMPLOYEE
WHERE HIRE_DATE >= '82/01/01';

--7. 보너스 포인트가 0.1, 0.2 인 조회
SELECT EMP_ID 사번, EMP_NAME 사원명, BONUS_PCT 보너스포인트, PHONE 전화번호
FROM EMPLOYEE
WHERE BONUS_PCT IN (0.1, 0.2);

--8.보너스 포인트가 0.1, 0.2도 아닌 조회
SELECT EMP_ID 사번, EMP_NAME 사원명, BONUS_PCT 보너스포인트, EMP_NO 주민번호
FROM EMPLOYEE
WHERE BONUS_PCT NOT LIKE 0.1
AND BONUS_PCT NOT LIKE 0.2;

--9. 성이 이씨 
SELECT EMP_ID 사번, EMP_NAME 사원명, HIRE_DATE 입사일
FROM EMPLOYEE
WHERE EMP_NAME LIKE '이%';

--10. 주민번호 8번째 값이 2
SELECT EMP_ID 사번, EMP_NAME 사원명, EMP_NO 주민번호, SALARY 급여
FROM EMPLOYEE
WHERE EMP_NO LIKE '_______2%'
ORDER BY SALARY DESC;

--전체 평균을 구하고 비교하는 방법
SELECT ROUND(AVG(SALARY),2)
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > 2961818.18;

--서브쿼리를 사용해 전체 연봉 평균보다 많이 받는 사원
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);

--단일행 함수 그룹함수는 select절에 함께 사용 못함
SELECT UPPER(EMAIL) 
FROM EMPLOYEE;

--단일행 함수 LENGTH() 글자 개수를 반환
SELECT LENGTH('ORACLE'), LENGTH('오라클')
FROM DUAL;

SELECT EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;

SELECT INSTR('ORCLEDATABASE', 'T')
FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '@')
FROM EMPLOYEE;

SELECT EMAIL, INSTR(EMAIL, 'k', -1, 3)
FROM EMPLOYEE;

--함수 중첩가능 함수안에 함수 사용
--이메일 '.' 문자 바로 뒤에 있는 'c' 문자의 위치를 조회
--단 '.' 문자 바로 앞글자 부터 검색 
SELECT EMAIL, INSTR(EMAIL, 'c', INSTR(EMAIL, '.') -1)
FROM EMPLOYEE;

--LPAD, RPAD
--LPAD('문자열리터럴'|컬럼명, 출력할 너비글자 수, 남은영역에 채울 문자)
--세번째 인자인 채울문자가 생략 되면 기본 값은 공백문자 ' ' 로 채워진다
--LPAD : 왼쪽에 채우기, RPAD : 오른쪽에 채우기
SELECT EMAIL 기본,
        LENGTH(EMAIL) 원본글자수,
        LPAD(EMAIL, 20, '#') 채우기결과,
        LENGTH(LPAD(EMAIL, 20, '#'))
FROM EMPLOYEE;

SELECT EMAIL 기본,
        LENGTH(EMAIL) 원본글자수,
        RPAD(EMAIL, 20, '#') 채우기결과,
        LENGTH(RPAD(EMAIL, 20, '#'))
FROM EMPLOYEE;



