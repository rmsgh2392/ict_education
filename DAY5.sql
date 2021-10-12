--DECODE() IF-ELSE
--DECODE(expr, search, result [searchN, resultN], default)
SELECT EMP_NAME,
       DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여', '3', '남', '4', '여') 성별
              --expr               search  
FROM EMPLOYEE;
SELECT EMP_NAME,
       DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '3', '남', '여')
FROM EMPLOYEE;
SELECT EMP_ID, EMP_NAME,
        DECODE(MGR_ID, NULL, '없음', MGR_ID) 관리자,
        NVL(MGR_ID, '관리자번호X')
FROM EMPLOYEE;

SELECT EMP_NAME, MGR_ID,
       CASE MGR_ID WHEN NULL THEN '없음' ELSE MGR_ID END
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EMP_NO,
        CASE SUBSTR(EMP_NO, 8, 1)
            WHEN '1' THEN '남'
            WHEN '2' THEN '여'
            END
FROM EMPLOYEE;


SELECT EMP_NAME, JOB_ID, SALARY,
        TO_CHAR(DECODE(JOB_ID, 'J4', SALARY * 2,
                       'J7', SALARY * 1.2,
                       'J5', SALARY * 1.5,
                       SALARY * 0.5), '99,999,999L')
FROM EMPLOYEE;

SELECT EMP_NAME, JOB_ID, SALARY 급여,
       CASE JOB_ID
            WHEN 'J4' THEN TO_CHAR(SALARY * 1.5 , '99,999,999L')
            WHEN 'J2' THEN TO_CHAR(SALARY * 2, '99,999,999L')
            WHEN 'J5' THEN TO_CHAR(SALARY * 1.2, '99,999,999L')
            ELSE TO_CHAR(SALARY * 0.5, '99,999,999L') END 인상급여
FROM EMPLOYEE
WHERE JOB_ID IN('J4','J2','J5')
ORDER BY JOB_ID DESC;

SELECT EMP_ID, EMP_NAME,
        SALARY,
        CASE WHEN SALARY <= 2000000 THEN '신입'
              WHEN SALARY >= 5000000 THEN '경력자'
              ELSE '중급' END 계급
FROM EMPLOYEE;

SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL
GROUP BY DEPT_ID
ORDER BY DEPT_ID ASC;

SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남')
FROM EMPLOYEE;
----------------------------------------------------
--날짜 데이터 비교연산자 주의사항
SELECT EMP_NAME, HIRE_DATE,
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD PM HH24:MI:SS')
FROM EMPLOYEE
WHERE EMP_ID LIKE '100';

SELECT EMP_NAME, HIRE_DATE,
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD PM HH24:MI:SS')
FROM EMPLOYEE; --결과 한선기 뺴고 다른 직원들은 날짜만 기록되어 있다.

--날짜와 시간이 같이 기록된 경우 비교연산시 날짜만 가지고 비교할 수 없음
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
--WHERE EMP_ID LIKE '100';
WHERE HIRE_DATE LIKE '90/09/01'; --ERROR 결과 나오지 않음
--'90/04/01 13:30:31' 내부적으로(눈에 안보임) 저장되어 있어서 = '09/04/01' 맞지 않다.
--시간을 포함하는 날짜데이터는 비교연산이 안되고 시간까지 같이 기록해 비교해야함
--날짜데이터를 비교했을 때 FALSE가 나올 경우 눈에 안보이는 시간이 저장되어 있음을 주의!!
--해결방법
--1.
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'YY/MM/DD')  LIKE '90/04/01';
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'YYMMDD') LIKE '900401';
--2.
SELECT EMP_NAME
FROM EMPLOYEE
WHERE HIRE_DATE LIKE '90/04/01%'; 
--와일드 카드를 사용하여 90/04/01 뒤에 머가 나오든 상관없이 비교 
--3.
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE SUBSTR(HIRE_DATE, 1, 8) LIKE '90/04/01';

SELECT TO_DATE('20201030', 'YYYYMMDD')
FROM DUAL;
SELECT TO_CHAR('20100101', 'YYYY, MON')
FROM DUAL;
SELECT TO_CHAR(TO_DATE('20111222', 'YYYYMMDD'), 'YY"년"/MON')
FROM DUAL;
SELECT TO_DATE('041030 143030', 'YYMMDD HH24MISS')
FROM DUAL;
SELECT TO_CHAR(TO_DATE('041022 133030', 'YYMMDD HH24MISS'),
                'DD"일"-MON-YY"년" HH:MI:SS PM')
FROM DUAL;
SELECT TO_DATE('930429', 'YYMMDD')
FROM DUAL;
SELECT TO_CHAR(TO_DATE('020307', 'YYMMDD'), 'YYYY.MM.DD')
FROM DUAL;
SELECT EMP_NAME, 
        TO_CHAR(HIRE_DATE, 'YYYY"년".MON.fmDD"일"')
FROM EMPLOYEE;
--날짜 변환시 주의사항 : 날짜나 시간 범위 안에 값일 때만 DATE형으로 변환가능
SELECT TO_DATE('20161235', 'YYYYMMDD')
FROM DUAL;
--ERROR 12월 35일 이라는 날짜는 존재하지 않다 실제 달력에 표시되는 날짜만 허용
--시간도 실제 시간에 존재하지 않는 것을 입력하면 에러가 난다.

--2022년 10월 9일의 요일은???
SELECT TO_CHAR(TO_DATE('20221009', 'YYYYMMDD'), 'DAY')
FROM DUAL;
SELECT TO_CHAR(TO_DATE('2022/04/29'), 'DAY')
FROM DUAL;

SELECT HIRE_DATE,
        TO_CHAR(HIRE_DATE, 'RRRR'),
        TO_CHAR(HIRE_DATE, 'YYYY')
FROM EMPLOYEE;

SELECT TO_CHAR(TO_DATE('160505', 'YYMMDD'), 'RRRR'),
        TO_CHAR(TO_DATE('160505', 'RRMMDD'), 'YYYY'),
        TO_CHAR(TO_DATE('160505', 'RRMMDD'), 'YYYY'),
        TO_CHAR(TO_DATE('160505', 'YYMMDD'), 'RRRR')
FROM DUAL;

--현재 년도가 50미만이고 바꿀년도가 50이상일 때
--TO_DATE() 에서 년도를 바꿀 때 Y 사용시 현재 세기 2000년도 적용
--R사용하면 이전세기 1900년도 적용
SELECT TO_CHAR(TO_DATE('970505', 'YYMMDD'), 'RRRR'), --2000
        TO_CHAR(TO_DATE('970505', 'RRMMDD'), 'YYYY'), --1900
        TO_CHAR(TO_DATE('970505', 'RRMMDD'), 'YYYY'), --1900
        TO_CHAR(TO_DATE('970505', 'YYMMDD'), 'RRRR') --2000
FROM DUAL;
--결론: 문자를 날짜로 바꿀때 년도에 R 사용하면됨
-- 2자리에서 4자리로 변경은 아무거나 사용가능

SELECT EMP_NAME, EMP_NO,
        SUBSTR(EMP_NO, 1, 6) 앞부분,
        SUBSTR(EMP_NO, 8) 뒷부분,
        TO_NUMBER(SUBSTR(EMP_NO, 1, 6)) + TO_NUMBER(SUBSTR(EMP_NO, 8)) 결과
FROM EMPLOYEE
WHERE EMP_ID LIKE '101';
--기타함수------------------------
SELECT EMP_NAME, 
        NVL(BONUS_PCT, 0.0),
        NVL(DEPT_ID, '없음'),
        NVL(JOB_ID, 'X')
FROM EMPLOYEE;
--NVL2() 함수
--사용형식 : NVL2(컬럼명, 바꿀 값1, 바꿀 값2)
--해당컬럼에 값이 있으면 바꿀 값1로 변경하고
--NULL이면 바꿀 값 2로 변경한다.
SELECT EMP_ID 사번, EMP_NAME 이름,
        BONUS_PCT 보너스포인트,
        NVL2(BONUS_PCT, 0.15, 0.05) 변경보너스포인트
FROM EMPLOYEE
WHERE BONUS_PCT < 0.2 
OR BONUS_PCT IS NULL;

SELECT DEPT_ID || '번' 부서, EMP_NAME 이름, EMP_NO 주민번호,
        DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남성', '여성') 성별
FROM EMPLOYEE
WHERE DEPT_ID LIKE '50';

SELECT EMP_NAME 사원이름,
        MARRIAGE,
        DECODE(MARRIAGE, 'Y', '기혼', '미혼') 결혼여부
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, SALARY,
        CASE
            WHEN TOSALARY <= 3000000 THEN '초급'
            WHEN SALARY <= 4000000 THEN '중급'
            ELSE '고급'
        END 구분
FROM EMPLOYEE
ORDER BY 구분 ASC;
--=================================================================
--함수 연습문제
--
--1. 직원명과 주민번호를 조회함
--  단, 주민번호 9번째 자리부터 끝까지는 '*'문자로 채움
--  예 : 홍길동 771120-1******
    SELECT EMP_NAME 직원명, EMP_NO 주민번호,
            RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') "*로 처리된 주민"
    FROM EMPLOYEE;
--
--2. 직원명, 직급코드, 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
--     연봉은 보너스포인트가 적용된 1년치 급여임
    SELECT EMP_NAME 직원명, NVL(JOB_ID, '없음') 직급코드,
            TO_CHAR((SALARY + (SALARY * NVL(BONUS_PCT, 0)) * 12), 'L99,999,999') "연봉(원)" 
    FROM EMPLOYEE;

--3. 부서코드가 50, 90인 직원들 중에서 2004년도에 입사한 직원의 
--   수 조회함.
--	사번 사원명 부서코드 입사일
    SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_ID 부서명 
    FROM EMPLOYEE
    WHERE DEPT_ID IN ('50', '90')
    AND TO_CHAR(HIRE_DATE, 'YYYY') LIKE '2004';
    --LIKE '04%'도 가능

--4. 직원명, 입사일, 입사한 달의 근무일수 조회
--  단, 주말도 포함함
    SELECT EMP_NAME, HIRE_DATE,
            LAST_DAY(HIRE_DATE) - HIRE_DATE "입사한 달의 근무일수"
    FROM EMPLOYEE;

--5. 직원명, 부서코드, 생년월일, 나이(만) 조회
--  단, 생년월일은 주민번호에서 추출해서, 
--     ㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 함.
--  나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음, 계산함
    SELECT EMP_NAME 직원명, DEPT_ID 부서코드, 
            SUBSTR(EMP_NO, 1, 2) || '년' ||
            SUBSTR(EMP_NO, 4, 2) || '월' ||
            SUBSTR(EMP_NO, 7, 2) || '일' 생년월일,
            TO_CHAR(SYSDATE, 'RRRR') - TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'), 'RRRR') 나이
    FROM EMPLOYEE;
    
    SELECT EMP_NAME 이름, DEPT_ID 부서코드,
            SUBSTR(EMP_NO, 1, 2) || '년' || SUBSTR(EMP_NO, 3, 2) || '월' || SUBSTR(EMP_NO, 5, 2) || '일' 생년월일,
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) "나이(만)"
    FROM EMPLOYEE;
--6. 직원들의 입사일로 부터 년도만 가지고, 각 년도별 입사인원수를 구하시오.
--  아래의 년도에 입사한 인원수를 조회하시오.
--  => to_char, decode, sum 사용
-- 다시풀고 이해하기!!!!!
    SELECT COUNT(*) 전체직원수,
            SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '2001', 1, 0)) "2001년",
            SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '2001', 1, 0)) "2002년",
            SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '2001', 1, 0)) "2003년",
            SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '2001', 1, 0)) "2004년"
    FROM EMPLOYEE;
--	-------------------------------------------------------------
--	전체직원수   2001년   2002년   2003년   2004년
--	-------------------------------------------------------------


--7.  부서코드가 50이면 총무부, 60이면 기획부, 90이면 영업부로 처리하시오.
--   단, 부서코드가 50, 60, 90 인 직원의 정보만 조회함
--  => case 사용
--	부서코드 기준 오름차순 정렬함.
    SELECT DEPT_ID 부서코드, 
        CASE DEPT_ID
            WHEN '50' THEN '총무부'
            WHEN '60' THEN '기획부'
            WHEN '90' THEN '영업부'
            END
    FROM EMPLOYEE
    WHERE DEPT_ID IN ('50', '60', '90')
    ORDER BY 부서코드 ASC;
