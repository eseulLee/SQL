-- REVIEW 3
-- ORDER BY
SELECT  *
FROM    EMPLOYEE;

SELECT  *
FROM    EMPLOYEE
ORDER BY SALARY DESC, EMP_NAME DESC;

-- ORDER BY 에서 별칭 사용 가능
SELECT  EMP_NAME  AS 이름,
        HIRE_DATE AS 입사일,
        DEPT_ID   AS 부서코드
FROM    EMPLOYEE
ORDER BY 부서코드 DESC, 입사일, 이름;    

-- 인덱스 사용 가능
-- SELECT 절에 제시된 순서대로 1, 2, 3 으로 인덱스 부여
SELECT  EMP_NAME    AS 이름,
        HIRE_DATE   AS 입사일,
        DEPT_ID     AS 부서코드
FROM    EMPLOYEE
ORDER BY 3 DESC, 2, 1;

-- GROUP BY: 하위 데이터 그룹
-- WORKBOOK_FUNC_10
SELECT  DEPARTMENT_NO AS 학과번호,
        COUNT(*) AS "학생수(명)"
FROM    TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- 부서별 평균 급여 조회
SELECT  DEPT_ID     AS 부서번호,
        ROUND(AVG(SALARY),-4) AS 평균급여
FROM    EMPLOYEE
GROUP BY DEPT_ID
ORDER BY 1;

-- GROUP BY 에는 별칭 및 인덱스 사용불가
-- 원래 SELECT 절에 그룹함수가 들어가면 일반 COLUMN은 못들어가지만, GROUP BY로 기준컬럼이 생기면 해당 컬럼은 SELECT절에 쓸 수 있다.
-- 성별에 따른 평균급여 조회
-- 기준컬럼이 GROUP BY 에 그대로 들어가는게 좋기 때문에 아래처럼 하는게 BETTER! (GROUP BY 에 표현식도 가능하구나~)

SELECT  CASE WHEN SUBSTR(EMP_NO, 8, 1) IN ('1','3') THEN 'MALE' ELSE 'FEMALE' END AS 성별,
        ROUND(AVG(SALARY),-4) AS 평균급여
FROM    EMPLOYEE
GROUP BY CASE WHEN SUBSTR(EMP_NO, 8, 1) IN ('1','3') THEN 'MALE' ELSE 'FEMALE' END;

-- DEPT_ID, EMP_NAME 을 COMPOSITE 해서 하나의 SET으로 봐서 COUNTING!
SELECT  DEPT_ID,
        EMP_NAME,
        COUNT(*)
FROM    EMPLOYEE
GROUP BY DEPT_ID, EMP_NAME;

-- 부서별 급여 총합 + 총합이 900 이상인 그룹만 GROUPING 하고 싶다면?
SELECT  DEPT_ID,
        SUM(SALARY)
FROM    EMPLOYEE
GROUP BY DEPT_ID
HAVING  SUM(SALARY) >= 9000000;

-- ROLLUP()
-- 소계, 총계 모두 확인: 두개를 COMPOSITE 해서 하나의 GROUP 만듦
-- 1 COL 기준으로 소계, 총계 출력
-- GROUPING(): GROUP에 속하면 0, 아니면 1 (여기서 아닌 경우는 소계, 총계인 경우)
SELECT  DEPT_ID,
        GROUPING(DEPT_ID) AS D_ID,
        JOB_ID,
        GROUPING(JOB_ID)  AS J_ID,
        SUM(SALARY)
FROM    EMPLOYEE
GROUP BY ROLLUP(DEPT_ID, JOB_ID);

-- 누적 총계: 괄호 하나를 더 쓰면 소계는 나오지 않고 총계만 나옴
SELECT  DEPT_ID,
        JOB_ID,
        SUM(SALARY)
FROM    EMPLOYEE
GROUP BY ROLLUP((DEPT_ID, JOB_ID));

-- 누적 소계: 소계는 나오는데, 총계는 나오지 않음
SELECT  DEPT_ID,
        JOB_ID,
        SUM(SALARY)
FROM    EMPLOYEE
GROUP BY DEPT_ID, ROLLUP(JOB_ID);

SELECT  DEPT_ID,
        JOB_ID,
        SUM(SALARY)
FROM    EMPLOYEE
GROUP BY ROLLUP(DEPT_ID), JOB_ID;

/*
ROLLUP(DEPT_ID, JOB_ID)
DEPT_ID, JOB_ID
DEPT_ID
()
*/

-- ERD
-- EMPLOYEE, DEPARTMENT
SELECT  *
FROM    DEPARTMENT;

SELECT  *
FROM    EMPLOYEE;

-- 사원의 이름, 부서의 이름 조회
-- 즉, 두개의 컬럼 한번에 볼 수 있는 방법
-- JOIN
-- EQUALS JOIN
SELECT  EMP_NAME,
        DEPT_NAME,
        E.DEPT_ID
FROM    EMPLOYEE E, DEPARTMENT D
WHERE   E.DEPT_ID = D.DEPT_ID;

-- ANSI JOIN
/*
SELECT  ...
FROM    TABLE1
[INNER] JOIN    TABLE2  ON      (CONDITION)     -- SELECT절에 별칭 사용 가능
[INNER] JOIN    TABLE2  USING   (COLUMN)        -- SELECT절에 COLUMN 별칭 사용 불가

-- OUTER JOIN: 조건에 만족하지 않는 데이터까지 포함시키는 조인
LEFT | RIGHT | FULL [OUTER] JOIN    TABLE2  ON      (CONDITION)
LEFT | RIGHT | FULL [OUTER] JOIN    TABLE2  USING   (COLUMN)
*/

SELECT  EMP_NAME,
        DEPT_NAME,
        DEPT_ID
FROM    EMPLOYEE E
JOIN    DEPARTMENT D USING (DEPT_ID);

SELECT  EMP_NAME,
        DEPT_NAME,
        E.DEPT_ID   -- 누구껀지 정의 필요
FROM    EMPLOYEE E
JOIN    DEPARTMENT D ON E.DEPT_ID = D.DEPT_ID;

-- 3개 JOIN (EMPLOYEE, DEPARTMENT, JOB)
SELECT * FROM JOB;

SELECT  EMP_NAME,
        DEPT_NAME,
        DEPT_ID,
        JOB_TITLE
FROM    EMPLOYEE    E
JOIN    DEPARTMENT  D USING (DEPT_ID)
JOIN    JOB         J USING (JOB_ID);

SELECT  EMP_NAME,
        DEPT_NAME,
        E.DEPT_ID,
        JOB_TITLE
FROM    EMPLOYEE    E
JOIN    DEPARTMENT  D ON E.DEPT_ID = D.DEPT_ID
JOIN    JOB         J ON E.JOB_ID = J.JOB_ID;

-- LOC_DESCRIBE 출력해보기
-- USING 사용 불가 -> 부모와 자식의 KEYNAME이 다름 => USING, ON 섞어 사용
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;

SELECT  EMP_NAME,
        DEPT_NAME,
        DEPT_ID,
        JOB_TITLE,
        LOC_DESCRIBE
FROM    EMPLOYEE    E
JOIN    DEPARTMENT  D USING(DEPT_ID)
JOIN    JOB         J USING(JOB_ID)
JOIN    LOCATION    L ON (D.LOC_ID = L.LOCATION_ID);

-- 다 ON으로 해보기
SELECT  EMP_NAME,
        DEPT_NAME,
        E.DEPT_ID,
        JOB_TITLE,
        LOC_DESCRIBE
FROM    EMPLOYEE    E
JOIN    DEPARTMENT  D ON E.DEPT_ID = D.DEPT_ID
JOIN    JOB         J ON E.JOB_ID = J.JOB_ID
JOIN    LOCATION    L ON D.LOC_ID = L.LOCATION_ID;

-- NON-EQUALS JOIN: ON (CONDITION) 이용
SELECT  *
FROM    SAL_GRADE;

-- SALARY에 따른 SLEVEL 추가
SELECT  EMP_NAME,
        SALARY,
        SLEVEL
FROM    EMPLOYEE
JOIN    SAL_GRADE   ON  (SALARY BETWEEN LOWEST AND HIGHEST)
ORDER BY SLEVEL, SALARY DESC;

-- OUTER JOIN
-- ORACLE 기준 (+)붙어 있는 반대쪽의 모든 데이터 -> FULL JOIN 지원하지 않음
SELECT  EMP_NAME,
        DEPT_NAME
FROM    EMPLOYEE E, DEPARTMENT D
WHERE    E.DEPT_ID = D.DEPT_ID(+);

-- ANSI 표준: LEFT, RIGHT, FULL (OUTER) JOIN 모두 지원
SELECT  EMP_NAME,
        DEPT_NAME
FROM    EMPLOYEE E
FULL JOIN DEPARTMENT D USING (DEPT_ID);

-- 사원의 이름, 사수의 이름 셀프조인으로 조회하기
SELECT * FROM EMPLOYEE;

SELECT  E.EMP_ID,
        E.EMP_NAME,
        E.MGR_ID,
        M.EMP_NAME,
        S.EMP_NAME
FROM    EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MGR_ID = M.EMP_ID)
LEFT JOIN EMPLOYEE S ON (E.MGR_ID = S.EMP_ID);

-- LOC_DESCRIBE 아시아로 시작하고 직급이 대리인 사람의 이름, 부서이름 조회
SELECT  E.EMP_NAME,
        D.DEPT_NAME
FROM    EMPLOYEE    E
JOIN    DEPARTMENT  D   USING(DEPT_ID)
JOIN    JOB         J   USING(JOB_ID)
JOIN    LOCATION    L   ON(D.LOC_ID = L.LOCATION_ID)
WHERE   JOB_TITLE = '대리' AND LOC_DESCRIBE LIKE '아시아%';

-- SOL (JOIN 순서 고려)
SELECT  EMP_NAME,
        DEPT_NAME
FROM    JOB
JOIN    EMPLOYEE    USING(JOB_ID)
JOIN    DEPARTMENT  USING(DEPT_ID)
JOIN    LOCATION    ON (LOC_ID = LOCATION_ID)
WHERE   JOB_TITLE = '대리' AND LOC_DESCRIBE LIKE '아시아%';

-- SET 연산자
/*
두개 이상의 쿼리 결과를 하나로 결합시키는 연산자
- UNION     : 중복 제외 (합집합)
- UNION ALL : 중복 포함
- INTERSECT : 교집합
- MINUS     : 차집합
주의) 반드시 동일 컬럼 개수, 데이터 타입 -- 오류
*/
SELECT  *   FROM    EMPLOYEE_ROLE;

SELECT  EMP_ID,
        ROLE_NAME
FROM    EMPLOYEE_ROLE     
MINUS
SELECT  EMP_ID,
        ROLE_NAME
FROM    ROLE_HISTORY;

-- UNION 시 위의 컬럼의 HEADER NAME 을 따르기 때문에 별칭을 주는 것을 추천!
SELECT  TO_CHAR(SALARY),    -- DATA TYPE 이 같아야 SET 연산자 가능
        JOB_ID,
        HIRE_DATE
FROM    EMPLOYEE
UNION
SELECT  DEPT_NAME,
        DEPT_ID,
        NULL
FROM    DEPARTMENT
WHERE   DEPT_ID = 20;

-- UNION
-- 부서번호가 50번인 부서의 부서원을 관리자와 직원으로 구분, 사원번호, 이름, 구분 표시
-- 기준: EMP_ID = '141' 이면 관리자
SELECT * FROM EMPLOYEE;

SELECT  EMP_ID      AS 사원번호,
        EMP_NAME    AS 이름,
        '관리자'     AS 구분
FROM    EMPLOYEE
WHERE   DEPT_ID = 50 AND EMP_ID = 141
UNION
SELECT  EMP_ID,
        EMP_NAME,
        '직원'
FROM    EMPLOYEE
WHERE   DEPT_ID = 50 AND EMP_ID != 141
ORDER BY 3, 2;

SELECT  EMP_ID   AS 사원번호,
        EMP_NAME AS 이름,
        CASE WHEN EMP_ID = '141' THEN '관리자' ELSE '직원' END AS 구분
FROM    EMPLOYEE
WHERE   DEPT_ID = 50
ORDER BY 3, 2;

-- 같은 결과 나오게 만들기! (UNION 사용)
SELECT  EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE IN ('대리','사원');

SELECT  EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '대리'
UNION
SELECT  EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '사원'
ORDER BY 2,1;

-- SUBQUERY : 하나의 쿼리가 다른 쿼리를 포함하는 구조
/*
SELECT  EXPR(SELECT)    -- SCALAR SUBQUERY
FROM    (SELECT)        -- INLINE VIEW
WHERE   EXPR OPERATOR (SUBQUERY)
GROUP BY (SELECT)
HAVING   (SELECT)       -- GROUPBY, HAVING 둘 다 서브쿼리가 쓰일 수는 있지만 잘 쓰이지는 않는다.

유형
- 단일 행 서브쿼리 (단일 컬럼, 다중 컬럼)
- 다중 행 서브쿼리 (단일 컬럼, 다중 컬럼) - (IN, ANY, ALL)
*/

-- '나승원' 직원과 같은 부서원을 조회한다면?
SELECT  DEPT_ID
FROM    EMPLOYEE
WHERE   EMP_NAME = '나승원';

SELECT  *
FROM    EMPLOYEE
WHERE   DEPT_ID = (SELECT   DEPT_ID
                    FROM    EMPLOYEE
                    WHERE   EMP_NAME = '나승원');
                    
-- '나승원'과 같은 직급이면서 급여가 '나승원'보다 많이 받는 직원 조회  
SELECT  *
FROM    EMPLOYEE
WHERE   JOB_ID = (SELECT    JOB_ID
                  FROM      EMPLOYEE
                  WHERE     EMP_NAME = '나승원')
AND     SALARY > (SELECT    SALARY
                  FROM      EMPLOYEE
                  WHERE     EMP_NAME = '나승원');
                  
-- 최저급여 받는 사원의 정보 조회
SELECT  *
FROM    EMPLOYEE
WHERE   SALARY = (SELECT    MIN(SALARY)
                    FROM    EMPLOYEE);
                    
-- 부서별 급여 총합이 가장 높은 부서의 부서이름, 급여 총합 조회
SELECT  DEPT_NAME,
        SUM(SALARY)
FROM    EMPLOYEE
JOIN    DEPARTMENT USING(DEPT_ID)
GROUP BY DEPT_NAME
HAVING  SUM(SALARY) = (SELECT   MAX(SUM(SALARY))
                       FROM     EMPLOYEE
                       GROUP BY DEPT_ID);
                       
-- 다중 행 서브쿼리
/*
> ANY (서브쿼리 결과집합 최소보다 큰 값)
< ANY (결과집합의 최대보다 작은 값)

> ALL (서브쿼리 결과집합 최대보다 큰 값)
< ALL (결과집합의 최소보다 작은 값)

IN == =ANY / NOT IN (함께 쓰일 서브쿼리의 결과가 MUST NOT NULL)
*/

-- 관리자들만 조회한다면?
-- MGR_ID 에 EMP_ID 가 있다면 관리자
SELECT  EMP_ID,
        EMP_NAME,
        '관리자' AS "관리자 여부"
FROM    EMPLOYEE
WHERE   EMP_ID IN (SELECT   MGR_ID
                    FROM    EMPLOYEE)
UNION                    
-- 직원 조회
SELECT  EMP_ID,
        EMP_NAME,
        '직원' AS "관리자 여부"
FROM    EMPLOYEE
WHERE   EMP_ID NOT IN (SELECT MGR_ID 
                       FROM   EMPLOYEE
                       WHERE  MGR_ID IS NOT NULL)
ORDER BY 3;

-- 대리 직급의 사원의 이름, 급여 조회
SELECT * FROM EMPLOYEE;
SELECT * FROM JOB;

SELECT  EMP_NAME,
        SALARY,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '대리'
UNION
-- 과장 직급의 사원의 이름, 급여 조회
SELECT  EMP_NAME,
        SALARY,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '과장'
ORDER BY 3;

SELECT  EMP_NAME,
        SALARY,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE IN ('과장','대리');

-- 과장 직급보다 많은 급여를 받는 대리 직급의 사원이름, 급여 조회
SELECT  EMP_NAME, SALARY
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '대리' AND SALARY > ANY (SELECT   SALARY
                                             FROM   EMPLOYEE
                                             JOIN   JOB USING(JOB_ID)
                                             WHERE  JOB_TITLE = '과장');
                                             
-- 직급별(JOB_TITLE) 평균급여 조회
-- 계산의 편의를 위해 정수 5자리에서 절삭 (TRUNC)
SELECT  JOB_TITLE,
        TRUNC(AVG(SALARY), -5)
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
GROUP BY JOB_TITLE;

/*
단일 컬럼을 사용했을 때 문제점?
- JOB_TITLE 에 맞는 SALARY를 가져오기가 어려움
-> 다중컬럼으로 가져와야 함!(JOB_TITLE, SALARY)
*/
-- 자기 직급의 평균 급여를 받는 직원의 이름, 직급, 급여 조회
-- 01. SUBQUERY (WHERE)
SELECT * FROM EMPLOYEE;

SELECT  EMP_NAME,
        JOB_TITLE,
        SALARY
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   (JOB_TITLE, SALARY) IN (SELECT  JOB_TITLE, TRUNC(AVG(SALARY), -5)
                                FROM    EMPLOYEE
                                JOIN    JOB USING(JOB_ID)
                                GROUP BY JOB_TITLE);
                                
-- 02. FROM SUBQUERY (INLINE VIEW)
SELECT  EMP_NAME,
        JOB_TITLE,
        SALARY
FROM    (SELECT     JOB_ID,
                    TRUNC(AVG(SALARY), -5) AS SALAVG
         FROM       EMPLOYEE
         JOIN       JOB USING(JOB_ID)
         GROUP BY   JOB_ID) V
JOIN     EMPLOYEE E ON (V.JOB_ID = E.JOB_ID AND SALARY = SALAVG)
JOIN     JOB J ON (J.JOB_ID = E.JOB_ID);

-- 03. 상관관계 서브쿼리 (CORRELATED SUBQUERY)
-- 메인쿼리에서 처리되는 각 행의 값에 따라 서브쿼리의 결과값이 달라지는 경우
-- 서브쿼리 내의 E.JOB_ID가 핵심!
SELECT  EMP_NAME,
        JOB_TITLE,
        SALARY
FROM    EMPLOYEE E
JOIN    JOB      J  ON (E.JOB_ID = J.JOB_ID)
WHERE   SALARY = (SELECT    TRUNC(AVG(SALARY), -5)
                  FROM      EMPLOYEE
                  WHERE     JOB_ID = E.JOB_ID);
                  
-- 직무(JOB_TITLE)별로 최대 급여를 받는 직원의 직무, 이름, 급여
-- JOB_TITLE 기준 오름차순 정렬하여 출력
SELECT  EMP_NAME,
        JOB_TITLE,
        SALARY
FROM    EMPLOYEE E
JOIN    JOB      J ON (E.JOB_ID = J.JOB_ID)
WHERE   SALARY  = (SELECT   MAX(SALARY)
                    FROM    EMPLOYEE
                    WHERE   JOB_ID = E.JOB_ID)
ORDER BY E.JOB_ID;
