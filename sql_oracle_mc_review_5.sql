-- DML (INSERT, UPDATE, DELETE)
-- TRANSACTION - COMMIT, ROLLBACK

-- 데이터 갱신 구문
-- UPDATE하려는 COLUMN이 FK인 경우, 데이터의 무결성 제약조건을 따져야 함 (무조건 UPDATE 불가)
/*
무결성 제약
            부모      자식
UPDATE       X         O
INSERT       O         O
DELETE       X         O
*/

/*
UPDATE  TABLE_NAME
SET     COLUMN_NAME = VALUE | SUBQUERY, [COLUMN_NAME = VALUE]
[WHERE  CONDITION]
*/
SELECT  *
FROM    EMPLOYEE;

UPDATE  EMPLOYEE
SET     JOB_ID = (SELECT    JOB_ID
                  FROM      EMPLOYEE
                  WHERE     EMP_NAME = '성해교'),
        DEPT_ID = '90'
WHERE   EMP_NAME = '심하균';

UPDATE  EMPLOYEE
SET     MARRIAGE = DEFAULT
WHERE   EMP_ID = '100';

-- INSERT
/*
INSERT INTO TABLE_NAME (COLUMN_NAME)
VALUES (VALUE1, VALUE2, ..., DEFAULT)

INSERT INTO TABLE_NAME (COLUMN_NAME)
SUBQUERY
-- 테이블 구조만 만들어놓고 다른 테이블에서 데이터를 가져오고 싶을 때 사용가능

- 데이터 타입 일치
- 순서 일치
- 개수 일치
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO)
VALUES ('901','홍길동','234567-2345678');

-- DELETE : 테이블에 포함된 기존 데이터 삭제 (테이블 구조 유지)
/*
DELETE FROM TABLE_NAME
[WHERE  CONDITION] ;

TRUNCATE TABLE TABLE_NAME;
-- COMMIT, ROLLBACK 제어 불가 <> DELETE
*/

SELECT * FROM DEPARTMENT;

-- ERROR [integrity constraint (HR.FK_DEPTID) violated - child record found] :무결성 제약 조건 위배
DELETE FROM DEPARTMENT
WHERE LOC_ID LIKE 'A%';

-- ERROR [integrity constraint (HR.FK_JOBID) violated - child record found] :무결성 제약 조건 위배
DELETE FROM JOB
WHERE JOB_ID = 'J2';

-- ERROR [integrity constraint (HR.FK_MGRID) violated - child record found] :무결성 제약 조건 위배
DELETE FROM EMPLOYEE
WHERE EMP_ID = '141';

-- TRANSACTION
-- 데이터의 일관성을 유지하기 위해 사용하는 논리적으로 연관된 작업들의 집합
-- 하나 이상의 연관된 DML 구문

>INSERT~~
>UPDATE~~
>COMMIT/ROLLBACK

>UPDATE
>DELETE
>CREATE(DDL) - AUTO COMMIT