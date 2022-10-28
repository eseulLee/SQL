-- SQL REVIEW
-- COMMENT
-- 검색 (SELECT)
/*
MULTILINE COMMENT
키워드 - 대문자
데이터 - 대소문자 구별
가독성을 위해 절 개행하여 작성

PARSING
- SELECT - FROM - WHERE - GROUP BY - HAVING - ORDER BY
SELECT * | [DISTINCT] COLUMN_NAM | EXPR | [AS] ALIAS - 가져오고자 하는 컬럼 리스트
FROM    TABLE_NAME                      - 대상 테이블
-- WHERE   SEARCH_CONDITION                - 행에 대한 제한
-- GROUP BY   기준 컬럼                     - 그룹핑
-- HAVING  SEARCH_CONDITION                - 그룹에 대한 조건
-- ORDER BY   기준 컬럼 [ASC | DESC]        - 정렬할 때 사용
[LIMIT]
*/

SELECT  *
FROM    EMPLOYEE;

SELECT  EMP_ID, EMP_NAME, DEPT_ID
FROM    EMPLOYEE;

SELECT  EMP_ID, EMP_NAME, DEPT_ID
FROM    EMPLOYEE
WHERE   DEPT_ID = 90;

SELECT  EMP_ID, EMP_NAME, JOB_ID
FROM    EMPLOYEE
WHERE   JOB_ID = 'J1' ;

-- 표현식 (컬럼 값에 대한 산술 연산)
-- 별칭 주의) 특수문자(공백, 괄호, &, 숫자) 포함될 경우 반드시 ""해야 함
-- cf) ''는 데이터! 별칭 사용할 때 ''사용하면 안됨

SELECT  EMP_NAME, SALARY, 
        SALARY * 12 AS ANNUAL_SALARY,
        (SALARY + (SALARY * BONUS_PCT)) * 12 AS "12개월연봉"
FROM    EMPLOYEE;

-- 더미 컬럼 추가 (컬럼 개수 맞추기)
SELECT  EMP_ID,
        EMP_NAME,
        '재직' AS 근무여부
FROM    EMPLOYEE;        

-- DISTINCT (중복 제거)
-- SELECT 절에 단 한번만 기술될 수 있다

-- DEPT_ID 와 JOB_ID 를 COMPOSITE 해서 하나의 UNIQUE 한 값으로 인식한다.
SELECT  DISTINCT DEPT_ID , 
        JOB_ID 
FROM    EMPLOYEE ; 

-- WHERE 행에 대한 제한
-- 급여가 4000000 보다 많은 사원의 이름과 급여 조회
SELECT  EMP_NAME, SALARY
FROM    EMPLOYEE
WHERE   SALARY > 4000000;

-- 이고 AND
-- 부서코드가 90이고 급여가 2000000 보다 많은 사원의 이름, 부서코드, 급여 조회
SELECT  EMP_NAME AS 이름,
        DEPT_ID  AS 부서코드,
        SALARY   AS 급여
FROM    EMPLOYEE
WHERE   DEPT_ID = '90' AND SALARY > 2000000;

-- 이거나 OR
-- 부서코드가 90이거나 20인 부서원의 이름, 부서코드, 급여 조회
SELECT  EMP_NAME AS 이름,
        DEPT_ID  AS 부서코드,
        SALARY   AS 급여
FROM    EMPLOYEE
WHERE   DEPT_ID = 90 OR DEPT_ID = 20;

SELECT  EMP_NAME AS 이름,
        DEPT_ID  AS 부서코드,
        SALARY   AS 급여
FROM    EMPLOYEE
WHERE   DEPT_ID IN ('90', '20');

-- WHERE (연산자)
-- 연결연산자 || : 여러개의 컬럼이나 문자열들을 하나의 문장으로 엮을 수 있음
SELECT  EMP_NAME||'의 월급은 '||SALARY||'원 입니다.' AS 문장
FROM    EMPLOYEE;

-- 논리연산자 (AND, OR, NOT)
-- 비교연산자 (=, >, <, >=, <=, !=, BETWEEN ~ AND ~, LIKE, NOT LIKE, IS NULL, IS NOT NULL,IN)

-- 사원테이블로부터 급여가 3500000 보다 많이 받고 5500000 보다 적게 받는 직원의 이름, 급여 조회
-- 하한값의 경계와 상한값의 경계 포함
SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE
WHERE   SALARY >= 3500000 AND SALARY <= 5500000;

SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE
WHERE   SALARY BETWEEN 3500000 AND 5500000;

-- 사원테이블에서 '김'씨 성을 가진 직원의 이름, 급여 조회
-- LIKE: 패턴 검색 %, _
SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE
WHERE   EMP_NAME LIKE '김%';

-- EMAIL에서 언더바 앞 자리수가 세자리인 사람들 출력
/*
- 언더바 앞 세자리 표시와 경계가 모호하기 때문에 ESCAPE 로 구분자 생성
- ESCAPE 뒤에 있는 건 문자로 보지 말고 데이터로 보라는 의미
*/
SELECT  EMP_NAME,
        EMAIL
FROM    EMPLOYEE
WHERE   EMAIL LIKE '___\_%' ESCAPE '\';

-- 사수번호가 없고 부서 배치도 받지 않은 사원의 이름, 사수번호, 부서 출력
-- DATA가 NULL인 경우, = 으로 비교 불가 -> IS NULL, IS NOT NULL 사용
SELECT  EMP_NAME,
        MGR_ID,
        DEPT_ID
FROM    EMPLOYEE
WHERE   MGR_ID IS NULL AND DEPT_ID IS NULL;

SELECT  EMP_NAME,
        MGR_ID,
        DEPT_ID
FROM    EMPLOYEE
WHERE   MGR_ID IS NOT NULL AND DEPT_ID IS NOT NULL;

-- 공백으로 하면? > 출력값 안나옴
SELECT  EMP_NAME,
        MGR_ID,
        DEPT_ID
FROM    EMPLOYEE
WHERE   MGR_ID = '' AND DEPT_ID = '';

-- 부서 배치를 받지 않았음에도 보너스를 지급받는 직원의 이름, 부서코드, 보너스 조회
SELECT  EMP_NAME, DEPT_ID, BONUS_PCT 
FROM    EMPLOYEE
WHERE   (DEPT_ID IS NULL) AND (BONUS_PCT IS NOT NULL);

-- 연산자 우선순위 : 산술 > 연결 > 비교 > 논리(NOT, AND, OR)