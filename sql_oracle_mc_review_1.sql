-- SQL REVIEW
-- COMMENT
-- �˻� (SELECT)
/*
MULTILINE COMMENT
Ű���� - �빮��
������ - ��ҹ��� ����
�������� ���� �� �����Ͽ� �ۼ�

PARSING
- SELECT - FROM - WHERE - GROUP BY - HAVING - ORDER BY
SELECT * | [DISTINCT] COLUMN_NAM | EXPR | [AS] ALIAS - ���������� �ϴ� �÷� ����Ʈ
FROM    TABLE_NAME                      - ��� ���̺�
-- WHERE   SEARCH_CONDITION                - �࿡ ���� ����
-- GROUP BY   ���� �÷�                     - �׷���
-- HAVING  SEARCH_CONDITION                - �׷쿡 ���� ����
-- ORDER BY   ���� �÷� [ASC | DESC]        - ������ �� ���
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

-- ǥ���� (�÷� ���� ���� ��� ����)
-- ��Ī ����) Ư������(����, ��ȣ, &, ����) ���Ե� ��� �ݵ�� ""�ؾ� ��
-- cf) ''�� ������! ��Ī ����� �� ''����ϸ� �ȵ�

SELECT  EMP_NAME, SALARY, 
        SALARY * 12 AS ANNUAL_SALARY,
        (SALARY + (SALARY * BONUS_PCT)) * 12 AS "12��������"
FROM    EMPLOYEE;

-- ���� �÷� �߰� (�÷� ���� ���߱�)
SELECT  EMP_ID,
        EMP_NAME,
        '����' AS �ٹ�����
FROM    EMPLOYEE;        

-- DISTINCT (�ߺ� ����)
-- SELECT ���� �� �ѹ��� ����� �� �ִ�

-- DEPT_ID �� JOB_ID �� COMPOSITE �ؼ� �ϳ��� UNIQUE �� ������ �ν��Ѵ�.
SELECT  DISTINCT DEPT_ID , 
        JOB_ID 
FROM    EMPLOYEE ; 

-- WHERE �࿡ ���� ����
-- �޿��� 4000000 ���� ���� ����� �̸��� �޿� ��ȸ
SELECT  EMP_NAME, SALARY
FROM    EMPLOYEE
WHERE   SALARY > 4000000;

-- �̰� AND
-- �μ��ڵ尡 90�̰� �޿��� 2000000 ���� ���� ����� �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT  EMP_NAME AS �̸�,
        DEPT_ID  AS �μ��ڵ�,
        SALARY   AS �޿�
FROM    EMPLOYEE
WHERE   DEPT_ID = '90' AND SALARY > 2000000;

-- �̰ų� OR
-- �μ��ڵ尡 90�̰ų� 20�� �μ����� �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT  EMP_NAME AS �̸�,
        DEPT_ID  AS �μ��ڵ�,
        SALARY   AS �޿�
FROM    EMPLOYEE
WHERE   DEPT_ID = 90 OR DEPT_ID = 20;

SELECT  EMP_NAME AS �̸�,
        DEPT_ID  AS �μ��ڵ�,
        SALARY   AS �޿�
FROM    EMPLOYEE
WHERE   DEPT_ID IN ('90', '20');

-- WHERE (������)
-- ���Ῥ���� || : �������� �÷��̳� ���ڿ����� �ϳ��� �������� ���� �� ����
SELECT  EMP_NAME||'�� ������ '||SALARY||'�� �Դϴ�.' AS ����
FROM    EMPLOYEE;

-- �������� (AND, OR, NOT)
-- �񱳿����� (=, >, <, >=, <=, !=, BETWEEN ~ AND ~, LIKE, NOT LIKE, IS NULL, IS NOT NULL,IN)

-- ������̺�κ��� �޿��� 3500000 ���� ���� �ް� 5500000 ���� ���� �޴� ������ �̸�, �޿� ��ȸ
-- ���Ѱ��� ���� ���Ѱ��� ��� ����
SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE
WHERE   SALARY >= 3500000 AND SALARY <= 5500000;

SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE
WHERE   SALARY BETWEEN 3500000 AND 5500000;

-- ������̺��� '��'�� ���� ���� ������ �̸�, �޿� ��ȸ
-- LIKE: ���� �˻� %, _
SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE
WHERE   EMP_NAME LIKE '��%';

-- EMAIL���� ����� �� �ڸ����� ���ڸ��� ����� ���
/*
- ����� �� ���ڸ� ǥ�ÿ� ��谡 ��ȣ�ϱ� ������ ESCAPE �� ������ ����
- ESCAPE �ڿ� �ִ� �� ���ڷ� ���� ���� �����ͷ� ����� �ǹ�
*/
SELECT  EMP_NAME,
        EMAIL
FROM    EMPLOYEE
WHERE   EMAIL LIKE '___\_%' ESCAPE '\';

-- �����ȣ�� ���� �μ� ��ġ�� ���� ���� ����� �̸�, �����ȣ, �μ� ���
-- DATA�� NULL�� ���, = ���� �� �Ұ� -> IS NULL, IS NOT NULL ���
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

-- �������� �ϸ�? > ��°� �ȳ���
SELECT  EMP_NAME,
        MGR_ID,
        DEPT_ID
FROM    EMPLOYEE
WHERE   MGR_ID = '' AND DEPT_ID = '';

-- �μ� ��ġ�� ���� �ʾ������� ���ʽ��� ���޹޴� ������ �̸�, �μ��ڵ�, ���ʽ� ��ȸ
SELECT  EMP_NAME, DEPT_ID, BONUS_PCT 
FROM    EMPLOYEE
WHERE   (DEPT_ID IS NULL) AND (BONUS_PCT IS NOT NULL);

-- ������ �켱���� : ��� > ���� > �� > ��(NOT, AND, OR)