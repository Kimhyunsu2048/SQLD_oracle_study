SQL 최적화 기본원리 / 옵티마이저와 실행계획

--SQL 최적화 기본원리 / 옵티마이저와 실행계획
--옵티마이저 == 네비게이션
--옵티마이저와 실행계획(최적의 경로, 길)
--조인수행원리
--조인기본원리

--옵티마이저(Optimizer)는 SQL을 가장 빠르고 효율적으로 수행할 최적(최저비용)의 처리경로를 생성해 주는 DBMS 내부의 핵심엔진
--사용자가 구조화된 질의언어(SQL)로 결과집합을 요구하면, 이를 생성하는데 필요한 처리경로는 DBMS에 내장된 옵티마이저가 자동으로 생성
--실행계획? 옵티마이저가 생성한 SQL 처리경로

--옵티마이저의 SQL 최적화 과정을 요약

--사용자가 던진 쿼리수행을 위해, 후보군이 될만한 실행계획을 찾는다.
--데이터 딕셔너리(Data Dictionary)에 미리 수집해 놓은 오브젝트(테이블) 통계 및 시스템 통계정보를 이용해 각 실행계획의 예상비용을 산정
--각 실행계획을 비교해서 최저비용을 갖는 하나를 선택한다.

show parameter OPTIMIZER_FEATURES_ENAMBLE; // 실행안됨 (SQL PLUS에서만 실행됨)

--SQL 실행 -> SQL문 범위 모두 드래그 -> SQL편집기 -> 실행계획 보기
SELECT * FROM TBL_MOVIE A LEFT OUTER JOIN TBL_MOVIE_REVIEW B
ON A.MOVIE_NAME =B.MOVIE_NAME 
WHERE B.MOVIE_NAME IS NOT NULL; 

--각 의미를 생각해보기
Operation Object Optimizer Cost Cardinality Bytes

SELECT STATEMENT ALL_ROWS 4 3 618

  HASH JOIN 4 3 618

    TABLE ACCESS (FULL) TBL_MOVIE_REVIEW ANALYZED 2 3 87

    TABLE ACCESS (FULL) TBL_MOVIE ANALYZED 2 4 708

--옵티마이저가 자동으로 해주는데 왜 배워야 하는가?
--통계 정보 잘못된 경우 -> 통계정보 업데이트
--게임회사 통계정보 업데이트 시간    

--sqlplus에서 옵티마이저 확인
show parameter OPTIMIZER_FEATURES_ENABLE;

--옵티마이저 상세정보 보기
SELECT optimizer_feature_enable, description
FROM v$system_fix_control
WHERE substr(optimizer_feature_enable,1,2) = '21'

--https://leejehong.tistory.com/entry/Oracle-Optimizer%EC%9D%98-%EC%9B%90%EB%A6%AC-%EC%9D%B4%ED%95%B4-%EB%B0%8F-SQL-%EC%95%A0%ED%94%8C%EB%A6%AC%EC%BC%80%EC%9D%B4%EC%85%98%EC%9D%98-%ED%8A%9C%EB%8B%9D%EC%83%81-%EC%98%B5%ED%8B%B0%EB%A7%88%EC%9D%B4%EC%A0%80%EC%9D%98-%EC%9B%90%EB%A6%AC%EC%99%80-%ED%8A%B9%EC%A7%95
--옵티마이저 이미지 검색

--옵티마이저 종류(2가지)
--규칙기반 옵티마이저
--규칙기반 옵티마이저(Rule-Based Optimizer, 이하 RBO)는 다른 말로 ‘휴리스틱(Heuristic) 옵티마이저’라고 불리며, 
--미리 정해 놓은 규칙에 따라 액세스 경로를 평가하고 실행계획을 선택한다. 
--여기서 규칙이란 액세스 경로별 우선순위로서, 인덱스 구조, 연산자, 조건절 형태가 순위를 결정짓는 주요인이다.

--비용기반 옵티마이저
--비용기반 옵티마이저(Cost-Based Optimizer, 이하 CBO)는 말 그대로 비용을 기반으로 최적화를 수행한다.
--비용 = COST
--미리 구해놓은 테이블과 인덱스에 대한 여러 통계정보를 기초로 각 오퍼레이션 단계별 예상 비용을 산정하고, 이를 합산한 총비용이 가장 낮은 실행계획을 선택
--Oracle도 10g 버전부터 RBO에 대한 지원을 중단하였으므로 본서는 CBO를 중심으로 설명

--1.sql 최적화 과정
--PARSER에 의해서
--SQL 문장을 이루는 개별 구성요소를 분석하고 파싱해서 파싱 트리(내부적인 구조체)를 만든다.
-- 이 과정에서 사용자 SQL에 문법적 오류가 없는지(→ Syntax 체크), 의미상 오류가 없는지(→ Semantic 체크) 확인한다.

--2.옵티마이저에 의해서
--Query Transformer : 파싱된 SQL을 좀 더 일반적이고 표준적인 형태로 변환한다.
--Estimator : 오브젝트 및 시스템 통계정보를 이용해 쿼리 수행 각 단계의 선택도, 카디널리티, 비용을 계산하고, 궁극적으로는 실행계획 전체에 대한 총 비용을 계산해 낸다.
--Plan Generator : 하나의 쿼리를 수행하는 데 있어, 후보군이 될만한 실행계획들을 생성해낸다.

--3.Row-Source Generator : 옵티마이저가 생성한 실행계획을 SQL 엔진이 실제 실행할 수 있는 코드(또는 프로시저) 형태로 포맷팅한다.

--4.SQL Engine : SQL을 실행한다.

--최적화 목표
-- 전체 처리속도 최적화 -> 시스템 리소스(I/O, CPU, 메모리 등)를 가장 적게 사용하는 실행계획을 선택
-- 최초 응답속도 최적화 -> 리소스 사용량 증가


--※ 옵티마이저 행동에 영향을 미치는 요소
--SQL과 연산자 형태
--옵티마이징 팩터(요소) : 인덱스, IOT, 클러스터링, 파티셔닝, MV
--DBMS 제약 설정 : DBMS가 제공하는 PK, FK, Check, Not Null 같은 제약 설정 기능
--옵티마이저 힌트 : 옵티마이저의 판단보다 사용자가 지정한 옵티마이저 힌트가 우선
--통계정보 : 통계정보가 옵티마이저에게 미치는 영향력은 절대적
--DBMS 버전과 종류 : 같은 SQL이더라도 DBMS 종류에 따라 내부적으로 처리하는 방식이 다를 수 있다.

​
--문제
--쿼리를 수행하는데 소요되는 일량 또는 시간을 기반으로 최적화를 수행하는 옵티마이저는 무엇인지 작성하시오
--(    )옵티마이저
--정답 : 비용 기반


--CBO(비용 기반 옵티마이저)는 쿼리 최적화 과정에 비용을 계산한다. 다음중 비용과 거리가 먼 것은?
--1. 비용이란 기본적으로 SQL 수행과정에 수반될 것으로 예상되는 I/O일량을 계산한 것이다.
--2. 데이터베이스 CALL발생량도 옵티마이저의 중요한 비용 요소이다.
--3. 옵티마이저가 비용을 계산할 때 CPU 속도,디스크 I/O속도 등도 고려함.
--4. 최신 옵티마이저는 I/O에 CPU 연산 비용을 더해서 비용을 계산한다.

--정답 2번

--데이터베이스 콜이란 요청하는 과정에 발생.
--데이터베이스 콜이란? DBMS 외부로부터 요청되는 Call
--call은 parse call, excute call, fetch call


--옵티마이저의 한계
--옵티마이저가 사람이 만든 소프트웨어 엔진에 불과하며 결코 완벽할 수 없음을 이해하는 것은 매우 중요 -> 불완전 -> dba가 존재하는 이유
--1.통계정보의 부정확성(불확실성)
--2.바인드 변수 사용 시 균등분포 가정
-- A table -> no.1 ~ 백만
-- select * from table where no=1 -> 쿼리 실행하는 순간 실행계획이 생성 됨
-- select * from table where no:no -> 쿼리 실행하는 순간 어떤값이든 맵핑시켜줌
-- 자바에서 prepared statement -> where col1 = ? 
-- 바인드 변수의 문제? 균등하지 않은 정보를 가져올경우 잘못된 정보를 가져올 경우가 발생됨.

--3.옵티마이징 팩터(요소)의 부족 - 인덱스 부족
--4.하드웨어 성능 -> 병렬처리? cpu속도
​

--바인드 조건형태에 따른 테스트
CREATE TABLE t AS
SELECT ROWNUM NO
FROM dual
CONNECT BY LEVEL <= 1000;

--바인드 변수란 :변수로 정의
--통계정보생성
ANALYZE TABLE t COMPUTE STATISTICS FOR TABLE FOR ALL COLUMNS;

--SQL문의 액세스 경로를 확인, 튜닝할 수 있도록 SQL문을 분석, 해석해 실행계획을 수립한 후 PLAN_TABLE에 저장하는 명령어
EXPLAIN PLAN FOR SELECT * FROM t WHERE no <= :no;

EXPLAIN PLAN FOR SELECT * FROM t WHERE no <= 200;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY(null, null, 'basic rows'));


--OLTP환경에서 바인드변수 사용필수
--바인드변수(java prepared statment)를 쓰지 않으면 각각 캐시됨.  1~1억 - > CPU영향
--where no= 1
--no= 2
--no= 3
--no= 4
--no= 5
--no= 6


--통계정보를 이용한 비용계산 원리
--선택도(Selectivity) : 전체 대상 레코드 중에서 특정 조건에 의해 선택될 것으로 예상되는 레코드 비율
--선택도 = 1/distinct value 개수

SELECT * FROM TBL_MOVIE -- CARDINALITY 개수 파악

--SQL편집기 -> 실행계획 보기
SELECT * FROM TBL_MOVIE A LEFT OUTER JOIN TBL_MOVIE_REVIEW B
ON A.MOVIE_NAME =B.MOVIE_NAME 
WHERE B.MOVIE_NAME IS NOT NULL 
​

--각 의미를 생각해보기
Operation Object Optimizer Cost Cardinality Bytes
SELECT STATEMENT ALL_ROWS 4 3 618
  HASH JOIN 4 3 618
    TABLE ACCESS (FULL) TBL_MOVIE_REVIEW ANALYZED 2 3 87
    TABLE ACCESS (FULL) TBL_MOVIE 

INSERT INTO TBL_MOVIE(MOVIE_NAME) values('없음2')

--카디널리티 개수 파악
SELECT * FROM TBL_MOVIE -- CARDINALITY 개수 파악

--SQL편집기 -> 실행계획 보기
SELECT * FROM TBL_MOVIE A LEFT OUTER JOIN TBL_MOVIE_REVIEW B
ON A.MOVIE_NAME =B.MOVIE_NAME 
WHERE B.MOVIE_NAME IS NOT NULL 

ANALYZE TABLE TBL_MOVIE COMPUTE STATISTICS FOR TABLE FOR ALL COLUMNS;

--다시 통계파악
--통계는 실시간이 아니다. 가장 근본적인 문제
--그냥 업데이트 해결? 테이블 1만개일경우? 게임 서버과부하 - 유저이탈 / 서버 중지.

--카디널리티
--카디널리티(Cardinality)는 특정 액세스 단계를 거치고 난 후 출력될 것으로 예상되는 결과 건수
--카디널리티 = 총 로우 수 × 선택도
--총로우 10개 / distinct value가 10이라면 선택도는 1/10 = 0.1이다. 총 로우수 10*0.1= 카디널리티 1

-- 히스토그램
--미리 저장된 히스토그램 정보가 있으면, 옵티마이저는 그것을 사용해 더 정확하게 카디널리티를 구할 수 있다. 
--도수분포 히스토그램 / 높이균형 히스토그램

--오라클 힌트
--통계정보가 정확하지 않거나 기타 다른 이유로 옵티마이저가 잘못된 판단을 할 수 있다.
--그럴 때 프로그램이나 데이터 특성 정보를 정확히 알고 있는 개발자가 직접 인덱스를 지정하거나 조인 방식을 변경함으로써
-- 더 좋은 실행계획으로 유도하는 메커니즘이 필요

SELECT * FROM TBL_MOVIE A LEFT OUTER JOIN TBL_MOVIE_REVIEW B
ON A.MOVIE_NAME =B.MOVIE_NAME 
WHERE B.MOVIE_NAME IS NOT NULL 
​

--FIRST_ROWS 힌트
--처음 로우(행, 레코드)가 추출하는데 비용이 가장 적게드는 형태의 실행계획을 수립하는 힌트
SELECT /*+FIRST_ROWS */* FROM TBL_MOVIE A LEFT OUTER JOIN TBL_MOVIE_REVIEW B
ON A.MOVIE_NAME =B.MOVIE_NAME 
WHERE B.MOVIE_NAME IS NOT NULL 
​

-- 힌트 
SELECT /*+all_rows */* FROM TBL_MOVIE A LEFT OUTER JOIN TBL_MOVIE_REVIEW B
ON A.MOVIE_NAME =B.MOVIE_NAME 
WHERE B.MOVIE_NAME IS NOT NULL 

=======================================
분류 힌트
=======================================
최적화 목표 
all_rows / forst_rows(n)
=======================================
액세스 경로 
FULL /CLUSTER /hash

index, no_index

index_asc, index_desc

index_combine

index_join

index_ffs, no_index_ffs

index_ss, no_index_ss

index_ss_asc, index_ss_desc

=======================================
쿼리 변환 
no_query_transformation

use_concat

no_expand

rewrite, no_rewrite

merge, no_merge

star_transformation, no_star_transformation

fact, no_fact

unnest, no_unnest

=======================================
조인 순서 
ordered

LEADING

=======================================
조인 방식 
use_nl, no_use_nl

use_nl_with_index

use_merge, no_use_merge

use_hash, no_use_hash

=======================================
병렬 처리 
parallel, no_parallel

pq_distribute

parallel_index, no_parallel_index

=======================================
기타 
append, noappend

cache, nocache

push_pred, no_push_pred

push_subq, no_push_subq

qb_name

cursor_sharing_exact

driving_site

dynamic_sampling

model_min_analysis

=======================================

--SQL 최적화 기본원리 / 옵티마이저와 실행계획
--옵티마이저(o)
--옵티마이저와 실행계획
--조인수행원리
--조인기본원리

--옵티마이저(Optimizer)는 사용자가 질의한 SQL문에 대해 최적의 실행 방법을 결정하는 역할을 수행
--https://dataonair.or.kr/db-tech-reference/d-guide/sql/?pageid=3&mod=document&uid=354
--규칙기반 옵티마이저(RBO, Rule Based Optimizer)
--비용기반 옵티마이저(CBO, Cost Based Optimizer)


--규칙기반 옵티마이저
--우선 순위 규칙 
--규칙 1. 
--Single row by rowid : ROWID를 통해서 테이블에서 하나의 행을 액세스하는 방식이다. 
--ROWID는 행이 포함된 데이터 파일, 블록 등의 정보를 가지고 있기 때문에 다른 정보를 참조하지 않고도 
--바로 원하는 행을 액세스할 수 있다. 하나의 행을 액세스하는 가장 빠른 방법이다.

--규칙 4. Single row by unique or primary key : 유일 인덱스(Unique Index)를 통해서 하나의 행을 액세스하는 방식이다. 

--이 방식은 인덱스를 먼저 액세스하고 인덱스에 존재하는 ROWID를 추출하여 테이블의 행을 액세스한다.

--규칙 8. Composite index : 복합 인덱스에 동등(‘=’ 연산자) 조건으로 검색하는 경우이다. 
--예를 들어, 만약 A+B 칼럼으로 복합 인덱스가 생성되어 있고, 조건절에서 WHERE A=10 AND B=1 형태로 검색하는 방식이다. 
--복합 인덱스 사이의 우선 순위 규칙은 다음과 같다. 인덱스 구성 칼럼의 개수가 더 많고 해당 인덱스의 모든 구성 칼럼에 대해 ‘=’로 값이 주어질 수록 우선순위가 더 높다.
-- 예를 들어, A+B로 구성된 인덱스와 A+B+C로 구성된 인덱스가 각각 존재하고 조건절에서 A, B, C 칼럼 모두에 대해 ‘=’로 값이 주어진다면 A+B+C 인덱스가 우선 순위가 높다. 
--만약 조건절에서 A, B 칼럼에만 ‘=’로 값이 주어진다면 A+B는 인덱스의 모든 구성 칼럼에 대해 값이 주어지고
-- A+B+C 인덱스 입장에서는 인덱스의 일부 칼럼에 대해서만 값이 주어졌기 때문에 A+B 인덱스가 우선 순위가 높게 된다.

--규칙 9. Single column index : 단일 칼럼 인덱스에 ‘=’ 조건으로 검색하는 경우이다.
-- 만약 A 칼럼에 단일 칼럼 인덱스가 생성되어 있고, 조건절에서 A=10 형태로 검색하는 방식이다.

--규칙 10. Bounded range search on indexed columns :
-- 인덱스가 생성되어 있는 칼럼에 양쪽 범위를 한정하는 형태로 검색하는 방식이다. 
--이러한 연산자에는 BETWEEN, LIKE 등이 있다. 만약 A 칼럼에 인덱스가 생성되어 있고, A BETWEEN ‘10’ AND ‘20’ 또는 A LIKE '1%' 형태로 검색하는 방식이다.


--비용기반 옵티마이저
--규칙기반 옵티마이저는 조건절에서 ‘=’ 연산자와 'BETWEEN' 연산자가 사용되면 규칙에 따라 ‘=’ 칼럼의 인덱스를 사용하는 
--것이 보다 적은 일량 즉, 보다 적은 처리 범위로 작업을 할 것이라고 판단한다. 
--그러나 실제로는 ‘BETWEEN’ 칼럼을 사용한 인덱스가 보다 일량이 적을 수 있다.
--비용기반 옵티마이저는 이러한 규칙기반 옵티마이저의 단점을 극복하기 위해서 출현하였다.

--https://dataonair.or.kr/db-tech-reference/d-guide/sql/?pageid=3&mod=document&uid=354
--1.질의 변환기 : 사용자가 작성한 SQL문을 처리하기에 보다 용이한 형태로 변환하는 모듈
--2.대안 계획 생성기 : 동일한 결과를 생성하는 다양한 대안 계획을 생성하는 모듈
--3.비용 예측기 :  대안 계획 생성기에 의해서 생성된 대안 계획의 비용을 예측하는 모듈
--4.통계를 딕셔터리에서
--실행계획(Execution Plan)이란 SQL에서 요구한 사항을 처리하기 위한 절차와 방법을 의미
--실행계획을 생성한다는 것은 SQL을 어떤 순서로 어떻게 실행할 지를 결정하는 작업
--실행계획(Execution Plan) 보는법
--1.위에서 아래로 내려가면서 제일 먼저 읽을 위치 찾기
--2.내려가는 과정에서 같은 들여쓰기가 있으면, 무조건 위에서 아래 순으로 읽기
--3.같은 레벨에 들여쓰기된 하위 스텝이 존재하면, 가장 안쪽으로 들여쓰기 된 스텝을 시작으로 상위 스텝으로 읽기

--실행계획순서
SELECT * FROM TBL_MOVIE A LEFT OUTER JOIN TBL_MOVIE_REVIEW B
ON A.MOVIE_NAME =B.MOVIE_NAME 
WHERE B.MOVIE_NAME IS NOT NULL 

--실행계획순서
0     select cstmer_no
1          nested loops
2                table access by index rowid
3                        index unique scan
4                table accescc by index rowid
5                        index unique scan

--찾는방법
--1.같은레벨을 먼저 찾는다 2,4  3,5
--2.같은레벨에서 위부터 읽는다 (하위가 있다면 하위부터)
--3.  3-> 2  5 -> 4 -> 1 -> 0

--이진트리   맨 왼쪽 아래부터 

                 0
                 
                 |

                 1

               |   |

               2   4

               3   5


--실행계획순서
0     select cstmer_no
1          nested loops
2                nested loops
3                    table access full
4                    indes unique scan
5                table accescc by index rowid

--    3 -> 4 -> 2 -> 5 -> 1 - > 0

        0

        1

       2  5 

     3  4


아래의 실행계획의 순서를 바로 적은 것은?
 [보기]
 0- SELECT ..
 1-   NESTED LOOP JOIN
 2-     NESTED LOOP JOIN
 3-       TABLE ACCESS (FULL)
 4-       TABLE ACCESS (BY INDEX ROWID)
 5-         INDEX (RANGE SCAN)
 6-     TABLE ACCESS (BY INDEX ROWID)
 7-       INDEX (RANGE SCAN)

               0

               1

              2  6

            3 4  7                

              5
              
3 -> 5 -> 4 -> 2 -> 7 -> 6 -> 1 -> 0 순서


--문제 다음의 실행계획에서 가장 먼저 실행되는 작업은?
id
0    SELECT
1      FILTER
2        TABLE ACCESS FULL
3        TABLE ACCESS BY INDEX
4           INDEX UNIQUE SCAN​

    0

    1

   2 3

     4  

--왼쪽아래부터 시작 2 -> 4 -> 3 -> 1 -> 0
    

--문제
0   SELECT
1      FILTER
2        NESTED LOOPS
3            NESTED LOOPS
4               TABLE ACCESS
5                   INDEX RANGE SCAN
6               INDEX UNIQUE SCAN
7            TABLE ACCESS
8        TABLE ACCESS FULL
​

      0

      1

   2    8

 3  7   

4 6

5

정답 : 5 -> 4 -> 6 -> 3 -> 7 -> 2 -> 8 -> 1 -> 0


--문제
0     SELECT
1       SORT
2         HASH JOIN
3            TABLE ACCESS
4               NESTED LOOPS
5                  NESTED LOOPS
6                    TABLE ACCESS
7                        INDEX RANGE SCAN
8                    TABLE ACCESS
9                        INDEX RANGE SCAN
10                 INDEX RANGE SCAN
11           VIEW
12              UNION ALL
13                 TABLE ACCESS
14                   INDEX RANGE SCAN
15                 TABLE ACCESS
16                   INDEX RANGE SCAN


                               0

                               1

                               2

                           3           11

                           4           12 

                         5   10      13   15

                       6   8         14   16

                       7   9
 

--순서  7 6 9 8 5 10 4 3   14 13   16  15  12  11  2 1 0
                   

--SQL 최적화 기본원리 / 옵티마이저와 실행계획
--옵티마이저(O)
--옵티마이저와 실행계획(O)
--조인수행원리
--조인기본원리

--NL JOIN                       
--NL Join은 프로그래밍에서 사용하는 중첩된 반복문과 유사한 방식으로 조인을 수행한다.    
--NL 조인 (Nested Loops 조인) == for loop(반복문)
--NL 조인은 두 테이블이 조인을 할 때, 드라이빙 테이블(Outer 테이블)에서 결합 조건에 일치하는 레코드를 내부 테이블(Inner Table)에서 조인하는 방식이다.
                      
-- A LEFT OUTER JOIN B -> A테이블 기준으로 B테이블의 요소를 찾는다.
-- A테이블 -> 기준(드라이빙 테이블, OUTER테이블)
-- B테이블 -> INNER 테이블                       

--아우터 테이블 -> 드라이빙 테이블
--드리븐 테이블 -> 이너 테이블
--아우터 테이블이 작을수록 성능이 좋음.(아우터 테이블 수가 결정적.)
--이중포문                   

'''

a table -> 1,2,3
b table -> 1,2,3

1   1
2   1
3   1

1   2
2   2
3   2

1   3
2   3
3   3

'''

for i in range(1,4):
    for j in range(1,4):
        print(i,j)
        if i==j:
            print('good!')
       

--NL Join은 랜덤 방식으로 데이터를 액세스하기 때문에 처리 범위가 좁은 것이 유리하다.
-- 테이블? 여러개의 데이터 블록...으로 저장
-- 테이블 A(1~100) -> BLOCK1(1~33) + BLOCK2(34~60) + BLOCK3(61~100)
--> 32, 55 번 선택해요. 몇가지 블록을 접근해야 할까요? 2번접근 해야됨..           

--총 블록 사이즈            
select value from v$parameter where name = 'db_block_size';  

--테이블 액세스 방식에는 2가지가 있다.
--시퀀셜 액세스 (Sequential Access)
--논리적 또는 물리적으로 연결된 순서에 따라 차례대로 블록을 읽어들이는 방식이다. 

--랜덤 액세스 (Random Access)
--논리적, 물리적 순서가 아닌 레코드 하나를 읽기 위해 한 블록씩 접근하는 방식이다.

--NL Join의 작업 방법은 다음과 같다.
-- ① 선행 테이블에서 주어진 조건을 만족하는 행을 찾음
-- ② 선행 테이블의 조인 키 값을 가지고 후행 테이블에서 조인 수행 
-- ③ 선행 테이블의 조건을 만족하는 모든 행에 대해 1번 작업 반복 수행

--특징
--1.중첩된 반복문과 유사한 방식으로 조인
--2.랜덤엑세스 방식
--3.조인이 성공하면 바로 결과를 사용자에게 보여줌 -> 온라인 프로그램에 적당한 조인 기법
​

CREATE TABLE TBL_NL_1
(
id int GENERATED ALWAYS AS IDENTITY,
txt varchar(100)
);

INSERT INTO TBL_NL_1(txt) values(to_char(CURRENT_TIMESTAMP))
DECLARE num1 NUMBER :=1;

BEGIN
LOOP
INSERT INTO TBL_NL_1(txt) values(to_char(CURRENT_TIMESTAMP));
num1:=num1+1;
EXIT WHEN num1>100;
END LOOP;
END;

SELECT * FROM TBL_NL_1

​
CREATE TABLE TBL_NL_2
(
id int GENERATED ALWAYS AS IDENTITY,
txt varchar(100)
)


DECLARE NUM1 NUMBER :=1;
​

BEGIN
LOOP 
INSERT INTO TBL_NL_2(txt) values(to_char(CURRENT_TIMESTAMP));
NUM1:=NUM1+1;
EXIT WHEN NUM1>1000;
END LOOP;
​
END;


--해쉬조인을 하는 이유
SELECT a.*,b.* FROM TBL_NL_1 a INNER JOIN TBL_NL_1 b
ON a.id=b.id


--해쉬조인
--Hash Join은 해슁 기법을 이용하여 조인을 수행한다. 
--Hash Join은 NL Join의 랜덤 액세스 문제점과 Sort Merge Join의 문제점인 정렬 작업의 부담을 해결 위한 대안으로 등장

select ora_hash('1') hv,'1' num from dual
UNION all
select ora_hash('2') hv,'2' num from dual


select ora_hash('1') hv,'1' num from dual
UNION all
select ora_hash('2') hv,'2' num from dual
UNION all
select ora_hash('1') hv,'1' num from dual


--해쉬함수를 쓰는 이유
select ora_hash('insert into values 1') hv,'1' num from dual
UNION all
select ora_hash('insert into values 2') hv,'2' num from dual
UNION all
select ora_hash('insert into values 1') hv,'1' num from dual


--cpu cost 실행계획보기
select ora_hash('insert into values 1') hv,'1' num from dual

--cpu cost 실행계획보기
select to_char(sysdate) from dual

--해시함수는 cpu를 많이 사용한다.

--Hash Join의 동작 -> 선행/후행 테이블로 나뉨
--① 선행 테이블에서 주어진 조건을 만족하는 행을 찾음 
--② 선행 테이블의 조인 키를 기준으로 해쉬 함수를 적용하여 해쉬 테이블을 생성 → 조인 칼럼과 SELECT 절에서 필요로 하는 칼럼도 함께 저장됨 
--① ~ ②번 작업을 선행 테이블의 조건을 만족하는 모든 행에 대해 반복 수행 
--③ 후행 테이블에서 주어진 조건을 만족하는 행을 찾음 
--④ 후행 테이블의 조인 키를 기준으로 해쉬 함수를 적용하여 해당 버킷을 찾음 → 조인 키를 이용해서 실제 조인될 데이터를 찾음
--⑤ 조인에 성공하면 추출버퍼에 넣음 ③ ~ ⑤번 작업을 후행 테이블의 조건을 만족하는 모든 행에 대해서 반복 수행


--해시함수 특징
--Hash Join은 조인 칼럼의 인덱스를 사용하지 않기 때문에 조인 칼럼의 인덱스가 존재하지 않을 경우에도 사용할 수 있는 조인 기법이다
--Hash Join은 해쉬 함수를 이용하여 조인을 수행하기 때문에 '='로 수행하는 조인 즉, 동등 조인에서만 사용할 수 있다. 
--해쉬 함수를 적용한 값은 어떤 값으로 해슁될 지 알 수 없다. 
--해쉬 함수가 적용될 때 동일한 값은 항상 같은 값으로 해슁됨이 보장된다. 
--그러나 해쉬 함수를 적용할 때 보다 큰 값이 항상 큰 값으로 해슁되고 작은 값이 항상 작은 값으로 해슁된다는 보장은 없다. 
--그렇기 때문에 Hash Join은 동등 조인에서만 사용할 수 있다. 


--해시힌트
SELECT /*+ ORDERED USE_HASH(a) */a.*,b.* FROM TBL_NL_1 a INNER JOIN TBL_NL_2 b
ON a.id=b.id

--머지조인 힌트
SELECT /*+ USE_MERGE(a b) */a.*,b.* FROM TBL_NL_1 a INNER JOIN TBL_NL_2 b
ON a.id=b.id

--해시 조인 -> sort 머지 조인 변경됨.
SELECT /*+ ORDERED USE_HASH(a) */a.*,b.* FROM TBL_NL_1 a INNER JOIN TBL_NL_2 b
ON a.id>b.id
​

--Hash Join은 조인 작업을 수행하기 위해 해쉬 테이블을 메모리에 생성해야 한다. 
--생성된 해쉬 테이블의 크기가 메모리에 적재할 수 있는 크기보다 더 커지면 임시 영역(디스크)에 해쉬 테이블을 저장한다.
--Hash Join을 할 때는 결과 행의 수가 적은 테이블을 선행 테이블로 사용하는 것이 좋다. 
--선행 테이블의 결과를 완전히 메모리에 저장할 수 있다면 임시 영역에 저장하는 작업이 발생하지 않기 때문이다.
-- Hash Join에서는 선행 테이블을 이용하여 먼저 해쉬 테이블을 생성한다고 해서 선행 테이블을 Build Input이라고도 하며, 
--후행 테이블은 만들어진 해쉬 테이블에 대해 해쉬 값의 존재여부를 검사한다고 해서 Prove Input이라고도 한다. 

-- TABLE A -> (JOIN) TABLE B 어떻게 하면 빨리 찾는가? 인덱스
-- 1. NL 조인 - FOR LOOP, 랜덤 액세스 -> 인덱스가 없으면 느려짐

-- 2. HASH 조인 - 해시함수, 해시테이블 사용 -> 일종의 인덱스
   --> 인덱스가 없이도 빠름.
   --> HASH JOIN은 NL JOIN이나 SORT MERGE JOIN 이 효과적이지 못한 상황에서 해결하고자 나온 방식
   --> HASH 조인같은 경우에는 많은 메모리를 사용한다.
   -- 메모리는 속도가 빠르고, 디스크는 속도가 느림.
   -- A JOIN B(HASH JOIN)
   -- A 테이블 -> A테이블에 대한 해시 테이블
   --       해시함수
   -- 한쪽 테이블(A 테이블)이 가용 메모리에 담길 정도로 충분히 작아야 함
   -- 총 메모리 10G, 현재 8G, 가용메모리? 2G
-- 메카니즘(어떻게 돌아가는가? 작동방식)
-- A. 작은 집합(BUILD 테이블)을 읽음.
-- B. HASH AREA에 해시 테이블을 생성을 한다.(BUILD 테이블 기준)
-- C. 반대쪽 큰 집합(PROBE)을 읽어서 해시 테이블을 탐색하면서 조인

-- 3. SORT MERGE 조인 - 각테이블을 정렬하고 나서 조인을 수행
   --> SORT 소트단계 : 양 쪽 집합을 조인 칼럼 기준으로 정렬
   --> MERGE 머지단계 : 정렬된 양쪽을 하나로 합친다.
-- 위의 조인중에 옵티마이저가 상황에 맞게 판단해서 가장 빠른 경로를 찾아 사용

--Sort Merge Join
--Sort Merge Join은 조인 칼럼을 기준으로 데이터를 정렬하여 조인을 수행
--NL Join은 주로 랜덤 액세스 방식으로 데이터를 읽는 반면 Sort Merge Join은 주로 스캔 방식으로 데이터를 읽는다.
--Sort Merge Join은 랜덤 액세스로 NL Join에서 부담이 되던 넓은 범위의 데이터를 처리할 때 이용되던 조인 기법이다. 
--그러나 Sort Merge Join은 정렬할 데이터가 많아 메모리에서 모든 정렬 작업을 수행하기 어려운 경우에는 임시 영역(디스크)을 사용하기 때문에 성능이 떨어질 수 있다.
--일반적으로 대량의 조인 작업에서 정렬 작업을 필요로 하는 Sort Merge Join 보다는 CPU 작업 위주로 처리하는 Hash Join이 성능상 유리
--sort Merge Join은 Hash Join과는 달리 동등 조인 뿐만 아니라 비동등 조인에 대해서도 조인 작업이 가능하다는 장점
​

--해시 조인 -> sort 머지 조인 변경됨.
SELECT /*+ ORDERED USE_MERGE(a b) */a.*,b.* FROM TBL_NL_1 a INNER JOIN TBL_NL_2 b
ON a.id>b.id


--대량의 조인 작업에서 정렬 작업을 필요로 하는 Sort Merge Join 보다는 CPU 작업 위주로 처리하는 Hash Join이 성능상 유리
--실제 머지와 해시를 비교
--해시의 cpu cost는 732,833 머지의 cpu cost는 29,367,300
SELECT /*+ ORDERED USE_HASH(a b) */a.*,b.* FROM TBL_NL_1 a INNER JOIN TBL_NL_2 b
ON a.id=b.id

SELECT /*+ ORDERED USE_MERGE(a b) */a.*,b.* FROM TBL_NL_1 a INNER JOIN TBL_NL_2 b
ON a.id=b.id


--소트머지 조인의 동작
--1 선행 테이블에서 주어진 조건을 만족하는 행을 찾음 
--2 선행 테이블의 조인 키를 기준으로 정렬 작업을 수행 
--1 ~ 2번 작업을 선행 테이블의 조건을 만족하는 모든 행에 대해 반복 수행
--3 후행 테이블에서 주어진 조건을 만족하는 행을 찾음
--4 후행 테이블의 조인 키를 기준으로 정렬 작업을 수행 
--3 ~ 4번 작업을 후행 테이블의 조건을 만족하는 모든 행에 대해 반복 수행 
--5 정렬된 결과를 이용하여 조인을 수행하며 조인에 성공하면 추출버퍼에 넣음
--정리 : 테이블 A,B에서 A,B를 각각 정렬후 조인 수행

--Sort Merge Join은 조인 칼럼의 인덱스를 사용하지 않기 때문에 조인 칼럼의 인덱스가 존재하지 않을 경우에도 사용할 수 있는 조인 기법이다. 


--해시조인
SELECT a.*,b.* FROM TBL_NL_1 a INNER JOIN TBL_NL_2 b
ON a.id=b.id
​

--해시조인 -> NL조인으로 변경? 인덱스 생성(PK생성)
SELECT a.*,b.* FROM TBL_NL_1 a INNER JOIN TBL_NL_2 b
ON a.id=b.id


ALTER TABLE TBL_NL_2 ADD CONSTRAINT pk_TBL_NL_2 PRIMARY KEY (id);
​

--nested loop 조인
SELECT a.id,b.id FROM TBL_NL_1 a INNER JOIN TBL_NL_2 b
ON a.id=b.id
​
--where조건절 추가
SELECT a.id,b.id FROM TBL_NL_1 a INNER JOIN TBL_NL_2 b
ON a.id=b.id
WHERE a.id=1


--테이블1에도 pk생성
ALTER TABLE TBL_NL_1 ADD CONSTRAINT pk_TBL_NL_1 PRIMARY KEY (id);

--cpu cost 9,221 -- nested loop 조인
SELECT a.id,b.id FROM TBL_NL_1 a INNER JOIN TBL_NL_2 b
ON a.id=b.id
WHERE a.id=1
​

-----------------------------------------------------------------------------------------------------                  
--SQL 최적화 기본원리 / 옵티마이저와 실행계획
--옵티마이저(O)
--옵티마이저와 실행계획(O)
--조인수행원리(O)
--조인기본원리
--https://dataonair.or.kr/db-tech-reference/d-guide/sql/?pageid=1&mod=document&uid=368

--Nested Loop Join 기본 메커니즘 -> 이중 for loop

--CBO(비용 기반 옵티마이저)는 쿼리 최적화 과정에 비용을 계산한다. 다음중 비용과 거리가 먼 것은?
--1. 비용이란 기본적으로 SQL 수행과정에 수반될 것으로 예상되는 I/O일량을 계산한 것이다.
--2. 데이터베이스 CALL발생량도 옵티마이저의 중요한 비용 요소이다.
--3. 옵티마이저가 비용을 계산할 때 CPU 속도,디스크 I/O속도 등도 고려함.
--4. 최신 옵티마이저는 I/O에 CPU 연산 비용을 더해서 비용을 계산한다.

--정답 2번

--데이터베이스 콜이란 요청하는 과정에 발생.
--데이터베이스 콜이란? DBMS 외부로부터 요청되는 Call
--call은 parse call, excute call, fetch call

--문제. 다음중 규칙 기반 옵티마이저가 사용하는 규칙으로 부적절한 것은?
--1.고객유형코드에 인덱스가 있으면 아래 SQL에 인덱스를 사용한다.
--SELECT * FROM 고객 WHERE 고객유형코드=1

--2.고객명에 인덱스가 있으면 아래 SQL에 인덱스를 사용해 ORDER BY 소트 연산을 대체한다.
--SELECT * FROM 고객 ORDER BY 고객명

--3.연령과 연봉에 인덱스가 하나씩 있으면 아래 SQLP에 연봉인덱스를 사용. BETWEEN은 닫힌조건 / 부등호조건은 열린조건
--SELECT * FROM 사원 WHERE 연련>=60 AND 연봉 BETWEEN 3000 AND 6000

--4.직급에 인덱스가 있고 직급의 종류 개수가 5개 이상이면 인덱스를 사용
--SELECT * FROM 사원 WHERE 직급 = '대리'

--정답 4번 -- 직급의 종류개수 NDV - Number of Distinct Value - CBO가 사용하는 가장 대표적인 통계정보


--문제. 다음 중 전체 범위 최적화(all_rows) 방식의 옵티마이저 모드에 대한 설명으로 가장 거리가 먼 것은?
--1.쿼리의 최종 결과 집합을 끝까지 fetch하는 것을 전제로, 시스템 리소스를 가장 적게 사용하는 실행 계획을 선택한다.
--2.부분 범위 최적화(first rows)와 비교할 때, index scan보다 table full scan하는 실행 계획을 더 많이 생성한다.
--3.DML 문장은 옵티마이저 모드와 상관없이 항상 전체 범위 최적화 방식으로 최적화된다.
--4.가장 빠른 응답속도를 목표로 한다.

--정답 4번. all_rows는 최대 처리량을 목표

--FIRST_ROWS : 옵티마이저는 첫번째 레코드의 추출을 가장 빠르게 하는 최적의 경로를 찾습니다.
--ALL_ROWS : 통계 정보의 유무와 상관없이 모든 SQL 문에 대해 CBO를 이용하며 최대 처리량을 목표로 합니다.


--NL Join의 특징
--대부분 DBMS가 블록(또는 페이지) 단위로 I/O를 수행하는데, 
--하나의 레코드를 읽으려고 블록을 통째로 읽는 Random 액세스 방식은 설령 메모리 버퍼에서 빠르게 읽더라도 비효율이 존재
--NL Join의 첫 번째 특징이 Random 액세스 위주의 조인 방식이라는 점
--인덱스 구성이 아무리 완벽하더라도 대량의 데이터를 조인할 때 매우 비효율적
--조인 칼럼에 대한 인덱스가 있느냐 없느냐, 있다면 칼럼이 어떻게 구성됐느냐에 따라 조인 효율이 크게 달라진다. 
-- 이런 여러 가지 특징을 종합할 때, NL Join은 소량의 데이터를 주로 처리하거나 
--부분범위처리가 가능한 온라인 트랜잭션 환경에 적합한 조인 방식이라고 할 수 있다.

--SQL SERVER plan 

--여기서부터 sql server


--오라클
CREATE TABLE TBL_NL_1
(
id int GENERATED ALWAYS AS IDENTITY,
txt varchar(100)
)


--MSSQL
--실행은 F5
CREATE TABLE TBL_NL_1
(
id int identity(0,1),
txt varchar(100)
)


select getdate(),convert(varchar(20),getdate(),120)

INSERT INTO TBL_NL_1(txt) VALUES(convert(varchar(20),getdate(),120))

SELECT * FROM TBL_NL_1


INSERT INTO TBL_NL_1(txt) VALUES(convert(varchar(20),getdate(),120))
GO 1000


SELECT * FROM TBL_NL_1

CREATE TABLE TBL_NL_2
(
id int identity(0,1),
txt varchar(100)
)

commit

select @@TRANCOUNT


--트랜잭션 시작
begin tran

INSERT INTO TBL_NL_2(txt) VALUES(convert(varchar(20),getdate(),120))

SELECT * FROM TBL_NL_2

--트랜잭션 카운트수
select @@TRANCOUNT

--롤백
rollback

SELECT * FROM TBL_NL_2

INSERT INTO TBL_NL_2(txt) VALUES(convert(varchar(20),getdate(),120))
GO 1000


--mssql 기본 auto commit
--실제 개발시에 주의... 한번 쿼리돌리면 끝.

select @@TRANCOUNT


--실제 실행계획 포함
--대량의 데이터이고 인덱스가 없을 경우 해시조인
SELECT * FROM TBL_NL_1 a INNER JOIN TBL_NL_2 b
ON a.id=b.id

--ORACLE
--Sort Merge Join
--소트 단계 : 양쪽 집합을 조인 칼럼 기준으로 정렬한다. 
--머지 단계 : 정렬된 양쪽 집합을 서로 머지(merge)한다.

--만약 조인 칼럼에 인덱스가 있으면(Oracle의 경우 Outer 테이블에만 해당) 
-- ①번 소트 단계를 거치지 않고 곧바로 조인할 수도 있다.

--Oracle은 조인 연산자가 부등호이거나 아예 조인 조건이 없어도 Sort Merge Join으로 처리할 수 있지만,
--SQL Server는 조인 연산자가 ‘=’ 일 때만 Sort Merge Join을 수행한다는 사실에도 유념

--특징
--스캔(Scan) 위주의 조인 방식이다.
--Sort Merge Join은 두 집합을 각각 정렬한 후에 조인함으로 각 집합의 크기, 즉 테이블별 검색 조건에 의해 전체 일량이 좌우
--조인 하기 전에 양쪽 집합을 정렬한다.
--->만약 정렬해야 할 집합이 초대용량 테이블이면 정렬 자체가 큰 비용을 수반하기 때문에 성능 개선 효과를 얻지 못할 수도 있다. 
--->하지만, 일반 인덱스나 클러스터형 인덱스처럼 미리 정렬된 오브젝트를 이용하면 정렬작업을 하지 않고 바로 조인을 수행

--Hash Join
--Hash Join은 NL Join이나 Sort Merge Join이 효과적이지 못한 상황을 해결하고자 나온 조인 방식

--MSSQL
--실제 실행계획포함
--대량의 데이터이고 인덱스가 없을 경우 해시조인

SELECT * FROM TBL_NL_1 a INNER JOIN TBL_NL_2 b
ON a.id=b.id
option(hash join)

SELECT * FROM TBL_NL_1 a INNER JOIN TBL_NL_2 b
ON a.id=b.id
option(loop join)


SELECT * FROM TBL_NL_1 a INNER JOIN TBL_NL_2 b
ON a.id=b.id
option(merge join)

--해시 함수는, 출력값을 미리 알 순 없지만, 같은 입력값에 대해 같은 출력값을 보장하는 함수
--다른 입력값에 대한 출력값이 같을 수는 있는데, 이를 ‘해시 충돌’이라고 한다. 
--해시 테이블을 만들 때 해시 충돌이 발생하면, 입력값이 다른 엔트리가 한 해시 버킷에 담길 수 있다. 

--메커니즘
--  A. 작은 집합(Build Input)을 읽어
--  B. Hash Area 에 해시 테이블을 생성하고
--  C. 반대쪽 큰 집합(Probe Input)을 읽어 해시 테이블을 탐색 하면서 조인

--해시함수
--  * 해시 테이블 생성 (Build)
--  * 해시 테이블 탐색 (Probe)

--Hash Join은, NL Join처럼 조인 과정에서 발생하는 Random 액세스 부하가 없고 
--Sort Merge Join처럼 조인 전에 미리 양쪽 집합을 정렬하는 부담도 없다. 다만, 해시 테이블을 생성하는 비용이 수반된다.
--build input이 작아야 효율적

-- Hash Join 사용기준
--한 쪽 테이블이 가용 메모리에 담길 정도로 충분히 작아야 함
--Build Input 해시 키 칼럼에 중복 값이 거의 없어야 함

--조인 칼럼에 적당한 인덱스가 없어 NL Join이 비효율적일 때
--조인 칼럼에 인덱스가 있더라도 NL Join 드라이빙 집합에서 Inner 쪽 집합으로의 조인 액세스량이 많아 Random 액세스 부하가 심할 때
--Sort Merge Join 하기에는 두 테이블이 너무 커 소트 부하가 심할 때
--수행빈도가 낮고 조인할 때

/*
Hash Join의 순서로 올바른 것?
가) 선행 테이블에서 주어진 조건을 만족하는 레코드를 필터링
나) 선행 테이블의 조인 키를 기준으로 해시 함수를 적용해 해시 테이블을 생성
다) 1,2번 작업을 선행 테이블에서 조건을 만족하는 모든 행 수행
라) 후행 테이블에서 주어지는 조건을 만족하는 레코드를 필터링
마) 후행 테이블의 조인 키를 기준으로 해시 함수를 적용해 선행 테이블에서 해시 함수 반환값과 같은 값을 반환하는 해당 버킷을 찾음 --> 버킷 : 값이 있는 장소

가-나-다-라-마
가-나-라-마-다
나-가-마-라-다
가-라-나-마-다

정답 : 가-나-다-라-마
*/