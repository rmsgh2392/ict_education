--LTRIM, RTRIM함수 사용 예
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

--TRIM(LEADING | TRAILING | BOTH '제거할 문자 하나!' FROM '문자리터럴' | 컬럼명)
--기본사항중 명시적으로 표시를 안하면 기본은 양쪽의 문자를 제거한다. (기본이 BOTH)
--제거할 문자! -> LTRIM과 RTRIM과 다른점!
SELECT 'aaORACLEaa',
       TRIM('a' FROM 'aaORACLEaa'),
       TRIM(LEADING 'a' FROM 'aaORACLEaa'),
       TRIM(TRAILING 'a' FROM 'aaORACLEaa'),
       TRIM(BOTH 'a' FROM 'aaORACLEaa')
FROM DUAL;

--SUBSTR() 사용 예
SELECT 'ORACLE 18EXPRESS',
        SUBSTR('ORACLE 18EXPRESS', 7),
        SUBSTR('ORACLE 18EXPRESS', 8, 2),
        SUBSTR('ORACLE 18EXPRESS', -11, 2)
FROM DUAL;

SELECT EMAIL, SUBSTR(EMAIL, 7)
FROM EMPLOYEE;

SELECT EMAIL, SUBSTR(EMAIL, -7, 3)
FROM EMPLOYEE;

SELECT EMP_NO 주민번호,
       SUBSTR(EMP_NO, 1, 2) || '년생',
       SUBSTR(EMP_NO, 3, 2) || '월',
       SUBSTR(EMP_NO, 5, 2) || '일',
       SUBSTR(EMP_NO, 8, 1) || '성별(1:남자, 2:여자)'
FROM EMPLOYEE;

--날짜데이터도 SUBSTR사용가능
SELECT HIRE_DATE, EMP_NAME,
       SUBSTR(HIRE_DATE, 1, 2) || '년' 입사년도,
       SUBSTR(HIRE_DATE, 4, 2) || '월' 입사월,
       SUBSTR(HIRE_DATE, 7, 2) || '일' 입사일
FROM EMPLOYEE;

SELECT ROUND(125.3131, -1)
FROM DUAL;

SELECT SUBSTR('ORACLE', 3, 2),
        SUBSTRB('ORACLE', 3, 2),
        SUBSTR('오라클', 2, 2),
        SUBSTRB('오라클', 4, 6)
FROM DUAL;

--함수 중첩 사용 :  함수안에 함수를 사용할 수 있음
SELECT EMP_NAME 이름, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) 아이디 
FROM EMPLOYEE;

SELECT EMP_NAME 이름, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') 주민번호
FROM EMPLOYEE; --14숫자 자리에 LENGTH(EMP_NO)로도 대체 가능하다.

SELECT EMP_NAME, EMAIL,
        LPAD(SUBSTR(EMP_NO, 7, 14), 14, '*')
FROM EMPLOYEE;

SELECT EMAIL, RTRIM(EMAIL, '@kcom.')
FROM EMPLOYEE;

SELECT 123.456,
        ROUND(123.456),
        ROUND(123.456, 1), --소수점 첫쨰짜리까지 표시하고 둘째자리부터 버려짐
        ROUND(123.456, 2),
        ROUND(123.456, -1)
FROM DUAL;

--연봉 천단위에서 반올림
SELECT EMP_ID, EMP_NAME, SALARY, BONUS_PCT,
       ROUND(((SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12), -4) "1년 급여"
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

--날짜연산도 가능하다.
SELECT SYSDATE - HIRE_DATE 근무일수,
        HIRE_DATE - SYSDATE 근무일수,
       ABS(FLOOR(HIRE_DATE - SYSDATE)) 근무일수,
       ABS(FLOOR(SYSDATE - HIRE_DATE)) 근무일수
FROM EMPLOYEE;

SELECT FLOOR(25 / 7) 몫, MOD(25, 7) 나머지
FROM DUAL;

SELECT EMP_ID, EMP_NAME  --EMP_ID는 문자타입인데 연산시 자동형변환을 해준다.
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) LIKE 1;

SELECT SYSDATE
FROM DUAL;

SELECT * 
FROM SYS.nls_session_parameters;

--날짜 포맷과 관련된 변수 값만 조회
SELECT VALUE
FROM SYS.NLS_SESSION_PARAMETERS
WHERE PARAMETER LIKE 'NLS_DATE_FORMAT';

--일부 설정값만 수정가능 그렇다면 날씨 포맷을 수정한다면.
--하지만 이렇게 함수로 포맷설정은 바꾸면 안된다 
--함수를 이용해서 바꾼다.
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
-- 오늘날짜 10년뒤 날짜는?
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 120)
FROM DUAL;

SELECT EMP_ID 사번, EMP_NAME 이름,
       HIRE_DATE 입사일, ADD_MONTHS(HIRE_DATE, 240) "20년 뒤날짜"
FROM EMPLOYEE;

--20년이상 근무한 사원들 조회
SELECT EMP_ID 사번, EMP_NAME 이름,
        DEPT_ID 부서코드, JOB_ID 직급코드,
        HIRE_DATE
FROM EMPLOYEE
WHERE ADD_MONTHS(HIRE_DATE, 240) < SYSDATE;

SELECT EMP_NAME 이름, HIRE_DATE 입사일,
       FLOOR(SYSDATE - HIRE_DATE) 근무일수,
       FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) 근무개월수,
       FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) 근무년수
FROM EMPLOYEE;

SELECT SYSDATE,  NEXT_DAY(SYSDATE, '일요일')
FROM DUAL;

SELECT SYSDATE, NEXT_DAY(SYSDATE, 'SUNDAY')
FROM DUAL; -- ERROR

ALTER SESSION
SET NLS_LANGUAGE = KOREAN; --영어로 바꾸고 싶으면 AMERICAN

SELECT LAST_DAY(SYSDATE)
FROM DUAL;

--입사한 달의 근무일수 조회
SELECT EMP_NAME 이름, HIRE_DATE 입사일,
       LAST_DAY(HIRE_DATE) - HIRE_DATE 근무일수
FROM EMPLOYEE;

SELECT SYSDATE, SYSTIMESTAMP,
       CURRENT_DATE, CURRENT_TIMESTAMP
FROM DUAL;

SELECT SYSDATE,
       EXTRACT(YEAR FROM SYSDATE) 년도,
       EXTRACT(MONTH FROM SYSDATE) 월,
       EXTRACT(DAY FROM SYSDATE) 일
FROM DUAL;

--직원의 이름 입사일 근무년수 조회
SELECT EMP_NAME, HIRE_DATE,
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 근무년수
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE,
       FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12 ) 근무년수 --만 근무년수
FROM EMPLOYEE;

-- 자동형변환은 굳이 형변환을 할 필요 없다
-- SELECT 25 + '12' FROM DUAL; (자동 형변환)
-- SELECT 25 + TO_NUMBER('12') FROM DUAL; (명시적 형변환)
-- 기본적으로 컴퓨터 CPU는 같은 종류의 타입을 가지고 계산한다.
-- 자동 형변환이 안되는 경우
-- SYSDATE - '15/01/03' ->(ERROR) DATE - CHAR : 자동형변환이 안됨 X
-- 그럼 명시적으로 형변환을 해줘야한다.
-- SYSDATE - TO_DATE('15/01/03') 주의! 형식은 00/00/00 맞춰줘야한다. 

SELECT EMP_ID, EMP_NAME,
        TO_CHAR(NVL(BONUS_PCT, 0), '90.00') 보너스포인트,
        TO_CHAR(SALARY, '99,999,999L') 급여 
FROM EMPLOYEE;
--9는 그 자리에 있으면 비우고 0을 써주면 0으로 채움
--09.999.999 => 결과 09,000,000 / 99.999.999 => 결과 9,000,000

--년월일, 시분초, 분기, 요일, 오전/오후등을 출력
SELECT HIRE_DATE,
        TO_CHAR(HIRE_DATE, 'YEAR-RM-fmDD'),
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') -- Y를 R로 표현할 수 있다.
FROM EMPLOYEE;

SELECT TO_CHAR(SYSDATE, 'Q"분기"'),
        TO_CHAR(SYSDATE, 'YYYY-MON-fmDD"일" PM HH:MI:SS')
FROM DUAL;
--년도에대한 포맷
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE, 'YEAR'),
       TO_CHAR(SYSDATE, ' YYYY"년" ')      
FROM DUAL;
--월에 대한 포맷
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'fmMM'),
       TO_CHAR(SYSDATE, 'RM')
FROM DUAL;
--날짜에대한 포맷
SELECT SYSDATE,
       TO_CHAR(SYSDATE, '"1년기준" DDD "일쨰"'),
       TO_CHAR(SYSDATE, '"월기준" DD "일째"'),
       TO_CHAR(SYSDATE, '"주기준" D "일째"')
FROM DUAL;
--요일 포맷
SELECT SYSDATE,
      TO_CHAR(SYSDATE, 'DAY'),
      TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

--이름 입사일 조회 / 입사일 포맷적용 : 2016년 05월 19일(목)
SELECT EMP_NAME || '님의 입사일은' || ' ' || TO_CHAR(HIRE_DATE,'YYYY"년" MONTH DD"일""("DY")"')
FROM EMPLOYEE;
