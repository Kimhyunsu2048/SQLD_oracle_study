-- 데이터베이스란?
데이터베이스는 전자적으로 저장되고 체계적인 데이터 모음입니다. 여기에는 단어, 숫자, 이미지, 비디오 및 파일을 포함한 모든 유형의 데이터가 포함될 수 있습니다. 
DBMS (데이터베이스 관리 시스템) 라는 소프트웨어를 사용하여 데이터를 저장, 검색 및 편집할 수 있습니다. 
컴퓨터 시스템에서 데이터베이스라는 단어는 모든 DBMS, 데이터베이스 시스템 또는 데이터베이스와 관련된 응용 프로그램을 나타낼 수도 있습니다.

DDL(Data Definition Language, 데이터 정의어)
- DDL은 데이터를 정의하는 언어로서 '데이터를 담는 그릇을 정의하는 언어'
- 테이블과 같은 데이터 고조를 정의하는 데 사용되는 명령어들로 특정 구조를 생성, 변경, 삭제, 이름을 바꾸는 데이터 구조와 관련된 명령어들

DDL 명령어는 CREATE, ALTER, DROP, TRUNCATE가 있다.

생성(CREATE)
▶ CREATE TABLE
- CREATE TABLE은 테이블을 생성하는 명령
- CREATE TABLE에서 하나의 컬럼(속성)에 대해 '컬럼명 데이터타입 제약조건'으로 구성

CREATE TABLE 테이블명 ( 컬럼명 데이터타입 [제약조건], ... );

▶ CREATE VIEW
- CREATE VIEW는 뷰를 생성하는 명령

CREATE VIEW 뷰이름 AS 조회쿼리;
- VIEW 테이블의 SELECT 문에는 UNION이나 ORDER BY 절을 사용할 수 없음
- 컬럼명을 기술하지 않으면 SELECT 문의 컬럼명이 자동으로 사용

▶ CREATE OR REPLACE VIEW 기본문법
- CREATE OR REPLACE VIEW는 뷰를 교체하는 명령
- OR REPLACE라는 키워드를 추가하는 것을 제외하고는 CREATE VIEW와 사용 방법이 동일
CREATE OR REPLACE VIEW 뷰이름 AS 조회쿼리;

▶ CREATE INDEX
 - CREATE INDEX는 인덱스를 생성하는 명령
 - UNIQUE는 생략 가능
 - 인덱스 걸린 컬럼에 중복 값을 혀용하지 않음
 - 복수 컬럼을 인덱스로 걸 수 있음

CREATE [UNIQUE] INDEX 인덱스명 ON 테이블명(컬럼명1, 컬럼명2, ...);

수정(ALTER)

▶ ALTER TABLE
 - ALTER TABLE은 테이블을 수정하는 명령

▶ ALTER TABLE 컬럼 추가
 - 테이블에 필요한 컬럼을 추가하는 문법
 - CREATE TABLE의 컬럼에 사용되는 제약조건인 PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL, CHECK, DEFAULT를 ALTER TABLE에서도 사용 가능
ALTER TABLE 테이블명 ADD 컬럼명 데이터타입 [제약조건];

▶ ALTER TABLE 컬럼 수정
 - 테이블에 필요한 컬럼을 수정하는 문법
 - 테이블 생성을 위한 CREATE 문에 제약조건을 명시 후에 ALTER를 통해 테이블 제약조건의 변경이 가능
ALTER TABLE 테이블명 MODIFY 컬럼명 데이터타입 [제약조건];

▶ ALTER TABLE 컬럼 삭제
 - 테이블에 불필요한 컬럼을 삭제하는 문법
ALTER TABLE 테이블명 DROP 컬럼명;

▶ ALTER INDEX
ALTER [UNIQUE] INDEX 인덱스명 ON 테이블명(컬럼명1, 컬럼명2, ...);

삭제(DROP, TRUNCATE)
▶ DROP TABLE
 - DROP TABLE은 테이블을 삭제하는 명령

DROP TABLE 테이블명 [CASCADE | RESTRICT];
 - DROP TABLE 명령어의 옵션에는 CASCASE와 RESTRICT가 있음
   - CASCADE는 참조하는 테이블까지 연쇄적으로 제거하는 옵션
   - RESTRICT는 다른 테이블이 삭제할 테이블을 참조 중이면 제거하지 않는 옵션
 - CASCADE와 RESTRICT의 경우 외래 키(FOREIGN KEY)가 걸려 있을 때 해당

▶ TRUNCATE TABLE
 - TRUNCATE TABLE은 테이블 내의 데이터들을 삭제하는 명령
TRUNCATE TABLE 테이블명;

▶ DROP VIEW
DROP VIEW 뷰이름;

▶ DROP INDEX
 - DROP INDEX는 인덱스를 삭제하는 명령어


-- 세미콜론 기준으로 행이 바뀜
-- 실행 방법 -> ctrl + enter
--  -> 주석 기호

SELECT * FROM dual;

SELECT 'TEST' FROM dual;

SELECT '김민제' FROM dual;

-- dual : 아무 의미없은 것

-- 쿼리
-- select -> 선택
-- from 어디서부터 갖고올것인가?
-- select 라면, 떡라면, 김밥 .. from 김밥천국;

-- 테이블 

-- 데이터는 어디에 저장되어 있는가? 데이터베이스
-- 데이터베이스 -> 김밥천국, 서브웨이, 편의점...
--> 데이터를 저장하기 위한 장소

-- 영화와 관련된 테이블
CREATE TABLE tbl_movie
(
	movie_name varchar(200), -- 영화이름
	movie_director char(200), -- 영화감독
	movie_attendance NUMBER, -- 영화관객수
	movie_startdate DATE DEFAULT sysdate -- 영화 개봉날짜
);

-- 영화와 관련된 모든 정보를 가져온다. -> 쿼리
SELECT * FROM tbl_movie;

-- 데이터를 추가
INSERT INTO tbl_movie(movie_name, movie_director, movie_attendance, movie_startdate)
VALUES('아바타','제임카메론',1000000,'2022-12-14');

INSERT INTO tbl_movie(movie_name, movie_director, movie_attendance, movie_startdate)
VALUES('오펜하이머','크리스토퍼놀란',10000,'2023-07-21');

INSERT INTO tbl_movie(movie_name, movie_director, movie_attendance, movie_startdate)
VALUES('오펜하이머','',10000,null);

-- tbl_movie 테이블의 데이터를 가져오고 싶다.
SELECT * FROM tbl_movie;

SELECT movie_name, movie_director FROM tbl_movie WHERE movie_name='아바타';


-- 영화 테이블
-- 데이터 저장 , 숫자만 저장
-- 문자만 저장 가능
-- 날짜만 저장 가능
-- 데이터형을 써준다(varchar, number, date)
-- varchar(200) -> varchar 문자만 데이터형
-- 200 -> 숫자 , 얼마나 저장을 할 것인지?

CREATE TABLE tbl_movie
(
	movie_name varchar(200), -- 영화이름
	movie_director char(200), -- 영화감독
	movie_attendance NUMBER, -- 영화관객수
	movie_startdate DATE DEFAULT sysdate -- 영화 개봉날짜
);

-- null 이란? 데이터가 없음을 의미.

-- 데이터 삭제
DELETE FROM tbl_movie WHERE movie_name='아바타';

-- 테이블(껍데기, 스키마)
DROP TABLE tbl_movie;

-- truncate
TRUNCATE TABLE tbl_movie;

-- delete 와 truncate 는 기능적으로 동일함.
-- truncate 실제로 완전히 데이터를 지우지는 않는다.


ALTER TABLE tbl_movie MODIFY(movie_name varchar(500));

SELECT * FROM tbl_movie;

INSERT INTO tbl_movie(movie_name, movie_director, movie_attendance, movie_startdate)
VALUES('오펜하이머','크리스토퍼놀란',10000,'2023-07-21');

-- 관객수 -> 10만 -> 100만 변경
-- SELECT, DELETE, TRUNCATE, DROP ...
-- UPDATE -> 데이터 변경 명령어

UPDATE tbl_movie SET movie_attendance=1000000 WHERE MOVIE_NAME='오펜하이머';

-- alias 별명
-- 별명이라는 것은 긴 이름 -> 짧게

SELECT a.movie_name, a.movie_attendance
FROM tbl_movie a;

-- count(*) : 몇개인지?
SELECT count(*) FROM tbl_movie;

-- 산술연산자 +, -, *, / 
SELECT 1+1 FROM dual; -- 2
SELECT 10-1 FROM dual; -- 9
SELECT 12*15 FROM dual; -- 180
SELECT 10/2 FROM dual; -- 5

SELECT 10+NULL FROM dual; -- NULL
SELECT 10-NULL FROM dual; -- NULL
SELECT 0/1 FROM dual; -- 0
SELECT 10/0 FROM dual; -- ERROR
SELECT NULL/0 FROM dual; -- NULL

SELECT 3.14197874684355454122323 FROM dual; 

-- ROUND -> round(3.14...) -> 3
SELECT ROUND(3.14197874684355454122323) FROM dual; -- 3


SELECT * FROM tbl_movie;

-- 합성연산자
SELECT movie_name || '입니다' || 'abc' FROM tbl_movie;


-- coalesce
SELECT COALESCE(10,20,30) FROM DUAL;
SELECT COALESCE(NULL,NULL,3) FROM DUAL;
SELECT COALESCE(1,NULL,3) FROM DUAL;


[SQLD_39_12]

COL1      COL2
--------------
100       100	-> 1행
NULL      60	-> 2행
NULL      NULL	-> 3행

CREATE TABLE SQLD_39_12
(
COL1 NUMBER,
COL2 NUMBER
);

INSERT INTO SQLD_39_12(COL1,COL2) VALUES(100,100);
INSERT INTO SQLD_39_12(COL1,COL2) VALUES(NULL,60);
INSERT INTO SQLD_39_12(COL1,COL2) VALUES(NULL,NULL);

SELECT COALESCE (COL1,COL2*50,50) FROM SQLD_39_12;

SELECT * FROM SQLD_39_12;

-- ABS 절대값 -> 음수 -> 양수로 변환
SELECT ABS(-8) FROM dual; 

-- 트랜잭션, Transaction 오라클(DBMS)에서 발생하는 1개이상의 명령어들을 하나의 논리 집합으로 묶어놓은 단위
SELECT * FROM tbl_movie; -- 하나의 트랜잭션
DELETE FROM TBL_MOVIE WHERE MOVIE_DIRECTOR ='제임스카메론'; -- 하나의 트랜잭션
ROLLBACK 

-- COMMIT : 내가 지금까지 했던 모든 작업들을 DB에 저장
-- ROLLBACK : 특정 작업으로 되돌린다(시간 되돌림)

SELECT * FROM tbl_movie;

INSERT INTO tbl_movie(movie_name, movie_director, movie_attendance, movie_startdate)
VALUES('참치김밥','',10000,null);

-- WHERE LIKE 절 -> 비슷한 데이터를 가져와라.
SELECT * FROM tbl_movie WHERE movie_name LIKE '%김밥';

SELECT * FROM tbl_movie WHERE movie_attendance<>1000;
SELECT * FROM tbl_movie WHERE movie_attendance>=1000;
SELECT * FROM tbl_movie WHERE movie_attendance BETWEEN 5000 AND 10000;

-- WHERE IN 여러개의 데이터를 포함
-- WHERE COLUMN IN (COL1,COL2,COL3,...)
SELECT * FROM TBL_MOVIE WHERE MOVIE_NAME IN ('아바타','오펜하이머');

-- NULL 비교 -> IS NULL, IS NOT NULL
SELECT * FROM TBL_MOVIE WHERE MOVIE_STARTDATE IS NULL;
SELECT * FROM TBL_MOVIE WHERE MOVIE_STARTDATE IS NOT NULL;

-- 와일드카드 
-- 조건식(WHERE) _ 또는 %를 와일드카드
-- 아바타 _바타 -> 아바타, 김바타, X바타, ...
-- % -> 여러글자 / _ -> 한글자

SELECT * FROM TBL_MOVIE WHERE MOVIE_NAME LIKE '오펜_이머';
SELECT * FROM TBL_MOVIE WHERE MOVIE_NAME LIKE '%김밥';

-- TOP(n) -> 최상위의 몇개만 가져와라 / n개의 데이터만 가져와라

-- MSSQL에서 사용하는 TOP()
-- SELECT TOP(10) FROM TBL_MOVIE

-- 오라클에선 ROWNUM 사용

-- 영화 테이블 
-- 아바타만 갖고오고 싶다..

SELECT ROWNUM, aa.*
FROM TBL_MOVIE aa ;
WHERE ROWNUM>=4;


-- 서브쿼리
-- SELECT (SELECT FROM WHERE ) * FROM (SELECT FROM WHERE ) WHERE (SELECT FROM WHERE );

SELECT aaa.rownumber, aaa.movie_name
FROM 
(
	SELECT ROWNUM AS rownumber, aa.*
	FROM TBL_MOVIE AA
) aaa
WHERE aaa.rownumber>4;

-- order by : 순서대로 정렬해준다.
-- 오름차순(ASC), 내림차순(DESC)
-- 오름차순 : 1,2,3,4,5,6,... 점점 커짐
-- 내림차순 : 8,7,6,.... 점점 작아짐

SELECT * FROM TBL_MOVIE ORDER BY MOVIE_ATTENDANCE DESC;

-- PRIMARY KEY -> 고유하게 행을 구별해주는 키값

-- NOT NULL -> NULL을 허용하지 않음
-- '' -> NULL  
-- ' ' -> NULL 이 아님


-- 참고: 쿼리문 실행순서 
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY

합성(CONCATENATION) 연산자
문자와 문자를 연결하는 합성(CONCATENATION) 연산자를 사용하면 별도의 프로그램 도움 없이도 SQL 문장만으로도 유용한 리포트를 출력할 수 있다. 
합성(CONCATENATION) 연산자의 특징은 다음과 같다.

- 문자와 문자를 연결하는 경우 2개의 수직 바(||)에 의해 이루어진다. (Oracle)
- 문자와 문자를 연결하는 경우 + 표시에 의해 이루어진다. (SQL Server)
- 두 벤더 모두 공통적으로 CONCAT (string1, string2) 함수를 사용할 수 있다. 
- 칼럼과 문자 또는 다른 칼럼과 연결시킨다. 
- 문자 표현식의 결과에 의해 새로운 칼럼을 생성한다.

[예제] 다음과 같은 선수들의 출력 형태를 만들어 본다.
출력 형태) 선수명 선수, 키 cm, 몸무게 kg 예) 박지성 선수, 176 cm, 70 kg

[예제 - Oracle]  SELECT PLAYER_NAME || '선수,' || HEIGHT || 'cm,' || WEIGHT || 'kg' 체격정보 FROM PLAYER;

[예제 - SQL Server]  SELECT PLAYER_NAME +'선수, '+ HEIGHT +'cm, '+ WEIGHT +'kg'체격정보 FROM PLAYER;


--DDL
--ctrl+enter로 해당열만 스크립트 실행
SELECT 'TEST' FROM dual;
SELECT 'TEST2' FROM dual;
SELECT 'TEST3' FROM dual;

--create table
CREATE TABLE tbl_movie
(
movie_name varchar(200),--영화이름
movie_director char(200),--영화 감독
movie_attendance NUMBER,--영화 관객수
movie_startdate date DEFAULT sysdate --영화 개봉날짜
);

--select query
SELECT * FROM tbl_movie

--data insert
INSERT INTO tbl_movie(movie_name,movie_director,movie_attendance,movie_startdate)
values('아바타2','제임스카메론',10787975,'2022-12-14');

INSERT INTO tbl_movie(movie_name,movie_director,movie_attendance,movie_startdate)
values('오펜하이머','크리스토퍼놀란',100000,'2023-07-21');

/*
  행/열 ROW/COLUMN 설명
 ↓1열 COLUMN   ↓2열 COLUMN
MOVIE_NAME  MOVIE_DIRECTOR
아바타2       제임스카메론           <-------ROW == 1행                                                                                                                                                                                 
오펜하이머      크리스토퍼놀란        <-------ROW == 2행                                                                                                                                                                           

*/

--select query table schema
select * from user_tables where table_name = 'TBL_MOVIE';
​

--select column schema
SELECT * FROM cols where table_name = 'TBL_MOVIE';

/*
TABLE_NAME 	COLUMN_NAME   		DATA_TYPE
TBL_MOVIE 	MOVIE_NAME   		VARCHAR2
TBL_MOVIE 	MOVIE_DIRECTOR   	CHAR
TBL_MOVIE 	MOVIE_ATTENDANCE  	NUMBER
TBL_MOVIE	MOVIE_STARTDATE   	DATE
*/

--varchar char 차이
--lengthB?
--The string to return the length for. string1 can be CHAR, VARCHAR2, NCHAR, NVARCHAR2, or single-byte LOB.
--LENGTHB 함수는 바이트 수로 계산되며, 영문/숫자/특수문자는 1byte 한글은 3byte로 계산
SELECT lengthB(movie_name),movie_name,LENGTHB(MOVIE_DIRECTOR),MOVIE_DIRECTOR  FROM tbl_movie

-- SQL Error [903] [42000]: ORA-00903: 테이블명이 부적합합니다
-- 테이블명과 칼럼명은 반드시 문자로 시작해야 하고, 벤더별로 길이에 대한 한계가 있다. - 벤더에서 사전에 정의한 예약어(Reserved word)는 쓸 수 없다. 
-- A-Z, a-z, 0-9, _, $, # 문자만 허용된다. - 테이블명이 잘못된 사례
CREATE TABLE 123
(
test_name varchar(200)
);


--PK 설명
--중복 데이터 삽입
INSERT INTO tbl_movie(movie_name,movie_director,movie_attendance,movie_startdate) values('오펜하이머','크리스토퍼놀란',100000,'2023-07-21');

SELECT * FROM tbl_movie;

--PK 기본키 저장된 행 데이터를 고유하게 식별
CREATE TABLE tbl_movie2
(
movie_name varchar(200) PRIMARY key,--영화이름 PK
movie_director char(200),--영화 감독
movie_attendance NUMBER,--영화 관객수
movie_startdate date DEFAULT sysdate --영화 개봉날짜
);


INSERT INTO tbl_movie2(movie_name,movie_director,movie_attendance,movie_startdate)
values('아바타2','제임스카메론',10787975,'2022-12-14');
​

INSERT INTO tbl_movie2(movie_name,movie_director,movie_attendance,movie_startdate)
values('오펜하이머','크리스토퍼놀란',100000,'2023-07-21');
​

SELECT * FROM tbl_movie2

--PK 중복 에러
--SQL Error [1] [23000]: ORA-00001: 무결성 제약 조건(SYSTEM.SYS_C008314)에 위배됩니다
INSERT INTO tbl_movie2(movie_name,movie_director,movie_attendance,movie_startdate)
values('오펜하이머','크리스토퍼놀란',100000,'2023-07-21');

--NULL 데이터 설명
INSERT INTO tbl_movie2(movie_name,movie_attendance,movie_startdate)
values('오펜하이머2',100000,'2023-07-21');


--오펜하이머2 movie_director NULL삽입
SELECT * FROM tbl_movie2

--아스키코드
--아스키 코드는 1963년 미국 ANSI에서 표준화한 정보교환용 7비트 부호체계이다.

SELECT 
ASCII('A'),
ASCII('B'),
ASCII('C'),
ASCII('D'),
ASCII('E'),
ASCII('F')
FROM DUAL;


--chr은 ascii값을 다시 문자로 변환
SELECT 
CHR('65'),
CHR('66'),
CHR('67'),
CHR('68'),
CHR('69'),
CHR('70')
FROM DUAL;


--null의 아스키코드?
--''과 ' '은 다름
--''은 NULL이랑 동일  의미 -> 빈 문자열은 NULL값을 의미

SELECT 
ASCII('A'),
ASCII('B'),
ASCII('C'),
ASCII('D'),
ASCII('E'),
ASCII('F'),
ASCII(NULL), --NULL의 아스키코드 -> NULL 
ASCII('NULL'), --->N의 아스키값
ASCII(''),     -->NULL ''은 NULL이랑 동일
ASCII(' '),--빈값   빈값과 NULL은 다름
ASCII(0)--숫자 0
FROM DUAL;
​

SELECT 
CHR(NULL)
FROM DUAL;
​

--NULL의 아스키코드값은 0
SELECT 
CHR(0)
FROM DUAL;

--dump 함수
--DUMP 함수는 데이터 타입, 바이트 길이 및 expression의 내부 표현 정보를 VARCHAR2 형식으로 반환하는 함수입니다.
SELECT 
dump(null),dump(''),dump(' '),dump('NULL')
FROM DUAL;


--MOVIE_DIRECTOR 값을 NOT NULL 컬럼으로 변경
SELECT * FROM tbl_movie2

CREATE TABLE tbl_movie2
(
movie_name varchar(200) PRIMARY key,--영화이름 PK
movie_director char(200),--영화 감독
movie_attendance NUMBER,--영화 관객수
movie_startdate date DEFAULT sysdate --영화 개봉날짜
)

SELECT * FROM tbl_movie2
WHERE MOVIE_DIRECTOR IS NULL
​

DELETE FROM tbl_movie2
WHERE MOVIE_DIRECTOR IS NULL
​

SELECT * FROM tbl_movie2;

ALTER TABLE tbl_movie2 MODIFY MOVIE_DIRECTOR NOT NULL;

SELECT * FROM cols where table_name = 'TBL_MOVIE';

SELECT a.NULLABLE ,a.* FROM cols a where a.table_name = 'TBL_MOVIE2';


--왜 movie_name은 nullable이 n일까?
--컬럼 삭제 생성
--drop /add column
SELECT * FROM tbl_movie2;

ALTER TABLE tbl_movie2 DROP column MOVIE_STARTDATE;

SELECT * FROM tbl_movie2;

ALTER TABLE tbl_movie2 add COLUMN MOVIE_STARTDATE date DEFAULT sysdate;

ALTER TABLE tbl_movie2 add MOVIE_STARTDATE date DEFAULT sysdate;

ALTER TABLE tbl_movie2 add MOVIE_STARTDATE date DEFAULT sysdate;

SELECT * FROM tbl_movie2


--rename table
rename tbl_movie2 TO tbl_movie22

SELECT * FROM tbl_movie2

SELECT * FROM tbl_movie22

--table copy

CREATE TABLE tbl_movie2 as

SELECT * FROM tbl_movie22

SELECT * FROM tbl_movie2

--table drop
drop table tbl_movie22

SELECT * FROM tbl_movie22
​

--truncate table 
--TRUNCATE TABLE은 테이블 자체가 삭제되는 것이 아니고, 
--해당 테이블에 들어있던 모든 행들이 제거되고 저장 공간을 재사용 가능하도록 해제한다

SELECT * FROM tbl_movie2;

truncate TABLE tbl_movie2;

SELECT * FROM tbl_movie2;


--문제
/*
 * 다음 중 NULL의 설명으로 가장 부적절한 것은?
 * 1.모르는 값을 의미
 * 2.값의 부재를 의미
 * 3.공백 문자 혹은 숫자 0을 의미
 * 4.NULL과 모든 비교(IS NULL제외)는 알 수 없음을 반환한다.
 */

INSERT INTO tbl_movie(movie_name,movie_attendance,movie_startdate)
values('오펜하이머2',100000,'2023-07-21');


SELECT * FROM tbl_movie
WHERE MOVIE_DIRECTOR  >NULL;

SELECT * FROM tbl_movie
WHERE MOVIE_DIRECTOR  <=NULL;


SELECT * FROM tbl_movie
WHERE MOVIE_DIRECTOR  IS NULL;


--문제
/*
 * 다음 중 테이블 생성시 컬럼별 생성할 수 있는 제약조건에 대한설명으로 가장 부적절한 것은?
 * 1.unique : 테이블 내에서 중복되는 값이 없으며 null입력이 불가능하다.
 * 2.pk:주키로 테이블당 1개만 생성이 가능하다
 * 3.fk : 외래키로 테이블당 여러개 생성가능
 * 4.not null : 명시적으로 null값 방지
 */

CREATE TABLE tbl_test1
(
test1_col1 int unique
);

INSERT INTO tbl_test1 values(1);

INSERT INTO tbl_test1 values(1) --SQL Error [1] [23000]: ORA-00001: 무결성 제약 조건(SYSTEM.SYS_C008317)에 위배됩니다

INSERT INTO tbl_test1 values(null);

SELECT * FROM tbl_test1--(!)

/* 문제
TEST 테이블의 NAME 칼럼의 데이터 타입을 CHAR에서 VARCHAR로 변경하고 데이터 크기를 100으로 늘린다.
(1) ALTER TABLE TEST ALTER COLUMN NAME VARCHAR(100);
(2) ALTER TABLE TEST MODIFY(NAME VARCHAR(100));
(3) ALTER TABLE TEST ADD COLUMN NAME VARCHAR(100);
(4) ALTER TABLE TEST ADD CONSTRAINT COLUMN NAME NAME VARCHAR(100);
 */

--dml+tcl
--dml = crud  = create/read/update/delete = insert/select/update/delete

--update
SELECT * FROM tbl_movie

UPDATE tbl_movie
SET movie_name='아바타1'
WHERE movie_name='아바타2';

SELECT * FROM tbl_movie;

SELECT * FROM tbl_movie;

--distinct
SELECT DISTINCT MOVIE_NAME  FROM tbl_movie;

--alias
SELECT *  FROM tbl_movie;
SELECT a.MOVIE_NAME  FROM tbl_movie a;
SELECT a.MOVIE_NAME  FROM tbl_movie AS a (x) --dbms마다 다름


--각 컬럼명을 순서대로 a,b,c,d별칭을 붙이시오
SELECT *  FROM tbl_movie;

--count()
SELECT count(*)  FROM tbl_movie;

--count+distinct
SELECT count(DISTINCT MOVIE_NAME)  FROM tbl_movie;

--산술연산자
SELECT 2*2 FROM dual;
SELECT 1+1 FROM dual;
SELECT 10-1 FROM dual;
SELECT 10/2 FROM dual;
SELECT 0/1 FROM dual;
SELECT 1/0 FROM dual;

/* 역연산
 * 3에다 1을 더하면4      4에다가 어떤수를 빼야 3인가? 1
 * 10을 2로 나누면 5   / 5에다가 어떤수를 곱하면 10인가? 2
 * 10을 0으로 나누면    / 어떤수에 0을 곱해야 10인가? 없음 
 */

SELECT 10/null FROM dual;

SELECT NULL/10 FROM dual;

SELECT NULL/0 FROM dual;

SELECT 0/null FROM dual;

SELECT NULL+10 FROM dual;

SELECT (NULL+10)+100 FROM dual;

SELECT 3.14198714198714199 FROM DUAL;

SELECT ROUND(3.14198714198714199,3) FROM DUAL;


--합성연산자 CONCATENATION
SELECT * FROM tbl_movie;

SELECT MOVIE_NAME || '의 감독은 ' || MOVIE_DIRECTOR  FROM tbl_movie;


/*
주어진 데이터에서 아래의 SQL문이 수행된 결과로 옳은 것은? 
[SQLD_39_12]
COL1      COL2
---------------
100       100
NULL      60
NULL      NULL


[SQL]
SELECT COALESCE(COL1,COL2*50,50)
FROM SQLD_39_12;
1) 100,3000,50
2) 100,NULL,50
3) 100,60,50
4) 100,3000,NULL
*/

--COALESCE 함수는 NULL 값이 아닌 첫번째 값을 반환
SELECT COALESCE(COL1,COL2*50,50) FROM (
SELECT 100 COL1, 100 COL2 FROM DUAL
UNION ALL
SELECT NULL COL1, 60 COL2 FROM DUAL
UNION ALL
SELECT NULL COL1, NULL COL2 FROM DUAL
) AA

--아래의 SQL값은?
SELECT ROUND(7.45, 1), 
       ABS(7.45), 
       FLOOR(7.45),
       TRUNC(7.45),
       CEIL(7.1)
FROM DUAL;
​

--ROUND 함수는 특정 소수점을 반올림하고 나머지를 버리는 함수 이다.

--소수점 첫째자리에서 반올림
SELECT ROUND(1235.543)    --①
     , ROUND(1235.443)    --②
     , ROUND(1235.443, 0) --③
  FROM dual

--소수점 2,3,4자리에서 반올림
  SELECT ROUND(1235.345, 1) --①
     , ROUND(1235.345, 2) --②
     , ROUND(1235.345, 3) --③
  FROM dual


 --abs 절대값
 SELECT abs(-100),abs(-0.5),abs(11) FROM dual

 --floor 
 --ORACLE 에서도 FLOOR(절삭 할 숫자) 형태로 사용
 SELECT floor(10),floor(0.5),floor(-0.3) FROM dual

 --trunc 시간 절사
 WITH temp AS (
  SELECT TO_DATE('2018-12-13 22:10:59', 'YYYY-MM-DD HH24:MI:SS') dt, 1234.56 nmb
    FROM dual 
)  

SELECT dt 
     , TRUNC(dt, 'DD')   --시간 절사 
     , TRUNC(dt, 'HH24') --분, 초 절사
     , TRUNC(dt, 'MI')   --초 절사
     ,trunc(100.456)
     ,trunc(-199.333)
  FROM temp

 --ceil 함수 
 --무조건 위로 올림함수
 SELECT ceil(0.9),ceil(-0.3),ceil(-3.5) FROM dual
 

  /*
   * 트랜잭션(Transaction) : 오라클(DBMS)에서 발생하는 1개이상의 명령어들을 하나의 논리 집합으로 묶어놓은 단위
   */

  SELECT * FROM tbl_movie;
 
  DELETE FROM TBL_MOVIE WHERE MOVIE_DIRECTOR ='제임스카메론';
 
  ROLLBACK

  --dbeaver default가 auto commit이라서 바꿔줘야 함.
  --sql server는 default가 auto commit / oracle non auto commit
  --윈도우->설정->dbeaver->연결유형->auto-commit by default해제
  --새창 띄어서 롤백 테스트
  --꼭 새창 띄워서 해야 적용 됨.(기존 세션 적용 안됨.)
  -- 새창 띄워서...
  
--drop table은 롤백이 안됨.
SELECT * FROM TBL_MOVIE;

DROP TABLE TBL_MOVIE;


--savepoint
CREATE TABLE tbl_movie
(
movie_name varchar(200) PRIMARY key,--영화이름 PK
movie_director char(200),--영화 감독
movie_attendance NUMBER,--영화 관객수
movie_startdate date DEFAULT sysdate --영화 개봉날짜
);

SAVEPOINT svp1;

INSERT INTO tbl_movie(movie_name,movie_director,movie_attendance,movie_startdate)
values('아바타2','제임스카메론',10787975,'2022-12-14');

SELECT * FROM tbl_movie;

ROLLBACK TO svp1;


/*
AUTO COMMIT :
Oracle은 DML을 실행하는 경우 DBMS가 트랜잭션을 내부적으로 실행하며 DML 문장 수행 후 사용자가 임의로 COMMIT 
혹은 ROLLBACK을 수행해 주어야 트랜잭션이 종료된다. (일부 툴에서는 AUTO COMMIT을 옵션으로 선택할 수 있다)
SQL Server는 기본적으로 AUTO COMMIT 모드이기 때문에 DML, DDL 단위 SQL을 수행할 때마다 DBMS가 트랜잭션을 컨트롤하는 방식이다. 
따라서 사용자가 COMMIT이나 ROLLBACK을 처리할 필요가 없다. 
명령어가 성공적으로 수행되면 자동으로 COMMIT이 되고 오류가 발생할 경우 자동으로 ROLLBACK 처리된다.

암시적 트랜잭션 :
Oracle과 같은 방식으로 처리된다. 즉, 트랜잭션의 시작은 DBMS가 처리하고 트랜 잭션의 끝은 사용자가 명시적으로 COMMIT 또는 ROLLBACK으로 처리한다.

명시적 트랜잭션 : 
트랜잭션의 시작과 끝을 모두 사용자가 명시적으로 지정하는 방식이다. 
BEGIN TRANSACTION으로 트랜잭션을 시작하고 COMMIT TRANSACTION 또는 ROLLBACK TRANSACTION으로 트랜잭션을 종료한다.
 */

​

-- 아래의 SQL문을 순차적으로 수행한 결과값을 작성하시오.
CREATE TABLE SQLD39_46 (N1 NUMBER);

INSERT INTO SQLD39_46 VALUES(1);

INSERT INTO SQLD39_46 VALUES(2);

CREATE TABLE TMP_SQLD39_46 (N1 NUMBER);

INSERT INTO TMP_SQLD39_46 VALUES(1);

TRUNCATE TABLE TMP_SQLD39_46;

ROLLBACK;

COMMIT;

SELECT SUM(N1) FROM SQLD39_46;

--번외
--새 테이블을 만드는 순간 create를 쓰는 순간 지금까지 했던 transactions가 모두 commit됨
DROP TABLE SQLD39_46;

DROP TABLE TMP_SQLD39_46;

DROP TABLE TMP_SQLD39_46_2;

CREATE TABLE SQLD39_46 (N1 NUMBER);

INSERT INTO SQLD39_46 VALUES(1);

INSERT INTO SQLD39_46 VALUES(2);

CREATE TABLE TMP_SQLD39_46 (N1 NUMBER);

INSERT INTO TMP_SQLD39_46 VALUES(1);

--TRUNCATE TABLE TMP_SQLD39_46;
CREATE TABLE TMP_SQLD39_46_2 (N1 NUMBER);

ROLLBACK;

SELECT * FROM SQLD39_46

SELECT * FROM TMP_SQLD39_46

------------------------------------------------1주차 마지막 WHERE 
--문제 풀고 시작
--풀이 방법
--1.눈으로 시도
--2.손으로 쓰면서 시도
--3.쿼리로 직접 풀어서 시도(dual 테이블 사용)

/*
다음 주어진 테이블들에 대해서 아래의 SQL문을 수행한 결과로 가장 적절한 것은? 
[SQLD39_31_1]
COL1    COL2    COL3
--------------------
1       A       10
2       B       20
3       A       10

[SQLD39_31_2]
COL1    COL2    COL3
--------------------
X       A       10
Y       B       20
Z       B       10

[SQL]
SELECT COUNT(DISTINCT COL1)
FROM SQLD39_31_1
WHERE COL3 = (SELECT COL3
              FROM SQLD39_31_2
              WHERE COL2 = 'A');
1) 1
2) 2
3) 0
4) 3

 */

DROP TABLE tbl_movie;

CREATE TABLE tbl_movie
(
movie_name varchar(200),--영화이름
movie_director char(200),--영화 감독
movie_attendance NUMBER,--영화 관객수
movie_startdate date DEFAULT sysdate --영화 개봉날짜
)

--select query
SELECT * FROM tbl_movie;

--data insert
INSERT INTO tbl_movie(movie_name,movie_director,movie_attendance,movie_startdate)
values('아바타2','제임스카메론',10787975,'2022-12-14');

INSERT INTO tbl_movie(movie_name,movie_director,movie_attendance,movie_startdate)
values('아바타1','제임스카메론',10787975,'2018-12-14');

INSERT INTO tbl_movie(movie_name,movie_director,movie_attendance,movie_startdate)
values('오펜하이머','크리스토퍼놀란',100000,'2023-07-21');

SELECT * FROM tbl_movie
WHERE movie_name LIKE '아바타%';

SELECT * FROM tbl_movie
WHERE movie_name <> '오펜하이머';

SELECT * FROM tbl_movie
WHERE movie_name >= '오펜하이머';

SELECT * FROM tbl_movie
WHERE movie_name > '오펜하이머';

SELECT * FROM tbl_movie
WHERE movie_name < '오펜하이머';

INSERT INTO tbl_movie(movie_name,movie_director,movie_attendance,movie_startdate)
values('더글로리','김은숙',100000,'2023-07-21');

SELECT * FROM tbl_movie
WHERE movie_name < '오펜하이머'

SELECT ascii(a.movie_name),a.movie_name FROM tbl_movie a

SELECT * FROM tbl_movie
WHERE MOVIE_ATTENDANCE  BETWEEN 5000 AND 1000000

SELECT * FROM tbl_movie
WHERE MOVIE_ATTENDANCE  NOT BETWEEN 5000 AND 1000000

SELECT * FROM tbl_movie
WHERE MOVIE_ATTENDANCE  BETWEEN 100000 AND 100000

SELECT * FROM tbl_movie;
SELECT * FROM tbl_movie WHERE MOVIE_NAME IN ('더글로리','아바타1');
SELECT * FROM tbl_movie WHERE MOVIE_NAME NOT IN ('더글로리','아바타1');
SELECT * FROM tbl_movie WHERE MOVIE_NAME NOT IN (NULL);
SELECT * FROM tbl_movie WHERE MOVIE_NAME IN (NULL);


UPDATE tbl_movie
SET MOVIE_DIRECTOR =NULL
WHERE movie_name ='아바타2'

SELECT * FROM tbl_movie WHERE MOVIE_DIRECTOR IS NULL;
SELECT * FROM tbl_movie WHERE MOVIE_DIRECTOR IS NOT NULL;

SELECT * FROM tbl_movie;
SELECT * FROM tbl_movie WHERE MOVIE_DIRECTOR <>'박찬욱';
SELECT * FROM tbl_movie WHERE MOVIE_DIRECTOR !='박찬욱';
SELECT * FROM tbl_movie WHERE MOVIE_DIRECTOR =NULL;
SELECT * FROM tbl_movie WHERE MOVIE_DIRECTOR IS NULL;
SELECT * FROM tbl_movie WHERE MOVIE_DIRECTOR !=NULL;

/*
와일드카드
조건식에서 _ 또는 % 를 와일드카드라고 한다.
와일드 카드는 특수 문자 또는 문자열을 대체하거나
문자열 데이터의 패턴을 표기하는 특수문자이다.
LIKE와 같이 쓸 수 있는 와일드카드는 _와 %이다.

종류 의미
_ 어떤 값이든 상관없이 한 개의 문자 데이터를 의미
% 길이와 상관없이(문자 없는 경우 포함) 모든 문자 데이터를 의미
 */

SELECT * FROM tbl_movie

SELECT * FROM tbl_movie 
where MOVIE_NAME LIKE '_바%';

SELECT * FROM tbl_movie 
where MOVIE_NAME LIKE '_타%';


SELECT * FROM tbl_movie 
where MOVIE_NAME LIKE '아바타%';

SELECT * FROM tbl_movie 
where MOVIE_NAME LIKE '[아바타]%';

/*
 * 순서를 매기지만 / 2이상은 where절에 조건 불가
 * ROWNUM : 어떤 테이블 내에 물리적으로 저장되어 있는 컬럼이 아니라 SYSDATE나 USER 등과 같이 모든 SQL에 그대로 삽입해서 사용할 수 있는 가상(Pseudo)의 컬럼이다
 */

--rownum

SELECT rownum,aa.* FROM tbl_movie aa

SELECT rownum,aa.* FROM tbl_movie aa
WHERE rownum=1

--!

SELECT rownum,aa.* FROM tbl_movie aa
WHERE rownum=4

SELECT rownum,aa.* FROM tbl_movie aa
WHERE rownum<4


--서브쿼리로 해결
SELECT aaa.rownumber ,aaa.movie_name 
FROM (SELECT rownum AS rownumber,aa.* FROM tbl_movie aa)aaa
WHERE aaa.rownumber=3
​

--TOP
--SQL Server는 TOP 절을 사용하여 결과 집합으로 출력되는 행의 수를 제한할 수 있다. TOP 절의 표현식은 다음과 같다.
SELECT TOP(10) FROM tbl_movie

--Oracle에는 위의 TOP함수가 없기 때문에, rownum 함수를 이용해야 한다.
SELECT rownum,aa.* FROM tbl_movie aa
ORDER BY aa.movie_name


SELECT rownum,aa.* FROM tbl_movie aa
WHERE rownum<3
ORDER BY aa.movie_name

--주의할 점은 order by하고 나서 rownum 숫자를 매겨야 함.
--rownum하면 순서 보장 x
--http://wiki.gurubee.net/pages/viewpage.action?pageId=27428090


CREATE TABLE tbl_rownum
(
c1 int,
c2 varchar(10),
c3 int
);

INSERT INTO tbl_rownum(c1,c2,c3) values(1,'C',101);
INSERT INTO tbl_rownum(c1,c2,c3) values(2,'D',102);
INSERT INTO tbl_rownum(c1,c2,c3) values(3,'E',103);
INSERT INTO tbl_rownum(c1,c2,c3) values(4,'F',104);
INSERT INTO tbl_rownum(c1,c2,c3) values(5,'G',105);
INSERT INTO tbl_rownum(c1,c2,c3) values(6,'H',106);
INSERT INTO tbl_rownum(c1,c2,c3) values(7,'I',107);
INSERT INTO tbl_rownum(c1,c2,c3) values(8,'J',108);
INSERT INTO tbl_rownum(c1,c2,c3) values(9,'K',109);
INSERT INTO tbl_rownum(c1,c2,c3) values(10,'L',110);

SELECT * FROM tbl_rownum

SELECT *
FROM  (SELECT *
       FROM   tbl_rownum
       ORDER BY c1)
WHERE  ROWNUM >= 1
AND    ROWNUM <= 5;


C1 	C2 	C3
----- -- ---------
1 	C 	101
2 	D 	102
3 	E 	103
4 	F 	104
5 	G 	105

--실행하면 결과값이 나오지 않는 이유?
SELECT *
FROM  (SELECT *
       FROM   tbl_rownum
       ORDER BY c1)
WHERE  ROWNUM >= 6
AND    ROWNUM <= 10;


C1 ROWNUM ROWNUM 조건 결과 데이터
1 1 ROWNUM >= 1 AND ROWNUM <= 5 만족하므로 결과 데이터로 포함. 1
  1 ROWNUM >= 6 AND ROWNUM <= 10 만족하지 않으므로 패스.  

2 2 ROWNUM >= 1 AND ROWNUM <= 5 만족하므로 결과 데이터로 포함. 1, 2
  1 ROWNUM >= 6 AND ROWNUM <= 10 만족하지 않으므로 패스.  

3 3 ROWNUM >= 1 AND ROWNUM <= 5 만족하므로 결과 데이터로 포함. 1, 2, 3
  1 ROWNUM >= 6 AND ROWNUM <= 10 만족하지 않으므로 패스.  

4 4 ROWNUM >= 1 AND ROWNUM <= 5 만족하므로 결과 데이터로 포함. 1, 2, 3, 4
  1 ROWNUM >= 6 AND ROWNUM <= 10 만족하지 않으므로 패스.  

5 5 ROWNUM >= 1 AND ROWNUM <= 5 만족하므로 결과 데이터로 포함. 1, 2, 3, 4, 5
  1 ROWNUM >= 6 AND ROWNUM <= 10 만족하지 않으므로 패스.  

6 6 ROWNUM >= 1 AND ROWNUM <= 5 만족하지 않으므로 패스. 스톱  
  1 ROWNUM >= 6 AND ROWNUM <= 10 만족하지 않으므로 패스.  
  

--무조건 1부터 생성
--rownum>=1은 결과값에서 1부터 번호 붙임
--시스템 입장에서 2부터 번호 붙이라고 하면 1은 기준이 뭐야? 기준 없음...!?  

SELECT *
FROM   tbl_rownum
WHERE ROWNUM>=1

SELECT *
FROM   tbl_rownum
WHERE ROWNUM>=2

SELECT *
FROM   tbl_rownum
WHERE ROWNUM>=3
​

SELECT *
FROM  (SELECT *
       FROM   tbl_rownum
       ORDER BY c1)
WHERE  ROWNUM >= 1
AND    ROWNUM <= 1;


--order by -> rownum -> alias -> select
SELECT c1, c2, c3, RNUM
FROM  (SELECT ROWNUM rnum,
              t1.*
       FROM  (SELECT *
              FROM   tbl_rownum
              ORDER BY c1) T1
       )
WHERE  rnum >= 6 and rnum <= 10 ;


/*
다음 주어진 SQL문에서 오류가 발생하지 않는 것은?
CREATE TABLE SQLD39_20(
ID NUMBER PRIMARY KET,
AGE NUMBER NOT NULL,
NAME VARCHAR2(1)
);

- -  - - - - - - - - - - -

(1) INSERT INTO SQLD39_20 VALUES(10,20,SYSDATE);
(2) INSERT INTO SQLD39_20 VALUES(20,NULL,'A');
(3) INSERT INTO SQLD39_20(AGE, NAME) VALUES(20,'A');
(4) INSERT INTO SQLD39_20(ID, AGE, NAME) VALUES(20,10,NULL);












