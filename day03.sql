-- pk(주키) / fk(외래키) 예제
CREATE TABLE tbl_test1
(
id number PRIMARY KEY,
name varchar(100)
);
-- 기존의 객체가 이름을 사용하고 있습니다.
DROP TABLE tbl_test1;

INSERT INTO tbl_test1 values(1, 'name1');
SELECT * FROM tbl_test1; -- (부모)
INSERT INTO tbl_test1 values(1, 'name1');
-- 무결성 제약 조건(SYSTEM.SYS_C008318)에 위배됩니다.
INSERT INTO tbl_test1 values(3, 'name3');
INSERT INTO tbl_test1 values(100, 'name100');

CREATE TABLE tbl_test2
(
id number PRIMARY KEY,
name varchar(100),
fk_id NUMBER,
CONSTRAINT fk_tbl_test2 FOREIGN KEY(fk_id) REFERENCES tbl_test1(id)
);

SELECT * FROM tbl_test2; -- (자식)
INSERT INTO tbl_test2 values(1, 'name1', 10);
INSERT INTO tbl_test2 values(1, 'name1', 1);
INSERT INTO tbl_test2 values(2, 'name100', 100);

-- SQL Error [2449] [72000]: ORA-02449: 
-- 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다
-- 삭제순서 또한 외래키와 연관이 있다.
-- 삭제순서는 자식테이블에서 부모테이블로 지워야 함.
DROP TABLE tbl_test1;
DROP TABLE tbl_test2;


-- 오라클에서 함수는 2가지가 존재한다.
-- 1.내장함수 (시스템에 미리 정의된 함수)  

SELECT 'abc' FROM dual; -- abc
 
SELECT UPPER('abc') FROM dual; -- ABC -> 데이터로 반환하는데 테이블 형식으로 보여줌

SELECT LOWER('ABC') FROM dual; -- abc

-- 2.사용자 정의 함수 -- 사용자가 함수를 직접 만듦.
-- create or replace function - 없으면 create 있으면 update
create or replace function adder(n1 in number, n2 in number)    
return number    
is     
n3 number(8);    
begin    
n3 :=n1+n2;  
return n3;    
end;

SELECT adder(100,200) FROM dual

-- TRIM : 공백제거를 해준다.
-- LTRIM : 왼쪽 공백제거
-- RTRIM : 오른쪽 공백제거
SELECT ' test ' FROM dual; 
SELECT TRIM(' test ') FROM dual; 
SELECT LTRIM(' test ') FROM dual; 
SELECT RTRIM(' test ') FROM dual; 

-- ROUND
SELECT 1.33333 FROM DUAL;
SELECT ROUND(1.33333) FROM DUAL; -- 1

-- POWER(X,Y) 제곱수 - X의 Y 제곱
SELECT POWER(2,2) FROM DUAL; -- 4
SELECT POWER(2,3) FROM DUAL; -- 8

-- 문자 -> 숫자로 변경가능
SELECT to_number('abc') FROM dual; -- 변환 오류

SELECT to_number('001') FROM dual; -- 1로 변경됨

SELECT to_number('974482') FROM dual; -- 974482로 변경됨

-- SQL Error [1426] [22003]: ORA-01426: 수치 오버플로우
-- 오버플로우 - 데이터 초과
SELECT TO_NUMBER('420000000000000000000000000000000000000000004200000000000000000000000000000000000000000000004200000000000000000000000000000000000000000000004200000000000000000000000000000000000000000000004200000420000420000042020000042000') FROM DUAL; 

-- group by
-- 여러 행들의 그룹을 묶어서 단 하나의 결과를 돌려주는 집계 함수

-- 가상테이블 
WITH student as(
SELECT '영수' NAME, '95' SCORE, '1학년' GRADE FROM DUAL
UNION ALL
SELECT '민호' NAME, '90' SCORE, '2학년' GRADE FROM DUAL
UNION ALL
SELECT '철수' NAME, '70' SCORE, '1학년' GRADE FROM DUAL
UNION ALL
SELECT '영희' NAME, '100' SCORE, '3학년' GRADE FROM DUAL
)
SELECT MAX(NAME),GRADE,sum(score),max(score),min(score),AVG(score),COUNT(*)  
FROM student
GROUP BY GRADE -- GROUP BY 하면 SELECT 에서 * 조회 안됨
HAVING MAX(NAME)='철수' -- GROUP BY 의 조건을 추가, SELEC에 있는것만 사용 가능함 --> 시스템에서 저장할경우 이진수로 저장되며, 이진수 기준으로 출력됨

-- 기본 SQL 구문
SELECT 
FROM 
WHERE 
GROUP BY 
HAVING 

WITH student as(
SELECT '영수' NAME, '95' SCORE, '1학년' GRADE FROM DUAL
UNION ALL
SELECT '민호' NAME, '90' SCORE, '2학년' GRADE FROM DUAL
UNION ALL
SELECT '철수' NAME, '70' SCORE, '1학년' GRADE FROM DUAL
UNION ALL
SELECT '영희' NAME, '100' SCORE, '3학년' GRADE FROM DUAL
)
SELECT MAX(NAME),GRADE,sum(score),max(score),min(score),AVG(score),COUNT(*)  
FROM student
GROUP BY GRADE -- GROUP BY 하면 SELECT 에서 * 조회 안됨
HAVING COUNT(*)=1 -- 조건을 여러개 줄경우 AND 사용.

-- 문제> MOVIE 영화 테이블 - (영화제목 TITLE, 장르 GENRE, 점수 SCORE)
-- 장르별 최고점수, 최저점수, 평균점수를 구해보시오
-- 조건은 평균점수가 50점 이상
WITH movie as(
SELECT '화이트 칙스' title, '코미디' genre, '80' score FROM DUAL
UNION ALL
SELECT '황비홍' title, '액션' genre, '90' score FROM DUAL
UNION ALL
SELECT '핫칙' title, '코미디' genre, '90' score FROM DUAL
UNION ALL
SELECT '아바타' title, 'SF' genre, '90' score FROM DUAL
)
SELECT genre,sum(score),max(score),min(score),AVG(score),COUNT(*)  
FROM movie
GROUP BY genre 
HAVING AVG(score)>50

-- order by 정렬
CREATE TABLE tbl_order
(
id NUMBER
)
INSERT INTO tbl_order values(100);
INSERT INTO tbl_order values(90);
INSERT INTO tbl_order values(80);
INSERT INTO tbl_order values(95);
INSERT INTO tbl_order values(85);

TRUNCATE TABLE tbl_order

-- asc 오름차순
SELECT * 
FROM tbl_order 
ORDER BY id ASC 

-- desc 내림차순
SELECT * 
FROM tbl_order 
ORDER BY id DESC 


















