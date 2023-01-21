-- ORDER BY
SELECT	mem_id, mem_name, debut_date
FROM	member
ORDER BY debut_date;  -- default: ASC(Ascending; 오름차순)

SELECT	mem_id, mem_name, debut_date
FROM	member
ORDER BY debut_date DESC;  -- DESC(Descending; 내림차순)

-- 평균 키(height)가 164 이상인 회원들을 키가 큰 순서로 출력 (1.HEIGHT, 2.DEBUT_DATE)
SELECT	mem_id, mem_name, debut_date, height
FROM	member
WHERE	height >= 164
ORDER BY height DESC, debut_date ASC;

-- LIMIT: 출력 개수 제한 (ORACLE에 없음), 주로 ORDER BY 와 함께 사용됨
SELECT	* 
FROM	member
LIMIT	3;

-- 데뷔 일자(debut_date)가 빠른 회원 3건만 추출
SELECT	mem_name, debut_date
FROM	member
ORDER BY debut_date
LIMIT	3;

-- LIMIT 시작, 개수 (= LIMIT 개수 OFFSET 시작): 중간부터 출력
-- 평균 키(height)가 큰 순으로 정렬하되, 3번째부터 2건만 조회
SELECT	mem_name, height
FROM	member
ORDER BY height DESC
LIMIT	3, 2;

-- DISTINCT: 중복된 결과 제거
SELECT addr FROM member ORDER BY addr;

SELECT DISTINCT addr FROM member;

-- GROUP BY > SUM(), AVG(), MAX(), MIN(), COUNT(), COUNT(DISTINCT)
SELECT	mem_id, amount
FROM	buy
ORDER BY mem_id;

SELECT	mem_id "회원 아이디", SUM(amount) "총 구매 개수"
FROM	buy
GROUP BY mem_id;

-- 회원이 구매한 금액의 총합 계산
SELECT	mem_id "회원 아이디", SUM(price * amount) "총 구매 금액"
FROM	buy
GROUP BY mem_id;

-- 전체 회원이 구매한 물품 개수(amount)의 평균
SELECT	AVG(amount) "평균 구매 개수";

-- 각 회원별 구매한 물품 개수 평균
SELECT	mem_id, AVG(amount) "평균 구매 개수"
FROM	buy
GROUP BY mem_id;

-- 회원 테이블(member)에서 연락처가 있는 회원의 수 카운트
SELECT COUNT(*) FROM member;       -- 10
SELECT COUNT(phone1) FROM member;  -- 8

-- Having
-- 회원별 총 구매액이 1000 보다 큰 회원 추출
SELECT	mem_id "회원 아이디", SUM(price * amount) "총 구매 금액"
FROM	buy
GROUP BY mem_id
HAVING	SUM(price * amount) > 1000
ORDER BY 2 DESC;