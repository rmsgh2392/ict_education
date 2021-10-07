-- DAY4. SELECT3

-- 단일행 함수 계속 진행 ----------------------------

-- LTRIM('문자열리터럴' | 문자가 기록된 컬럼명, '제거할문자들')
-- 문자열의 왼쪽에 있는 문자를 제거함. (제거할 문자가 아닌 다른 문자가 있으면 TRIM 종료됨)
-- RTRIM('문자열리터럴' | 문자가 기록된 컬럼명, '제거할문자들')
-- 문자열의 오른쪽에 있는 문자를 제거함. (제거할 문자가 아닌 다른 문자가 있으면 TRIM 종료됨)

SELECT '       0123456ABCDabxyORACLExxxxyyyyzyx532     ',
        LTRIM('       0123456ABCDabxyORACLExxxxyyyyzyx532     '),
        LTRIM('       0123456ABCDabxyORACLExxxxyyyyzyx532     ', ' '),
        LTRIM('       0123456ABCDabxyORACLExxxxyyyyzyx532     ', ' 0123456789'),
        LTRIM('       0123456ABCDabxyORACLExxxxyyyyzyx532     ', ' 0123456ABCDybax')
FROM DUAL;

SELECT '       0123456ABCDabxyORACLExxxxyyyyzyx532     ',
        RTRIM('       0123456ABCDabxyORACLExxxxyyyyzyx532     '),
        RTRIM('       0123456ABCDabxyORACLExxxxyyyyzyx532     ', ' '),
        RTRIM('       0123456ABCDabxyORACLExxxxyyyyzyx532     ', ' 0123456789'),
        RTRIM('       0123456ABCDabxyORACLExxxxyyyyzyx532     ', ' 0123456789xyz')
FROM DUAL;

-- TRIM(LEADING | TRAILING | BOTH '제거할문자하나' FROM '문자리터럴' | 컬럼명)
-- 기본은 양쪽의 문자 제거하는 함수 (기본이 BOTH 임)
-- 제거할문자 생략시 공백문자 제거를 의미함
SELECT 'aaORACLEaa',
        TRIM('a' FROM 'aaORACLEaa'),
        TRIM(LEADING 'a' FROM 'aaORACLEaa'),
        TRIM(TRAILING 'a' FROM 'aaORACLEaa'),
        TRIM(BOTH 'a' FROM 'aaORACLEaa')
FROM DUAL;

-- SUBSTR('문자리터럴' | 컬럼명, 추출할 시작위치, 추출할 글자수)
-- 추출할 시작위치 : 양수(앞에서부터의 위치), 음수(뒤에서부터의 위치)
-- 추출할 글자수 : 생략되면 글자 끝까지를 의미함
SELECT 'ORACLE 18C',
        SUBSTR('ORACLE 18C', 5),
        SUBSTR('ORACLE 18C', 8, 2),
        SUBSTR('ORACLE 18C', -7, 3)
FROM DUAL;

-- 직원들의 주민번호에서 생년, 생월, 생일을 각각 분리 조회
-- 별칭 적용
SELECT EMP_NO,
        SUBSTR(EMP_NO, 1, 2) 생년,
        SUBSTR(EMP_NO, 3, 2) 생월,
        SUBSTR(EMP_NO, 5, 2) 생일
FROM EMPLOYEE;

-- 날짜 데이터에도 SUBSTR 사용할 수 있음
-- 직원들의 입사일에서 입사년도, 입사월, 입사일을 분리 조회
SELECT HIRE_DATE,
        SUBSTR(HIRE_DATE, 1, 2) 입사년도,
        SUBSTR(HIRE_DATE, 4, 2) 입사월,
        SUBSTR(HIRE_DATE, 7, 2) 일사일
FROM EMPLOYEE;

-- SUBSTRB('문자리터럴' | 컬럼명, 추출할 시작바이트위치, 추출할 바이트)
SELECT SUBSTR('ORACLE', 3, 2),  -- AC
        SUBSTRB('ORACLE', 3, 2),  --AC
        SUBSTR('오라클', 2, 2),   --라클
        SUBSTRB('오라클', 4, 6)
FROM DUAL;

-- UPPER('문자리터럴' | 문자가 기록된 컬럼명) : 영문자일 때 대문자로 바꾸는 함수
-- LOWER('문자리터럴' | 문자가 기록된 컬럼명) : 영문자일 때 소문자로 바꾸는 함수
-- INITCAP('문자리터럴' | 문자가 기록된 컬럼명) : 영문자일 때 첫글자만 대문자로 나머지는 소문자로 바꾸는 함수
SELECT UPPER('ORACLE'), UPPER('oracle'),
        LOWER('ORACLE'), LOWER('oracle'),
        INITCAP('ORACLE'), INITCAP('oracle')
FROM DUAL;

-- 함수 중첩 사용 : 함수 안에 함수를 사용할 수 있음  ------------------------------------------------

-- 직원 정보에서 이름, 아이디 조회
-- 아이디는 이메일에서 분리 추출함
SELECT EMP_NAME 이름, EMAIL 이메일, 
       SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) 아이디
FROM EMPLOYEE;

-- 직원 테이블에서 이름, 주민번호 조회
-- 주민번호는 생년월일성별만 보이게 하고 뒷자리는 '*' 로 처리함 : 781225-1******
SELECT EMP_NAME 이름,
        RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') 주민번호
FROM EMPLOYEE;

-- 숫자 처리 함수 ********************************************************************************
-- ROUND(), TRUNC(), FLOOR(), ABS(), MOD()

-- ROUND(숫자 | 숫자가 기록된 컬럼명 | 계산식, 반올림할 자릿수)
-- 버려지는 자리의 값이 5이상이면 자동 반올림함
-- 반올림할 자릿수 : 양수이면 소숫점 아래 자리를 의미함 (그 자리까지 표시함)
-- 반올림할 자릿수 : 음수이면 소숫점 왼쪽 정수부 자리를 의미함 (해당 자리값을 올림 | 내림 처리함)

SELECT 123.456,
        ROUND(123.456),   --123
        ROUND(123.456, 0), --123
        ROUND(123.456, 1), --123.5
        ROUND(123.456, -1) --120
FROM DUAL;

-- 직원 정보에서 사번, 이름, 급여, 보너스포인트, 보너스포인트가 적용된 연봉 조회
-- 연봉은 별칭 처리 : 1년급여
-- 연봉은 천단위에서 반올림함
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 급여, BONUS_PCT 보너스포인트,
        ROUND(((SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12), -4) "1년급여"
FROM EMPLOYEE;

-- TRUNC(숫자 | 숫자가 기록된 컬럼명 | 계산식, 자릿수) : 절삭함수
-- 자릿수 : 생략되면 0임. (0 은 소숫점 위치임)
-- 지정한 자릿수 뒤(양수) 또는 지정한 자릿수(음수)의 값을 버리는 함수임. (반올림 없음)
SELECT 145.678, 
        TRUNC(145.678), -- 145
        TRUNC(145.678, 0), --145
        TRUNC(145.678, 1), --145.6
        TRUNC(145.678, -1), --140
        TRUNC(145.678, -3)  --0
FROM DUAL;

-- 직원 정보에서 급여의 평균을 조회
-- 10단위에서 절삭함
SELECT AVG(SALARY), TRUNC(AVG(SALARY), -2)
FROM EMPLOYEE;

-- FLOOR(숫자 | 숫자가 기록된 컬럼명 | 계산식)
-- 정수 만들기 함수 (소숫점 아래값 버리는 함수)
SELECT ROUND(123.56), TRUNC(123.56), FLOOR(123.56)
FROM DUAL;

-- ABS(숫자 | 숫자가 기록된 컬럼명 | 계산식)
-- 절대값 처리 함수 (양수는 그대로, 음수는 양수로 바꿈)
SELECT ABS(123), ABS(-123)
FROM DUAL;

-- 입사일 - 오늘, 오늘 - 입사일 조회 : 별칭은 근무일수
-- 근무일수는 정수로 처리, 모두 양수로 처리
-- 오늘 날짜 구하는 함수 : SYSDATE
SELECT HIRE_DATE - SYSDATE 근무일수,
        SYSDATE - HIRE_DATE 근무일수,
        ABS(FLOOR(HIRE_DATE - SYSDATE)) 근무일수,
        ABS(FLOOR(SYSDATE - HIRE_DATE)) 근무일수
FROM EMPLOYEE;

-- MOD(나눌 대상값, 나눌 수)
-- 나누기한 나머지 값을 반환하는 함수
-- 자바처럼 나눌값 % 나눌수 사용 못 함
SELECT FLOOR(25 / 7) 몫, MOD(25, 7) 나머지 
FROM DUAL;

-- 직원 정보에서 사번이 홀수인 직원들 조회
-- 사번, 이름
SELECT EMP_ID 사번, EMP_NAME 이름
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) = 1;

-- 날짜 처리 함수 **************************************************************************

-- SYSDATE 함수
-- 시스템으로 부터 현재 날짜와 시간을 조회해 옴

SELECT SYSDATE
FROM DUAL;

-- 오라클에서는 환경설정, 데이터베이스 객체 관련 정보들을 모두 저장 관리하고 있음
-- 데이터 딕셔너리 (Data Dictionary : 데이터 사전) 영역에 테이블 형태로 각각 저장되면서 관리되교 있음
-- 데이터 딕셔너리는 DB 시스템이 관리함, 사용자는 손댈 수 없음
-- 사용자는 저장된 정보를 조회해서 볼 수는 있음

-- 환경설정과 관련된 데이터 딕셔너리에서 셋팅 정보만 일부 변경할 수 있음.
SELECT *
FROM SYS.nls_session_parameters;

-- 날짜 포멧과 관련된 변수 값만 조회
SELECT VALUE
FROM SYS.NLS_SESSION_PARAMETERS
WHERE PARAMETER = 'NLS_DATE_FORMAT';

-- 날짜 포멧을 수정한다면
ALTER SESSION
SET NLS_DATE_FORMAT = 'DD-MON-RR';

-- 확인
SELECT SYSDATE
FROM DUAL;

-- 원래 포멧으로 변경
ALTER SESSION
SET NLS_DATE_FORMAT = 'RR/MM/DD';

-- ADD_MONTHS('날짜리터럴' | 날짜가 기록된 컬럼명, 더하기할 개월수)
-- 더한 개월수에 대한 날짜가 반환됨

-- 오늘 날짜에서 10년 뒤 날짜는?
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 120)
FROM DUAL;

-- 직원 정보에서 입사일 기준 20년된 날짜 조회
-- 사번, 이름, 입사일, 20년된 날짜
SELECT EMP_ID 사번, EMP_NAME 이름, HIRE_DATE 입사일, 
        ADD_MONTHS(HIRE_DATE, 240) "20년된 날짜"
FROM EMPLOYEE;

-- 직원들 중 근무년수가 20년 이상된 직원 정보 조회
-- 사번, 이름, 부서코드, 직급코드, 입사일
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_ID 부서코드, JOB_ID 직급코드, HIRE_DATE 입사일
FROM EMPLOYEE
WHERE ADD_MONTHS(HIRE_DATE, 240) < SYSDATE;

-- MONTHS_BETWEEN('날짜리터럴' | 날짜가 기록된 컬럼명 | 날짜함수, '날짜리터럴' | 날짜가 기록된 컬럼명 | 날짜함수)
-- 두 날짜의 개월 수의 차이를 반환함

-- 직원들의 이름, 입사일, 현재까지의 근무일수, 근무개월수, 근무년수 조회
-- 모두 정수형으로 처리함
SELECT EMP_NAME 이름, HIRE_DATE 입사일,
        FLOOR(SYSDATE - HIRE_DATE) 근무일수,
        FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) 근무개월수,
        FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) 근무년수
FROM EMPLOYEE;

-- NEXT_DAY('날짜리터럴' | 날짜가 기록된 컬럼명, '요일이름')
-- 지정한 날짜 뒤쪽 날짜에서 가장 가까운 지정 요일의 날짜를 반환함
-- 현재 DBMS 의 사용언어가 'KOREAN' 이므로 요일이름은 한글로 써야 함
-- 영어로 요일이름 사용하면 에러남

SELECT SYSDATE, NEXT_DAY(SYSDATE, '일요일')
FROM DUAL;

SELECT SYSDATE, NEXT_DAY(SYSDATE, 'SUNDAY')
FROM DUAL;  -- ERROR

-- 환경설정에서 사용 언어 변경해 봄
ALTER SESSION
SET NLS_LANGUAGE = AMERICAN;

ALTER SESSION
SET NLS_LANGUAGE = KOREAN;

-- LAST_DAY('날짜리터럴' | 날짜가 기록된 컬럼명)
-- 지정한 날짜의 월에 대한 마지막 날짜(DATE)를 반환함
SELECT SYSDATE, LAST_DAY(SYSDATE)
FROM DUAL;

-- 직원 정보에서 이름, 입사일, 입사한 달의 근무일수 조회
-- 주말 포함 일수
SELECT EMP_NAME 이름, HIRE_DATE 입사일,
        LAST_DAY(HIRE_DATE) - HIRE_DATE "입사 첫달 근무일수"
FROM EMPLOYEE;

-- 오늘 날짜 조회 함수
SELECT SYSDATE, SYSTIMESTAMP,
        CURRENT_DATE, CURRENT_TIMESTAMP
FROM DUAL;

-- EXTRACT(추출할정보 FROM 날짜)
-- 날짜 데이터에서 원하는 정보만 추출해서 반환하는 함수임.
-- 추출할 정보 : YEAR, MONTH, DAY, HOUR, MINUTE, SECOND

-- 오늘 날짜에서 년도, 월, 일 따로 추출
SELECT SYSDATE, 
        EXTRACT(YEAR FROM SYSDATE),
        EXTRACT(MONTH FROM SYSDATE),
        EXTRACT(DAY FROM SYSDATE)
FROM DUAL;

-- 직원의 이름, 입사일, 근무년수1, 근무년수2 조회
-- 근무년수는 오늘 날짜 기준으로 계산함 : EXTRACT, MONTHS_BETWEEN 각각 사용해 봄
-- 근무년수는 정수로 처리함
SELECT EMP_NAME 이름, HIRE_DATE 입사일,
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) "근무년수1",
        FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) "근무년수2"
FROM EMPLOYEE;

-- 형변환 함수 ***********************************************************
-- NUMBER, DATE, CHARACTER 간의 타입을 바꾸는 함수

-- 자동형변환 경우
SELECT 25 + '10'   -- NUMBER + CHARACTER --> 자동으로 NUMBER 로 바뀜(자동형변환)
FROM DUAL;

-- 명시형변환
SELECT 25 + TO_NUMBER('10')
FROM DUAL;

SELECT *
FROM EMPLOYEE
--WHERE EMP_ID = 100;  -- CHAR = NUMBER  --> CHAR 자동형변환됨
WHERE EMP_ID = TO_CHAR(100);  -- 명시형변환

-- 자동형변환이 안 되는 경우 ==> 형변환을 명시해야 함
SELECT SYSDATE - '15/03/25'  -- DATE - CHARACTER : 자동형변환 안 됨
FROM DUAL;  -- ERROR

SELECT SYSDATE - TO_DATE('15/03/25') -- 명시형변환
FROM DUAL;

-- TO_CHAR() 함수 --------------------------------------------------------------------
-- 숫자(NUMBER)나 날짜(DATE)에 대해 출력 포멧(FORMAT : 출력형식) 지정시 사용하는 함수
-- NUMBER + FORMAT ==> CHARACTER (포멧이 적용된 문자열로 변환됨)
-- DATE + FORMAT ==> CHARACTER (포멧이 적용된 문자열로 변환됨)

-- 숫자에 포멧 적용하는 TO_CHAR() 함수 사용
-- 사용형식 : TO_CHAR(숫자값 | 숫자가 기록된 컬럼명, '포멧지정용문자열')
-- 주로 통화단위 표시, 천단위구분자, 소숫점 표시, 실수형 데이터 지수형(과학용 표기)으로 표시

SELECT EMP_NAME 이름,
        TO_CHAR(SALARY, 'L99,999,999') 급여,
        TO_CHAR(NVL(BONUS_PCT, 0), '90.00') 보너스포인트
FROM EMPLOYEE;

-- 날짜에 포멧 적용하는 TO_CHAR() 함수 사용
-- 사용형식 : TO_CHAR('날짜데이터' | 날짜가 기록된 컬럼명, '포멧지정문자열')
-- 년월일 시분초 분기 요일 오전|오후 등을 출력 처리할 때 사용함

-- 년도 출력 포멧
SELECT SYSDATE,
        TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'RRRR'),
        TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'RR'),
        TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- 년도 출력 포멧 + '임의의 문자열'
-- '' 안에 '' 를 사용할 수 없음 작은 따옴표 안에 큰 따옴표로 교대로 사용함
SELECT SYSDATE,
        TO_CHAR(SYSDATE, 'YYYY "년"'), TO_CHAR(SYSDATE, 'RRRR "년"'),
        TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'RR'),
        TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- 월에 대한 포멧
SELECT SYSDATE,
        TO_CHAR(SYSDATE, 'YYYY "년" MM "월"'), TO_CHAR(SYSDATE, 'RRRR "년" fmMM "월"'),
        TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'RM'),
        TO_CHAR(SYSDATE, 'MONTH'), TO_CHAR(SYSDATE, 'MON')
FROM DUAL;

-- 날짜에 대한 포멧
SELECT SYSDATE,
        TO_CHAR(SYSDATE, '"1년기준" DDD "일째"'),
        TO_CHAR(SYSDATE, '"월기준" DD "일째"'),
        TO_CHAR(SYSDATE, '"주기준" D "일째"')
FROM DUAL;

-- 분기와 요일 포멧
SELECT SYSDATE,
        TO_CHAR(SYSDATE, 'Q "분기"'),
        TO_CHAR(SYSDATE, 'DAY'),
        TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

-- 직원 정보에서 이름, 입사일 조회
-- 입사일은 포멧 적용함 : '2016년 05월 19일 (목)' 
SELECT EMP_NAME 이름,
        TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일" "("DY")"') 입사일,
        TO_CHAR(HIRE_DATE, 'YYYY"년" MON DD"일" "("DY")"') 입사일
FROM EMPLOYEE;









