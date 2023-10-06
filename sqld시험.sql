1.데이터 모델링에 대한 아래 보기 설명 중 알맞은 것은?
1) 논리 모델링의 외래키는 물리 모델에서 반드시 구현되지는 않는다
2) 실제로 데이터베이스를 구축할 때 참고되는 모델은 개념적 데이터 모델링이다
3) 물리 모델링 -> 논리 모델링 -> 개념 모델링 단계로 갈수록 구체적이다
4) 데이터 모델링의 3가지 요소는 Process, Attributes, Relationship 이다

2.데이터 모델링에 대한 단계 중 아래에서 설명하는 단계는 어떤 단계의 모델링인가?
추상화 수준이 높고 업무중심적이고 포괄적인 수준의 모델링 진행. 전사적 데이터 모델링, EA 수립 시 많이 이용됨
1) 개념적 데이터 모델링
2) 논리적 데이터 모델링
3) 물리적 데이터 모델링
4) 추상적 데이터 모델링

3.엔터티 - 인스턴스 - 속성 - 속성값에 대한 관계 설명중 틀린 것을 고르시오
1) 한 개의 엔터티는 두 개 이상의 인스턴스의 집합이어야 한다
2) 한 개의 엔터티는 두 개 이상의 속성을 갖는다
3) 하나의 속성은 하나 이상의 속성값을 가진다
4) 하나의 엔터티의 인스터스는 다른 엔터티의 인스턴스간의 관계인 Paring 을 가진다

4.다음주 엔터티의 종류가 아닌 것은?
1) 교수
2) 학생
3) 청약자
4) 수강​

5.도메인의 특징으로 알맞지 않은 것은?
1) 엔터티 내에서 속성에 대한 데이터 타입과 크기를 지정한다
2) 엔터티 내에서 속성에 대한 NOT NULL 을 지정한다
3) 엔터티 내에서 속성에 대한 Check 조건을 지정한다
4) 테이블의 속성 간 FK 제약 조건을 지정한다.

6.주식별자의 특징으로 가장 적절하지 않은 것은?
1) 유일성 : 주식별자에 의해 엔터티내에서 모든 인스터스들을 유일하게 구분함
2) 최소성 : 주식별자를 구성하는 속성의 수는 유일성을 만족하는 최소의 수가 되어야 함
3) 불변성 : 주식별자가 한 번 특정 엔터티에 지정되면 그 식별자의 값은 변하지 않아야 함
4) 존재성 : 주식별자가 지정되면 데이터 값이 존재하지 않을 수 있음 (NULL 허용)

7.다음 중 컬럼에 대한 반정규화 기법으로 가장 적절하지 않은 것은?
1) 중복칼럼을 추가 - 조인감소를 위해 여러 테이블에 동일한 칼럼을 갖도록한다.
2) 파생칼럼을 추가한다 - 조회 성능을우수하게 하기 위해 미리 계산된 칼럼을 갖도록한다.
3) 이력테이블에 기능 칼럼을 추가한다 - 최신값을 처리하는 이력의 특성을 고려하여 기능성 칼럼을 추가한다
4) FK에 대한 속성을 추가한다 - FK관계 에 해당하는 속성을 추가하여 조인 성능을 높인다

8.속성의 특징으로 가장 올바른 것은?
1) 엔터티는 한 개의 속성만으로 구성될 수 있다
2) 엔터티를 설명하고 인스턴스의 구성요소가 된다
3) 하나의 속성에는 여러개의 속성값을 가질 수 있다
4) 속성의 특성에 따른 분류에는 PK 속성, FK 속성, 일반 속성이 있다

9.다음 중 아래 시나리오에서 엔터티로 가장 적절한 것은 ?
<시나리오>
S 병원은 여러 명의 환자가 존재하고 각 환자에 대한 이릅, 주소 등을 관리해야 한다
( 단, 업무범위와 데이 터 의 특성은 상기 시나리오에 기술되어 있는 사항만을 근거하여 판단해야 함)
1) 병원
2) 환자
3) 이름
4) 주소

10.아래의 ERD를 참고하여 테이블에 대한 관계를 설명하는 것으로 가장 적절한 것은?

주문테이블        -------      제품 테이블

주문id  <-(다) ................(다)->제품id

--------------         --------------

1) 주문은 여러 개의 제품을 가질 수 있고, 제품은 하나의 주문에만 속할 수 있다
2) 제품은 여러 개의 주문에 속할 수 있고, 주문은 하나의 제품만 가질 수 있다
3) 주문 1개는 여러개의 제품을 가질 수 있으며, 제품 1개는 여러개의 주문에 속할 수 있다
4) 주문은 제품을 하나도 안 가질 수 있다

11.TRUNCATE TABLE 명령어의 특징으로 가장 적절한 것은?
1) 테이블 자체를 삭제하는 명령어로 DROP TABLE 과 동일한 명령어이다
2) 특정 로우를 선택하여 지울 수 없다
3) DELETE TABLE 과는 다르게 TRUNCATE TABLE 의 경우 정상적인 복구가 가능하다
4) DELETE TABLE 보다 시스템 부하가 더 크다

12.다음의 SCRIPT 를 수행한 후 보기의 SQL 을 수행할 때 잘못된 것은?
<SCRIPT>
CREATE TABLE SQLD_34_12 (N1 NUMBER, N2 NUMBER );
INSERT INTO SQLD_34_12 VALUES (1,10);
INSERT INTO SQLD_34_12 VALUES (2,20);

1) SELECT N1 FROM SQLD_34_12 ORDER BY N2;
2) SELECT * FROM SQLD_34_12 ORDER BY 2;
3) SELECT N1 FROM (SELECT * FROM SQLD_34_12) ORDER BY N2;
4) SELECT N1 FROM (SELECT * FROM SQLD_34_12) ORDER BY 2; -- 컬럼의 순번(2) 로 정렬

13.PROCEDURE, TRIGGER 에 대한 설명 중 가장 잘못된 것은?
1) PROCEDURE, TRIGGER 모두 EXECUTE 명령어로 수행된다
2) PROCEDURE, TRIGGER 모두 CREATE 명령어로 생성한다
3) PROCEDURE 는 COMMIT, ROLLBACK 명령어를 사용할 수 있다
4) TRIGGER 는 COMMIT, ROLLBACK 명령어를 사용할 수 없다

14.아래의 SQL 에 대해서 결과값이 다른 것은?
1) SELECT CONCAT ('RDBMS', ' SQL') FROM DUAL;
2) SELECT 'RDMBS' || ' SQL' FROM DUAL;
3) SELECT 'RDBMS' + ' SQL' FROM DUAL;
4) SELECT 'RDBMS' & ' SQL' FROM DUAL;

15.비교연산자의 어느 한쪽이 VARCHAR 유형 타입인 경우 문자 우형 비교에 대한 설명 중 가장 알맞지 않은 것은?
1) 서로 다른 문자가 나올 때까지 비교한다
2) 길이가 다르다면 짧은 것이 끝날 때까지만 비교한 후에 길이가 긴 것이 크다고 판단한다
3) 길이가 같고 다른 것이 없다면 같다고 판단한다
4) 길이가 다르다면 작은 쪽에 SPACE 를 추가하여 길이를 같게 한 후에 비교한다

16.아래의 SQL 에 대해서 실행 순서를 올바르게 나열한 것은?
SELECT DEPTNO, COUNT(EMPNO)
FROM SCOTT.EMP
WHERE SAL >= 500
GROUP BY DEPTNO
HAVING COUNT(EMPNO) > 2
ORDER BY DEPTNO;

1) FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
2) FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY -> SELECT
3) FROM -> WHERE -> HAVING -> GROUP BY -> SELECT -> ORDER BY
4) FROM -> WHERE -> GROUP BY -> SELECT -> HAVING -> ORDER BY

17.아래의 실행 계획을 올바르게 설명한 것은?
-----------------------------------------------------------
   0      SELECT STATEMENT Optimizer=ALL_ROWS (Cost=7 Card=9 Bytes=1K) 
   1    0   HASH JOIN (Cost=7 Card=9 Bytes=1K)
   2    1     TABLE ACCESS (FULL) OF 'SCOTT.DEPT' (TABLE) (Cost=3 Card=1 Bytes=30) -- Bytes가 작은 테이블이 선행테이블이 됨 
   3    1     VIEW (Cost=3 Card=9 Bytes=783)
   4    3       COUNT (STOPKEY)
   5    4         TABLE ACCESS (FULL) OF 'SCOTT.EMP' (TABLE) (Cost=3 Card=14 Bytes=1K) --CARD : CARDINALITY , BYTES=1K(1024)
-----------------------------------------------------------
Predicate information (identified by operation id):
-----------------------------------------------------------
-- 아래가 WHERE 조건이 되어 행제한 줌.
   1 - access("A"."DEPTNO"="B"."DEPTNO")	
   2 - filter("B"."DNAME"='SALES')
   4 - filter(ROWNUM<10)
-----------------------------------------------------------
1) EMP TABLE 에 대한 행제한 구문이 있다
2) EMP TABLE 과 DEPT TABLE 은 OUTER JOIN 으로 수행되고 있다
3) EMP TABLE 과 DEPT TABLE 에서 선행 테이블은 EMP TABLE 이다
4) DEPT TABLE 은 별도의 조건이 없어 FULL SCAN 을 하고 있다   -- FULL SCAN(전체 테이블 스캔)

18.조인에 대한 설명 중 Hash Join 에 대한 특성으로 부적절한 것 2개를 고르시오
1) 각 테이블에 INDEX 가 반드시 필요한 것은 아니다
2) 일반적으로 작은 테이블을 MEMORY 에 올리는 선행 테이블로 사용한다
3) Non Equal Join 이 가능하다 (비동등)
4) 조인을 위해 사전 소트 작업이 필요하다
​
19.아래 VIEW 에 대한 설명 중 가장 올바르지 않은 것은?
1) 독립성 : 테이블 구조가 변경되어도 뷰를 사용하는 응용 프로그램은 변경하지 않아도 된다.
2) 편리성 : 복잡한 질의를 뷰로 생성함으로써 관련 질의를 단순하게 작성할 수 있다.
           또한, 해당 형태의 SQL문을 자주 사용할 때 뷰를 이용하면 편리하게 사용할 수 있다.
3) 물리성 : 실제 데이터를 가지고 있어서 물리적인 관리가 가능하다
4) 보안성 : 직원의 급여정보와 같이 숨기고 싶은 정보가 존재한다면， 뷰를 생성할 때 해당 칼럼을 빼고
           생성함으로써 사용자에게 정보를 감출 수 있다

20.SQL 구문에서 FROM 절에 대한 설명 중 가장 올바르지 않은 것은?
1) FROM 절에 ALIAS 를 쓰기 위해서 AS 키워드 사용이 가능하다
2) FROM 은 가장 먼저 수행된다
3) FROM 절에 사용되는 subquery 를 보통 inline view 라고 한다
4) FROM 절은 SELECT 와 항상 짝을 이룬다

21.서브쿼리에 대한 설명 중 가장 올바르지 않은 것은?
1) 서브쿼리는 괄호로 감싸서 사용한다
2) 서브쿼리는 비교 연산자와 함게 사용 가능하다
3) 메인쿼리는 서브쿼리의 컬럼을 쓸수 없다
4) 서브쿼리는 SELECT 절, FROM 절, WHERE 절등에서 사용 가능하다

22.유저와 권한 중 권한에 대한 설명 중 가장 올바르지 않은 것은?
1) 사용자가 실행하는 모든 DDL 문장은 그에 해당하는 적절한 권한이 있어야만 문장을 실행 할 수 있다.
2) DBA 권한을 가진 유저만이 권한을 부여 할 수 있다
3) 테이블의 소유자는 해당 테이블의 DML 권한을 다른 유저에게 부여 할 수 있다.
4) 권한 부여를 편리하게 관리하기 위해 만들어진 권한의 집합인 ROLE 이 있다

23.아래의 SQL에서 NULL 을 반환하는 SQL은 어떤것인가?
1) SELECT COALESCE(NULL,'2') FROM DUAL
2) SELECT NULLIF('A','A') FROM DUAL
3) SELECT NVL(NULL,0) + 10 FROM DUAL
4) SELECT NVL(NULL,'A') FROM DUAL

24.아래의 GROUP 함수예 대한 설명으로 가장 적절한 것은 ?
1) CUBE는 결합 가능한 모든 값에 대하여 다차원 집계를 생성한다.
2) ROLLUP 은 계층구조가 평등한 관계이므로 인수의 순서가 바뀌어도 결과는 같다.
3) ROLLUP, CUBE, GROUPING SETS 은 특정 컬럼에 대한 정렬은 가능하나 계층간 정렬은 불가능하다.
4) ROLLUP은 CUBE에 비해 시스템에 많은 부담을 주므로 사용에 주의해야 한다

25.순번을 구하는 그룹함수가 아닌 것은?
1) RANK
2) ROW_NUMBER
3) DENSE_RANK
4) RATIO_TO_REPORT

26.아래의 SCRIPT 에서 최종결과로 알맞은 것은?
<SCRIPT>
CREATE TABLE SQLD_34_29 (N1 NUMBER, N2 NUMBER) ;
--------------------------------------------------------------------------
INSERT INTO SQLD_34_29 VALUES (1,1);
INSERT INTO SQLD_34_29 VALUES (2,2);
SAVEPOINT SV1;
UPDATE SQLD_34_29 SET N1=4 WHERE N2=1;
SAVEPOINT SV1;
DELETE SQLD_34_29 WHERE N1 >= 2;
ROLLBACK TO SAVEPOINT SV1;
SELECT MAX(N1) FROM SQLD_34_29;

1) NULL
2) 4
3) 2
4) 답 없음

27.아래의 SQL 을 ORACLE 과 SQL SERVER 에서 수행할 때 SQL 에 대해 틀린 설명은? (AUTO COMMIT 은 FALSE 로 설정한다)
<SCRIPT>
UPDATE SQLD_34_30 SET N1=3 WHERE N2=1;
CREATE TABLE SQLD_34_30_TEMP (N1 NUMBER);
ROLLBACK;

1) SQL SERVER 의 경우 ROLLBACK 이 된 후 UPDATE 와 CREATE 구문 모두 취소된다
2) SQL SERVER 의 경우 ROLLBACK 이 된 후 SQLD_34_21_TEMP 는 만들어지지 않는다.
3) ORACLE 의 경우 ROLLBACK 이 된 후 UPDATE 와 CREATE 구문 모두 취소된다.
4) ORACLE 의 경우 UPDATE 는 취소되지 않는다

28.아래의 SQL 에 대한 설명 중 올바른 것은?
<SQL>
SELECT *
FROM SQLD_34_33
WHERE EMP_NAME LIKE 'A%'

1) 테이블의 EMP_NAME 이 A 또는 a 로 시작하는 모든 row
2) 테이블의 EMP_NAME 이 A 로 시작하는 모든 row
3) 테이블의 EMP_NAME 이 A 로 끝나는 모든 row
4) 테이블의 EMP_NAME 이 A 또는 a 로 끝나는 모든 row

29.반올림 함수로 알맞은 것은?
1) ROUND
2) CEIL
3) TRUNC
4) EXP

30.ORDER BY 의 특징으로 가장 적절하지 않은 것은?
1) ORDER BY 의 기본 정렬은 내림차순이다
2) SELECT 구문에 사용되지 않은 컬럼도 OERDER BY 구문에서 사용할 수 있다
3) ORDER BY 1, COL1 과 같이 숫자와 컬럼을 혼용하여 사용할 수 있다
4) ORACLE 은 NULL 을 가장 큰 값으로 취급하여 ORDER BY 시 맨 뒤로 정렬되고 SQL SERVER 반대로 가장 앞으로 정렬한다.

31.조인 기법 설명중 가장 적절한 것은?
1) Hash Join 은 정렬 작업이 없어 정렬이 부담되는 대량배치작업에 유리하다.
2) 대용량의 데이터를 가진 두개 테이블을 조인할 때 Hash Join 보다 Nested Loop Join 이 더 유리하다
3) 옵티마이저는 조인컬럼에 인덱스가 존재하지 않으면 Nested Loop Join 을 선호한다.
4) Nested Loop Join 기법은 배치작업에서 선호하는 조인기법이다.

32.SQL 집합 연산자 INTERSECT 에 대한 설명 중 올바른 것은?
1) 결과의 합집합으로 중복된 행을 모두 포함한다.
2) 결과의 합집합으로 중복된 행은 하나의 행으로 표시한다.
3) 결과의 교집합으로 중복된 행을 하나의 행으로 표시한다.
4) 결과의 교집합으로 중복된 행을 모두 포함한다.

33. 아래의 Window function 에 대한 설명중 적절한 것은?
1) Partition 과 Group By 구문은 의미적으로 완전히 다르다    -- PARTITION BY : 그룹을 나눠줌.
2) Sum,max, min 등과 같은 집계 window function을 사용할 때 window 절과 함께 사용하면 집계의 대상이 되는 레코드 범위를 지정할 수 있다 
3) Window function 처리로 인해 결과 건수가 줄어들 수 있다
4) GROUP BY 구문과 Window function 은 병행하여 사용 할 수 있다

34.아래의 트랜잭션 특성에 대한 설명을 올바르게 연결한 것은?
<설명>
 (ㄱ) : 트랜잭션에서 정의된 연산들은 모두 성공적으로 실행 되던지 아니면 전혀 실행되지 않은 상태로 남아 있어야 한다.
 (ㄴ) : 트랜잭션이 실행되는 도중에 다른 트랜잭션의 영향을 받아 잘못된 결과를 만들어서는 안된다.
 (ㄷ) : 트랜잭션이 성공적으로 수행되면 그 트랜잭션이 갱신한 데이터베이스의 내용은 영구적으로 저장된다.
 (ㄹ) : 트랜잭션이 실행 되기 전의 데이터베이스 내용이 잘못 되어 있지 않다면 트랜잭션이 실행된 이후에도 데이터베이스의 내용에 잘못이 있으면 안된다

1) 일관성, 원자성, 지속성, 고립성
2) 원자성, 일관성, 지속성, 고립성
3) 원자성, 고립성, 지속성, 일관성
4) 고립성, 원자성, 일관성, 지속성

35.아래의 테이블에 대한 SQL 결과로 올바른 것은?
<SQL> 
SELECT COUNT(*) 
FROM SQLD_34_23 
HAVING COUNT(*) > 4

SQLD_34_23
------------
C1
------------
1
2
3
4
------------
1) 공집합이다 (0 Rows)
2) 0
3) 1
4) 2

36.아래의 SQL 에서 FUNCTION 자리에 쓰인 함수에 의한 결과값이 다른 하나는?
SELECT function(3.46) FROM DUAL;

1) TRUNC
2) CEIL
3) FLOOR
4) ROUND

37.아래와 같이 문자와 문자를 연결하는 함수에 대해서 작성하시오. 
SELECT ( ) (COL1, COL2)
FROM EMP
WHERE EMPID = 10;

38.아래 테이블에 대해 수행된 SQL 결과와 보기의 SQL 의 결과가 같은 것으로 올바른 것은?
<SQLD_34_27>
EMP_ID DEPT_ID SALARY
1 		10 		1000
2 		10  	1500
3 			10 		1500
4 			20  	1200
5 		20  	1100
6 		20  	100
7 		30  	4000
8 			30  	5000

<SQL>
SELECT DEPT_ID, SALARY
FROM (
 SELECT ROW_NUMBER() OVER(PARTITION BY DEPT_ID ORDER BY SALARY DESC) RN , DEPT_ID, SALARY
 FROM SQLD_34_27 )
WHERE RN = 1

1)
SELECT DEPT_ID, SALARY
FROM (
 SELECT RANK() OVER(PARTITION BY DEPT_ID ORDER BY SALARY DESC) RN , DEPT_ID, SALARY
 FROM SQLD_34_27 )
WHERE RN = 1

2)
SELECT DEPT_ID, MAX(SALARY) AS SALARY
FROM SQLD_34_27
GROUP BY DEPT_ID

3)
SELECT DEPT_ID, SALARY
FROM SQLD_34_27
WHERE ROWNUM =1
ORDER BY DEPT_ID, SALARY DESC ;

4)
SELECT DEPT_ID, SALARY
FROM SQLD_34_27
WHERE SALARY = (SELECT MAX(SALARY) FROM SQLD_34_27 )

39.아래의 테이블에 대한 SELECT 결과 건수로 알맞은 것은?
<SQL> 
SELECT DISTINCT COL1
FROM SQLD_34_25_01 
UNION ALL 
SELECT COL1 
FROM SQLD_34_25_02 

SQLD_34_25_01 table
col1 
1
1
1
2
2
3
5
6

SQLD_34_25_02 table
col1
1
2
2
4
5

1) 4
2) 6
3) 8
4) 10

40.아래의 SCRIPT 를 수행한 후 수행한 보기의 SQL 중 잘못된 것은?
<SCRIPT>
CREATE TABLE 주문 (C1 NUMBER, C2 DATE, C3 VARCHAR2(10), C4 NUMBER DEFAULT 100 );
INSERT INTO 주문(C1,C2,C3) VALUES (1, SYSDATE, 'TEST1');

1) INSERT INTO 주문 VALUES (2, SYSDATE, 'TEST2')
2) DELETE 주문
3) DELETE FROM 주문
4) UPDATE 주문 SET C1=1

---------------------------------------------------------------------------------------------------------------
문제1 1번 
문제2 1번 
문제3 3번 
문제4 3번
문제5 4번
문제6 4번 
문제7 4번 
문제8 2번 
문제9 2번 
문제10 3번 
문제11 2번
문제12 4번
문제13 1번
문제14 4번
문제15 4
문제16 1
문제17 1
문제18 3,4
문제19 3
문제20 1
문제21 3
문제22 2
문제23 2
문제24 1
문제25 4
문제26 2
문제27 3
문제28 2
문제29 1
문제30 1
문제31 1
문제32 3
문제33 2
문제34 3
문제35 1
문제36 2
문제37 concat
문제38 2
문제39 4
문제40 1
​
---------------------------------------------------------------------------------------------------------------
1번 해설 : 1번
논리 모델링의 외래키는 물리 모델에서 반드시 구현되지 않음. (선택 사항임)
실제 데이터베이스 구축 시 참고되는 모델은 물리적 데이터 모델링이다
개념 모델링에서 물리 모델링으로 가면서 더 구체적이며 개념 모델링이 가장 추상적이다
데이터 모델링의 3요소는 Thing, Attirbutes, Relationship 이다

2번 해설 : 1번 개념적 데이터모델링

3번 해설 : 3번
하나의 속성은 하나의 속성값을 가지며 하나 이상의 속성값을 가지는 경우 정규화가 필요

4번 해설 : 3
교수,학생은 논란의 여지가 없으나, 수강과 청약자에서 논란이 일어남
청약자 라는 개념은 관심사라기 보다는 청약의 주체가 되는 속성에 가까운 곳으로 보임. 속성값을 가지기에 애매함
* 참고 : 대다수 수강이라고 했으나 청약자로 체킹한 분이 만점으로 답으로 인정

5번 해설 : 4) 테이블의 속성 간 FK 제약 조건을 지정한다. fk 제약 조건을 지정하는 것은 관계

6번 해설 : 4) 존재성 : 주식별자가 지정되면 데이터 값이 존재하지 않을 수 있음 (NULL 허용)  / 존재성은 없음

7번 해설 : 4) FK에 대한 속성을 추가한다 - FK관계에 해당하는 속성을 추가하여 조인 성능을 높인다
fk 관계에 대한 속성을 추가하면 조인 성능이 늦어짐.

8.속성의 특징
속성의 특성에 따른 분류에는 PK 속성, FK 속성, 일반 속성이 있다
->4.기본속성,설계속성,파생속성

12번 해설 : 4) select절에 없는 컬럼은 order by로 지정 불가능.

14번 해설 : 
Oracle 의 결합 함수 : CONCAT / ||
SQL Server : +

15번 해설:
SAPCE 를 추가하여 길이를 맞춰 비교하는 방법은 CHAR 타입인 경우임

15.비교연산자의 어느 한쪽이 VARCHAR 유형 타입인 경우 문자 우형 비교에 대한 설명 중 가장 알맞지 않은 것은?
길이가 다르다면 작은 쪽에 SPACE 를 추가하여 길이를 같게 한 후에 비교한다
->char의 특징
 char  / varchar 의 차이 : char 고정형 / varchar  가변형

17번 해설
Outer Join 이라고 표시된 SQL Operation 이 존재하지 않음
Hash Join 의 선행 테이블은 SCOTT.DEPT 테이블임
Predicate 정보를 보면 DEPT 테이블에 대한 Full Scan 후 DNAME ='SALES' 로 필터됨

18번 해설
Hash Join 은 Non Equal Join 은 불가능함. Equal Join 만 가능함
사전 Sorting 작업이 필요한 Join 알고리즘은 Sort Merge Join 임

19번 해설
View 는 논리적인 SELECT 를 포함하는 OBEJCT 로 실제 데이터를 저장하지 않음
20.1) FROM 절에 ALIAS 를 쓰기 위해서 AS 키워드 사용이 가능하다->애매

20번 해설
#mysql
select a.key1  as 'test' from SLQD_30_33 as a

21번해설
서브쿼리, 특히 INLINE VIEW 의 컬럼을 메인 쿼리에서도 사용 가능함

22번해설
DBA 권한은 SYSTEM,SYS 등의 상위 유저와 그에 해당하는 권한을 가진 경우 부여 가능

23.
SELECT COALESCE(NULL,'2') FROM DUAL -> null이 아닌것을 찾아라
SELECT NULLIF('c','B') FROM DUAL -- 같으면 null 그렇지 않으면 첫번째
SELECT NVL(NULL,0) + 10 FROM DUAL -- null이면 치환
SELECT NVL(NULL,'A') FROM DUAL

24번 해설
CUBE는 인자로 주어진 컬럼의 결합 가능한 모든 조합에 대해서 집계를 수행하므로 다른 그룹 함수에 비해 시스템에 대한 부하가 크다.

27번해설
oracle 의 경우 기본 값이 auto commit off 로 ddl 이 일어날 경우 묵시적
commit 이 됨 (설정 불가)
sql server 의 경우 기본 값이 auto commit on 으로 false 가 될 경우 ddl 도 묵
시적 commit 이 되지 않음
오라클은 auto commit off / sql server auto commit on

4)oracle의 경우 auto commit off 라서 create - ddl 일어나는 순간
자동 commit 됨. update는 취소되지 않음.
3)oracle 은 롤백이 된 후 update,create 모두 취소되지 않음.
2)sql server는 auto commit on - ddl이 일어나도 commit이랑 상관 없다.
rollback하면 create 롤백 / 
1)rollback 시에 모두 롤백 가능

29.round -> 반올림함수 / ceil은 무조건 소수점 업

33번해설
아래의 Window function 에 대한 설명중 적절한 것은?
​
1) Partition 과 Group By 구문은 의미적으로 완전히 다르다
#윈도우함수는 Group By와 비슷하게 데이터를 그룹화하여 집계해준다. 
#하지만 Group By는 집계된 결과만 보여주는 반면, 윈도우함수는 기존 데이터에 집계된 값을 추가하여 나타낸다.

2) Sum,max, min 등과 같은 집계 window function을 사용할 때 window 절과 함께 사용하면 집계의 대상이 되는 레코드 범위를 지정할 수 있다

3) Window function 처리로 인해 결과 건수가 줄어들 수 있다
#집계되어서 결과 건수가 늘어남.

4) GROUP BY 구문과 Window function 은 병행하여 사용 할 수 있다
# GROUP BY 구문과 병행하여 사용 불가

36번해설
* FLOOR: 숫자보다 작거나 같은 최대 정수를 리턴
* CEIL/CEILING: 숫자보다 크거나 같은 최소 정수를 리턴
* TRUNC: 숫자를 소수 m 자리에서 잘라서 리턴 (m default: 0)
* ROUND: 숫자를 소수 m 자리에서 반올림하여 리턴 (m default: 0)
해답
TRUNC(3.46) = 3,
FLOOR(3.46) = 3
ROUND(3.46)=3
CEIL(3.46) = 4

36.CEIL 함수는 소수점 값이 있는 경우 무조건 올려서 다음 정수 값을 반환한다

38.
rank함수
 SAL        RANK
1000          1
2000          2
2000          2
3000          4

row number함수
  SAL        RANK
1000          1
2000          2
2000          3
3000          4

40번해설
CREATE TABLE orders (C1 int, C2 DATE, C3 VARCHAR(10), C4 int DEFAULT 100 );
INSERT INTO orders(C1,C2,C3) VALUES (1, now(), 'TEST1');

1)INSERT INTO 주문 VALUES (2, SYSDATE, 'TEST2')
->INSERT INTO orders VALUES (2, now(), 'TEST2') -> column does not match

2) DELETE 주문
->delete orders

3) DELETE FROM 주문
delete from orders

4) UPDATE 주문 SET C1=1