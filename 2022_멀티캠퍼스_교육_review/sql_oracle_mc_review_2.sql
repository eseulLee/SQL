-- SQL REVIEW 2
/*
�Լ��� ����
- ���� �� �Լ� (SINGLE ROW FUNCTION)
- �׷� �Լ� (GROUP FUNCTION)

�÷� Ÿ��(���� - number, ���� - char, varchar2, ��¥ - date)
- ���� �Լ�
- ���� �Լ� ��
- ��¥ �Լ�
- ��Ÿ �Լ� ��
*/

-- ���� �Լ� (����: 1byte, �ѱ�: 2-3byte)
-- LENGTH
-- CHAR �ѱ��� ��� LENGTH
-- �ѱ� 3, 6 * 3 = 18 BYTE , 20 - 18 = 2 BYTE (����ó��), 2 + 6 = 8 -> CHAR �� �ѱ��� ���� ����
SELECT  LENGTH(CHARTYPE),
        LENGTH(VARCHARTYPE)
FROM    COLUMN_LENGTH;

-- INSTR() : ã�� ������ �ε����� �����ϴ� �Լ�
-- INSTR(STRING, SUBSTRING, [POSITION(�պ���:+, �ں���:-1), OCCURRENCE] ) : NUMBER

SELECT  *
FROM    EMPLOYEE;

-- '@vcc.com' ���ڿ� �� . ���� ���� 'c' �ε����� ���ϸ�?
-- ORACLE�� �ε����� 0���� ���� �ʴ´�! 1���� START
SELECT  EMAIL,
        INSTR(EMAIL, 'c', -1, 2)
FROM    EMPLOYEE;

-- LPAD | RPAD : ������ �� ���� ���
-- LPAD(STRING, N, [STR])
SELECT  EMAIL,
        LENGTH(EMAIL),
        LPAD(EMAIL, 20, '*'),   -- ���� ����(*), ������ ������ ����
        RPAD(EMAIL, 20, '*')   -- ������ ����(*), ������ ���� ����
FROM    EMPLOYEE;        

-- TRIM, LTRIM, RTRIM
-- ���ڸ� ������ �� (DEFAULT: ���� ����)
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
        TRIM('A' FROM 'AATECHAA')  -- ����� BOTH
FROM    DUAL;  

-- �� SUBSTR(STRING, POSITION(���: �պ���, ����: �ں���, IDX_NUMBER), [LENGTH: ������ ����])
SELECT  EMP_NO,
        SUBSTR(EMP_NO, 1, 6),  -- SUBSTR(STRING, START_IDX, END_IDX)
        SUBSTR(EMP_NO, 8, 1)
FROM    EMPLOYEE;        

-- ��� ���̺��� ������ ������ ����� ��� ���� ��ȸ
SELECT  *
FROM    EMPLOYEE
WHERE   SUBSTR(EMP_NO, 8, 1) = '1';

-- ���� �Լ� (���: �Ҽ��� ���� �ڸ��� | ����: ���� �κ�)
-- ROUND(NUMBER, [DECIMAL_PLACES]), TRUNC(NUMBER, [DECIMAL_PLACES])

SELECT  ROUND(123.315),
        ROUND(123.315, 0),
        ROUND(123.315, 2),
        ROUND(123.314, 2),
        ROUND(123.315, -1),
        ROUND(125.315, -1),  -- �ݿø�(������)
        TRUNC(125.315, -1)   -- �ڸ��� ����
FROM    DUAL;  

-- ��¥ �Լ�
-- SYSDATE, ADD_MONTHS(DATE, N)
-- MONTHS_BETWEEN(DATE1, DATE2) -> DATE1�� DATE2���� �� Ŀ�� �� (������ �Ǵ� ��¥)

SELECT  SYSDATE,     -- ���� ��¥ ����
        SYSDATE +1   -- �ϼ� +1
FROM    DUAL;  

-- �ټӿ��� 20�� �̻��� ��� ��ȸ
SELECT  HIRE_DATE,
        ADD_MONTHS(HIRE_DATE, 240),   -- 20 * 12 = 240
        MONTHS_BETWEEN(SYSDATE, HIRE_DATE),
        MONTHS_BETWEEN(HIRE_DATE, SYSDATE)  -- ���� ���
FROM    EMPLOYEE;

-- �ټӿ��� ���(* �ڿ��� �÷��߰� �Ұ�)
SELECT  EMP_NAME,
        HIRE_DATE,
        TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12) AS �ټӿ���
FROM    EMPLOYEE
WHERE   MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;

SELECT  *
FROM    EMPLOYEE
WHERE   ADD_MONTHS(HIRE_DATE, 240) <= SYSDATE;

-- Ÿ�� ��ȯ �Լ�

/*
<-  TO_NUMBER()   TO_CHAR(DATE, ǥ������)
NUMBER  -  CHARACTER  -  DATE
->  TO_CHAR()     TO_DATE()

��¥ -> ���� (���ĵ� �����Ǿ� ����) => ������� �����ϱ� ���ؼ��� Ÿ�� �ٲ���� ��
- YYYY/YY/YEAR
- MONTH/MON/MM/RM
- DDD/DD/D
- DAY/DY (����)
- HH24/ HH:MI:SS
- AM, PM
- Q (�б�)
*/
SELECT  *
FROM    EMPLOYEE
WHERE   DEPT_ID = 90;

SELECT  *
FROM    EMPLOYEE
WHERE   DEPT_ID = TO_CHAR(90) ;
-- �ΰ��� ���� ���
-- �̷� �������� �� ��ȯ�� �Ͼ�� ������ DEPT_ID = 90 ���� ��ȸ�ص� �Ǵ°�!

SELECT  SYSDATE,
        TO_CHAR(SYSDATE, 'YYYY-MM-DD-DY-DAY'),
        TO_CHAR(SYSDATE, 'MM-DD, YYYY'),
        TO_CHAR(SYSDATE, 'YYYY, YY, YEAR'),
        TO_CHAR(SYSDATE, 'AM HH24:MI:SS'),
        TO_CHAR(SYSDATE, 'YEAR, Q')   -- Q: �б�(QUARTER)
FROM    DUAL;

SELECT  HIRE_DATE,
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM    EMPLOYEE;        

-- ��¥�� ���ڷ� ��޵� �� ����
SELECT  HIRE_DATE,
        SUBSTR(HIRE_DATE, 1, 2) || '��' ||
        SUBSTR(HIRE_DATE, 4, 2) || '��' ||
        SUBSTR(HIRE_DATE, -2, 2) || '��' AS �Ի���
FROM    EMPLOYEE
WHERE   DEPT_ID = 90;

-- TO_CHAR�� �Բ� ���̴� �پ��� ����
-- 9: �Ϲ����� ���� (�� �տ� ���� �ϳ� ���� ����)
SELECT  TO_CHAR('123', '999999'),
        LENGTH(TO_CHAR('123', '999999')),
        TO_CHAR('123', '999'),
        LENGTH(TO_CHAR('123', '999')),
        LTRIM(TO_CHAR('123', '999')),
        LENGTH(LTRIM(TO_CHAR('123', '999')))
FROM    DUAL;

-- 0: ���̸�ŭ ���� ���ڸ� 0���� ä��
SELECT  TO_CHAR('123', '000000')
FROM    DUAL;

-- $: DOLLAR ǥ��
SELECT  TO_CHAR('123', '$999999'),
        TO_CHAR('123', '$000000')
FROM    DUAL;

-- L: ���� ��ȭ ���� (EX. \)
SELECT  TO_CHAR('123', 'L999999')
FROM    DUAL;

-- .: �Ҽ��� ǥ��
SELECT  TO_CHAR('123', '999.999'),
        TO_CHAR('12.3', '999.999')
FROM    DUAL;

-- ,: �޸� ǥ��
SELECT  TO_CHAR('12345', '999,999,999')
FROM    DUAL;

-- CHAR -> DATE
-- '20220215' -> 22/02/15
-- ��� ���ڰ� ��¥�� �� �� �ִ� ���� �ƴ�
SELECT  TO_DATE('20220215', 'YYYYMMDD'),
        TO_DATE('220215', 'YYMMDD'),
        TO_DATE('150222', 'DDMMYY'),   -- ��� ���������� �˷��ִ°� �ʿ���!
        TO_CHAR(TO_DATE(TO_CHAR(220215), 'YYMMDD'), 'YYYY-MM-DD')
FROM    DUAL;

-- ���� �������� �� YYYY(TO_CHAR���� ��밡��, ���� ���� ����), RRRR(TO_DATE �� �� ���)
SELECT  HIRE_DATE,
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM    EMPLOYEE
WHERE   EMP_NAME = '�Ѽ���';

SELECT  SYSDATE AS ����,
        '95/02/15' AS �Է�,
        TO_CHAR(TO_DATE('95/02/15', 'YY/MM/DD'), 'YYYY'),
        TO_CHAR(TO_DATE('95/02/15', 'RR/MM/DD'), 'YYYY')
FROM    DUAL;        

-- ��Ÿ�Լ�
-- NULL �� ó�� �Լ�: NVL(VALUE, ��ü��)
SELECT  EMP_NAME,
        BONUS_PCT,
        NVL(BONUS_PCT, 0)
FROM    EMPLOYEE
WHERE   SALARY > 3500000;

SELECT  EMP_NAME,
        SALARY,
        SALARY * 12 AS ANNUAL_SALARY,
        BONUS_PCT,
        (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 AS "12��������"
FROM    EMPLOYEE;

-- ORACLE ���� �Լ� (�ٸ� ������ ��ǰ���� �������� ����)
-- DECODE(EXPR(����ǥ�� �Ұ�), SEARCH, RESULT, [SEARCH, RESULT], [DEFAULT])
-- IF ~ ELSE

-- �μ���ȣ�� 50���� ������� �̸�, ���� ��ȸ
SELECT * FROM EMPLOYEE;

SELECT  EMP_NAME,
        EMP_NO,
        DECODE(SUBSTR(EMP_NO, 8, 1),
        '1', 'Male',
        '3', 'Male',
        'Female') AS GENDER
FROM    EMPLOYEE
WHERE   DEPT_ID = 50;

-- ����� �λ�޿��� Ȯ���ϰ��� �� ��, 90 �μ��� �޿��� 10%�� �λ��Ѵٸ�?
SELECT  DEPT_ID,
        EMP_NAME,
        SALARY,
        DECODE(DEPT_ID, '90', SALARY * 1.1, SALARY) AS �λ�޿�
FROM    EMPLOYEE;

-- ANSI ǥ��
-- CASE EXPR WHEN SEARCH THEN RESULT [WHEN SEARCH THEN RESULT] ELSE DEFAULT END
-- CASE WHEN CONDITION THEN RESULT [WHEN SEARCH THEN RESULT] ELSE DEFAULT END
SELECT  DEPT_ID,
        SALARY,
        CASE DEPT_ID WHEN '90' THEN SALARY * 1.1
                     ELSE SALARY
        END AS �λ�޿�
FROM    EMPLOYEE;

SELECT  DEPT_ID,
        SALARY,
        CASE WHEN DEPT_ID = '90' THEN SALARY * 1.1
             ELSE SALARY
        END AS �λ�޿�
FROM    EMPLOYEE;

-- �޿��� ���� �޿� ����� Ȯ���Ϸ��� �Ѵ�.
-- 3000000 ���� : �ʱ� / 4000000 ���� : �߱� / 4000000 �ʰ� : ���
SELECT  EMP_NAME,
        SALARY,
        CASE WHEN SALARY <= 3000000 THEN '�ʱ�' 
             WHEN SALARY <= 4000000 THEN '�߱�'
             ELSE '���' 
        END AS �޿����
FROM    EMPLOYEE;

-- �׷� �Լ�(SUM, AVG) - NUMBER
-- �׷� �Լ�(MIN, MAX, COUNT) - ANY TYPE (NUMBER, CHARACTER, DATE)
-- INPUT N -> OUTPUT 1

SELECT  SUM(SALARY), -- SELECT ���� �׷��Լ� ���Ǹ� �ϹݼӼ��� ���ǵ� �� ����. SELECT EMP_ID, SUM(SALARY) -- ERROR
        AVG(SALARY),
        MIN(SALARY),
        MAX(SALARY),
        COUNT(*),
        COUNT(BONUS_PCT),  -- 22�� �߿� 8�� ���ʽ��� ���� �޴´�. (���� �����ִ� ����, NULL ���� COUNT ���� �����Ƿ� ���ܵ�)
        MAX(HIRE_DATE),
        MIN(HIRE_DATE)
FROM    EMPLOYEE;