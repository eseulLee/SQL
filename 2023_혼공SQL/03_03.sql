-- 03-3. 데이터 변경을 위한 SQL 문
-- 데이터 입력: INSERT

USE market_db;
CREATE TABLE hongong1 
( toy_id	INT,
  toy_name	CHAR(4),
  age		INT );
INSERT INTO hongong1 VALUES (1, '우디', 25);
INSERT INTO hongong1 (toy_id, toy_name) VALUES (2, '버즈');
INSERT INTO hongong1 (toy_name, age, toy_id) VALUES ('제시', 20, 3);
select * from hongong1;

-- 자동으로 증가하는 AUTO_INCREMENT
-- 열을 정의할 때 1부터 증가하는 값 입력
-- 주의) AUTO_INCREMENT 로 지정하는 열은 반드시 PRIMARY KEY로 지정해야 함
CREATE TABLE hongong2 (
	toy_id		INT	AUTO_INCREMENT PRIMARY KEY,
    toy_name	CHAR(4),
    age			INT );

INSERT INTO hongong2 VALUES (NULL, '보핍', 25);
INSERT INTO hongong2 VALUES (NULL, '슬링키', 22);
INSERT INTO hongong2 VALUES (NULL, '렉스', 21);
SELECT *	FROM hongong2; -- toy_id 에 1,2,3 으로 차례로 증가한 숫자값 기입

SELECT LAST_INSERT_ID(); -- 마지막 ID뭔지 CHECK

-- 만약 AUTO_INCREMENT로 입력되는 값을 100부터 시작하도록 변경하고 싶다면?
ALTER TABLE hongong2 AUTO_INCREMENT=100;

INSERT INTO hongong2 VALUES (NULL, '재남', 35);
SELECT *	FROM hongong2;

-- 처음 입력값을 1000으로 지정 후, 1003, 1006, 1009 등 3씩 증가하도록 설정
-- 시스템 변수인 @@auto_increment_increment 를 변경시켜야 함
CREATE TABLE hongong3 (
	toy_id		INT		AUTO_INCREMENT PRIMARY KEY,
    toy_name	CHAR(4),
    age			INT);

ALTER TABLE hongong3 AUTO_INCREMENT = 1000;  -- 시작값 1000으로 지정
SET @@auto_increment_increment = 3;  -- 증가값 3으로 지정

-- 시스템 변수? MySQL에서 자체적으로 가지고 있는 설정값이 저장된 변수로 주로 MySQL의 환경과 관련된 내용이 저장되어 있으며, 그 개수 500개 이상
-- 앞에 @@가 붙는 것이 특징이며, 시스템 변수의 값을 확인하려면 SELECT @@시스템변수 실행
SELECT @@auto_increment_increment;
-- 전체 시스템 변수의 종류를 알고 싶을 때는 SHOW GLOBAL VARIABLES 실행
SHOW GLOBAL VARIABLES;

INSERT INTO hongong3 VALUES (NULL, '토마스', 20);
INSERT INTO hongong3 VALUES (NULL, '제임스', 23);
INSERT INTO hongong3 VALUES (NULL, '고든', 25);
SELECT *	FROM hongong3;

-- 여러 데이터 한번에 insert
INSERT INTO hongong3 VALUES (NULL, '스미스', 15), (NULL, '폴', 22), (NULL, '미키', 10);

-- 다른 테이블의 데이터를 한 번에 입력하는 INSERT INTO ~ SELECT
-- 주의) SELECT 문의 열 개수는 INSERT 할 테이블의 열 개수와 같아야 함 == 즉, SELECT 의 열이 3개라면, INSERT될 테이블의 열도 3개여야 함
-- world DB의 city 테이블 데이터 개수 세기
SELECT	COUNT(*)	FROM world.city;

-- 테이블 구조 확인: DESC table_nm; (describe 약자)
DESC world.city;

-- 데이터 상위 5건만 조회
SELECT	* 	FROM world.city	LIMIT 5;

-- Name, Population 가져오기
CREATE TABLE city_popul (
	city_name	CHAR(35),
    population	INT);
    
-- world.city 테이블 내용을 city_popul 테이블에 입력
INSERT INTO city_popul
	SELECT	Name, Population FROM world.city;
    
SELECT * FROM city_popul;

-- 데이터 수정: UPDATE
-- city_popul 테이블의 도시 이름 중 Seoul을 '서울'로 변경
UPDATE	city_popul
   SET	city_name = '서울'
   WHERE	city_name = 'Seoul';
   
SELECT * FROM city_popul WHERE city_name = '서울';

-- 한꺼번에 여러 열의 값 변경
UPDATE	city_popul
	SET	city_name = '뉴욕', population = 0
    WHERE city_name = 'New York';
    
SELECT * FROM city_popul WHERE city_name = '뉴욕';

-- WHERE 가 없는 UPDATE문
-- WHERE절은 문법상 생략이 가능하지만, WHERE절을 생략하면 테이블의 모든 행의 값이 변경됨 주의
-- 모든 인구 열(population)을 한꺼번에 10,000으로 나누기
UPDATE city_popul
	SET population = population / 10000;
    
SELECT * FROM city_popul LIMIT 10;

-- 데이터 삭제: DELETE
-- 행 단위로 삭제
-- city_popul 테이블에서 'New'로 시작하는 도시 삭제
SELECT * FROM city_popul WHERE city_name like 'New%';
DELETE FROM city_popul
	WHERE city_name LIKE 'New%';
    
-- 위처럼 전체 다 말고 상위 몇개만 삭제할 때 LIMIT 사용
DELETE FROM city_popul
	WHERE city_name LIKE 'New%'
    LIMIT 5;
    
----------------------------------------------------------
-- 대용량 테이블 삭제
CREATE TABLE big_table1 (SELECT * FROM world.city, sakila.country);
CREATE TABLE big_table2 (SELECT * FROM world.city, sakila.country);
CREATE TABLE big_table3 (SELECT * FROM world.city, sakila.country);
SELECT COUNT(*) FROM big_table1;

-- 1. DELETE   : 삭제가 오래 걸림 (빈 테이블 남김)
-- 2. DROP     : 테이블 자체를 삭제 (상대적으로 적은 시간)
-- 3. TRUNCATE : DELETE와 동일한 효과이나 속도가 빠름 (빈 테이블 남김) > TRUNCATE의 경우, DELETE와 달리 WHERE 사용 불가
-- 대용량 테이블 전체 삭제시, 테이블 자체가 필요없을 땐 DROP, 테이블 구조는 남겨놓고 싶을 땐 TRUNCATE 삭제가 효율적!                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
DELETE FROM big_table1;
DROP TABLE big_table2;
TRUNCATE TABLE big_table3;