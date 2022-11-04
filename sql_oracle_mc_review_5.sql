-- DML (INSERT, UPDATE, DELETE)
-- TRANSACTION - COMMIT, ROLLBACK

-- ������ ���� ����
-- UPDATE�Ϸ��� COLUMN�� FK�� ���, �������� ���Ἲ ���������� ������ �� (������ UPDATE �Ұ�)
/*
���Ἲ ����
            �θ�      �ڽ�
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
                  WHERE     EMP_NAME = '���ر�'),
        DEPT_ID = '90'
WHERE   EMP_NAME = '���ϱ�';

UPDATE  EMPLOYEE
SET     MARRIAGE = DEFAULT
WHERE   EMP_ID = '100';

-- INSERT
/*
INSERT INTO TABLE_NAME (COLUMN_NAME)
VALUES (VALUE1, VALUE2, ..., DEFAULT)

INSERT INTO TABLE_NAME (COLUMN_NAME)
SUBQUERY
-- ���̺� ������ �������� �ٸ� ���̺��� �����͸� �������� ���� �� ��밡��

- ������ Ÿ�� ��ġ
- ���� ��ġ
- ���� ��ġ
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO)
VALUES ('901','ȫ�浿','234567-2345678');

-- DELETE : ���̺� ���Ե� ���� ������ ���� (���̺� ���� ����)
/*
DELETE FROM TABLE_NAME
[WHERE  CONDITION] ;

TRUNCATE TABLE TABLE_NAME;
-- COMMIT, ROLLBACK ���� �Ұ� <> DELETE
*/

SELECT * FROM DEPARTMENT;

-- ERROR [integrity constraint (HR.FK_DEPTID) violated - child record found] :���Ἲ ���� ���� ����
DELETE FROM DEPARTMENT
WHERE LOC_ID LIKE 'A%';

-- ERROR [integrity constraint (HR.FK_JOBID) violated - child record found] :���Ἲ ���� ���� ����
DELETE FROM JOB
WHERE JOB_ID = 'J2';

-- ERROR [integrity constraint (HR.FK_MGRID) violated - child record found] :���Ἲ ���� ���� ����
DELETE FROM EMPLOYEE
WHERE EMP_ID = '141';

-- TRANSACTION
-- �������� �ϰ����� �����ϱ� ���� ����ϴ� �������� ������ �۾����� ����
-- �ϳ� �̻��� ������ DML ����

>INSERT~~
>UPDATE~~
>COMMIT/ROLLBACK

>UPDATE
>DELETE
>CREATE(DDL) - AUTO COMMIT