-- DAY3. SELECT 2

-- 연습 1 : 
-- 급여가 2백만이상 4백만이하인 직원의
-- 사번, 이름, 급여, 직급코드, 부서코드 조회
-- 별칭 사용
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 급여, JOB_ID 직급코드, DEPT_ID 부서코드
FROM EMPLOYEE
WHERE SALARY >= 2000000 AND SALARY <= 4000000;

-- 연습 2 : 
-- 입사일이 1995년 1월 1일부터 2000년 12월 31일 사이에 입사한 직원의
-- 사번, 이름, 입사일, 부서코드 조회
-- 별칭 사용
-- 날짜 데이터는 기록된 포멧과 일치되게 작성하면 됨
-- 작은 따옴표으로 묶어서 표현함 : '1995/01/01' 또는 '95/01/01'
SELECT EMP_ID 사번, EMP_NAME 이름, HIRE_DATE 입사일, DEPT_ID 부서코드
FROM EMPLOYEE
WHERE HIRE_DATE >= '95/01/01' AND HIRE_DATE <= '00/12/31';

-- 연결 연산자 : || (자바의 println("출력메세지" + 출력값) 목적의 연산자임)
-- SELECT 절에서 조회한 컬럼값들의 연결 처리를 해서 하나의 문장을 만들거나
-- 컬럼값 뒤에 단위 등을 표시할 때 이용할 수 있음
SELECT EMP_NAME || ' 직원의 급여는 ' || SALARY || '원 입니다.' AS 급여정보
FROM EMPLOYEE
WHERE DEPT_ID = '90';

-- 연습 3 : 
-- 2000년 1월 1일 이후에 입사한 기혼인 직원의
-- 이름, 입사일, 직급코드, 부서코드, 급여, 결혼여부 조회
-- 별칭 사용
-- 입사날짜 뒤에 ' 입사' 문자 연결 출력함
-- 급여값 뒤에는 '(원)' 문자 연결 출력함
-- 결혼여부 는 리터럴 사용함 : '기혼' 으로 채움
SELECT EMP_NAME 이름, HIRE_DATE || ' 입사' 입사일, JOB_ID 직급코드, DEPT_ID 부서코드, 
        SALARY || '(원)' 급여, '기혼' 결혼여부
FROM EMPLOYEE
WHERE HIRE_DATE >= '00/01/01' AND MARRIAGE = 'Y';

-- BETWEEN AND 연산자
-- WHERE 컬럼명 BETWEEN 작은값 AND 큰값
-- 컬럼의 값이 작은값 이상이면서 큰값이하인 행들을 골라라. 라는 의미임.
-- WHERE 컬럼명 >= 작은값 AND 컬럼명 <= 큰값  과 같은 의미의 연산자임.

SELECT EMP_NAME 이름, SALARY 급여
FROM EMPLOYEE
--WHERE SALARY >= 3500000 AND SALARY <= 5500000;
WHERE SALARY BETWEEN 3500000 AND 5500000;

SELECT EMP_ID 사번, EMP_NAME 이름, HIRE_DATE 입사일, DEPT_ID 부서코드
FROM EMPLOYEE
--WHERE HIRE_DATE >= '95/01/01' AND HIRE_DATE <= '00/12/31';
WHERE HIRE_DATE BETWEEN '95/01/01' AND '00/12/31';

-- LIKE 연산자
-- 문자열값에 대한 패턴을 제시해서, 패턴과 일치하는 문자열을 골라낼 때 사용하는 연산자임.
-- WHERE 컬럼명 LIKE '문자패턴'
-- 문자패턴에 와일드카드 문자 사용함 : % (0개이상의 글자), _ (글자 한자리)

-- 성이 김씨인 직원 정보 조회
-- 사번, 이름, 주민번호, 전화번호 : 별칭 적용
SELECT EMP_ID 사번, EMP_NAME 이름, EMP_NO 주민번호, PHONE 전화번호
FROM EMPLOYEE
WHERE EMP_NAME LIKE '김%';

-- 직원 이름에 '해' 자가 포함되어 있는 직원 정보 조회
-- 이름, 주민번호, 전화번호, 결혼여부 : 별칭 적용
SELECT EMP_NAME 이름, EMP_NO 주민번호, PHONE 전화번호, MARRIAGE 결혼여부
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%해%';

-- 전화번호의 국번(4번째 자리값)이 '9'로 시작하는 직원 정보 조회
-- 이름, 전화번호 : 별칭 적용
SELECT EMP_NAME 이름, PHONE 전화번호
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- 연습 : 
-- 성별이 여자인 직원 조회
-- 주민번호 8번째 문자가 1이면 남자, 2이면 여자임.
-- 사번, 이름, 주민번호, 전화번호 : 별칭 조회
SELECT EMP_ID 사번, EMP_NAME 이름, EMP_NO 주민번호, PHONE 전화번호
FROM EMPLOYEE
WHERE EMP_NO LIKE '_______2%';

-- 이메일에서 아이디 부분의 값 중에서 기록된 '_' 앞 글자가 3글자로 구성된 직원 정보 조회
-- 이름, 이메일
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
--WHERE EMAIL LIKE '____%';
WHERE EMAIL LIKE '___\_%' ESCAPE '\';
-- 기록값인 '_'와 와일드카드 '_' 가 구분이 안 됨 => 와일드카드 '_'로 해석됨
-- 기록값을 구분하기 위해서 ESCAPE OPTION 을 사용하면 됨
-- 기록문자 앞에 기호를 하나 표시함
-- '문자패턴기호기록문자' ESCAPE '기호'

-- NOT LIKE 
-- 성별이 남자인 직원 조회
-- 주민번호 8번째 문자가 1이면 남자, 2이면 여자임.
-- 사번, 이름, 주민번호, 전화번호 : 별칭 조회
SELECT EMP_ID 사번, EMP_NAME 이름, EMP_NO 주민번호, PHONE 전화번호
FROM EMPLOYEE
--WHERE EMP_NO LIKE '_______2%';
--WHERE EMP_NO NOT LIKE '_______2%';
WHERE NOT EMP_NO LIKE '_______2%';

-- IS NULL 연산자
-- WHERE 컬럼명 IS NULL
-- 해당 컬럼에 값이 없는 행들을 골라라. 의 의미임
-- 컬럼명 = NULL : 에러임

-- 부서도 직급도 배정받지 못한 직원 조회
-- 사번, 이름, 직급코드, 부서코드
SELECT EMP_ID, EMP_NAME, JOB_ID, DEPT_ID
FROM EMPLOYEE
WHERE DEPT_ID IS NULL AND JOB_ID IS NULL;
--WHERE DEPT_ID = NULL;  -- 결과가 안 나오는 에러임.

-- 보너스포인트가 없는 직원 조회
-- 사번, 이름, 부서코드, 보너스포인트
SELECT EMP_ID, EMP_NAME, DEPT_ID, BONUS_PCT
FROM EMPLOYEE
WHERE BONUS_PCT IS NULL OR BONUS_PCT = 0.0;

-- IS NOT NULL 연산자
-- WHERE 컬럼명 IS NOT NULL
-- 컬럼에 값이 기록된 (널이 아닌) 의미임

-- 부서는 배정받지 않았는데, 관리자는 있는 직원 조회
-- 사번, 이름, 관리자사번, 부서코드
SELECT EMP_ID, EMP_NAME, MGR_ID, DEPT_ID
FROM EMPLOYEE
WHERE DEPT_ID IS NULL AND MGR_ID IS NOT NULL;  -- 0 개

-- 부서도 없고 관리자도 없는 직원
SELECT EMP_ID, EMP_NAME, MGR_ID, DEPT_ID
FROM EMPLOYEE
WHERE DEPT_ID IS NULL AND MGR_ID IS NULL;

-- 부서는 없는데 보너스포인트는 받는 직원 조회
-- 사번, 이름, 보너스포인트, 부서코드
SELECT EMP_ID, EMP_NAME, BONUS_PCT, DEPT_ID
FROM EMPLOYEE
WHERE DEPT_ID IS NULL AND BONUS_PCT IS NOT NULL;

-- IN 연산자
-- WHERE 컬럼명 IN (비교값1, 비교값2, ....)
-- WHERE 컬럼명 = 비교값1 OR 컬럼명 = 비교값2 OR .....

-- 90 또는 20번 부서에 근무하는 직원 조회
SELECT *
FROM EMPLOYEE
--WHERE DEPT_ID = '90' OR DEPT_ID = '20';
WHERE DEPT_ID IN ('90', '20');

-- 연산자 우선 순위에 따라 계산됨
-- 60, 90번 부서에 소속된 직원들 중 급여 300만 보다 많이 받는 직원 조회
-- 사번, 부서코드, 급여
SELECT EMP_ID, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE DEPT_ID = '60' OR DEPT_ID = '90'
AND SALARY > 3000000;  -- AND 가 OR 보다 우선순위가 높음. 결과가 틀렸음.

-- 해결 : () 를 묶어서 해결
SELECT EMP_ID, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE (DEPT_ID = '60' OR DEPT_ID = '90')
AND SALARY > 3000000; 

-- 해결 : IN 연산자 사용
SELECT EMP_ID, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE DEPT_ID IN ('60', '90')
AND SALARY > 3000000; 

-- **************************************************************************
--SELECT 연습문제
--
--1. 부서코드가 90이면서, 직급코드가 J2인 직원들의 사번, 이름, 부서코드, 직급코드, 급여 조회함
--   별칭 적용함
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_ID 부서코드, JOB_ID 직급코드, SALARY 급여
FROM EMPLOYEE
WHERE DEPT_ID = '90' AND JOB_ID = 'J2';

--2. 입사일이 '1982-01-01' 이후이거나, 직급코드가 J3 인 직원들의 사번, 이름, 관리자 사번, 보너스포인트 조회함
SELECT EMP_ID 사번, EMP_NAME 이름, MGR_ID 관리자사번, BONUS_PCT 보너스포인트
FROM EMPLOYEE
WHERE HIRE_DATE >= '82/01/01' OR JOB_ID = 'J3';

--3. 직급코드가 J4가 아닌 직원들의 급여와 보너스포인트가 적용된 연봉을 조회함.
--  별칭 적용함, 사번, 사원명, 직급코드, 연봉(원)
--  단, 보너스포인트가 null 일 때는 0으로 바꾸어 계산하도록 함.
SELECT EMP_ID 사번, EMP_NAME 사원명, JOB_ID 직급코드, 
        (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 || ' (원)' 연봉
FROM EMPLOYEE
WHERE JOB_ID != 'J4';

--4. 보너스포인트가 0.1 이상 0.2 이하인 직원들의 사번, 사원명, 이메일, 급여, 보너스포인트 조회함
SELECT EMP_ID 사번, EMP_NAME 사원명, EMAIL 이메일, SALARY 급여, BONUS_PCT 보너스포인트
FROM EMPLOYEE
WHERE BONUS_PCT BETWEEN 0.1 AND 0.2;
-- WHERE BONUS_PCT >= 0.1 AND BONUS_PCT <= 0.2;

--5. 보너스포인트가 0.1 보다 작거나(미만), 0.2 보다 많은(초과) 직원들의 사번, 사원명, 보너스포인트, 급여, 입사일 조회함
SELECT EMP_ID 사번, EMP_NAME 사원명, EMAIL 이메일, SALARY 급여, BONUS_PCT 보너스포인트
FROM EMPLOYEE
WHERE BONUS_PCT NOT BETWEEN 0.1 AND 0.2;

--6. '1982-01-01' 이후에 입사한 직원들의 사원명, 보너스포인트, 급여 조회함
SELECT EMP_NAME 이름, BONUS_PCT 보너스포인트, SALARY 급여
FROM EMPLOYEE
WHERE HIRE_DATE >= '82/01/01';

--7. 보너스포인트가 0.1, 0.2 인 직원들의 사번, 사원명, 보너스포인트, 전화번호 조회함
SELECT EMP_ID 사번, EMP_NAME 이름, BONUS_PCT 보너스포인트, PHONE 전화번호
FROM EMPLOYEE
WHERE BONUS_PCT IN (0.1, 0.2);

--8. 보너스포인트가 0.1도 0.2도 아닌 직원들의 사번, 사원명, 보너스포인트, 주민번호 조회함
SELECT EMP_ID 사번, EMP_NAME 이름, BONUS_PCT 보너스포인트, PHONE 전화번호
FROM EMPLOYEE
WHERE BONUS_PCT NOT IN (0.1, 0.2);

--9. 성이 '이'씨인 직원들의 사번, 사원명, 입사일 조회함
--  단, 입사일 기준 오름차순 정렬함
SELECT EMP_ID 사번, EMP_NAME 사원명, HIRE_DATE 입사일
FROM EMPLOYEE
WHERE EMP_NAME LIKE '이%'
ORDER BY HIRE_DATE ASC;

--10. 주민번호 8번째 값이 '2'인 직원의 사번, 사원명, 주민번호, 급여를 조회함
--  단, 급여 기준 내림차순 정렬함
SELECT EMP_ID 사번, EMP_NAME 사원명, EMP_NO 주민번호, SALARY 급여
FROM EMPLOYEE
WHERE EMP_NO LIKE '_______2%'
ORDER BY SALARY DESC;

-- **********************************************************************************
-- 함수 (FUNCTION)
-- 컬럼에 기록된 값을 읽어서 처리한 결과를 반환하는 형태임.
-- 함수명(컬럼명) 으로 사용함
-- 단일행 함수와 그룹함수로 구분됨.
-- 단일행 함수 : 읽은 값이 N개이면, 반환값도 N개임
-- 그룹 함수 : 읽은 값이 N개이면 반환값은 1개임

-- 그룹함수 : SUM, AVG, MAX, MIN, COUNT

-- SUM(컬럼명) | SUM(DISTINCT 컬럼명)
-- 컬럼에 기록된 값들의 합계를 구해서 리턴함

-- 소속부서가 '50'이거나 부서가 배정되지 않은 직원들의 급여 합계 조회
SELECT SUM(SALARY), SUM(DISTINCT SALARY)
FROM EMPLOYEE
WHERE DEPT_ID = '50' OR DEPT_ID IS NULL;

-- AVG(컬럼명) | AVG(DISTINCT 컬럼명)
-- 평균을 구해서 반환함

-- 소속부서가 50 또는 90 또는 NULL 인 직원들의 보너스 평균 조회
SELECT AVG(BONUS_PCT) 기본평균, -- /4
        AVG(DISTINCT BONUS_PCT) 중복제거평균, -- /3
        AVG(NVL(BONUS_PCT, 0)) NULL포함평균  -- /10
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90') OR DEPT_ID IS NULL;

-- MAX(컬럼명) | MAX(DISTINCT 컬럼명)
-- 컬럼에 기록된 값들 중 가장 큰 값을 리턴함
-- MIN(컬럼명) | MIN(DISTINCT 컬럼명)
-- 컬럼에 기록된 값들 중 가장 작은 값을 리턴함
-- 문자형(CHAR, VARCHAR2, LONG, CLOB), 숫자형(NUMBER), 날짜형(DATE) : 모든 자료형에 사용할 수 있음

-- 부서코드가 50 또는 90인 직원들의 직급코드의 최대값, 최소값, 입사일의 최대값, 최소값, 급여의 최대값, 최소값을 조회
SELECT MAX(JOB_ID), MIN(JOB_ID),
        MAX(HIRE_DATE), MIN(HIRE_DATE),
        MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90');

-- COUNT(*) | COUNT(컬럼명) | COUNT(DISTINCT 컬럼명)
-- * : 테이블의 전체 행 갯수 반환함
-- 컬럼명 : NULL 을 제외한 기록값의 행갯수 반환함

SELECT COUNT(*), COUNT(DEPT_ID), COUNT(DISTINCT DEPT_ID)
FROM EMPLOYEE;

-- 50번 부서에 소속되었거나 부서가 배정되지 않은 직원 수 파악
SELECT COUNT(*), -- NULL 포함된 전체 행갯수
        COUNT(DEPT_ID) -- NULL 제외된 행갯수
FROM EMPLOYEE
WHERE DEPT_ID = '50' OR DEPT_ID IS NULL;

-- 그룹함수는 SELECT 절, HAVING 절에서만 사용할 수 있음.
-- 그룹함수는 WHERE 절에서는 사용 못 함 : WHERE 절이 한 행씩 조건 비교를 하기 때문임

-- 전 직원의 급여 평균보다 급여를 많이 받는 직원 정보 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > AVG(SALARY);  -- ERROR

-- 해결 1 : 급여 평균을 따로 구한 다음, 그 값을 WHERE 절에서 사용함
SELECT AVG(SALARY)
FROM EMPLOYEE;   -- 2961818.18181818181818181818181818181818

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > 2961818;

-- 해결 2 : 서브쿼리를 사용
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);

-- 단일행 함수와 그룹함수는 SELECT 절에 함께 사용 못 함
-- ORDB (Object Relational DataBase) : 객체 관계형 데이터베이스
-- 2차원 테이블 구조로 저장 데이터를 표현함. (사각형이어야 함)
SELECT UPPER(EMAIL), SUM(SALARY)   -- ERROR
FROM EMPLOYEE;

-- 단일행 함수 (SINGLE ROW FUNCTION) **************************************************

-- 문자열 함수 --------------------------------------------------------------------------------------------

-- LENGTH('문자열리터럴' | 문자가 기록된 컬럼명)
-- 글자 갯수를 반환함

SELECT LENGTH('ORACLE'), LENGTH('오라클')
FROM DUAL;
-- 테이블 참조없이 단순한 계산의 결과만 SELECT 하는 경우에 더미(DUMMY) 테이블을 FROM 절에 사용할 수 있음.
-- 오라클에서 제공함

SELECT 23 + 5 
FROM DUAL;

SELECT EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;

-- LENGTHB('문자열리터럴' | 문자가 기록된 컬럼명)
-- 기록 글자의 바이트 크기를 반환함
SELECT LENGTH('ORACLE'), LENGTHB('ORACLE'),
        LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL;
-- 컴퓨터에서는 한글은 기본 1글자가 2바이트임.
-- eXpress Edition 제품에서 한글 1글자를 3바이트 할당하고 있음.


-- INSTR('문자열리터럴' | 문자가 기록된 컬럼명, 찾을문자, 찾을 시작위치, 몇번째문자) 함수

-- 이메일에서 '@' 문자의 위치 조회
SELECT EMAIL, INSTR(EMAIL, '@')
FROM EMPLOYEE;

-- 이메일에서 '@'문자 바로 뒤에 있는 'k' 문자의 위치를 조회
-- 단, 뒤에서 검색한다면
SELECT EMAIL, INSTR(EMAIL, 'k', -1, 3)
FROM EMPLOYEE;

-- 함수 중첩 사용 가능함 : 함수 안에 함수 사용
-- 이메일에서 '.' 문자 바로 뒤에 있는 'c' 문자의 위치를 조회
-- 단, '.' 문자 바로 앞글자부터 검색 시작하도록 함
SELECT EMAIL, INSTR(EMAIL, 'c', INSTR(EMAIL, '.') - 1)
FROM EMPLOYEE;

-- LPAD('문자열리터럴' | 문자가 기록된 컬럼명, 출력할 너비 글자수, 남는영역 채울문자)
-- 채울문자가 생략되면 기본값은 ' ' (공백문자)임
-- LPAD() : 왼쪽 채우기, RPAD() : 오른쪽 채우기
SELECT EMAIL 원본, LENGTH(EMAIL) 원본글자수,
        LPAD(EMAIL, 20, '*') 채우기결과,
        LENGTH(LPAD(EMAIL, 20, '*')) 결과길이
FROM EMPLOYEE;

SELECT EMAIL 원본, LENGTH(EMAIL) 원본글자수,
        RPAD(EMAIL, 20, '*') 채우기결과,
        LENGTH(RPAD(EMAIL, 20, '*')) 결과길이
FROM EMPLOYEE;



