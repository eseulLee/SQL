-- REVIEW 3
-- ORDER BY
SELECT  *
FROM    EMPLOYEE;

SELECT  *
FROM    EMPLOYEE
ORDER BY SALARY DESC, EMP_NAME DESC;

-- ORDER BY ���� ��Ī ��� ����
SELECT  EMP_NAME  AS �̸�,
        HIRE_DATE AS �Ի���,
        DEPT_ID   AS �μ��ڵ�
FROM    EMPLOYEE
ORDER BY �μ��ڵ� DESC, �Ի���, �̸�;    

-- �ε��� ��� ����
-- SELECT ���� ���õ� ������� 1, 2, 3 ���� �ε��� �ο�
SELECT  EMP_NAME    AS �̸�,
        HIRE_DATE   AS �Ի���,
        DEPT_ID     AS �μ��ڵ�
FROM    EMPLOYEE
ORDER BY 3 DESC, 2, 1;

-- GROUP BY: ���� ������ �׷�
-- WORKBOOK_FUNC_10
SELECT  DEPARTMENT_NO AS �а���ȣ,
        COUNT(*) AS "�л���(��)"
FROM    TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- �μ��� ��� �޿� ��ȸ
SELECT  DEPT_ID     AS �μ���ȣ,
        ROUND(AVG(SALARY),-4) AS ��ձ޿�
FROM    EMPLOYEE
GROUP BY DEPT_ID
ORDER BY 1;

-- GROUP BY ���� ��Ī �� �ε��� ���Ұ�
-- ���� SELECT ���� �׷��Լ��� ���� �Ϲ� COLUMN�� ��������, GROUP BY�� �����÷��� ����� �ش� �÷��� SELECT���� �� �� �ִ�.
-- ������ ���� ��ձ޿� ��ȸ
-- �����÷��� GROUP BY �� �״�� ���°� ���� ������ �Ʒ�ó�� �ϴ°� BETTER! (GROUP BY �� ǥ���ĵ� �����ϱ���~)

SELECT  CASE WHEN SUBSTR(EMP_NO, 8, 1) IN ('1','3') THEN 'MALE' ELSE 'FEMALE' END AS ����,
        ROUND(AVG(SALARY),-4) AS ��ձ޿�
FROM    EMPLOYEE
GROUP BY CASE WHEN SUBSTR(EMP_NO, 8, 1) IN ('1','3') THEN 'MALE' ELSE 'FEMALE' END;

-- DEPT_ID, EMP_NAME �� COMPOSITE �ؼ� �ϳ��� SET���� ���� COUNTING!
SELECT  DEPT_ID,
        EMP_NAME,
        COUNT(*)
FROM    EMPLOYEE
GROUP BY DEPT_ID, EMP_NAME;

-- �μ��� �޿� ���� + ������ 900 �̻��� �׷츸 GROUPING �ϰ� �ʹٸ�?
SELECT  DEPT_ID,
        SUM(SALARY)
FROM    EMPLOYEE
GROUP BY DEPT_ID
HAVING  SUM(SALARY) >= 9000000;

-- ROLLUP()
-- �Ұ�, �Ѱ� ��� Ȯ��: �ΰ��� COMPOSITE �ؼ� �ϳ��� GROUP ����
-- 1 COL �������� �Ұ�, �Ѱ� ���
-- GROUPING(): GROUP�� ���ϸ� 0, �ƴϸ� 1 (���⼭ �ƴ� ���� �Ұ�, �Ѱ��� ���)
SELECT  DEPT_ID,
        GROUPING(DEPT_ID) AS D_ID,
        JOB_ID,
        GROUPING(JOB_ID)  AS J_ID,
        SUM(SALARY)
FROM    EMPLOYEE
GROUP BY ROLLUP(DEPT_ID, JOB_ID);

-- ���� �Ѱ�: ��ȣ �ϳ��� �� ���� �Ұ�� ������ �ʰ� �Ѱ踸 ����
SELECT  DEPT_ID,
        JOB_ID,
        SUM(SALARY)
FROM    EMPLOYEE
GROUP BY ROLLUP((DEPT_ID, JOB_ID));

-- ���� �Ұ�: �Ұ�� �����µ�, �Ѱ�� ������ ����
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

-- ����� �̸�, �μ��� �̸� ��ȸ
-- ��, �ΰ��� �÷� �ѹ��� �� �� �ִ� ���
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
[INNER] JOIN    TABLE2  ON      (CONDITION)     -- SELECT���� ��Ī ��� ����
[INNER] JOIN    TABLE2  USING   (COLUMN)        -- SELECT���� COLUMN ��Ī ��� �Ұ�

-- OUTER JOIN: ���ǿ� �������� �ʴ� �����ͱ��� ���Խ�Ű�� ����
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
        E.DEPT_ID   -- �������� ���� �ʿ�
FROM    EMPLOYEE E
JOIN    DEPARTMENT D ON E.DEPT_ID = D.DEPT_ID;

-- 3�� JOIN (EMPLOYEE, DEPARTMENT, JOB)
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

-- LOC_DESCRIBE ����غ���
-- USING ��� �Ұ� -> �θ�� �ڽ��� KEYNAME�� �ٸ� => USING, ON ���� ���
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

-- �� ON���� �غ���
SELECT  EMP_NAME,
        DEPT_NAME,
        E.DEPT_ID,
        JOB_TITLE,
        LOC_DESCRIBE
FROM    EMPLOYEE    E
JOIN    DEPARTMENT  D ON E.DEPT_ID = D.DEPT_ID
JOIN    JOB         J ON E.JOB_ID = J.JOB_ID
JOIN    LOCATION    L ON D.LOC_ID = L.LOCATION_ID;

-- NON-EQUALS JOIN: ON (CONDITION) �̿�
SELECT  *
FROM    SAL_GRADE;

-- SALARY�� ���� SLEVEL �߰�
SELECT  EMP_NAME,
        SALARY,
        SLEVEL
FROM    EMPLOYEE
JOIN    SAL_GRADE   ON  (SALARY BETWEEN LOWEST AND HIGHEST)
ORDER BY SLEVEL, SALARY DESC;

-- OUTER JOIN
-- ORACLE ���� (+)�پ� �ִ� �ݴ����� ��� ������ -> FULL JOIN �������� ����
SELECT  EMP_NAME,
        DEPT_NAME
FROM    EMPLOYEE E, DEPARTMENT D
WHERE    E.DEPT_ID = D.DEPT_ID(+);

-- ANSI ǥ��: LEFT, RIGHT, FULL (OUTER) JOIN ��� ����
SELECT  EMP_NAME,
        DEPT_NAME
FROM    EMPLOYEE E
FULL JOIN DEPARTMENT D USING (DEPT_ID);

-- ����� �̸�, ����� �̸� ������������ ��ȸ�ϱ�
SELECT * FROM EMPLOYEE;

SELECT  E.EMP_ID,
        E.EMP_NAME,
        E.MGR_ID,
        M.EMP_NAME,
        S.EMP_NAME
FROM    EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MGR_ID = M.EMP_ID)
LEFT JOIN EMPLOYEE S ON (E.MGR_ID = S.EMP_ID);

-- LOC_DESCRIBE �ƽþƷ� �����ϰ� ������ �븮�� ����� �̸�, �μ��̸� ��ȸ
SELECT  E.EMP_NAME,
        D.DEPT_NAME
FROM    EMPLOYEE    E
JOIN    DEPARTMENT  D   USING(DEPT_ID)
JOIN    JOB         J   USING(JOB_ID)
JOIN    LOCATION    L   ON(D.LOC_ID = L.LOCATION_ID)
WHERE   JOB_TITLE = '�븮' AND LOC_DESCRIBE LIKE '�ƽþ�%';

-- SOL (JOIN ���� ���)
SELECT  EMP_NAME,
        DEPT_NAME
FROM    JOB
JOIN    EMPLOYEE    USING(JOB_ID)
JOIN    DEPARTMENT  USING(DEPT_ID)
JOIN    LOCATION    ON (LOC_ID = LOCATION_ID)
WHERE   JOB_TITLE = '�븮' AND LOC_DESCRIBE LIKE '�ƽþ�%';

-- SET ������
/*
�ΰ� �̻��� ���� ����� �ϳ��� ���ս�Ű�� ������
- UNION     : �ߺ� ���� (������)
- UNION ALL : �ߺ� ����
- INTERSECT : ������
- MINUS     : ������
����) �ݵ�� ���� �÷� ����, ������ Ÿ�� -- ����
*/
SELECT  *   FROM    EMPLOYEE_ROLE;

SELECT  EMP_ID,
        ROLE_NAME
FROM    EMPLOYEE_ROLE     
MINUS
SELECT  EMP_ID,
        ROLE_NAME
FROM    ROLE_HISTORY;

-- UNION �� ���� �÷��� HEADER NAME �� ������ ������ ��Ī�� �ִ� ���� ��õ!
SELECT  TO_CHAR(SALARY),    -- DATA TYPE �� ���ƾ� SET ������ ����
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
-- �μ���ȣ�� 50���� �μ��� �μ����� �����ڿ� �������� ����, �����ȣ, �̸�, ���� ǥ��
-- ����: EMP_ID = '141' �̸� ������
SELECT * FROM EMPLOYEE;

SELECT  EMP_ID      AS �����ȣ,
        EMP_NAME    AS �̸�,
        '������'     AS ����
FROM    EMPLOYEE
WHERE   DEPT_ID = 50 AND EMP_ID = 141
UNION
SELECT  EMP_ID,
        EMP_NAME,
        '����'
FROM    EMPLOYEE
WHERE   DEPT_ID = 50 AND EMP_ID != 141
ORDER BY 3, 2;

SELECT  EMP_ID   AS �����ȣ,
        EMP_NAME AS �̸�,
        CASE WHEN EMP_ID = '141' THEN '������' ELSE '����' END AS ����
FROM    EMPLOYEE
WHERE   DEPT_ID = 50
ORDER BY 3, 2;

-- ���� ��� ������ �����! (UNION ���)
SELECT  EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE IN ('�븮','���');

SELECT  EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '�븮'
UNION
SELECT  EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '���'
ORDER BY 2,1;

-- SUBQUERY : �ϳ��� ������ �ٸ� ������ �����ϴ� ����
/*
SELECT  EXPR(SELECT)    -- SCALAR SUBQUERY
FROM    (SELECT)        -- INLINE VIEW
WHERE   EXPR OPERATOR (SUBQUERY)
GROUP BY (SELECT)
HAVING   (SELECT)       -- GROUPBY, HAVING �� �� ���������� ���� ���� ������ �� �������� �ʴ´�.

����
- ���� �� �������� (���� �÷�, ���� �÷�)
- ���� �� �������� (���� �÷�, ���� �÷�) - (IN, ANY, ALL)
*/

-- '���¿�' ������ ���� �μ����� ��ȸ�Ѵٸ�?
SELECT  DEPT_ID
FROM    EMPLOYEE
WHERE   EMP_NAME = '���¿�';

SELECT  *
FROM    EMPLOYEE
WHERE   DEPT_ID = (SELECT   DEPT_ID
                    FROM    EMPLOYEE
                    WHERE   EMP_NAME = '���¿�');
                    
-- '���¿�'�� ���� �����̸鼭 �޿��� '���¿�'���� ���� �޴� ���� ��ȸ  
SELECT  *
FROM    EMPLOYEE
WHERE   JOB_ID = (SELECT    JOB_ID
                  FROM      EMPLOYEE
                  WHERE     EMP_NAME = '���¿�')
AND     SALARY > (SELECT    SALARY
                  FROM      EMPLOYEE
                  WHERE     EMP_NAME = '���¿�');
                  
-- �����޿� �޴� ����� ���� ��ȸ
SELECT  *
FROM    EMPLOYEE
WHERE   SALARY = (SELECT    MIN(SALARY)
                    FROM    EMPLOYEE);
                    
-- �μ��� �޿� ������ ���� ���� �μ��� �μ��̸�, �޿� ���� ��ȸ
SELECT  DEPT_NAME,
        SUM(SALARY)
FROM    EMPLOYEE
JOIN    DEPARTMENT USING(DEPT_ID)
GROUP BY DEPT_NAME
HAVING  SUM(SALARY) = (SELECT   MAX(SUM(SALARY))
                       FROM     EMPLOYEE
                       GROUP BY DEPT_ID);
                       
-- ���� �� ��������
/*
> ANY (�������� ������� �ּҺ��� ū ��)
< ANY (��������� �ִ뺸�� ���� ��)

> ALL (�������� ������� �ִ뺸�� ū ��)
< ALL (��������� �ּҺ��� ���� ��)

IN == =ANY / NOT IN (�Բ� ���� ���������� ����� MUST NOT NULL)
*/

-- �����ڵ鸸 ��ȸ�Ѵٸ�?
-- MGR_ID �� EMP_ID �� �ִٸ� ������
SELECT  EMP_ID,
        EMP_NAME,
        '������' AS "������ ����"
FROM    EMPLOYEE
WHERE   EMP_ID IN (SELECT   MGR_ID
                    FROM    EMPLOYEE)
UNION                    
-- ���� ��ȸ
SELECT  EMP_ID,
        EMP_NAME,
        '����' AS "������ ����"
FROM    EMPLOYEE
WHERE   EMP_ID NOT IN (SELECT MGR_ID 
                       FROM   EMPLOYEE
                       WHERE  MGR_ID IS NOT NULL)
ORDER BY 3;

-- �븮 ������ ����� �̸�, �޿� ��ȸ
SELECT * FROM EMPLOYEE;
SELECT * FROM JOB;

SELECT  EMP_NAME,
        SALARY,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '�븮'
UNION
-- ���� ������ ����� �̸�, �޿� ��ȸ
SELECT  EMP_NAME,
        SALARY,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '����'
ORDER BY 3;

SELECT  EMP_NAME,
        SALARY,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE IN ('����','�븮');

-- ���� ���޺��� ���� �޿��� �޴� �븮 ������ ����̸�, �޿� ��ȸ
SELECT  EMP_NAME, SALARY
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '�븮' AND SALARY > ANY (SELECT   SALARY
                                             FROM   EMPLOYEE
                                             JOIN   JOB USING(JOB_ID)
                                             WHERE  JOB_TITLE = '����');
                                             
-- ���޺�(JOB_TITLE) ��ձ޿� ��ȸ
-- ����� ���Ǹ� ���� ���� 5�ڸ����� ���� (TRUNC)
SELECT  JOB_TITLE,
        TRUNC(AVG(SALARY), -5)
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
GROUP BY JOB_TITLE;

/*
���� �÷��� ������� �� ������?
- JOB_TITLE �� �´� SALARY�� �������Ⱑ �����
-> �����÷����� �����;� ��!(JOB_TITLE, SALARY)
*/
-- �ڱ� ������ ��� �޿��� �޴� ������ �̸�, ����, �޿� ��ȸ
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

-- 03. ������� �������� (CORRELATED SUBQUERY)
-- ������������ ó���Ǵ� �� ���� ���� ���� ���������� ������� �޶����� ���
-- �������� ���� E.JOB_ID�� �ٽ�!
SELECT  EMP_NAME,
        JOB_TITLE,
        SALARY
FROM    EMPLOYEE E
JOIN    JOB      J  ON (E.JOB_ID = J.JOB_ID)
WHERE   SALARY = (SELECT    TRUNC(AVG(SALARY), -5)
                  FROM      EMPLOYEE
                  WHERE     JOB_ID = E.JOB_ID);
                  
-- ����(JOB_TITLE)���� �ִ� �޿��� �޴� ������ ����, �̸�, �޿�
-- JOB_TITLE ���� �������� �����Ͽ� ���
SELECT  EMP_NAME,
        JOB_TITLE,
        SALARY
FROM    EMPLOYEE E
JOIN    JOB      J ON (E.JOB_ID = J.JOB_ID)
WHERE   SALARY  = (SELECT   MAX(SALARY)
                    FROM    EMPLOYEE
                    WHERE   JOB_ID = E.JOB_ID)
ORDER BY E.JOB_ID;
