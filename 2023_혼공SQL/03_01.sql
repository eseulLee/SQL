USE market_db;
SELECT * FROM member;
SELECT mem_name FROM member;
SELECT addr, debut_date "데뷔 일자", mem_name FROM member; -- alias 지정

SELECT * FROM	member WHERE	mem_name = '블랙핑크';
SELECT * FROM	member WHERE	mem_number = 4;

SELECT	mem_id, mem_name 
FROM	member 
WHERE	height  <= 162;

SELECT	mem_name, height, mem_number
FROM	member
WHERE	height >= 165 AND mem_number > 6;

SELECT	mem_name, height, mem_number
FROM	member
WHERE	height >= 165 OR mem_number > 6;

-- BETWEEN ~ AND
SELECT	mem_name, height
FROM	member
WHERE	height >= 163 AND height <= 165;

SELECT	mem_name, height
FROM	member
WHERE	height BETWEEN 163 AND 165;

-- IN()
SELECT	mem_name, addr
FROM	member
WHERE	addr = '경기' OR addr = '전남' OR addr = '경남';

SELECT	mem_name, addr
FROM	member
WHERE	addr IN ('경기', '전남', '경남');

-- LIKE
SELECT	*
FROM	member
WHERE	mem_name LIKE '우%';  -- 무엇이든(%) 허용

SELECT	*
FROM	member
WHERE	mem_name LIKE '__핑크';  -- 한 글자와 매치하기 위해 언더바(_) 사용

-- 서브쿼리(Subquery)
-- 이름(mem_name)이 '에이핑크'인 회원의 평균 키(height)보다 큰 회원 검색
SELECT	mem_name, height
FROM	member
WHERE	height > (SELECT height FROM member WHERE mem_name = '에이핑크');

