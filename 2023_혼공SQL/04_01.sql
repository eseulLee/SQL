-- 데이터 형식
-- 정수형
USE market_db;
CREATE TABLE hongong4 (
	tinyint_col		TINYINT,
    smallint_col	SMALLINT,
    int_col			INT,
	bigint_col		BIGINT  );
    
-- 각 열의 최대값 입력
INSERT INTO hongong4 VALUES (127, 32767, 2147483647, 9000000000000000000 );
-- 각 숫자에 1 더해서 입력
INSERT INTO hongong4 VALUES (128, 32768, 2147483648, 9000000000000000001 ); -- ERROR

DESC member;
-- mem_number, height 의 경우 각각 int, smallint로 지정되어 있음
-- mem_number의 경우, 그룹의 인원이므로 최대 127명까지 지정가능한 tinyint로 지정해도 충분
-- height의 경우, smallint로 -32768~32767까지 지정 가능. 키가 2m 넘는 사람도 있으니까 tinyint는 범위 부족

-- UNSIGNED 예약어 사용 : 범위가 0부터 시작(최대값이 더 커지게 됨)
-- TINYINT : -128 ~ 127 // TINYINT UNSIGNED : 0 ~ 255 >> 모두 256개를 표현(1 Byte)
ALTER TABLE member MODIFY mem_number TINYINT NOT NULL;
ALTER TABLE member MODIFY height TINYINT UNSIGNED;

-- 문자형 : CHAR() 최대 255, VARCHAR() 최대 16383

-- 대량의 데이터 형식
-- TEXT : TEST 65535/ LONGTEXT 4294967295
-- BLOB(Binary Long Object; 글자가 아닌 이미지, 동영상 등의 데이터) : BLOB 65535/ LONGBLOB 4294967295

CREATE DATABASE netflix_db;
USE netflix_db;
CREATE TABLE movie (
	movie_id		INT,
    movie_title		VARCHAR(30),
    movie_director	VARCHAR(20),
    movie_star		VARCHAR(20),
    movie_script	LONGTEXT,      -- LONGTEXT, LONGBLOB 각각 최대 4GB 입력 가능
    movie_film		LONGBLOB );
    
-- 실수형
-- FLOAT 4BYTE, 소수점 아래 7자리/ DOUBLE 8BYTE, 소수점 아래 15자리

-- 날짜형
-- DATE: 3 BYTE, 날짜만 저장. YYYY-MM-DD
-- TIME: 3 BYTE, 시간만 저장. HH:MM:SS
-- DATETIME: 8 BYTE, 날짜 및 시간 저장. YYYY-MM-DD HH:MM:SS

-- 변수의 사용
-- SET @변수이름 = 변수 값;  > 변수 선언 및 값 대입
-- SELECT @변수이름;       > 변수 값 출력
-- 변수는 Workbench 재시작 때까지는 유지되지만, 종료하면 없어짐 (임시 사용)

USE market_db;
SET @myVar1 = 5;
SET @myVar2 = 4.25;

SELECT @myVar1;
SELECT @myVar1 + @myVar2;

SET @txt = '가수 이름==> ';
SET @height = 166;
SELECT @txt, mem_name FROM member WHERE height > @height;

-- LIMIT 에 변수 사용 불가
SET @count = 3;
SELECT	mem_name, height 
FROM	member 
ORDER BY height
LIMIT	@count; -- error

-- 이를 해결하는 것이 PREPARE, EXECUTE
-- PREPARE는 실행하지 않고 SQL문만 준비해 놓고 EXECUTE에서 실행하는 방식
SET @count = 3;
PREPARE mySQL FROM 'SELECT mem_name, height FROM member ORDER BY height LIMIT ?';   -- ?: 현재는 모르지만 나중에 채워짐
EXECUTE mySQL USING @count;  -- USING 으로 물음표(?)에 @count 변수의 값 대입

-- 데이터 형 변환
