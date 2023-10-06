--프로그램 설치(sql server)
--dbms(oracle, mysql, mysql=sql server)
-- sql server download -> 온프레스 -> ssms설치
-- ssms.exe

-- 테이블=데이터 영역
-- 인덱스 영역은 별도로 존재함 (포인터로 가리킴)
-- 쿼리문을 치면 인덱스를 통해 찾아감

-- 인덱스 기본 / 인덱스 기본2 / sqld Test / 풀이
-- 인덱스란 인덱스는 원하는 데이터를 쉽게 찾을 수 있도록 돕는 책의 찾아보기와 유사한 개념
-- 빨리 찾기 위해 인덱스 사용

--MSSQL에서 실습
--인덱스와 페이지의 관계
--페이지 
--진짜 페이지(블록)에 데이터가 있는지?

-- oracle은 '블록(Block)'이라고 하고, SQL Server는 '페이지(Page)'라고 한다. 
-- Oracle은 2KB, 4KB, 8KB, 16KB, 32KB, 64KB의 다양한 블록 크기를 사용할 수 있지만,
-- SQL Server에선 8KB 단일 크기를 사용

USE [TEST_A]
GO

/****** Object:  Table [dbo].[test]    Script Date: 2023-08-10 오후 3:50:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[test](
[id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SELECT * FROM TEST

INSERT INTO TEST VALUEs(3);

INSERT INTO TEST VALUEs(4);
​

--인덱스 확인 방법
EXEC sp_helpindex 'TEST'

SELECT a.name      AS table_name
     , b.name      AS index_name
     , d.name      AS column_name
     , b.type_desc AS index_type
  FROM sys.tables a
     , sys.indexes b
     , sys.index_columns c
     , sys.columns d
 WHERE a.name = 'TEST' 
   AND a.object_id = b.object_id 
   AND b.object_id = c.object_id 
   AND b.index_id  = c.index_id 
   AND c.object_id = d.object_id 
   AND c.column_id = d.column_id
   

--index_id = 1
SELECT * 
FROM SYS.indexes 
WHERE object_id = OBJECT_ID('test') 

DBCC TRACEON(3604)

--db명 / 테이블명 . 
DBCC Ind('TEST_A', 'test',1)

CREATE TABLE test_index(c1 varchar(1000) primary key);

INSERT INTO test_index VALUES(REPLICATE('AAAA1', 50));
INSERT INTO test_index VALUES(REPLICATE('AAAA2', 50));
INSERT INTO test_index VALUES(REPLICATE('AAAA3', 50));
INSERT INTO test_index VALUES(REPLICATE('AAAA4', 50));
INSERT INTO test_index VALUES(REPLICATE('AAAA5', 50));
INSERT INTO test_index VALUES(REPLICATE('AAAA6', 50));
INSERT INTO test_index VALUES(REPLICATE('AAAA7', 50));
INSERT INTO test_index VALUES(REPLICATE('AAAA8', 50));
INSERT INTO test_index VALUES(REPLICATE('AAAA9', 50));
INSERT INTO test_index VALUES(REPLICATE('AAAA10', 50));

declare @num int
set @num=1
while @num<1000
begin
select @num
INSERT INTO test_index VALUES(REPLICATE('ZE1zere'+convert(varchar(1000),@num), 1));
set @num=@num+1
end;

select count(*) from test_index


--index_id = 1
SELECT * 
FROM SYS.indexes 
WHERE object_id = OBJECT_ID('test_index') 

DBCC Ind('TEST_A', 'test_index',1)

--pageFID 파일번호 pagePid가 페이지번호
--DBCC PAGE(DB 이름, 파일 번호, 페이지 번호, 옵션)

/*
옵션에는 다음과 같은 것이 있습니다.
0 : 헤더만
1 : 행 단위
2 : 페이지 단위
3 : 행 그리고 컬럼 값 (대부분 이 옵션을 사용)
*/

dbcc page('TEST_A',1,696,3)

dbcc page('TEST_A',1,700,3)

select * from test_index

 AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AA

AA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5

 AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AA

AA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5AAAA5


--테이블에 인덱스를 생성하지 않아도 되고 여러 개를 생성해도 된다.
--인덱스의 기본적인 목적은 검색 성능의 최적화이다. 
--즉, 검색 조건을 만족하는 데이터를 인덱스를 통해 효과적으로 찾을 수 있도록 돕는다. 
--insert, Update, Delete 등과 같은 DML 작업은 테이블과 인덱스를 함께 변경해야 하기 때문에 오히려 느려질 수 있다는 단점이 존재
--인덱스를 생성할 때 동일 칼럼으로 구성된 인덱스를 중복해서 생성할 수 없다.
--인덱스 구성 칼럼은 동일하지만 칼럼의 순서가 다르면 서로 다른 인덱스로 생성할 수 있다. 
--인덱스의 칼럼 순서는 질의의 성능에 중요한 영향을 미치는 요소

--트리기반 인덱스
--https://dataonair.or.kr/db-tech-reference/d-guide/sql/?pageid=2&mod=document&uid=355
--DBMS에서 가장 일반적인 인덱스는 B-트리 인덱스
--B-트리 인덱스는 브랜치 블록(Branch Block)과 리프 블록(Leaf Block)으로 구성
--브랜치 블록 중에서 가장 상위에서 있는 블록을 루트 블록(Root Block)
--브랜치 블록은 분기를 목적으로 하는 블록
--리프 블록은 트리의 가장 아래 단계에 존재
--리프 블록은 양방향 링크(Double Link)를 가지고 있다. 
--B-트리 인덱스는 ‘=’로 검색하는 일치(Exact Match) 검색과 ‘BETWEEN’, ‘>’ 등과 같은 연산자로 검색하는 범위(Range) 검색 모두에 적합한 구조

--b트리 기반 인덱스
--   루트 노드  50일때
--       45,100 insert
--   30  48 insert
--         87  120 insert

-- b트리 구조는?

--SQL Server의 인덱스 종류는 저장 구조에 따라 클러스터형(clustered) 인덱스와 비클러스터형(nonclustered) 인덱스로 나뉨
--첫째, 인덱스의 리프 페이지가 곧 데이터 페이지
--클러스터형 인덱스의 리프 페이지를 탐색하면 해당 테이블의 모든 칼럼 값을 곧바로 얻을 수 있다.
--둘째, 리프 페이지의 모든 로우(=데이터)는 인덱스 키 칼럼 순으로 물리적으로 정렬되어 저장된다. 
--테이블 로우는 물리적으로 한 가지 순서로만 정렬될 수 있다. 그러므로 클러스터형 인덱스는 테이블당 한 개만 생성할 수 있다.
--클러스터형 인덱스는 물리적으로 하나만 존재
--리프페이지가 꽉차면 테이블 분할이 일어남.

--넌클러스터드 인덱스는 실제 DB의 데이터 파일에 정렬이 되지 않은 상태로 디스크에 저장
--넌클러스터드 인덱스는 여러개 생성가능
--레코드의 원본은 정렬되지 않고, 인덱스 페이지만 정렬
--Non-Clustered Index는 데이터 페이지를 건드리지 않고, 별도의 장소에 인덱스 페이지를 생성
--테이블당 약 240개의 Non Clustered Index를 만들 수 있다.
--클러스터형보다 검색 속도는 더 느리지만 데이터의 입력, 수정, 삭제는 더 빠르다.
--리프페이지가 모두 차 있어도 페이지 분할은 일어나지 않는다.

--문제.아래와 같은 컬럼으로 구성된 테이블에 COL1 을 구성컬럼으로 가지는 인덱스가 있다. 가장 효율적으로 해당 인덱스를 사용할 수 있는 조건절은?
TAB_A 
COL1 NUMBER 
COL2 VARCHAR2(10)
INDEX 
COL1

1) WHERE COL1 LIKE '2%'
2) WHERE COL1 = 10
3) WHERE COL1 IS NOT NULL
4) WHERE COL1 <> 10

--정답은 2번 


CREATE TABLE tab_a
(
col1 NUMBER PRIMARY key,
col2 varchar(10)
)

INSERT INTO tab_a values(10,'test')


--table access full
SELECT * FROM tab_a
WHERE col1 LIKE '2%'

--table access by index rowid
SELECT * FROM tab_a
WHERE col1 =10

--table access full
SELECT * FROM tab_a
WHERE col1 IS NOT NULL
​
--table access full
SELECT * FROM tab_a
WHERE col1 <>10

--전체 테이블 스캔 
--전체 테이블 스캔 방식은 테이블에 존재하는 모든 블록의 데이터를 읽는다.

--옵티마이저가 연산으로서 전체 테이블 스캔 방식을 선택하는 이유는 일반적으로 다음과 같다.
--SQL문에 조건이 존재하지 않는 경우
--SQL문의 주어진 조건에 사용 가능한 인덱스가 존재하는 않는 경우
--옵티마이저의 취사 선택
--병렬처리 방식으로 처리하는 경우 또는 전체 테이블 스캔 방식의 힌트를 사용한 경우에 전체 테이블 스캔 방식으로 데이터를 읽을 수 있다.

--인덱스 스캔 방식
--대용량 데이터 중에서 극히 일부의 데이터를 찾을 때, 
--인덱스 스캔 방식(Index Scan)은 인덱스를 이용해 몇 번의 I/O만으로 원하는 데이터를 쉽게 찾을 수 있다.

--index Range Scan
--B-tree 인덱스의 가장 일반적이고 정상적인 형태의 액세스 방식입니다. 
--인덱스 루트에서 리프 블록까지 수직적 탐색을 하고, 필요한 범위만큼 수평적 탐색하는 스캔 방식

--Index Full Scan
--수직적 탐색 없이 인덱스 리프 블록 처음부터 끝까지 수평적으로 탐색하는 방식

--Index Unique Scan
--Index Unique Scan은 수직적 탐색으로만 데이터를 찾는 스캔 방식
-- Unique 인덱스를 '=' 조건으로  탐색하는 경우에 동작

--table access by index rowid
--index unique scan 수직적 탐색 / 유니크 인덱스 = 조건 탐색하는 경우 동작
SELECT * FROM tab_a WHERE col1 =10

#mysql 로 복귀 
#문제 1. T_MEMBER 테이블을 생성하려고 한다. 테이블을 생성하고 kind에 인덱스를 생성하는 DDL문으로 올바른 것은? 

/*
[T_MEMBER : 기본키(PK) memberid]
memberid varchar(20)
name varchar(100) not null
kind varchar(10)
regdate date

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(1)                                      (2)
CREATE TABLE T_MEMBER(                     CREATE TABLE T_MEMBER(
memberid varchar(20) PRIMARY KEY,          memberid varchar(20),
name varchar(100) NOT NULL,                name varchar(100) NOT NULL,
kind varchar(10),                          kind varchar(10),
regdate date                               regdate date
);                                         );

CREATE index indmember on T_MEMBER(kind);  CREATE index indmember on T_MEMBER(kind);

(3)                                      (4)
CREATE TABLE T_MEMBER(                     CREATE TABLE T_MEMBER(
memberid varchar(20) PRIMARY KEY,          memberid varchar(20),
name varchar(100) NOT NULL,                name varchar(100) NOT NULL,
kind varchar(10),                          kind varchar(10),
regdate date                               regdate date
);                                         );

ALTER index indmember on T_MEMBER(kind);   CREATE index indmember as T_MEMBER(kind);
*/

#핵심은 pk키를 생성하고 나서 index 추가 정답은 1번  

create table t_member
(
memberid varchar(20) primary key,
name varchar(100) not null,
kind varchar(10),
regdate date
)

CREATE index indmember on T_MEMBER(kind); 

#여기서 질문 인덱스는 총 몇개 생성이 됐을까요?
#왼쪽 데이터베이스 네비게이터에서 index가 총 몇개인지 확인. 2개
#인덱스 유형이 btree인지 확인  view index로 확인 가능  

insert into T_MEMBER(memberid,name,kind,regdate) values('memberid','name1','kind1',now())

select * from T_MEMBER


/*
2.문제 다음의 설명으로 올바른 것은? 
조인되는 N개의 테이블을 모두 정렬한 후에 조인을 수행한다.
1) HASH JOIN
2) SORT MERGE JOIN
3) NESTED LOOP JOIN
4) INNER JOIN

해설 : Sort Merge 조인은 해당 테이블의 인덱스가 없을때 수행이 된다.
테이블을 정렬(Sort) 한 후에 정렬된 테이블을 병합(Merge) 하면서 조인을 실행한다.

3.문제 다음 보기에서 설명하는 인덱스 스캔 방식은 무엇인가? 
[보기]
인덱스를 역순으로 탐색한다.
최댓값을 쉽게 찾을 수 있다.
1) INDEX UNIQUE SCAN
2) INDEX RANGE SCAN
3) INDEX RANGE SCAN DESCENDING
4) INDEX FULL SCAN

해설 : DESCENDING  (ASC:최소값, DESC:최댓값)

UNIQUE SCAN : 유일한 값 하나 찾기 (예: 고객아이디) *한개의 행
RANGE SCAN : 어떠한 조건에서 한 범위를 찾기 (예:주문번호)
FULL SCAN : 전체 데이터 *전체 행

4.문제 HASH 조인에 대한 설명으로 옳지 않은 것은?  
1) 두 개의 테이블 중에서 작은 테이블을 HASH메모리에 로딩하고 두 개 테이블의 조인키를 사용해서 테이블을 생성한다.
2) HASH함수를 사용해서 주소를 계산하고 해당 주소를 사용해서 테이블을 조인하기 때문에 CPU연산이 많이 수행된다.
3) HASH함수를 사용해서 조인 시 RANDOM ACCESS로 인한 부하로 성능지연이 발생할수 있다.
4) HASH 조인 시에는 선행 테이블의 크기가 작아서 충분히 메모리에 로딩되어야 한다.

해설 : RANDOM ACCESS로 인해 부하가 걸리는 것은 NESTED LOOP JOIN 방식이다.
HASH JOIN
-조인 컬럼의 인덱스가 존재하지 않을 경우에도 사용할 수 있다.
-해시 함수를 이용하여 조인을 수행하기 때문에 '='로 수행하는 조인으로 동등 조건에만 사용가능
-해시 함수가 적용될 때 동일한 값을 항상 같은 값으로 해싱됨이 보장된다.
-HASH JOIN 작업을 수행하기 위해 해시 테이블을 메모리에 생성해야 한다.
-메모리에 적재할 수 있는 영역의 크기보다 커지면 임시 영역(디스크)에 해시 테이블을 저장한다.
-HASH JOIN을 할 때는 결과 행의 수가 적은 테이블을 선행 테이블로 사용하는 것이 좋다.
-선행 테이블을 Build input이라 하며, 후행 테이블을 Prove input이라 한다.

랜덤 엑세스란 데이터를 저장하는 블록을 한번에 여러 개 액세스하는 것이 아니라 한 번에 하나의 블록만을 액세스하는 방식이다. 
한 번에 여러 개의 블록을 액세스한다면(랜덤 엑세스와 반대) 같은 양의 데이터에 대해 
적은 횟수의 디스크 I/O가 발생하기 때문에 성능이 향상될 수 있다.

바로 인덱스를 액세스하여 확인한 ROWID를 이용하여 테이블을 액세스하는 경우 랜덤액세스가 발생하게 된다.

ROWID는 해당 데이터를 찾아가는 유일한 주소 값이며 
우리가 인덱스를 이용한다는 것은 인덱스로부터 조건을 만족하는 인덱스 값을 액세스한 후 
ROWID를 확인하여 ROWID 값으로 테이블을 액세스하는 것을 의미한다.

이처럼 인덱스 접근 후 테이블을 접근하는 경우에 발생하는 
I/O는 블록을 하나씩 접근하는 랜덤 액세스가 발생하게 된다.

데이터(우리가 찾고 있는 데이터) 찾기 위해서 rowid를 통해서 접근 가능. (rowid로 해당 위치가 어디인지 알 수 있음)
먼저 인덱스를 통해서 원하는 데이터를 가져온 후에 rowid값을 통해서 한번더 데이터에 대해 인덱스한다.

5.문제) 학생관련 정보를 조회하는 SQL을 작성할려고 한다. 조회하는 사람은 주로 학생 본인이 학번으로 조회를 주로 한다. 
이런 SQL 일 때 성능을 개선하는 방법으로 가장 알맞은 것은?
1) 학교명을 선두컬럼으로 하는 INDEX 를 생성한다
2) 학번을 선두컬럼으로 하는 INDEX 를 생성한다
3) 학교명 + 학번순으로 구성된 INDEX 를 생성한다
4) 학교명 + 이름 + 학번으로 구성된 INDEX 를 생성한다       

정답 : 2번
자주 사용하는 컬럼을 선두컬럼으로 둬야 함.

6.문제) 조인에 대한 설명 중 Hash Join 에 대한 특성으로 부적절한 것 2개를 고르시오
1) 각 테이블에 INDEX 가 반드시 필요한 것은 아니다
2) 일반적으로 작은 테이블을 MEMORY 에 올리는 선행 테이블로 사용한다
3) Non Equal Join 이 가능하다 (비동등)
4) 조인을 위해 사전 소트 작업이 필요하다

3,4

Hash Join 은 Non Equal Join 은 불가능함. Equal Join 만 가능함
사전 Sorting 작업이 필요한 Join 알고리즘은 Sort Merge Join 임
sort merge join은 hash조인과는 다르게 non equal join도 가능.                                                                                          

7.문제)아래의 실행 계획을 올바르게 설명한 것은?
-----------------------------------------------------------
   0      SELECT STATEMENT Optimizer=ALL_ROWS (Cost=7 Card=9 Bytes=1K)
   1    0   HASH JOIN (Cost=7 Card=9 Bytes=1K)
   2    1     TABLE ACCESS (FULL) OF 'SCOTT.DEPT' (TABLE) (Cost=3 Card=1 Bytes=30)
   3    1     VIEW (Cost=3 Card=9 Bytes=783)
   4    3       COUNT (STOPKEY)
   5    4         TABLE ACCESS (FULL) OF 'SCOTT.EMP' (TABLE) (Cost=3 Card=14 Bytes=1K)
-----------------------------------------------------------
Predicate information (identified by operation id):
----------------------------------------------------------
   1 - access("A"."DEPTNO"="B"."DEPTNO")
   2 - filter("B"."DNAME"='SALES')
   4 - filter(ROWNUM<10)
-----------------------------------------------------------

1) EMP TABLE 에 대한 행제한 구문이 있다
2) EMP TABLE 과 DEPT TABLE 은 OUTER JOIN 으로 수행되고 있다
3) EMP TABLE 과 DEPT TABLE 에서 선행 테이블은 EMP TABLE 이다
4) DEPT TABLE 은 별도의 조건이 없어 FULL SCAN 을 하고 있다

해답 : 1번

Outer Join 이라고 표시된 SQL Operation 이 존재하지 않음
Hash Join 의 선행 테이블은 SCOTT.DEPT 테이블임
Predicate 정보를 보면 DEPT 테이블에 대한 Full Scan 후 DNAME ='SALES' 로 필터됨
-hash조인의 on 조건절 또한 필터링으로 본다.


8.조인 기법 설명중 가장 적절한 것은?
1) Hash Join 은 정렬 작업이 없어 정렬이 부담되는 대량배치작업에 유리하다.
2) 대용량의 데이터를 가진 두개 테이블을 조인할 때 Hash Join 보다 Nested Loop Join 이 더 유리하다
3) 옵티마이저는 조인컬럼에 인덱스가 존재하지 않으면 Nested Loop Join 을 선호한다.
4) Nested Loop Join 기법은 배치작업에서 선호하는 조인기법이다.

정답 1번 Hash Join 은 정렬 작업이 없어 정렬이 부담되는 대량배치작업에 유리하다.

대량 집합 조인은 Random 액세스 위주의 NL Join의 경우 비효율이 있고, 이 비효율을 줄이고자 나온 조인 방식이 Sort Merge Join이다. 
만약 정렬해야 할 집합이 초대용량 테이블이면 정렬 자체가 큰 비용을 수반하기 때문에 성능 개선 효과를 얻지 못할 수도 있다. 
하지만, 일반 인덱스나 클러스터형 인덱스처럼 미리 정렬된 오브젝트를 이용하면 정렬작업을 하지 않고 
바로 조인을 수행할 수 있어 Sort Merge Join이 좋은 대안이 될 수 있다.

9. 아래와 같은 구조를 가진 테이블에서 Unique Index Scan 을 할 수 없는 것은?
[Table] SLQD_30_33
KEY1 (PK) NUMBER
KEY2 (PK) NUMBER
COL1 VARCHAR2
COL2 VARCHAR2
COL3 VARCHAR2

1) 모두 사용할 수 없다
2) WHERE KEY1 =1 AND KEY2 = 2
3) WHERE (KEY1, KEY2) IN ( (1,2) )
4) WHERE KEY1 = 1

정답 4번 
*/

create table SLQD_30_33
(
key1 int,
key2 int,
primary key(key1,key2)
)

insert into SLQD_30_33 values(1,1)
insert into SLQD_30_33 values(1,2)
insert into SLQD_30_33 values(1,3)
insert into SLQD_30_33 values(1,4)
insert into SLQD_30_33 values(1,5)
insert into SLQD_30_33 values(1,6)
insert into SLQD_30_33 values(1,7)
insert into SLQD_30_33 values(1,8)
insert into SLQD_30_33 values(1,9)
insert into SLQD_30_33 values(1,10)

select * from SLQD_30_33


2) WHERE KEY1 =1 AND KEY2 = 2
select * from SLQD_30_33
where key1=1 and key2=2

3) WHERE (KEY1, KEY2) IN ( (1,2) )
select * from SLQD_30_33
where (key1,key2) in ((1,2))

explain select * from SLQD_30_33
where (key1,key2) in ((1,2))

4) WHERE KEY1 =1
select * from SLQD_30_33
where key1=1 

/*
 type은 접근방식
 const 기본 키 또는 고유키에 의한 비
 조인이 아닌 가장 외부의 테이블에 접근 하는 방식, 결과는 항상 1행이다. 
 단 기본 키, 고유 키를 사용하고 있으므로 범위 검색으로 지정하는 경우 const가 되지 않는다

 ref 고유 키가아닌 인덱스에 대한 등가비교, 여러 개 행에 접근할 가능성이 있다.
 */

#type은 인덱스 스캔 / index : 인덱스 스캔, 테이블의 특정 인덱스의 전체 엔트리에 접근한다.
select * from SLQD_30_33

#인덱스가 많아지면 문제점은?
#insert delete update 부하가 커진다.
insert into SLQD_30_33 values(1,100)

select * from SLQD_30_33

#type : ALL 
#우리가 알고 있는 풀 테이블 스캔을 의미하는 접근 방법이다. 
#가장 비효율적인 방법.

explain insert into SLQD_30_33 values(1,50)
explain insert into SLQD_30_33 values(1,1000)
explain select * from SLQD_30_33

where key1=1 and key2=100

​

