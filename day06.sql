-- procedures -> 절차 -> 재사용이 가능하다.

(procedures A
-- 학교에서 수업을 듣는다.
1) 필기도구를 꺼낸다 - 절차1
2) 수업 노트를 꺼낸다 - 절차2
3) 중요한 내용을 필기한다 - 절차3
)
-- 수학 / 국어 / 영어 / 과학

-- 단일행 함수 : 하나의 데이터(행)를 반환
-- 다중행 함수 : 여러개의 데이터(행)를 반환

-- SQL 활용 2

-- 그룹함수/윈도우함수/DCL/절차형 SQL
-- 절차형 SQL
-- 일반적인 개발 언어처럼 SQL에도 절차 지향적인 프로그램이 가능하도록 DBMS 벤더별로 
-- PL(Procedural Language)/SQL(Oracle), SQL/PL(DB2), T-SQL(SQL Server) 등의 절차형 SQL을 제공하고 있다.

-- 절차형 SQL을 이용하면 SQL문의 연속적인 실행이나 조건에 따른 분기처리를 이용하여 
-- 특정 기능을 수행하는 저장 모듈을 생성할 수 있다. 본 절에서는 절차형 SQL을 이용하여 만들 수 있는
-- 저장 모듈인 Procedure, User Defined Function, Trigger에 대해서 간단하게 살펴본다. (상세한 내역은 각 DBMS 벤더의 매뉴얼을 참조한다.)

-- 객체지향 프로그래밍(java)과 절차적 프로그래밍(c언어, 프로시저)은 상반된 개념이 아니다.

-- 객체지향언어
-- 자동차 - 엔진, 바퀴, 창문,...  -> 모두 객체
				|--------------------------------> 동일한 바퀴를 하나로 통일
-- 비행기 - 엔진, 바퀴, 창문,...  -> 모두 객체

-- 프로시저(절차형) -> 언어는 아님
-- 함수로 되어 있음.
-- 자동차를 표현하기 위해서는 ? 엔진, 바퀴, 창문 각각을 하나의 함수로 만들어야 함.
-- 자동차, 비행기,,, 각각 만들어야 함.

-- function? 함수	
-- CREATE OR REPLACE FUNCTION : 없으면 새로 만들고 있으면 대체하라는 의미.				
CREATE OR REPLACE FUNCTION test_func -- 함수 만들기
	RETURN varchar
IS 
	v_test varchar2(100); -- 컬럼을 만듦
BEGIN 
	v_test := 'testFunction'; -- FUNCTION을 입력 , ;이 누락되면 호출시 안될수 있음
RETURN v_test;
END;

SELECT test_func() aa FROM dual; -- aa -> alias임


-- 프로시저
CREATE OR REPLACE PROCEDURE procInsert(
	param_1 int 
)
IS 
BEGIN 
	INSERT INTO TBL_A VALUES(param_1);
	COMMIT;
END;
-- COMMIT : 파일 저장   /   ROLLBACK : 되돌리기

-- 프로시저 호출
CALL procInsert(1)


CREATE TABLE TBL_A
(
	PARAM NUMBER
);

SELECT * FROM TBL_A;



객체지향 프로그래밍(Object Oriented Programming)이란?
특징
1. 캡슐화 : 데이터와 기능을 하나의 단위로 묶는 것
은닉: 구현은 숨기고, 동작은 노출시킴
느슨한 결합(Loose Coupling)에 유리: 언제든 구현을 수정할 수 있다.

2. 추상화 : 
공통의 속성이나 기능을 묶어 이름을 붙이는 것
필요한(공통적인) 부분만 파악해서 추출하고 필요하지 않는 것은 제거
클래스 정의 시, 메소드와 속성만 정의한 것을 인터페이스라 부른다. 이것이 추상화의 본질이라고 할 수 있다.

3. 상속
부모 클래스(base class)의 특징을 자식 클래스(derive class)가 물려받는 것
자식이 부모의 기능과 속성을 중복해서 가져야할 때는 상속을 통해 물려받고 추가적으로 필요한 기능만 추가할 수 있다.

4. 다형성
한 객체가 다른 여러 형태(객체)로 재구성 되는 것
자바의 Overload, Override이 다형성의 대표적인 예다.
Overload는 하나의 클래스 안에 같은 이름의 메소드를 여러 개 지닐 수 있는 것
Override는 상속받은 메소드를 재정의하여 기능을 확장하여 코드의 중복을 줄일 수 있는 것


장점
- 모듈화, 캡슐화로 인해 유지보수에 용이하다.
- 객체지향적이기 때문에 현실 세계와 유사성에 의해 코드를 이해하기 쉽게 만든다.
- 객체 자체가 하나의 프로그램이기에 재사용에 용이하다


단점
- 대부분의 객체지향 프로그램은 속도가 상대적으로 느려지고 많은 양의 메모리를 사용하는 경향이 있다.
- 코드를 설계하고 작성하는데 절차적 프로그래밍에 비해 많은 시간이 소요된다.


객체지향 프로그래밍과 절차적 프로그래밍은 상반된 개념이 아니다.
1.프로시저 - 절차
2.함수  - 기능
3.트리거 - 방아쇠 -> EX) 주문하는 순간 김치,단무지,물도 같이 나오는 것과 같음
-- CGV 표를 주문 -> 표와 관련된 데이터베이스에 저장(TABLE A) 
--							+ (트리거 자동 실행) 회원정보 테이블에서 표를 구매한 이력도 저장(TABLE B)

-- 데이터베이스 어떤 데이터를 지운다고 하면 -> DELETE A WHERE A..		TABLE A
--							+(트리거) 지운 정보를 백업 테이블에 저장 	TABLE B
​

-- 함수 function
-- 함수와 프로시저의 가장 큰 차이 : 반환값 유무

CREATE OR REPLACE FUNCTION test_func
    RETURN VARCHAR
IS
   v_test VARCHAR2(100);
BEGIN
  v_test := 'testFunction';
RETURN v_test;
END;


SELECT test_func() aa FROM dual

test_func() -> x

​

​

--숫자 리턴
CREATE OR REPLACE FUNCTION fnTest1
RETURN INT
IS
ret_value int;
BEGIN 
ret_value:= 10;
RETURN ret_value;
END;

SELECT fnTest1()  FROM dual


--테스트 함수 리턴? 무한로딩
CREATE OR REPLACE FUNCTION fnTest1
RETURN INT
IS
ret_value int;
BEGIN 
ret_value:= 10;
RETURN fnTest1;
END;

SELECT fnTest1()  FROM dual


--프로시저 
--오라클에서의 프로시저는 PL/SQL을 통해 만들어집니다. 
--자주 사용하는 SQL을 프로시저로 만든 뒤 필요 할때마다 호출,사용하여 작업 효율을 늘릴 수 있습니다. 
--함수는 특정 연산을 수행한 뒤 결과 값을 반환하지만 프로시저는 특정한 로직을 처리하기만 하고 결과 값은 반환하지 않는 서브 프로그램입니다.
​
--추가
​

SELECT * FROM TBL_A
    CREATE OR REPLACE PROCEDURE procInsert(
        param_1 int 
    )
    IS
    BEGIN
        INSERT INTO TBL_A VALUES(param_1);
        COMMIT;
    END;
   

CALL procInsert(11);--프로시저 호출  ->주석 붙이면 실행 안됨

SELECT * FROM TBL_A

--오라클 exec / call 차이 - 실행계획에서 차이 / mssql exec 사용 / 오라클 call 특정 버전 이후 혼합사용(최신)​

--구구단을 출력해주는 프로그램을 만들어라.
    CREATE OR REPLACE PROCEDURE procSelect(
        param_1 NUMBER  
    )
    IS
    BEGIN
    dbms_output.put_line(param_1|| 'X' || 1 || '=' || param_1*1);
    dbms_output.put_line(param_1|| 'X' || 2 || '=' || param_1*2);
    dbms_output.put_line(param_1|| 'X' || 3 || '=' || param_1*3);
    dbms_output.put_line(param_1|| 'X' || 4 || '=' || param_1*4);
	dbms_output.put_line(param_1|| 'X' || 5 || '=' || param_1*5);
	dbms_output.put_line(param_1|| 'X' || 6 || '=' || param_1*6);
	dbms_output.put_line(param_1|| 'X' || 7 || '=' || param_1*7);
	dbms_output.put_line(param_1|| 'X' || 8 || '=' || param_1*8);
	dbms_output.put_line(param_1|| 'X' || 9 || '=' || param_1*9);
    COMMIT;
    END;   

call procSelect(2);


--트리거란?
--Trigger의 사전적 뜻은 총의 방아쇠입니다.
--데이터베이스에서 트리거를 뜻하는 말은 총의 방아쇠를 당기는 것과 같이 어떤 이벤트의 자동으로 실행되는 것을 뜻합니다.
--구체적으론 데이터가 삭제되었을 때,변경되었을 때, 추가되었을 때에 따라 트리거를 생성해 실행시킬 수 있습니다.

--트리거는 데이터베이스 시스템에서 데이터의 입력, 갱신, 삭제 등의 이벤트가 발생할 때마다 자동적으로 수행되는 사용자 정의 프로시저이다.
--트리거는 TABLE과는 별도로 DATABASE에 저장된다.
--트리거는 VIEW에 대해서가 아니라 TABLE에 관해서만 정의될 수 있다.
--트리거는 SQL의 제약조건 방법을 통해 명시할 수 없는 무결성 제약조건을 구현하고, 관련 테이블의 데이터를 일치시킬 때 주로 사용된다.
--제약조건과 함께 데이터 무결성을 지키는 하나의 방법으로써 특정 이벤트에 대해서 연속적으로 자동 동작하는 특수한 형태의 저장 프로시저라고 볼 수 있다.
--일반적으로 사용처는 많지만 예를 들어보자면 "입고"테이블에 새로운 제품이 들어왔을 때 그 수량을 "재고"테이블에 자동으로 반영되게 하는 경우가 있다.
/*

CREATE [ OR REPLACE ] TRIGGER 트리거명
BEFORE | AFTER
[ 동작(INSERT, UPDATE, DELETE) ] ON 테이블명 
[ REFERENCING  NEW | OLD  TABLE AS 테이블명 ]
[ FOR EACH ROW ]
[ WHEN 조건식 ]
트리거 BODY문

OR REPLACE: 생성할 트리거와 같은 이름을 가지고 있어도 무시하고 새로운 것으로 갱신하는 것이므로 사용할 때 주의해야 한다.

* AFTER: 테이블이 변경된 후에 트리거가 실행되는 옵션이다.
* BEFORE: 테이블이 변경되기 전에 트리거가 실행되는 옵션이다.
* 동작옵션: 각각 INSERT, UPDATE, DELETE가 실행될 때 트리거를 실행시키는 것이다.
* NEW: 새로 추가되거나 변경된 후의 값에 트리거가 적용된다. (INSERT : 입력할 값, UPDATE: 수정할 값)
* OLD: 변경 전의 값에 트리거가 적용된다. (UPDATE: 수정 전 값, DELETE: 삭제할 값)
* WHEN: 트리거가 실행되면서 지켜야 할 조건을 지정한다. (조건에 맞는 데이터만 트리거 실행)
* 트리거 BODY문 : 트리거의 본문 코드를 입력하는 부분이다.
- BEGIN으로 시작해서 END로 끝나는데, 적어도 하나 이상의 SQL문이 있어야 한다. 그렇지 않으면 오류가 발생한다.
- 변수에 값을 치환할 때는 예약어 SET을 사용한다.
 */

--트리거 조회
 SELECT * FROM USER_TRIGGERS

 --프로시저와 트리거의 차이점 
--프로시저, 트리거
--CREATE Procedure 문법사용 CREATE Trigger 문법사용
--EXECUTE 명령어로 실행 생성 후 자동으로 실행
--COMMIT, ROLLBACK 실행 가능 COMMIT, ROLLBACK 실행 안됨
​
CALL(오라클) = EXECUTE(MSSQL) = EXEC 
 

--문제
 /*

PROCEDURE, TRIGGER 에 대한 설명 중 가장 잘못된 것은?  --정답은 1번
1) PROCEDURE, TRIGGER 모두 EXECUTE 명령어로 수행된다 -- 트리거는 자동실행
2) PROCEDURE, TRIGGER 모두 CREATE 명령어로 생성한다
3) PROCEDURE 는 COMMIT, ROLLBACK 명령어를 사용할 수 있다
4) TRIGGER 는 COMMIT, ROLLBACK 명령어를 사용할 수 없다  -- 트리거는 자동실행되므로 실행되는순간 끝남


 아래의 Trigger 에 대한 설명 중 가장 부적절한 것은 ?
1) DELETE ON TRIGGER 의 경우 :OLD 는 삭제 전 데이터를 , :NEW 는 삭제 후 데이터를 나타낸다.
2) 특정 테이블에 DML 문이 수행되었을 때 자동으로 동작하도록 작성된 프로그램이다.
3) 테이블, 뷰에만 트리거를 작성할 수 있으며 데이터베이스 작업에는 정의할 수 없다.
4) UPDATE TRIGGER 에서 :OLD 에는 수정 전, :NEW 에는 수정 후 값이 들어간다.

*/

 --데이터베이스 작업에도 트리거가능?
 --https://docs.oracle.com/cd/B13789_01/server.101/b10759/statements_7004.htmDATABASE
--Specify DATABASE to define the trigger on the entire database. The trigger fires whenever any database user initiates the triggering event.
 
--구글번역
 --전체 데이터베이스에서 트리거를 정의하려면 DATABASE를 지정하십시오. 트리거는 데이터베이스 사용자가 트리거링 이벤트를 시작할 때마다 실행됩니다.
 

-- 시스템 테이블
-- 데이터 베이스에 저장되어 있는 모든 사용자를 가져와라
SELECT * FROM ALL_USERS;
​
-- SQL plus에서 실행
create user C##TESTER111 identified by 1234; 
-- 롤 권한 부여
​GRANT connect, resource, dba TO c##TESTER111;
 
-- 사용자의 role(역할) 확인 ->  EX) 로그인 역할, 테이블 만드는 역할, 데이터 삭제 역할 
SELECT * FROM DBA_ROLE_PRIVS 



 ---------------------------------------------------------------SQL 활용 2
--그룹함수/윈도후함수/DCL/절차형 SQL(O)

--DCL
 /*
  * https://parkbosung.tistory.com/11
  * 

 DB 기본 용어 (SQL, DDL, DML, DCL, TCL)
SQL (Structured Query Language) 은 구조적인 질의 언어라는 것이다.
이 SQL 이라는 질의 언어를 통해서 데이터베이스를 제어, 관리한다.


SQL 은 다음 언어로 나눌 수 있다.
⒜ DDL : 데이터 정의 언어 
⒝ DML : 데이터 조작 언어
⒞ DCL : 데이터 제어 언어

DDL (Data Definition Language) 는 데이터 베이스 스키마를 정의 하거나 조작하기 위해 사용한다.

SCHEMA, DOMAIN, TABLE, VIEW, INDEX 를 다음 명령어로 정의, 변경, 삭제한다.
⒜ CREATE : 정의 
⒝ ALTER: 수정
⒞ DROP : 삭제
⒟ TRUNCATE : DROP 후 CREATE
​

DML (Data Manipulation Language) 는 데이터를 조작 (조회, 추가, 변경, 삭제) 하기 위해 사용한다.
⒜ SELECT : 조회
⒝ INSERT : 추가
⒞ DELETE : 삭제
⒟ UPDATE : 변경
​

DCL (Data Control Language) 는 데이터를 제어하는 언어이다.
데이터의 보안, 무결성, 회복, 병행 수행제어 등을 정의하는데 사용한다.
⒜ COMMIT : 트랜잭션의 작업 결과를 반영 
⒝ ROLLBACK : 트랜잭션의 작업을 취소 및 원래대로 복구
⒞ GRANT : 사용자에게 권한 부여
⒟ REVOKE : 사용자 권한 취소

​
TCL
일부에서는 DCL 에서 트랜잭션을 제어하는 명령인 COMMIT 과 ROLLBACK 만을 따로 분리해서 TCL (Transaction Control Language) 라고 표현하기도 한다.

 */

 --Oracle과 SQL Server의 사용자에 대한 아키텍처는 다른 면이 많다. 
 --Oracle은 유저를 통해 데이터베이스에 접속을 하는 형태이다. 
 --즉, 아이디와 비밀번호 방식으로 인스턴스에 접속을 하고 그에 해당하는 스키마에 오브젝트 생성 등의 권한을 부여받게 된다. 

 --SQL Server는 인스턴스에 접속하기 위해 로그인이라는 것을 생성하게 되며,
 -- 인스턴스 내에 존재하는 다수의 데이터베이스에 연결하여 작업하기 위해 유저를 생성한 후 로그인과 유저를 매핑해 주어야 한다.
 -- 더 나아가 특정 유저는 특정 데이터베이스 내의 특정 스키마에 대해 권한을 부여받을 수 있다.
 -- SQL Server 로그인은 두 가지 방식으로 가능하다. 첫 번째, Windows 인증 방식으로 Windows에 로그인한 정보를 가지고 SQL Server에 접속하는 방식이다. 
 

 --오라클 유저 생성
create user C##TESTER111 identified by 1234;
GRANT CONNECT,resource,dba TO C##TESTER111


--계정생성 확인
select * from all_users;


--SQLPLUS 로 로그인 시도 C##TESTER111으로 로그인 해야 함.
Copyright (c) 1982, 2021, Oracle.  All rights reserved.


사용자명 입력: C##TESTER111
비밀번호 입력:

다음에 접속됨:

Oracle Database 21c Express Edition Release 21.0.0.0.0 - Production

Version 21.3.0.0.0

​

SQL>
--계정삭제
drop user C##TESTER111 cascade;

select * from all_users;


--존재하는 유저인지 판단 못 함.
사용자명 입력: C##TESTER111
비밀번호 입력:

ERROR:

ORA-01017: 사용자명/비밀번호가 부적합, 로그온할 수 없습니다.

​

사용자명 입력: ejfklelfel
비밀번호 입력:

ERROR:

ORA-01017: 사용자명/비밀번호가 부적합, 로그온할 수 없습니다.



-- Role을 이용한 권한 부여
--오라클 SQL 에서의 ROLE(롤, 역할)이란, 여러개의 권한을 그룹으로 묶은 권한의 묶음?


-- 오라클 유저 생성
create user C##TESTER111 identified by 1234;

-- 롤 권한 부여
GRANT CONNECT,resource,dba TO C##TESTER111

-- 사용자의 role 확인
select * from dba_role_privs
where grantee='C##TESTER111';

-- 롤해제
revoke 롤이름A from 사용자이름K;

-- 롤삭제
drop role 롤이름A;

--sql server 권한 관리 테스트
--ssms -> 윈도우 인증?
--replication 성공

select * from test_a.dbo.test
insert into test_a.dbo.test values(2)
select * from test_b.dbo.test

--sql server에서 sa로 로그인해보기
--sql server에서 새로운 유저 만들어서 로그인 해보기
--데이터베이스 -> 보안 -> 서버 인증 비밀번호로 변경하고 리스타트 해야 함.(SQL SERVER 구성관리자)

sp_readerrorlog
Login failed for user 'tester'. 이유: SQL 인증을 사용하여 로그인하지 못했습니다. 서버가 통합 인증만 사용하도록 구성되어 있습니다. [클라이언트: <local machine>]  
Login failed for user 'tester'. 원인: 암호가 제공된 로그인의 암호와 일치하지 않습니다. [클라이언트: <local machine>]  

​

 ---------------------------------------------------------------SQL 활용 3

--그룹함수/윈도우함수/DCL(O)/절차형 SQL(O)
--윈도우함수 -> 분석 함수(ANALYTIC FUNCTION)나 순위 함수(RANK FUNCTION)로도 알려져 있음. 
--윈도우 함수(ANSI/ISO SQL 표준은 WINDOW FUNCTION이란 용어를 사용함)는 데이터웨어하우스에서 발전한 기능

-- 관계형 데이터베이스의 문제점 
--기존 관계형 데이터베이스는 칼럼과 칼럼간의 연산, 비교, 연결이나 집합에 대한 집계는 쉬운 반면, 
--행과 행간의 관계를 정의하거나, 행과 행간을 비교, 연산하는 것을 하나의 SQL 문으로 처리 하는 것은 매우 어려운 문제였다. 

--1.순위 함수 (RANK) 관련 함수는 RANK, DENSE_RANK, ROW_NUMBER 
--2.집계함수 그룹 내 집계(AGGREGATE) 관련 함수는 일반적으로 많이 사용하는 SUM, MAX, MIN, AVG, COUNT 
--3.그룹 내 행 순서 관련 함수는 FIRST_VALUE, LAST_VALUE, LAG, LEAD  -> 오라클에서만 사용되는 키워드
--4.그룹 내 비율 관련 함수는 CUME_DIST, PERCENT_RANK, NTILE, RATIO_TO_REPORT 함수 

-- rank
-- 아래 SQL의 수행결과에서 빈칸 ㉠, ㉡에 들어갈 값을 기술
고객번호  |   주문일자   | 주문순번  |  주문금액
100     |   20200105 |   1     |  20000
100     |   20200115 |   1     |  50000
100     |   20200427 |   1     |  30000
100     |   20200427 |   2     |  15000
200     |   20200105 |   1     |  25000
200     |   20200105 |   2     |  40000
200     |   20200320 |   1     |  18000


고객번호  최대주문금액
100       ㉠
200       ㉡


WITH CTE AS
(
SELECT 100 고객번호,20200105 주문일자, 1 주문순번, 20000 주문금액 FROM DUAL
UNION ALL
SELECT 100 고객번호,20200115 주문일자, 1 주문순번, 50000 주문금액 FROM DUAL
UNION ALL
SELECT 100 고객번호,20200427 주문일자, 1 주문순번, 30000 주문금액 FROM DUAL
UNION ALL
SELECT 100 고객번호,20200427 주문일자, 2 주문순번, 15000 주문금액 FROM DUAL
UNION ALL
SELECT 200 고객번호,20200105 주문일자, 1 주문순번, 25000 주문금액 FROM DUAL
UNION ALL
SELECT 200 고객번호,20200105 주문일자, 2 주문순번, 40000 주문금액 FROM DUAL
UNION ALL
SELECT 200 고객번호,20200320 주문일자, 1 주문순번, 18000 주문금액 FROM DUAL
)SELECT * FROM CTE


WITH CTE AS
(
SELECT 100 고객번호,20200105 주문일자, 1 주문순번, 20000 주문금액 FROM DUAL
UNION ALL
SELECT 100 고객번호,20200115 주문일자, 1 주문순번, 50000 주문금액 FROM DUAL
UNION ALL
SELECT 100 고객번호,20200427 주문일자, 1 주문순번, 30000 주문금액 FROM DUAL
UNION ALL
SELECT 100 고객번호,20200427 주문일자, 2 주문순번, 15000 주문금액 FROM DUAL
UNION ALL
SELECT 200 고객번호,20200105 주문일자, 1 주문순번, 25000 주문금액 FROM DUAL
UNION ALL
SELECT 200 고객번호,20200105 주문일자, 2 주문순번, 40000 주문금액 FROM DUAL
UNION ALL
SELECT 200 고객번호,20200320 주문일자, 1 주문순번, 18000 주문금액 FROM DUAL
)SELECT 고객번호,MAX(주문금액) KEEP (DENSE_RANK LAST ORDER BY 주문일자 )AS 최대주문금액 
FROM CTE
GROUP BY 고객번호;
​

SELECT 고객번호,MAX(주문금액) KEEP (DENSE_RANK LAST ORDER BY 주문일자) AS 최대주문금액
FROM 주문
GROUP BY 고객번호;
--> RANK 함수를 매기는데 주문일자로 정렬했을 때 가장 마지막에 있는 값중 주문금액이 최대값
--KEEP은 오라클에서 KEEP 키워드를 사용하면 행 그룹(GROUP BY) 내에서 최고 또는 최고 순위 행으로 집계를 할 수 있다

--그룹 내 순위 함수
--RANK() : 중복값은 중복등수, 등수 건너뜀(1위, 1위, 3위, 4위)
--DENSE_RANK() : 중복값은 중복등수, 등수 안 건너뜀(1위, 1위, 2위, 2위)
--ROW_NUMBER() : 중복값이 있어도 고유 등수 부여(1위, 2위, 3위, 4위)


--주어진 데이터에 대해서 SQL의 결과가 아래와 같을 때 SQL문의 빈칸을 완성하시오
[SQLD_43]
이름    부서       직책     급여
----------------------------
조조    경영지원부   부장     300
유비    경영지원부   과장     290
제갈량   인사부      대리     250
사마의   인사부      대리     250
관우    영업부      사원     230
장비    영업부      사원     220
​
- - - - - - - - - - - - - - - - -

SELECT RANK() OVER (ORDER BY 급여 DESC)
AS 순위,이름, 부서, 직책, 급여
FROM SQLD_43;
​

[Result1]
순위    이름    부서       직책     급여
-----------------------------------
1      조조    경영지원부   부장     300
2      유비    경영지원부   과장     290
3      제갈량   인사부      대리     250
3      사마의   인사부      대리     250
5      관우    영업부      사원     230
6      장비    영업부      사원     220

- - - - - - - - - - - - - - - - -
​
SELECT(     ) OVER (ORDER BY 급여 DESC)
AS 순위,
이름, 부서, 직책, 급여
FROM SQLD_43;
​

[Result2]
순위    이름    부서       직책     급여
-----------------------------------
1      조조    경영지원부   부장     300
2      유비    경영지원부   과장     290
3      제갈량   인사부      대리     250
4      사마의   인사부      대리     250
5      관우    영업부      사원     230
6      장비    영업부      사원     220


[SQLD_43]
이름    부서       직책     급여
----------------------------
조조    경영지원부   부장     300
유비    경영지원부   과장     290
제갈량   인사부      대리     250
사마의   인사부      대리     250
관우    영업부      사원     230
장비    영업부      사원     220


WITH CTE AS
(
SELECT '조조' 이름, '경영지원부' 부서,'부장' 직책, 300 급여 FROM DUAL
UNION ALL
SELECT '유비' 이름, '경영지원부' 부서,'과장' 직책, 290 급여 FROM DUAL
UNION ALL
SELECT '제갈량' 이름, '인사부' 부서,'대리' 직책, 250 급여 FROM DUAL
UNION ALL
SELECT '사마의' 이름, '인사부' 부서,'대리' 직책, 250 급여 FROM DUAL
UNION ALL
SELECT '관우' 이름, '영업부' 부서,'사원' 직책, 230 급여 FROM DUAL
UNION ALL
SELECT '장비' 이름, '영업부' 부서,'사원' 직책, 220 급여 FROM DUAL
) 
SELECT RANK() OVER(ORDER BY 급여 desc) 순위,이름,부서,직책,급여 
FROM CTE


WITH CTE AS
(
SELECT '조조' 이름, '경영지원부' 부서,'부장' 직책, 300 급여 FROM DUAL
UNION ALL
SELECT '유비' 이름, '경영지원부' 부서,'과장' 직책, 290 급여 FROM DUAL
UNION ALL
SELECT '제갈량' 이름, '인사부' 부서,'대리' 직책, 250 급여 FROM DUAL
UNION ALL
SELECT '사마의' 이름, '인사부' 부서,'대리' 직책, 250 급여 FROM DUAL
UNION ALL
SELECT '관우' 이름, '영업부' 부서,'사원' 직책, 230 급여 FROM DUAL
UNION ALL
SELECT '장비' 이름, '영업부' 부서,'사원' 직책, 220 급여 FROM DUAL
)

SELECT ROW_NUMBER() OVER(ORDER BY 급여 desc) 순위,이름,부서,직책,급여 
FROM CTE
​

----2.집계함수 그룹 내 집계(AGGREGATE) 관련 함수는 일반적으로 많이 사용하는 SUM, MAX, MIN, AVG, COUNT 
SELECT AVG(ID) FROM (
SELECT 1 ID FROM DUAL
UNION ALL
SELECT 2 ID FROM DUAL
UNION ALL
SELECT 3 ID FROM DUAL
)AA


SELECT AVG(ID) FROM (
SELECT 1 ID FROM DUAL
UNION ALL
SELECT 2 ID FROM DUAL
UNION ALL
SELECT 3 ID FROM DUAL
UNION ALL
SELECT 4 ID FROM DUAL
)AA


SELECT SUM(ID) FROM (
SELECT 1 ID FROM DUAL
UNION ALL
SELECT 2 ID FROM DUAL
UNION ALL
SELECT 3 ID FROM DUAL
)AA
​

SELECT MAX(ID) FROM (
SELECT 1 ID FROM DUAL
UNION ALL
SELECT 2 ID FROM DUAL
UNION ALL
SELECT 3 ID FROM DUAL
)AA


SELECT MIN(ID) FROM (
SELECT 1 ID FROM DUAL
UNION ALL
SELECT 2 ID FROM DUAL
UNION ALL
SELECT 3 ID FROM DUAL
)AA

​
SELECT COUNT(ID) FROM (
SELECT 1 ID FROM DUAL
UNION ALL
SELECT 2 ID FROM DUAL
UNION ALL
SELECT 3 ID FROM DUAL
)AA


--3.그룹 내 행 순서 관련 함수는 FIRST_VALUE, LAST_VALUE, LAG, LEAD
파티션 별 윈도우에서 가장 먼저 나온 값을 구하는 WINDOW FUNCTION은 무엇인가? 
1) FIRST_VALUE
2) LAG
3) LAST_VALUE
4) LEAD

-- 행 순서 설명
FIRST_VALUE - 파티션에서 가장 처음에 나오는 값을 구한다.
            - MIN 함수를 사용해서 같은 결과를 구할 수 있다.            

LASt_VALUE - 파티션에서 가장 나중에 나오는 값을 구한다.
            - MAX 함수를 사용해서 같은 결과를 구할 수 있다.            

LAG         - 이전에 행을 가지고 온다.

LEAD     - 윈도우에서 특정 위치의 행을 가지고 온다.  - 기본 값은 1이다.
     
DROP TABLE TBL_LAG;

CREATE TABLE TBL_LAG
(
ID NUMBER
);

INSERT INTO TBL_LAG VALUES(1);
INSERT INTO TBL_LAG VALUES(2);
INSERT INTO TBL_LAG VALUES(3);
INSERT INTO TBL_LAG VALUES(4);
INSERT INTO TBL_LAG VALUES(5);
SELECT * FROM TBL_LAG;


SELECT ID,LEAD(ID,0) OVER(ORDER BY ID DESC) LEAD FROM TBL_LAG;

SELECT id,lead(id,1) over(ORDER BY id desc) lead FROM TBL_LAG;

SELECT id,lead(id,2) over(ORDER BY id desc) lead FROM TBL_LAG;

SELECT id,lag(id) over(ORDER BY id desc) lag FROM TBL_LAG;

SELECT id,lag(id,0) over(ORDER BY id desc) lag FROM TBL_LAG;

SELECT id,lag(id,1) over(ORDER BY id desc) lag FROM TBL_LAG;

SELECT id,lead(id,1) over(ORDER BY id asc) lead,lag(id,1) over(ORDER BY id asc) lag FROM TBL_LAG;



--lag : 지연(다음) / lead : 선두(이전)
-- 1 2 3 4 5
--     3
-- <- 왼쪽은 지연(lag)
--     오른쪽은 선두(lead) ->   


--    3번 기준으로 지연은 2 선두는 4
--    3번 기준으로 lag는 2 lead는 4


--순서대로 정렬 
-- 1  ->  2  ->  3 ->  4  ->  5 
-- 3번 기준으로 1은 이미 지나갔다. 지연됨. 열차가 지연됨. lag
-- 3번 기준으로 5번은 아직 지나가지 않음. 선두권. lead. leader
--앞에 있으면 leader


 ---------------------------------------------------------------SQL 활용 

-- 그룹함수/윈도후함수(O)/DCL(O)/절차형 SQL(O)

-- 그룹함수 : ROLLUP함수 + GROUPING  함수
-- ROLLUP함수는 소그룹간의 합계를 계산하는 함수입니다. 
-- ROLLUP을 사용하면 GROUP BY로 묶은 각각의 소그룹 합계와 전체 합계를 모두 구할 수 있습니다. 

-- cube 함수
-- CUBE함수는 항목들 간의 다차원적인 소계를 계산합니다. 
-- ROLLUP과 달리 GROUP BY절에 명시한 모든 컬럼에 대해 소그룹 합계를 계산해줍니다.

--GROUPING SETS 함수
--GROUPING SETS는 특정 항목에 대한 소계를 계산하는 함수입니다

--소계란?  한 부분만의 합계

--다음 주어진 테이블에 대한 아래의 SQL문의 결과 건수로 알맞은 것은?
[SQLD_40]
COL1       COL2
---------------
A           100
B           200
C           300
C           400

SELECT COUNT(*)
FROM SQLD_40
GROUP BY ROLLUP(COL1), COL1;


SELECT count(*) FROM (
SELECT 'A' COL1, 100 COL2 FROM DUAL
UNION ALL
SELECT 'B' COL1, 200 COL2 FROM DUAL
UNION ALL
SELECT 'C' COL1, 300 COL2 FROM DUAL
UNION ALL
SELECT 'C' COL1, 400 COL2 FROM DUAL
)AA
GROUP BY rollup(col1),col1

​

SELECT col1,count(*) FROM ( -- SELECT 뒤에 * 넣으면 안됨 -> GROUP BY 로 나눴기 때문에...
SELECT 'A' COL1, 100 COL2 FROM DUAL
UNION ALL
SELECT 'B' COL1, 200 COL2 FROM DUAL
UNION ALL
SELECT 'C' COL1, 300 COL2 FROM DUAL
UNION ALL
SELECT 'C' COL1, 400 COL2 FROM DUAL
)AA
GROUP BY col1


SELECT col1,count(*) FROM (
SELECT 'A' COL1, 100 COL2 FROM DUAL
UNION ALL
SELECT 'B' COL1, 200 COL2 FROM DUAL
UNION ALL
SELECT 'C' COL1, 300 COL2 FROM DUAL
UNION ALL
SELECT 'C' COL1, 400 COL2 FROM DUAL
UNION ALL
SELECT NULL COL1, 400 COL2 FROM DUAL
)AA
GROUP BY col1
​

SELECT col1,count(*) FROM (
SELECT 'A' COL1, 100 COL2 FROM DUAL
UNION ALL
SELECT 'B' COL1, 200 COL2 FROM DUAL
UNION ALL
SELECT 'C' COL1, 300 COL2 FROM DUAL
UNION ALL
SELECT 'C' COL1, 400 COL2 FROM DUAL
UNION ALL
SELECT 'D' COL1, 1000 COL2 FROM DUAL
)AA
GROUP BY ROLLUP(col1)

-- 위 결과
COL1   COUNT(*)
A		1
B		1
C		2
D		1
[NULL]	5


SELECT col1,count(*) FROM (
SELECT 'A' COL1, 100 COL2 FROM DUAL
UNION ALL
SELECT 'B' COL1, 200 COL2 FROM DUAL
UNION ALL
SELECT 'C' COL1, 300 COL2 FROM DUAL
UNION ALL
SELECT 'C' COL1, 400 COL2 FROM DUAL
)AA
GROUP BY rollup(col1),col1

​

SELECT count(*) FROM (
SELECT 'A' COL1, 100 COL2 FROM DUAL
UNION ALL
SELECT 'B' COL1, 200 COL2 FROM DUAL
UNION ALL
SELECT 'C' COL1, 300 COL2 FROM DUAL
UNION ALL
SELECT 'C' COL1, 400 COL2 FROM DUAL
)AA
GROUP BY rollup(col1),col1


예를 들면 ROLLUP(a, b) 는
1. (a, b) 합계
2. (a) 합계
3. () 합계
이렇게 3가지 형태의 집계 결과가 나오게 된다.

ROLLUP(a), a 를 보면
1. (a), a
2. (), a
이렇게 두가지 형태의 집계 결과가 나오게 된다.
a 가 두번 나오나 한번 나오나 다 같은 a 기준 집계 결론은 a 기준 집계 두번 한 결과
​

CREATE TABLE TBL_EMP
(
deptno NUMBER,
job varchar(30),
sal NUMBER
);

INSERT INTO TBL_EMP values(10,'매니저',1000);
INSERT INTO TBL_EMP values(10,'사원',500);
INSERT INTO TBL_EMP values(10,'알바',300);
INSERT INTO TBL_EMP values(10,'알바',200);
INSERT INTO TBL_EMP values(10,'알바',100);

INSERT INTO TBL_EMP values(20,'매니저',1000);
INSERT INTO TBL_EMP values(20,'사원',1000);
INSERT INTO TBL_EMP values(20,'사원',1100);
INSERT INTO TBL_EMP values(20,'사원',1200);
INSERT INTO TBL_EMP values(20,'사원',1300);
INSERT INTO TBL_EMP values(20,'알바',1000);

INSERT INTO TBL_EMP values(30,'사장',10000);


SELECT * FROM TBL_EMP ORDER BY deptno,job;

--부서번호,직업별로 임금의 합계
SELECT deptno,job,sum(sal),count(*) FROM TBL_EMP
GROUP BY deptno,job;

--부서별,직업별 합계와 전체 합계
SELECT deptno,job,sum(sal),count(*) FROM TBL_EMP
GROUP BY ROLLUP(deptno,job);

--전체 급여 합만 출력
SELECT deptno,job,sum(sal),count(*) FROM TBL_EMP
GROUP BY ROLLUP((deptno,job));

--부서별 급여 합만 출력
SELECT deptno,job,sum(sal) FROM TBL_EMP
GROUP BY deptno, ROLLUP(job)
​
--직업별 급여 합만 출력
SELECT deptno,job,sum(sal) FROM TBL_EMP
GROUP BY job, ROLLUP(deptno)
​

--rollup의 원리

--https://myjamong.tistory.com/191


GROUP BY rollup(a,b,c)
1. a,b,c
2. a,b
3. a
4. ()
​

GROUP BY rollup(a,(b,c))
1. a,(b,c)
2. a
3. ()
​

GROUP BY a rollup((b,c))
1. a,(b,c)
2. a

​

--아래 두 개의 SQL이 같은 결과를 출력하도록 SQL을 완성하시오.
[SQLD_46]
상품명    상품코드      단가
-------------------------
가       A           1000
나       D           2000
다       G           3000
가       B           4000
나       E           5000
가       C           6000
다       H           7000
나       F           8000​

- - - - - - - - - - - - - - - 

SELECT 상품명, SUM(단가)
FROM SQLD_46
WHERE 상품명 = '가'
GROUP BY ROLLUP(상품명);
​

SELECT 상품명, SUM(단가)
FROM SQLD_46
WHERE 상품명 = '가'
GROUP BY GROUPING SETS(      );
​

SELECT 상품명, SUM(단가) FROM (
SELECT '가' 상품명,'A' 상품코드, 1000 단가 FROM DUAL
UNION ALL
SELECT '나' 상품명,'D' 상품코드, 2000 단가 FROM DUAL
UNION ALL
SELECT '다' 상품명,'G' 상품코드, 3000 단가 FROM DUAL
UNION ALL
SELECT '가' 상품명,'B' 상품코드, 4000 단가 FROM DUAL
UNION ALL
SELECT '나' 상품명,'E' 상품코드, 5000 단가 FROM DUAL
UNION ALL
SELECT '가' 상품명,'C' 상품코드, 6000 단가 FROM DUAL
UNION ALL
SELECT '다' 상품명,'H' 상품코드, 7000 단가 FROM DUAL
UNION ALL
SELECT '나' 상품명,'F' 상품코드, 8000 단가 FROM DUAL
)SQLD_46 
WHERE 상품명 = '가'
GROUP BY ROLLUP(상품명);

​

SELECT 상품명, SUM(단가) FROM (
SELECT '가' 상품명,'A' 상품코드, 1000 단가 FROM DUAL
UNION ALL
SELECT '나' 상품명,'D' 상품코드, 2000 단가 FROM DUAL
UNION ALL
SELECT '다' 상품명,'G' 상품코드, 3000 단가 FROM DUAL
UNION ALL
SELECT '가' 상품명,'B' 상품코드, 4000 단가 FROM DUAL
UNION ALL
SELECT '나' 상품명,'E' 상품코드, 5000 단가 FROM DUAL
UNION ALL
SELECT '가' 상품명,'C' 상품코드, 6000 단가 FROM DUAL
UNION ALL
SELECT '다' 상품명,'H' 상품코드, 7000 단가 FROM DUAL
UNION ALL
SELECT '나' 상품명,'F' 상품코드, 8000 단가 FROM DUAL
)SQLD_46 
WHERE 상품명 = '가'
GROUP BY GROUPING SETS(NULL,상품명);

-- GROUP BY GROUPING SETS(NULL,상품명);
-- GROUP BY GROUPING SETS(0,상품명);
-- GROUP BY GROUPING SETS((),상품명);




CREATE TABLE 월별매출 (
    상품ID VARCHAR2(5),
    월 VARCHAR2(10),
    회사 VARCHAR2(10),
    매출액 INTEGER );
    
INSERT INTO  월별매출 VALUES ('P001', '2019.10', '삼성', 15000);
INSERT INTO  월별매출 VALUES ('P001', '2019.11', '삼성', 25000);
INSERT INTO  월별매출 VALUES ('P002', '2019.10', 'LG', 10000);
INSERT INTO  월별매출 VALUES ('P002', '2019.11', 'LG', 20000);
INSERT INTO  월별매출 VALUES ('P003', '2019.10', '애플', 15000);
INSERT INTO  월별매출 VALUES ('P003', '2019.11', '애플', 10000);
 
SELECT * FROM 월별매출;

-- 1. GROUP BY절
SELECT 상품ID, 월, SUM(매출액) AS 매출액
FROM 월별매출
GROUP BY 상품ID, 월; --> 상품ID, 월 기준으로 그룹화가 됨.

-- 2. ROLLUP 함수
SELECT 상품ID, 월, SUM(매출액) AS 매출액
FROM 월별매출
GROUP BY ROLLUP(상품ID, 월);  --> 소계(SUBTOTAL), 총계(GRAND TOTAL)가 나오는 것을 알 수 있다.

-- ROLLUP함수를 쓰면 첫번째 인자(상품 ID)별 두번째 인자(월) + 첫번째 인자(상품 ID)별 두번째 인자(월)의 소계(SUBTOTAL) + 총계(GRAND TOTAL) 의 결과가 나온다.
-- 따라서 ROLLUP함수는 인수의 순서에도 영향을 받게 된다.

SELECT 월, 상품ID, SUM(매출액) AS 매출액
FROM 월별매출
GROUP BY ROLLUP(월, 상품ID);
-- 아까와는 반대로 첫번째 인자(월)별 두번째 인자(상품 ID) + 첫번째 인자(월)별 두번째 인자(상품ID)의 소계(SUBTOTAL) + 총계(GRAND TOTAL) 의 결과가 나온다.

-- 3. CUBE 함수
-- CUBE 함수는 그룹핑 컬럼이 가질 수 있는 모든 경우의 수에 대하여 소계(SUBTOTAL)과 총계(GRAND TOTAL)을 생성한다. 
-- 따라서 ROLLUP 함수와는 다르게 인자의 순서가 달라도 결과는 같다.
-- 위와 다르게 단순한 월별 소계(SUBTOTAL)도 생성되었으며, 그룹핑 컬럼의 개수를 N이라고 한다면 2의 N승의 소계(SUBTOTAL)을 생성한다.
SELECT 상품ID, 월, SUM(매출액) AS 매출액
FROM 월별매출
GROUP BY CUBE(상품ID, 월);

-- 4. GROUPING SETS 함수
SELECT 상품ID, 월, SUM(매출액) AS 매출액
FROM 월별매출
GROUP BY GROUPING SETS(상품ID, 월);
-- 첫번째 인자(상품ID)별 소계(SUBTOTAL), 두번째 인자(월)별 소계(SUBTOTAL)이 나오는 것을 확인할 수 있다.
-- ROLLUP과 CUBE와 달리 계층 구조가 나타나지 않으며 따라서 인자의 순서가 달라도 결과는 똑같다.
-- 또한, GROUPING SETS 함수는 괄호로 묶은 집합별로도 집계를 구할 수 있다.

SELECT 상품ID, 월, 회사, SUM(매출액) AS 매출액
FROM 월별매출
GROUP BY GROUPING SETS((상품ID, 월), 회사);
-- 묶여진 컬럼을 하나의 인자로 취급해 (상품ID, 월)별 소계(SUBTOTAL)과 회사별 소계(SUBTOTAL)이 나오는 걸 확인할 수 있다.

-- 5. GROUPING 함수
-- GROUPING 함수는 직접 그룹별 집계를 구하지는 않지만 앞서 말한 ROLLUP, CUBE, GROUPING SETS를 지원하는 역할을 한다. 
-- 집계가 계산된 결과에 GROUPING(표현식) = 1이 되며, 그 외에는 GROUPING(표현식) = 0이 된다.
SELECT 
    CASE GROUPING(상품ID) WHEN 1 THEN '모든 상품ID' ELSE 상품ID END AS 상품ID,
    CASE GROUPING(월) WHEN 1 THEN '모든 월' ELSE 월 END AS 월, 
    SUM(매출액) AS 매출액
FROM 월별매출
GROUP BY ROLLUP(상품ID, 월);

-- CASE 함수와 ROLLUP 함수를 응용해서 다음과 같은 표현도 가능하다.
SELECT 
    CASE GROUPING(상품ID) WHEN 1 THEN '모든 상품ID' ELSE 상품ID END AS 상품ID,
    CASE GROUPING(월) WHEN 1 THEN '모든 월' ELSE 월 END AS 월, 
    SUM(매출액) AS 매출액
FROM 월별매출
GROUP BY CUBE(상품ID, 월);


SELECT 
    CASE GROUPING(상품ID) WHEN 1 THEN '모든 상품ID' ELSE 상품ID END AS 상품ID,
    CASE GROUPING(월) WHEN 1 THEN '모든 월' ELSE 월 END AS 월, 
    CASE GROUPING(회사) WHEN 1 THEN '모든 회사' ELSE 회사 END AS 회사,
    SUM(매출액) AS 매출액
FROM 월별매출
GROUP BY GROUPING SETS((상품ID, 월), 회사);
-- 이는 CUBE 함수, GROUPING SETS 함수에서도 마찬가지로 응용해볼 수 있다.






























