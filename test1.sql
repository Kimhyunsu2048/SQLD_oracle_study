CREATE TABLE [dbo].[test](
[id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

SELECT * FROM test

EXEC sp_helpindex 'TEST' -- 인덱스의 정보를 알려줌


-- 인덱스? 1.인덱스 클러스터드 인덱스 2.넌클러스터드 인덱스
-- Insert, Update, Delete 등과 같은 DML 작업은 테이블과 인덱스를 함께 변경해야 하기 때문에 오히려 느려질 수 있다는 단점이 존재한다.
-- SELECT COL1 FROM ...
-- SELECT COL2 FROM ...
-- SELECT COL1,COL2 FROM ...

 -- B-트리(BALANCED TREE) 인덱스

-- 전체 테이블 스캔(느림) VS 인덱스 스캔(빠름)
-- 전체 테이블 스캔 : 전체 테이블 스캔 방식은 테이블에 존재하는 모든 노드를 읽는 방식
-- 전체 테이블 스캔은 언제하는가? 
--1.SQL 조건문이 없을 경우(where x)
--2.SQL문의 주어진 조건에 사용가능한 인덱스가 X

--인덱스 스캔 :
--대용량 데이터 중에서 극히 일부 데이터를 찾을 때 인덱스 스캔 방식은 인덱스를 이용해 몇번의 I/O 만으로 원하는 데이터를 쉽게 찾을 수 있다.

--데이터 영역 -> A,B,C
--인덱스 영역 -> C

SELECT C -> 데이터를 인덱스 영역에서 가져오면 됨
SELECT B -> 인덱스 영역에 없기 때문에 인덱스를 통해 전체 테이블에서 가져와야 됨

--Index Range Scan
--B-tree 인덱스의 가장 일반적이고 정상적인 형태의 액세스 방식입니다. 
--인덱스 루트에서 리프 블록까지 수직적 탐색을 하고, 필요한 범위만큼 수평적 탐색하는 스캔 방식

--Index Full Scan
--수직적 탐색 없이 인덱스 리프 블록 처음부터 끝까지 수평적으로 탐색하는 방식

--Index Unique Scan
--Index Unique Scan은 수직적 탐색으로만 데이터를 찾는 스캔 방식
--Unique 인덱스를 '=' 조건으로  탐색하는 경우에 동작












