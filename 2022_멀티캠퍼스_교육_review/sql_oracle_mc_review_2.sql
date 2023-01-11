-- SQL REVIEW 2
/*
함수의 유형
- 단일 행 함수 (SINGLE ROW FUNCTION)
- 그룹 함수 (GROUP FUNCTION)

컬럼 타입(숫자 - number, 문자 - char, varchar2, 날짜 - date)
- 숫자 함수
- 문자 함수 ★
- 날짜 함수
- 기타 함수 ★
*/

-- 문자 함수 (영어: 1byte, 한글: 2-3byte)
-- LENGTH
-- CHAR 한글일 경우 LENGTH
-- 한글 3, 6 * 3 = 18 BYTE , 20 - 18 = 2 BYTE (공백처리), 2 + 6 = 8 -> CHAR 로 한글은 쓰지 말자
SELECT  LENGTH(CHARTYPE),
        LENGTH(VARCHARTYPE)
FROM    COLUMN_LENGTH;

-- INSTR() : 찾는 문자의 인덱스를 리턴하는 함수
-- INSTR(STRING, SUBSTRING, [POSITION(앞부터:+, 뒤부터:-1), OCCURRENCE] ) : NUMBER

SELECT  *
FROM    EMPLOYEE;

-- '@vcc.com' 문자열 중 . 앞의 문자 'c' 인덱스를 구하면?
-- ORACLE은 인덱스를 0부터 세지 않는다! 1부터 START
SELECT  EMAIL,
        INSTR(EMAIL, 'c', -1, 2)
FROM    EMPLOYEE;

-- LPAD | RPAD : 정렬할 때 많이 사용
-- LPAD(STRING, N, [STR])
SELECT  EMAIL,
        LENGTH(EMAIL),
        LPAD(EMAIL, 20, '*'),   -- 왼쪽 공백(*), 데이터 오른쪽 정렬
        RPAD(EMAIL, 20, '*')   -- 오른쪽 공백(*), 데이터 왼쪽 정렬
FROM    EMPLOYEE;        

-- TRIM, LTRIM, RTRIM
-- 문자를 제거할 때 (DEFAULT: 공백 제거)
-- LTRIM(STRING, [STR])
-- RTRIM(STRING, [STR])
-- TRIM(LEADING | TRAILING | [BOTH] STR FROM STRING(TRIM_SOURCE))

SELECT  LENGTH('    TECH    '),
        LTRIM('    TECH    '),
        LENGTH(LTRIM('    TECH    ')),
        RTRIM('    TECH    '),
        LENGTH(RTRIM('    TECH    '))
FROM    DUAL;        -- DUMMY TABLE

SELECT  TRIM(LEADING 'A' FROM 'AATECHAA'),
        TRIM(TRAILING 'A' FROM 'AATECHAA'),
        TRIM(BOTH 'A' FROM 'AATECHAA'),
        TRIM('A' FROM 'AATECHAA')  -- 안적어도 BOTH
FROM    DUAL;  

-- ★ SUBSTR(STRING, POSITION(양수: 앞부터, 음수: 뒤부터, IDX_NUMBER), [LENGTH: 문자의 개수])
SELECT  EMP_NO,
        SUBSTR(EMP_NO, 1, 6),  -- SUBSTR(STRING, START_IDX, END_IDX)
        SUBSTR(EMP_NO, 8, 1)
FROM    EMPLOYEE;        

-- 사원 테이블에서 성별이 남자인 사원의 모든 정보 조회
SELECT  *
FROM    EMPLOYEE
WHERE   SUBSTR(EMP_NO, 8, 1) = '1';

-- 숫자 함수 (양수: 소수점 이하 자릿수 | 음수: 정수 부분)
-- ROUND(NUMBER, [DECIMAL_PLACES]), TRUNC(NUMBER, [DECIMAL_PLACES])

SELECT  ROUND(123.315),
        ROUND(123.315, 0),
        ROUND(123.315, 2),
        ROUND(123.314, 2),
        ROUND(123.315, -1),
        ROUND(125.315, -1),  -- 반올림(사사오입)
        TRUNC(125.315, -1)   -- 자릿수 절삭
FROM    DUAL;  

-- 날짜 함수
-- SYSDATE, ADD_MONTHS(DATE, N)
-- MONTHS_BETWEEN(DATE1, DATE2) -> DATE1이 DATE2보다 더 커야 함 (기준이 되는 날짜)

SELECT  SYSDATE,     -- 오늘 날짜 리턴
        SYSDATE +1   -- 일수 +1
FROM    DUAL;  

-- 근속연수 20년 이상인 사원 조회
SELECT  HIRE_DATE,
        ADD_MONTHS(HIRE_DATE, 240),   -- 20 * 12 = 240
        MONTHS_BETWEEN(SYSDATE, HIRE_DATE),
        MONTHS_BETWEEN(HIRE_DATE, SYSDATE)  -- 음수 출력
FROM    EMPLOYEE;

-- 근속연수 출력(* 뒤에는 컬럼추가 불가)
SELECT  EMP_NAME,
        HIRE_DATE,
        TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12) AS 근속연수
FROM    EMPLOYEE
WHERE   MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;

SELECT  *
FROM    EMPLOYEE
WHERE   ADD_MONTHS(HIRE_DATE, 240) <= SYSDATE;

-- 타입 변환 함수

/*
<-  TO_NUMBER()   TO_CHAR(DATE, 표현형식)
NUMBER  -  CHARACTER  -  DATE
->  TO_CHAR()     TO_DATE()

날짜 -> 문자 (형식들 지정되어 있음) => 출력형식 지정하기 위해서는 타입 바꿔줘야 함
- YYYY/YY/YEAR
- MONTH/MON/MM/RM
- DDD/DD/D
- DAY/DY (요일)
- HH24/ HH:MI:SS
- AM, PM
- Q (분기)
*/
SELECT  *
FROM    EMPLOYEE
WHERE   DEPT_ID = 90;

SELECT  *
FROM    EMPLOYEE
WHERE   DEPT_ID = TO_CHAR(90) ;
-- 두개가 같은 결과
-- 이런 묵시적인 형 변환이 일어나기 때문에 DEPT_ID = 90 으로 조회해도 되는거!

SELECT  SYSDATE,
        TO_CHAR(SYSDATE, 'YYYY-MM-DD-DY-DAY'),
        TO_CHAR(SYSDATE, 'MM-DD, YYYY'),
        TO_CHAR(SYSDATE, 'YYYY, YY, YEAR'),
        TO_CHAR(SYSDATE, 'AM HH24:MI:SS'),
        TO_CHAR(SYSDATE, 'YEAR, Q')   -- Q: 분기(QUARTER)
FROM    DUAL;

SELECT  HIRE_DATE,
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM    EMPLOYEE;        

-- 날짜는 문자로 취급될 수 있음
SELECT  HIRE_DATE,
        SUBSTR(HIRE_DATE, 1, 2) || '년' ||
        SUBSTR(HIRE_DATE, 4, 2) || '월' ||
        SUBSTR(HIRE_DATE, -2, 2) || '일' AS 입사일
FROM    EMPLOYEE
WHERE   DEPT_ID = 90;

-- TO_CHAR와 함께 쓰이는 다양한 포맷
-- 9: 일반적인 숫자 (맨 앞에 공백 하나 붙음 주의)
SELECT  TO_CHAR('123', '999999'),
        LENGTH(TO_CHAR('123', '999999')),
        TO_CHAR('123', '999'),
        LENGTH(TO_CHAR('123', '999')),
        LTRIM(TO_CHAR('123', '999')),
        LENGTH(LTRIM(TO_CHAR('123', '999')))
FROM    DUAL;

-- 0: 길이만큼 앞의 빈자리 0으로 채움
SELECT  TO_CHAR('123', '000000')
FROM    DUAL;

-- $: DOLLAR 표시
SELECT  TO_CHAR('123', '$999999'),
        TO_CHAR('123', '$000000')
FROM    DUAL;

-- L: 지역 통화 단위 (EX. \)
SELECT  TO_CHAR('123', 'L999999')
FROM    DUAL;

-- .: 소수점 표시
SELECT  TO_CHAR('123', '999.999'),
        TO_CHAR('12.3', '999.999')
FROM    DUAL;

-- ,: 콤마 표시
SELECT  TO_CHAR('12345', '999,999,999')
FROM    DUAL;

-- CHAR -> DATE
-- '20220215' -> 22/02/15
-- 모든 문자가 날짜로 될 수 있는 것은 아님
SELECT  TO_DATE('20220215', 'YYYYMMDD'),
        TO_DATE('220215', 'YYMMDD'),
        TO_DATE('150222', 'DDMMYY'),   -- 어디가 연월일인지 알려주는게 필요함!
        TO_CHAR(TO_DATE(TO_CHAR(220215), 'YYMMDD'), 'YYYY-MM-DD')
FROM    DUAL;

-- 연도 포맷팅할 때 YYYY(TO_CHAR에는 사용가능, 현재 세기 기준), RRRR(TO_DATE 쓸 때 사용)
SELECT  HIRE_DATE,
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM    EMPLOYEE
WHERE   EMP_NAME = '한선기';

SELECT  SYSDATE AS 현재,
        '95/02/15' AS 입력,
        TO_CHAR(TO_DATE('95/02/15', 'YY/MM/DD'), 'YYYY'),
        TO_CHAR(TO_DATE('95/02/15', 'RR/MM/DD'), 'YYYY')
FROM    DUAL;        

-- 기타함수
-- NULL 값 처리 함수: NVL(VALUE, 대체값)
SELECT  EMP_NAME,
        BONUS_PCT,
        NVL(BONUS_PCT, 0)
FROM    EMPLOYEE
WHERE   SALARY > 3500000;

SELECT  EMP_NAME,
        SALARY,
        SALARY * 12 AS ANNUAL_SALARY,
        BONUS_PCT,
        (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 AS "12개월연봉"
FROM    EMPLOYEE;

-- ORACLE 전용 함수 (다른 벤더사 제품에는 존재하지 않음)
-- DECODE(EXPR(수식표현 불가), SEARCH, RESULT, [SEARCH, RESULT], [DEFAULT])
-- IF ~ ELSE

-- 부서번호가 50번인 사원들의 이름, 성별 조회
SELECT * FROM EMPLOYEE;

SELECT  EMP_NAME,
        EMP_NO,
        DECODE(SUBSTR(EMP_NO, 8, 1),
        '1', 'Male',
        '3', 'Male',
        'Female') AS GENDER
FROM    EMPLOYEE
WHERE   DEPT_ID = 50;

-- 사원의 인상급여를 확인하고자 할 때, 90 부서만 급여의 10%를 인상한다면?
SELECT  DEPT_ID,
        EMP_NAME,
        SALARY,
        DECODE(DEPT_ID, '90', SALARY * 1.1, SALARY) AS 인상급여
FROM    EMPLOYEE;

-- ANSI 표준
-- CASE EXPR WHEN SEARCH THEN RESULT [WHEN SEARCH THEN RESULT] ELSE DEFAULT END
-- CASE WHEN CONDITION THEN RESULT [WHEN SEARCH THEN RESULT] ELSE DEFAULT END
SELECT  DEPT_ID,
        SALARY,
        CASE DEPT_ID WHEN '90' THEN SALARY * 1.1
                     ELSE SALARY
        END AS 인상급여
FROM    EMPLOYEE;

SELECT  DEPT_ID,
        SALARY,
        CASE WHEN DEPT_ID = '90' THEN SALARY * 1.1
             ELSE SALARY
        END AS 인상급여
FROM    EMPLOYEE;

-- 급여에 따른 급여 등급을 확인하려고 한다.
-- 3000000 이하 : 초급 / 4000000 이하 : 중급 / 4000000 초과 : 고급
SELECT  EMP_NAME,
        SALARY,
        CASE WHEN SALARY <= 3000000 THEN '초급' 
             WHEN SALARY <= 4000000 THEN '중급'
             ELSE '고급' 
        END AS 급여등급
FROM    EMPLOYEE;

-- 그룹 함수(SUM, AVG) - NUMBER
-- 그룹 함수(MIN, MAX, COUNT) - ANY TYPE (NUMBER, CHARACTER, DATE)
-- INPUT N -> OUTPUT 1

SELECT  SUM(SALARY), -- SELECT 절에 그룹함수 사용되면 일반속성은 정의될 수 없다. SELECT EMP_ID, SUM(SALARY) -- ERROR
        AVG(SALARY),
        MIN(SALARY),
        MAX(SALARY),
        COUNT(*),
        COUNT(BONUS_PCT),  -- 22명 중에 8명만 보너스를 지급 받는다. (갯수 세어주는 역할, NULL 값은 COUNT 하지 않으므로 제외됨)
        MAX(HIRE_DATE),
        MIN(HIRE_DATE)
FROM    EMPLOYEE;