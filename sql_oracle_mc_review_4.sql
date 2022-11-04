-- REVIEW 4
-- DDL (DATA DEFINITION LANGUAGE)
/*
RDBMS�� 2������ ���̺��������� ������ ���� -> ��ü(OBJECT) -> ��Ű��(SCHEMA) : ���̺� ����(����ȭ)

TABLE: �������� �޸� ���� Ȯ��
VIEW : ������ ���̺�
SEQUENCE (��ü)
INDEX

-- CONSTRAINT (PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE, CHECK)
-- �������� ���Ἲ ����, �������� �ߺ��� ���� �� ����
[�⺻����] DEFAULT, CONSTRAINT ������ �߿�!
CREATE TABLE TABLE_NAME (
    COLUMN_NAME DATATYPE [DEFAULT EXPR] [COLUMN_CONSTRAINT],
    COLUMN_NAME DATATYPE [DEFAULT EXPR] [COLUMN_CONSTRAINT],
    ...
    [TABLE_CONSTRAINT]
);

-- INSERT
INSERT INTO TABLE_NAME(COLUMNS) VALUES(?, ?, ?, ?) ;
*/
-- DROP TABLE TEST01;
CREATE TABLE TEST01(
    ID         NUMBER(5),
    NAME       VARCHAR2(50),
    ADDRESS    VARCHAR2(50),
    REGDATE    DATE DEFAULT SYSDATE
);

-- �������� NULL > DEFAULT �ɼ� ����
INSERT INTO TEST01(ID, NAME, ADDRESS)
VALUES(100, 'ȫ�浿', '����');

-- DEFAULT�� �������� NULL�� �� �Ҵ�Ǵ� ���̰�, ������� NULL�� ���� �Ǹ� DEFAULT VALUE �� �ƴ� NULL�� ��
INSERT INTO TEST01
VALUES(100, 'ȫ�浿', '����', NULL);

-- ������� DEFAULT > DEFAULT �ɼ� ����
INSERT INTO TEST01
VALUES(100, 'ȫ�浿', '����', DEFAULT);

SELECT  *
FROM    TEST01;

-- NOT NULL
-- TABEL LEVEL�� CONSTRAINT�� �� �� ����
-- DROP TABLE TEST_NN;

-- UNIQUE
CREATE TABLE TEST_NN(
    ID      VARCHAR2(50)    UNIQUE,
    PWD     VARCHAR2(50)
);
INSERT INTO TEST_NN VALUES('GDKIM','GDKIM');
INSERT INTO TEST_NN VALUES(NULL, 'GDKIM');
SELECT  *
FROM    TEST_NN;

-- PRIMARY KEY: ���̺� �� 1���� ����
-- NOT NULL + UNIQUE
-- �ΰ� �̻��� COLUMNS�� COMPOSITE �ؼ� PK�� ��� ���� ��� TABLE LEVEL CONSTRAINT�� ó��
-- DROP TABLE TEST_PK;
CREATE TABLE TEST_PK(
    ID      VARCHAR2(50),
    NAME    VARCHAR2(50),
    PRIMARY KEY(ID, NAME)
);
INSERT INTO TEST_PK
VALUES ('GDKIM','GDKIM');

INSERT INTO TEST_PK
VALUES('JSLIM', 'ȫ�浿');

SELECT  *
FROM    TEST_PK;
-- ('JSLIM','JSLIM'), ('JSLIM','�Ӽ���') �� COMPOSITE�Ǿ� ���� �ϳ��� Ű�� �Ǳ� ������, �ߺ��� ���� �ƴϴ�! > OK!

-- FOREIGN KEY (TAGEL_LEVEL CONSTRAINT), REFERENCE(COL_LEVEL CONSTRAINT)
-- �θ� �����ϴ� �������̰ų� NULL�� ���

-- DML (DELETE ~~)
-- REFERENCES [ON DELETE SET NULL]
-- REFERENCES [ON DELETE CASCADE]

-- DROP TABLE LOC;
CREATE TABLE LOC(
    LOCATION_ID     VARCHAR(50) PRIMARY KEY,
    LOC_DESC        VARCHAR(50)
);

-- �ڽĺ��� ���Ÿ� �ؾ� �θ� ���̺��� ���� ��
-- DROP TABLE DEPT;
CREATE TABLE DEPT(
    DEPT_ID     NUMBER(5)   PRIMARY KEY,
    DEPT_NAME   VARCHAR2(50),
    LOC_ID      VARCHAR2(50)   NOT NULL,
    FOREIGN KEY(LOC_ID) REFERENCES LOC(LOCATION_ID) -- FOREIGN KEY TABLE LEVEL�� ������!
);
INSERT INTO DEPT VALUES(10, '�λ���', 10);
INSERT INTO DEPT VALUES(20, '������', 20);
INSERT INTO DEPT VALUES(30, 'ȸ����', 20);

SELECT * FROM DEPT;

SELECT  DEPT_NAME,
        LOC_DESC
FROM    DEPT
JOIN    LOC ON(LOCATION_ID = LOC_ID);

-- DROP TABLE EMP;
CREATE TABLE EMP(
    EMP_ID      VARCHAR(50) PRIMARY KEY,
    EMP_NAME    VARCHAR(50),
    DEPT_ID     NUMBER(5)   REFERENCES DEPT(DEPT_ID)
);
-- INSERT INTO EMP VALUES('100', 'ȫ�浿', 40); -- ERROR [integrity constraint (HR.SYS_C007070) violated - parent key not found]

INSERT INTO EMP VALUES('100','GDKIM',10);
INSERT INTO EMP VALUES('200','GDKIM',NULL); -- �ܷ�Ű NULL ���
SELECT  *   FROM EMP;

-- COMPOSITE PRIMARY KEY�� ���
-- DROP TABLE SUPER_PK CASCADE CONSTRAINTS;
CREATE TABLE SUPER_PK(
    U_ID    VARCHAR2(20),
    P_ID    VARCHAR2(20),
    O_DATE  DATE,
    AMOUNT  NUMBER,             -- NUMBER �� SIZE �� �ʿ� ����
    PRIMARY KEY(U_ID, P_ID)
);
INSERT INTO SUPER_PK VALUES('GDKIM','P100',SYSDATE,10000);

--DROP TABLE SUB_FK;
CREATE TABLE SUB_FK(
    SUB_ID  VARCHAR2(20) PRIMARY KEY,
    U_ID    VARCHAR2(20),
    P_ID    VARCHAR2(20),
    FOREIGN KEY(U_ID, P_ID) REFERENCES SUPER_PK(U_ID, P_ID) ON DELETE CASCADE
);

-- �θ��� PK�� �޾Ƽ� ������ FK �� PK�� ����ϴ� ��� (1:1���� ����)
-- DROP TABLE SUB_FK;
CREATE TABLE SUB_FK(
    SUB_ID  VARCHAR2(20),
    U_ID    VARCHAR2(20),
    P_ID    VARCHAR2(20),
    FOREIGN KEY(U_ID, P_ID) REFERENCES SUPER_PK(U_ID, P_ID) ON DELETE CASCADE,
    PRIMARY KEY(SUB_ID, U_ID, P_ID)
);
INSERT INTO SUB_FK VALUES('SUB100', 'GDKIM', 'P100');
SELECT * FROM SUB_FK;

-- CHECK
-- ������ ������ �� ���ϴ� ���� �������� ����� �� ����
-- DROP TABLE TEST_CK;
CREATE TABLE TEST_CK(
    ID          VARCHAR2(50) PRIMARY KEY,
    SALARY      NUMBER,
--    HIRE_DATE   DATE CHECK(HIRE_DATE < SYSDATE),
    MARRIAGE    CHAR(1),
    CHECK( SALARY BETWEEN 0 AND 100 ),
    CHECK( MARRIAGE IN ('Y','N'))
);
INSERT INTO TEST_CK VALUES('100','100','N');
SELECT * FROM TEST_CK;

-- ALTER (���̺� ���� �� ����)
/*
- �÷� �߰�
ALTER TABLE TABLE_NAME ADD COLUMN_NAME DATATYPE [DEFAULT] [CONSTRAINTS];
- �÷� CONDITION ����
ALTER TABLE TABLE_NAME MODIFY COLUMN_NAME [CONDITION];
*/

-- DROP
-- DROP TABLE TABLE_NAME [CASCADE CONSTRAINTS];

-- VIEW
-- ���̺��� �κ��������� ���� �����̳� ������ ������ �ܼ�ȭ�ϱ� ���ؼ� ���
-- ���� ��(INSERT, UPDATE, DELETE ���� > ���� TABLE�� �ݿ�), ���� ��(I, U, D X)
-- ������ �б�����
-- DROP VIEW VIEW_NAME;

/*
[�⺻����]
CREATE [OR REPLACE] VIEW VIEW_NAME(ALIAS: HEADER �� ��Ī�ο� ����)
AS {SUBQUERY};
*/

-- �μ���ȣ�� 90�� ����� �̸�, �μ���ȣ�� ������ �� �ִ� �並 �����Ѵٸ�?
CREATE OR REPLACE VIEW V_EMP_90(�̸�, �μ���ȣ)
AS SELECT   EMP_NAME,
            DEPT_ID
   FROM     EMPLOYEE
   WHERE    DEPT_ID = '90';

-- VIEW SELECT ����
SELECT * FROM V_EMP_90;

CREATE OR REPLACE VIEW V_TEST(A, B, C)
AS SELECT   E.EMP_NAME,
            JOB_TITLE,
            V.JOBAVG
   FROM     (SELECT     JOB_ID,
                        TRUNC(AVG(SALARY), -5) AS JOBAVG
             FROM       EMPLOYEE
             JOIN       JOB USING(JOB_ID)
             GROUP BY   JOB_ID) V
   JOIN      EMPLOYEE E ON (JOBAVG = SALARY AND E.JOB_ID = V.JOB_ID)
   JOIN      JOB J ON (J.JOB_ID = E.JOB_ID);
   
SELECT * FROM V_TEST;

-- �ζ��� �並 Ȱ���� TOP N �м� ����
-- ���ǿ� �´� �ֻ��� �Ǵ� ������ ���ڵ� N�� �ĺ��� ���
/*
�м� ����
- ����
-- ROWNUM �̶�� ������ �÷��� �̿��� ���� ������� ���� �ο�
-- ROWNUM : EQUAL(=)�δ� �ֻ��� 1�Ǹ� ��� ���� (ROWNUM=1), ��ȣ(<,>,<=,>=) ����ؾ� ���� �� ��� ����
-- �ο��� ������ �̿��ؼ� �ʿ��� �� ��ŭ �ĺ�
*/
SELECT  ROWNUM,
        EMP_NAME
FROM    EMPLOYEE;        

-- �μ��� �޿� ��պ��� ���� �޴� ��� ��ȸ
SELECT  ROWNUM,
        EMP_NAME,
        SALARY
FROM(   SELECT  DEPT_ID,
                ROUND(AVG(SALARY), -3) AS DAVG
        FROM    EMPLOYEE
        GROUP BY DEPT_ID) V
JOIN    EMPLOYEE E ON (E.DEPT_ID = V.DEPT_ID)
WHERE   SALARY > V.DAVG
AND ROWNUM <= 5;
--ORDER BY 3 DESC;     -- �̷��� �Ǹ� SALARY ��� ������ ������, ROWNUM�� ���׹��׵�!

SELECT  ROWNUM, EMP_NAME, SALARY
FROM(   SELECT  EMP_NAME,
                SALARY
        FROM(   SELECT  DEPT_ID,
                        ROUND(AVG(SALARY), -3) AS DAVG
                FROM    EMPLOYEE
                GROUP BY DEPT_ID) V
        JOIN    EMPLOYEE E ON (E.DEPT_ID = V.DEPT_ID)
        WHERE   SALARY > V.DAVG
        ORDER BY 2 DESC)
WHERE   ROWNUM = 1;

-- RANK()�� �̿��� TOP-N �м�
SELECT  *
FROM(   SELECT  EMP_NAME,
                SALARY,
                RANK() OVER(ORDER BY SALARY DESC) AS RANK
        FROM    EMPLOYEE)
WHERE   RANK = 5;

-- SEQUENCE
-- ���������� ���� ���� �ڵ����� �������ִ� ��ü
-- �Խñۿ��� �� �� ������ �Խñ� ��ȣ�� 1�� �����ϴ� ����
-- 1���� ���������� �������� NUMBER ����,NO CYCLE, NO CASHE
/*
CREATE SEQUENCE SEQUENCE_NAME;
CREATE SEQUENCE SEQUENCE_NAME
START WITH 10           -- 10���� �����ҷ�
INCREMENT BY 10         -- 10�� ������ų��
MAXVALUE 100;           -- 100���� �ҷ�
*/
-- NEXTVAL, CURRVAL

CREATE SEQUENCE TEST_SEQ START WITH 10;
SELECT TEST_SEQ.NEXTVAL FROM DUAL;     -- �ѹ��� ���� ������ +1
SELECT TEST_SEQ.CURRVAL FROM DUAL;     -- ������ ä���� RETURN

DROP SEQUENCE TEST_SEQ;