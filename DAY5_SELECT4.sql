-- DAY5_SELECT4

-- 날짜 데이터 비교연산시 주의사항 : 
-- 사번이 '100'인 직원의 이름과 입사일 조회
-- 입사일은 출력 포멧을 지정함 : '2021-10-08 오후 14:25:30'
SELECT EMP_NAME 이름, 
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD AM HH24:MI:SS') 입사일
FROM EMPLOYEE
WHERE EMP_ID = '100';  -- 입사일에 날짜와 시간이 같이 기록된 상태임

-- 다른 직원들의 입사일 데이터 확인
SELECT EMP_NAME 이름, 
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD AM HH24:MI:SS') 입사일
FROM EMPLOYEE;  -- 다른 직원들의 입사일은 날짜만 기록된 상태임

-- 날짜와 시간이 같이 기록된 경우에는 비교연산시 날짜만 가지고 비교할 수 없음
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
--WHERE EMP_ID = '100';
WHERE HIRE_DATE = '90/04/01';  -- 결과가 나오지 않음
-- '90/04/01 13:30:30' = '90/04/01'  FALSE 임

-- 해결방법 1
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'YY/MM/DD') = '90/04/01';
-- 해결방법 2
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE LIKE '90/04/01%';
-- 해결방법 3
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE SUBSTR(HIRE_DATE, 1, 8) = '90/04/01';

-- TO_DATE() 함수 --------------------------------------------------
-- 사용형식 : TO_DATE('문자리터럴' | 문자형식으로 기록된 컬럼명, '문자 각자리별 적용포멧')
-- 주의 : 문자의 글자수와 포멧문자 글자수가 일치해야 함
-- TO_CHAR() 의 포멧(출력형식)과 의미가 다름
-- TO_DATE() 의 포멧은 글자 각각이 날짜 무엇으로 바뀌는지를 지정하는 역할을 함

SELECT TO_DATE( '20100101', 'YYYYMMDD') 
FROM DUAL;  -- DATE 형으로 변환되면 '10/01/01' 로 표현됨

SELECT TO_CHAR( '20100101', 'YYYY, MON') 
FROM DUAL;  -- 에러 : '20100101' 은 DATE 형이 아님. TO_CHAR() 로 포멧 적용할 수 없음
-- TO_CHAR(NUMBER TYPE | DATE TYPE, 'FORMAT') 사용임.

-- 해결방법 : 문자형을 날짜형으로 바꾼 다음 포멧 적용함
SELECT TO_CHAR( TO_DATE( '20100101', 'YYYYMMDD'), 'YYYY, MON') 
FROM DUAL;

SELECT TO_DATE( '041030 143000', 'YYMMDD HH24MISS' ) 
FROM DUAL;  -- 시간에 대한 포멧을 12시간제이면 HH, 24시간제이면 HH24로 지정함, 포멧은 공백도 맞추어야 함

SELECT TO_CHAR( TO_DATE( '041030 143000', 'YYMMDD HH24MISS' ), 'DD-MON-YY HH:MI:SS PM' ) 
FROM DUAL;  -- 글자의 공백자리도 맞추어야 함

SELECT TO_DATE( '980630', 'YYMMDD' ) 
FROM DUAL;

SELECT TO_CHAR( TO_DATE( '980630', 'YYMMDD' ), 'YYYY.MM.DD') 
FROM DUAL;

-- 날짜로 변환시 주의사항 : 날짜나 시간 범위 안에 값일 때만 DATE 형으로 바뀜
SELECT TO_DATE('20221235', 'YYYYMMDD')
FROM DUAL;  -- 에러 : 35일은 없는 값이므로...

-- 2022년 10월 9일의 요일은?
SELECT TO_CHAR(TO_DATE('20221009', 'YYYYMMDD'), 'DY')
FROM DUAL;

-- 데이터베이스 날짜 포멧과 같은 문자값일 때는 TO_DATE() 에서 FORMAT 생략해도 됨
SELECT TO_CHAR(TO_DATE('22/10/09'), 'DY')
FROM DUAL;

-- 년도 변환에 RR 과 YY 사용의 차이  ------------------------------------------------------------------
-- 두자리 년도를 네자리 년도로 바꿀 때
-- 현재 년도 21년도(50보다 작음) 일 때
-- 바꿀 년도가 50미만이면 2000년도가 적용
-- 바꿀 년도가 50이상이면 1900년도가 적용

SELECT HIRE_DATE, 
        TO_CHAR(HIRE_DATE, 'RRRR'),
        TO_CHAR(HIRE_DATE, 'YYYY')
FROM EMPLOYEE;

-- 현재 년도와 바꿀 년도가 둘 다 50미만이면, Y | R 아무거나 사용해도 됨
SELECT TO_CHAR(TO_DATE('160505', 'YYMMDD'), 'YYYY-MM-DD'),
        TO_CHAR(TO_DATE('160505', 'RRMMDD'), 'RRRR-MM-DD'),
        TO_CHAR(TO_DATE('160505', 'RRMMDD'), 'YYYY-MM-DD'),
        TO_CHAR(TO_DATE('160505', 'YYMMDD'), 'RRRR-MM-DD')
FROM DUAL;

-- 현재 년도가 50미만이고, 바꿀 년도가 50이상일 때
-- TO_DATE() 에서 년도를 바꿀 때 Y 사용시 현재 세기 2000년도 적용됨
-- R 사용하면 이전세기 1900년도가 적용됨
SELECT TO_CHAR(TO_DATE('970320', 'YYMMDD'), 'YYYY-MM-DD'),  -- 2000년 적용
        TO_CHAR(TO_DATE('970320', 'RRMMDD'), 'RRRR-MM-DD'), -- 1900년 적용
        TO_CHAR(TO_DATE('970320', 'RRMMDD'), 'YYYY-MM-DD'), -- 1900년 적용
        TO_CHAR(TO_DATE('970320', 'YYMMDD'), 'RRRR-MM-DD')  -- 2000년 적용
FROM DUAL;

-- 결론 : 문자를 날짜로 바꿀 때 년도에 'R' 사용하면 됨
-- 2자리에서 4자리로 변경은 아무거나 사용하면 됨

-- TO_NUMBER('문자형 숫자') ---------------------------------------
-- 문자형숫자를 숫자(NUMBER) 로 바꿈
SELECT EMP_NAME, EMP_NO,
        SUBSTR(EMP_NO,1,6)AS 앞부분,
        SUBSTR(EMP_NO,8) AS 뒷부분,
        TO_NUMBER( SUBSTR(EMP_NO,1,6) ) + TO_NUMBER( SUBSTR(EMP_NO,8) ) AS 결과
FROM EMPLOYEE
WHERE EMP_ID = '101';

-- 기타함수 ************************************************************
-- NVL() 함수
-- 사용형식 : NVL(컬럼명, 컬럼값이 NULL일 때 바꿀 값)
SELECT EMP_NAME, BONUS_PCT, DEPT_ID, JOB_ID
FROM EMPLOYEE;

SELECT EMP_NAME,
        NVL(BONUS_PCT, 0.0),
        NVL(DEPT_ID, '00'),
        NVL(JOB_ID, 'J0')
FROM EMPLOYEE;

-- NVL2() 함수  -----------------------------------------------------------------------------
-- 사용형식 : NVL2(컬럼명, 바꿀값1, 바꿀값2)
-- 해당 컬럼에 값이 있으면 바꿀값1로 변경하고, NULL이면 바꿀값2로 변경하는 함수임

-- 직원 정보에서 보너스포인트가 0.2 미만이거나 NULL 인 직원들을 조회함
-- 사번, 이름, 보너스포인트, 변경보너스포인트(별칭 처리)
-- 변경보너스포인트는 보너스포인트 컬럼에 값이 있으면 0.15로 바꾸고, 없으면 0.05로 바꿈
SELECT EMP_ID 사번, EMP_NAME 이름, BONUS_PCT 보너스포인트,
        NVL2(BONUS_PCT, 0.15, 0.05) 변경보너스포인트
FROM EMPLOYEE
WHERE BONUS_PCT < 0.2 OR BONUS_PCT IS NULL;

-- DECODE() 함수 ---------------------------------------------------------------------------------
-- 사용형식 : DECODE(계산식 | 컬럼명, 값1제시, 선택값1, 값2제시, 선택값2, ...........[, 제시된 값이 모두 아닐 때 선택값])
-- 프로그래밍의 switch 문과 같은 동작 방식임.

-- 50번 부서에 소속된 직원들의 이름과 성별 조회
-- 성별 기준 : 주민번호 8번째 값이 1, 3이면 남자, 2, 4이면 여자로 출력 처리
SELECT EMP_NAME 이름, 
        DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남자', '2', '여자', '3', '남자', '4', '여자') 성별
FROM EMPLOYEE
WHERE DEPT_ID = '50';

-- DECODE 에 DEFAULT 값 사용
SELECT EMP_NAME 이름, 
        DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남자', '3', '남자', '여자') 성별
FROM EMPLOYEE
WHERE DEPT_ID = '50';

-- 직원 이름과 해당 직원의 관리자의 사번을 조회
SELECT EMP_NAME, MGR_ID
FROM EMPLOYEE;

-- 관리자사번이 NULL 이면 '000' 로 바꿈
-- 1. NVL() 사용
SELECT EMP_NAME, NVL(MGR_ID, '000')
FROM EMPLOYEE;
-- 2. DECODE() 사용
SELECT EMP_NAME, DECODE(MGR_ID, NULL, '000', MGR_ID)
FROM EMPLOYEE;

-- 직급별 급여 인상분이 다를 때
-- 1. DECODE() 사용한 경우
SELECT EMP_NAME, JOB_ID, SALARY,
        TO_CHAR(DECODE(JOB_ID, 
                        'J7', SALARY * 1.1,
                        'J6', SALARY * 1.15,
                        'J5', SALARY * 1.2,
                        SALARY * 1.05), 'L99,999,999') 인상급여
FROM EMPLOYEE;

-- 2. CASE 표현식은 다중 if문과 같은 동작 구조를 가짐
-- PL-SQL 구문임.
SELECT EMP_NAME, JOB_ID, SALARY,
        CASE JOB_ID
            WHEN 'J7' THEN SALARY * 1.1
            WHEN 'J6' THEN SALARY * 1.15
            WHEN 'J5' THEN SALARY * 1.2
            ELSE SALARY * 1.05
        END 인상급여
FROM EMPLOYEE;

-- CASE 표현식을 다중 if문처럼  사용할 수도 있음
-- 직원의 급여를 등급 구분 조회
SELECT EMP_ID, EMP_NAME, SALARY,
        CASE WHEN SALARY <= 3000000 THEN '초급'
              WHEN SALARY <= 4000000 THEN '중급'
              ELSE '고급'
        END 구분
FROM EMPLOYEE
ORDER BY 구분; -- 오름차순정렬 처리함


--함수 연습문제 *****************************************************************************
--
--1. 직원명과 주민번호를 조회함
--  단, 주민번호 9번째 자리부터 끝까지는 '*'문자로 채움
--  예 : 홍길동 771120-1******

SELECT EMP_NAME 직원명, 
        RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') 주민번호
FROM EMPLOYEE;

--2. 직원명, 직급코드, 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
--     연봉은 보너스포인트가 적용된 1년치 급여임
 
SELECT EMP_NAME 직원명, NVL(DEPT_ID, '없음') 직급코드, 
        TO_CHAR(SALARY * 12, 'L999,999,999') "연봉(원)"
FROM EMPLOYEE;
 
--3. 부서코드가 50, 90인 직원들 중에서 2004년도에 입사한 직원 조회함.
--	사번 사원명 부서코드 입사일

SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_ID 부서코드, HIRE_DATE 입사일
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90') AND HIRE_DATE LIKE '04/%';

--4. 직원명, 입사일, 입사한 달의 근무일수 조회
--  단, 주말도 포함함

SELECT EMP_NAME 직원명, HIRE_DATE 입사일, 
        LAST_DAY(HIRE_DATE) - HIRE_DATE "입사한 달의 근무일수"
FROM EMPLOYEE;

--5. 직원명, 부서코드, 생년월일, 나이(만) 조회
--  단, 생년월일은 주민번호에서 추출해서, 
--     ㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 함.
--  나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음, 계산함

SELECT EMP_NAME 직원명, DEPT_ID 부서코드,
		SUBSTR(EMP_NO, 1, 2) || '년' || SUBSTR(EMP_NO, 3,2) || '월' || SUBSTR(EMP_NO, 5,2) || '일' 생년월일,
		EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) "나이(만)"
FROM EMPLOYEE;

--6. 직원들의 입사일로 부터 년도만 가지고, 각 년도별 입사인원수를 구하시오.
--  아래의 년도에 입사한 인원수를 조회하시오.
--  => to_char, decode, sum 사용
--
--	-------------------------------------------------------------
--	전체직원수   2001년   2002년   2003년   2004년
--	-------------------------------------------------------------

SELECT COUNT(*) 전체직원수,
		SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), 2001, 1, 0)) "2001년",
        SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), 2002, 1, 0)) "2002년",
        SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), 2003, 1, 0)) "2003년",
        SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), 2004, 1, 0)) "2004년"
FROM EMPLOYEE;

--7.  부서코드가 50이면 총무부, 60이면 기획부, 90이면 영업부로 처리하시오.
--   단, 부서코드가 50, 60, 90 인 직원의 정보만 조회함
--  => case 사용
--	부서코드 기준 오름차순 정렬함.
-- 부서코드, 부서명(별칭 처리)

SELECT DEPT_ID 부서코드, 
        CASE DEPT_ID WHEN '50' THEN '총무부'
                    WHEN '60' THEN '기획부'
                    WHEN '90' THEN '영업부' 
        END AS "부서명"
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '60', '90') 
ORDER BY DEPT_ID ASC;






















