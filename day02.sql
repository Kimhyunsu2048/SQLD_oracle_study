--entity 생성

CREATE TABLE tbl_entity
(
환자이름 varchar(100)
);

-- a환자, b환자 -> 인스턴스(실제존재)
INSERT INTO tbl_entity(환자이름) values('a환자');
INSERT INTO tbl_entity(환자이름) values('b환자');

SELECT * FROM tbl_entity;

-- 속성이란?
-- 주소 -> 인천광역시, 서울,...
-- 엔티티를 설명하고 인스턴스의 구성요소가 된다.

CREATE TABLE table_name...
(
col1, ... <- 속성(attribute)
col2, ... <- 속성(attribute)
)

-- 도메인
-- 속성이 가질 수 있는 값의 범위
-- 성적점수가 가질 수 있는 범위(a, a+, b, b+, c, ...)


CREATE TABLE tbl_class_result
(
	grade varchar(100) NOT NULL,
	CONSTRAINT check_grade check(grade IN ('A','B','C','D','E')),
	score number NOT NULL,
	CONSTRAINT check_score check(score IN ('20','40','60','80','100'))
)

INSERT INTO tbl_class_result VALUES('A',20);
INSERT INTO tbl_class_result VALUES('B',40);
INSERT INTO tbl_class_result VALUES('C',60);
INSERT INTO tbl_class_result VALUES('D',80);
INSERT INTO tbl_class_result VALUES('E',100);

SELECT * FROM tbl_class_result;

-- 속성의 명명규칙(이름을 어떻게 지을지...)
-- 속성의 이름을 부열할때는 현업(실제업무 담당하는 팀)에서 사용하는 이름
-- 일반적으로 서술식으로 속성명은 사용 X
-- 주소입니다(X) 주소인데요(X) / 주소(O)
-- 수식어 X -> 진짜 주소 / 가자 주소

CREATE TABLE TBL_ATTR_TEST
(
	NAME VARCHAR(100), -- 이름
	ADDR VARCHAR(100) -- 주소
)

INSERT INTO TBL_ATTR_TEST(NAME, ADDR) VALUES('홍길동','서울 특별시');
INSERT INTO TBL_ATTR_TEST(NAME, ADDR) VALUES('고길동','인천 부평구');
INSERT INTO TBL_ATTR_TEST(NAME, ADDR) VALUES('박길동','경기 수원시');

SELECT * FROM TBL_ATTR_TEST;


-- 테이블 속성을 추가
ALTER TABLE TBL_ATTR_TEST ADD PHONE varchar(20);
ALTER TABLE TBL_ATTR_TEST ADD GENDER varchar(5);

UPDATE TBL_ATTR_TEST
SET PHONE='000-0000-1111'
WHERE ADDR='서울 특별시';


-- 관계 : 엔티티의 인스턴스 사이의 논리적인 연관성으로서 존재의 형태로서나 행위로서 서로에게 연관성이 부여된 상태
-- 릴레이션 = 테이블 = 스키마  -> 테이블의 구조
-- 인스턴스 -> 실제존재

-- 식별자 .어떤 것을 식별하다
-- 구분이 가능한.
-- 하나의 엔티티 내에서 구분가능한 대표적인 속성
-- 하나의 엔티티 내에서 유일한 식별자가 존재해야 함

-- 식별자 - 주식별자, 보조식별자 --> 어떤걸 설정하느냐에 따라 찾는 속도가 다름(성능의 문제)
CREATE TABLE tbl_test
(
	사원번호 PRIMARY KEY -- 유일 주식별자, 유일하게 하나
	주민번호 -- 유일 보조식별자
)

CREATE TABLE tbl_employee
(
	empl_no integer PRIMARY KEY, -- 유일한 pk, 중복허용x
	empl_name varchar(100), -- 이름 100자 이름
	empl_jumin varchar(100) UNIQUE, -- 주민번호 유일하다.
	empl_juso varchar(200) -- 200자 주소
);

INSERT INTO TBL_EMPLOYEE(EMPL_NO,EMPL_NAME,EMPL_JUMIN,EMPL_JUSO) VALUES(1,'A사원','생년월일1','부평');
INSERT INTO TBL_EMPLOYEE(EMPL_NO,EMPL_NAME,EMPL_JUMIN,EMPL_JUSO) VALUES(2,'B사원','생년월일2','서울');
INSERT INTO TBL_EMPLOYEE(EMPL_NO,EMPL_NAME,EMPL_JUMIN,EMPL_JUSO) VALUES(3,'C사원','생년월일3','양주');
INSERT INTO TBL_EMPLOYEE(EMPL_NO,EMPL_NAME,EMPL_JUMIN,EMPL_JUSO) VALUES(4,'D사원','생년월일4','대전');
INSERT INTO TBL_EMPLOYEE(EMPL_NO,EMPL_NAME,EMPL_JUMIN,EMPL_JUSO) VALUES(5,'E사원','생년월일5','부산');

SELECT * FROM tbl_employee WHERE EMPL_NO=5;

-- 식별자 종류(내부식별자 PK, 외부식별자 FK)

CREATE TABLE A 
(
	COL1 PRIMARY KEY,
	COL2,
	COL3
)

CREATE TABLE B 
(
	B_COL1 PRIMARY KEY, -- 주키
	B_COL2,
	B_COL3,
	CONSTRAINT FOREIGN KEY(COL1) REFERENCES A -- FK 외래키
)

-- 주식별자 도출기준? 어떤것을 주식별자로 할 것인가?
-- 사원테이블(사원번호 주소, 이름, ....) -> 어떤것을 PK? == 어떤것을 주식별자로?





























