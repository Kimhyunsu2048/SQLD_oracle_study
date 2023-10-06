-- 표준조인, 집합연산자, 계층형질의, 서브쿼리
-- 뷰 = 가상테이블 -> 원본을 복제하지만 물리적으로 복제하는건 아님(하지만 원본의 데이터 변경시 뷰도 바뀜)
-- 테이블에는 실제 데이터 존재. 뷰에는 실제 데이터가 없다.
-- 뷰는 언제 쓰이는가?
-- 아주 중요한 테이블이 존재할 경우에 가상으로 테이블을 복제해서 원하는 정보만 보여줄 수 있음
-- 내부의 민감한 데이터가 외부에 노출되어서는 안되는 경우 사용. 
-- 뷰는 테이블을 복제 -> 데이터는 복제되지 않지만, 원본 데이터가 변경되면 뷰도 변경됨

CREATE TABLE tbl_memo
(
types varchar(50), -- 메모유형
start_data DATE, -- 메모날짜
details varchar(1000) -- 상세내용
)

INSERT INTO tbl_memo values('기본1',sysdate,'메모내용입니다.'); -- sysdate : 현재날짜, 현재시간으로 입력됨
INSERT INTO tbl_memo values('기본2',sysdate,'메모내용입니다.');
INSERT INTO tbl_memo values('기본3',sysdate,'메모내용입니다.');
INSERT INTO tbl_memo values('기본4',sysdate,'메모내용입니다.');
INSERT INTO tbl_memo values('기본5',sysdate,'메모내용입니다.');

SELECT * FROM tbl_memo; 

SELECT types || '' || details new_col FROM tbl_memo; -- 기본메모내용입니다.



-- view 생성
CREATE VIEW view_tbl_memo
AS 
SELECT types || '' || details new_col FROM tbl_memo
WHERE 조건문1 > 10;

SELECT * FROM view_tbl_memo; -- 기본메모내용입니다.


-- VIEW의 특징? ERP 회사에서 사용하기도 함. 
-- 독립성 : 테이블 구조가 변경되더라도 뷰는 변경되지 않음.
-- 편리성 : 복잡한 질의를 뷰로 저장가능.(ex. join 문이 적용된 테이블을 뷰로 간단히 조회)
-- 보안성 : 숨기고 싶은 컬럼을 빼고 뷰 생성 가능


다음의 VIEW를 조회한 SQL문의 실행결과로 올바른 것은? 
[SQLD39_32]
COL1     COL2
-------------
A       1000
A       2000
B       1000
B       NULL
NULL    3000
NULL    NULL

[뷰 생성 스크립트]
CREATE VIEW V_SQLD39_32
AS
SELECT * FROM SQLD39_32
WHERE COL1 = 'A' OR COL1 IS NULL;

[SQL]
SELECT SUM(COL2)
FROM V_SQLD39_32
WHERE COL2 >= 2000;

1) 1000 2) 3000 3) 4000 4) 5000

-- 서브쿼리란? 하나의 SQL 문에 포함되어 있는 또 다른 SQL 문을 말합니다.
-- EX)
SELECT COLUMN 
FROM (SELECT COLUMN2 FROM (SELECT COLUMN3 FROM (....)))


-- 서브쿼리가 사용가능한 곳?
-- SELECT 
-- FROM 
-- WHERE
-- HAVING
-- ORDER BY
-- INSERT 문의 VALUES절
-- UPDATE 문의 SET절


CREATE TABLE tbl_student
(
class varchar(100),
name varchar(100)
);
INSERT INTO tbl_student values('A반', '김이사');
INSERT INTO tbl_student values('B반', '박이사');
INSERT INTO tbl_student values('C반', '최이사');

SELECT * FROM tbl_student;


CREATE TABLE tbl_student_score
(
name varchar(100),
score number
);
INSERT INTO tbl_student_score values('김이사',80);
INSERT INTO tbl_student_score values('박이사',100);
INSERT INTO tbl_student_score values('최이사',95);

SELECT * FROM tbl_student_score;

-- in을 통해 여러 조건 모두 검색
SELECT * FROM tbl_student_score  
WHERE name in('김이사','박이사','최이사')
-- 서브쿼리
SELECT * FROM tbl_student_score  
WHERE name in(SELECT name FROM tbl_student WHERE class='A반')

-- exists 키워드 : 서브쿼리의 결과가 한건이라도 존재하면 true, 존재하지 않으면 false
SELECT * FROM tbl_student_score  
WHERE EXISTS(SELECT name FROM tbl_student WHERE class='A반')

-- ALL(모든) 키워드
SELECT * FROM tbl_student_score
WHERE score>=ALL(10, 50, 100); -- 박이사	100


-- ANY(하나라도) 키워드
SELECT * FROM tbl_student_score
WHERE score>ANY(10, 50, 100); 


-- 집합연산자 UNION ALL / UNION / INTERSECT / EXCEPT
SELECT 1 ID FROM DUAL 
UNION 
SELECT 2 ID FROM DUAL 
UNION 
SELECT 3 ID FROM DUAL 

-- UNION 은 합집합. 모든 데이터를 가져오는데 중복은 제외.
SELECT 1 ID FROM DUAL 
UNION 
SELECT 2 ID FROM DUAL 
UNION 
SELECT 2 ID FROM DUAL 

-- UNION ALL 은 모든 데이터를 중복 포함해서 가져옴.
SELECT 1 ID FROM DUAL 
UNION ALL
SELECT 2 ID FROM DUAL 
UNION ALL
SELECT 2 ID FROM DUAL

-- 성능상 관점(SQLP)
-- 쿼리 퍼포먼스 PERFORMANCE(성능)?
-- 중복된 데이터가 없다고 했을때, UNION 과 UNION ALL 어느것을 써야할까요? UNION ALL(UNION은 중복을 하나씩 비교하기 때문에...)


-- EXCEPT 차집합 
(
SELECT 1 ID FROM DUAL 
UNION ALL
SELECT 2 ID FROM DUAL 
UNION ALL
SELECT 2 ID FROM DUAL
)
MINUS
SELECT 2 ID FROM DUAL

SELECT 1 ID FROM DUAL 
MINUS
SELECT 7 ID FROM DUAL


-- 표준조인
-- ANSI SQL
-- 미국 표준 협회(ANSI) 
-- 테이블간의 join 관계가 from 에서 명시되기 때문에 where 문에서 조건만 확인하면 된다.

-- left outer join
-- 왼쪽 테이블을 기준으로 데이터가 출력되고
-- 조건에 맞는 오른쪽 테이블의 컬럼값이 같이 출력됨.
-- 왼쪽 테이블 자체는 전체가 출력
-- 오른쪽 테이블에 참조할 값이 없으면 null 이 나옴.

CREATE TABLE tbl_movie
(
	movie_name varchar(200), -- 영화이름
	movie_director char(200), -- 영화감독
	movie_attendance NUMBER, -- 영화관객수
	movie_startdate DATE DEFAULT sysdate -- 영화 개봉날짜
);

INSERT INTO tbl_movie(movie_name, movie_director, movie_attendance, movie_startdate)
VALUES('아바타','제임카메론',1000000,'2022-12-14');

INSERT INTO tbl_movie(movie_name, movie_director, movie_attendance, movie_startdate)
VALUES('오펜하이머','크리스토퍼놀란',10000,'2023-07-21');

INSERT INTO tbl_movie(movie_name, movie_director, movie_attendance, movie_startdate)
VALUES('오펜하이머','',10000,null);


SELECT * FROM tbl_movie;


SELECT * FROM tbl_movie_review;

CREATE TABLE tbl_movie_review
(
	movie_name varchar(20),
	review varchar(200)
)

INSERT INTO tbl_movie_review values('아바타', '★★★☆☆');
INSERT INTO tbl_movie_review values('오펜하이머', '★★★☆☆');


SELECT * FROM TBL_MOVIE LEFT OUTER JOIN TBL_MOVIE_REVIEW
ON TBL_MOVIE.MOVIE_NAME =TBL_MOVIE_REVIEW.MOVIE_NAME


SELECT * FROM TBL_MOVIE LEFT OUTER JOIN TBL_MOVIE_REVIEW
ON TBL_MOVIE.MOVIE_NAME =TBL_MOVIE_REVIEW.MOVIE_NAME
WHERE TBL_MOVIE_REVIEW.MOVIE_NAME IS NOT NULL 

​
-- left outer join 연산자 오른쪽 컬럼의 (+)
SELECT * FROM TBL_MOVIE,TBL_MOVIE_REVIEW
where TBL_MOVIE.MOVIE_NAME =TBL_MOVIE_REVIEW.MOVIE_NAME(+)

-- full outer join
-- left outer join + right outer join 합친 것
SELECT * FROM TBL_MOVIE FULL OUTER JOIN TBL_MOVIE_REVIEW
ON TBL_MOVIE.MOVIE_NAME =TBL_MOVIE_REVIEW.MOVIE_NAME

INSERT INTO tbl_movie_review values('잠', '★★★☆☆');

SELECT COUNT(*) FROM TBL_MOVIE  -- 9
SELECT COUNT(*) FROM TBL_MOVIE_REVIEW -- 3

-- 크로스조인(CROSS JOIN) / 카테시안 곱(PRODUCT)
-- 모든 경우의 수를 가져옴
SELECT * FROM TBL_MOVIE, TBL_MOVIE_REVIEW -- 27 (9*3)

-- INNER JOIN : 조인조건절에 정확하게 일치되는 것만 가져옴
SELECT *
FROM TBL_MOVIE
INNER JOIN TBL_MOVIE_REVIEW
ON 	TBL_MOVIE.MOVIE_NAME = TBL_MOVIE_REVIEW.MOVIE_NAME

--NATURAL JOIN
--NATURAL JOIN은 두 테이블 간의 동일한 이름을 갖는 모든 칼럼들에 대해 EQUI(=) JOIN을 수행한다. 
--NATURAL JOIN이 명시되면, 추가로 USING 조건절, ON 조건절, WHERE 절에서 JOIN 조건을 정의할 수 없다. 
--그리고, SQL Server에서는 지원하지 않는 기능이다. 


--using 조건절
--두 개의 테이블이 내부 조인으로 조인 될 때 조인하고자 하는 두 테이블의 컬럼명이 같을 경우 
--조인 조건을 길게 적지 않고 간단하게 적을 수 있도록 하는 역할

SELECT *
FROM TBL_MOVIE A
INNER JOIN TBL_MOVIE_REVIEW B 
USING(MOVIE_NAME)


-- 계층형질의 - 트리구조
-- 트리구조는 자료구조의 하나이다.
-- 자료구조? 데이터를 어떻게 저장하는가에 대한 형식
-- 테이블에 계층형 데이터가 존재하는 경우 데이터를 조회하기 위해서 계층형 질의(Hierarchical Query)를 사용한다. 
-- 계층형 데이터란 동일 테이블에 계층적으로 상위와 하위 데이터가 포함된 데이터를 말한다. 
-- 예를 들어, 사원 테이블에서는 사원들 사이에 상위 사원(관리자)과 하위 사원 관계가 존재하고 조직 테이블에서는 
-- 조직들 사이에 상위 조직과 하위 조직 관계가 존재한다. 
-- 엔터티를 순환관계 데이터 모델로 설계할 경우 계층형 데이터가 발생한다. 순환관계 데이터 모델의 예로는 조직, 사원, 메뉴 등이 있다

다음 계층형 쿼리문에 대한 설명으로 옳지 않은 것은?
[SQLD39_21]
ID   PARENT_ID   NAME   PARENT_NAME   DEPTH
-------------------------------------------
3     0          A                    1
4     0          B                    1
5     3          C       A            2
6     3          D       A            2
7     3          E       A            2
8     3          F       A            2
9     6          G       F            3
10    4          H       B            2
11    4          I       B            2

​

SELECT ID, PARENT_ID, NAME, PARENT_NAME
FROM SQLD39_21
WHERE PARENT_ID NOT IN(3)
START WITH PARENT_ID = 0
CONNECT BY PRIOR ID = PARENT_ID
ORDER SIBLINGS BY PARENT_ID ASC, ID ASC;

1) PARENT_ID가 0이라도 3이 포함되면 전개를 멈춘다.
2) 순방향 전개다.
3) 중복이 생겼을 때 루프를 돌지 않기 위해 NO CYCLE 옵션을 사용할 수 있다.
4) ORDER SIBLINGS BY를 하면 전체 테이블 기준으로 정렬한다


[계층형 구조] - 트리구조

        A    ---------------부모

      |   |

      B   C  ---------------자식

        |   |

        D   E

       
사원 관리자  -> 자식->부모
A    
B    A
C    A
D    C
E    C


--계층형 질의 구문
SELECT
FROM TABLE
WHERE CONDITION
START WITH CONDITION
CONNECT BY [NOCYCLE] CONDITION AND CONDITION...
[ORDER SIBLINGS BY COLUMN1,COLUMN2,...]
​
-- START WITH절은 계층 구조 전개의 시작 위치를 지정하는 구문이다. 즉, 보통 루트(꼭대기) 데이터를 지정한다.(액세스)
-- CONNECT BY절은 다음에 전개될 자식 데이터를 지정하는 구문이다. 
-- 자식 데이터는 CONNECT BY절에 주어진 조건을 만족해야 한다.(조인) - PRIOR : CONNECT BY절에 사용되며, 현재 읽은 칼럼을 지정한다. 
-- PRIOR 자식 = 부모 형태를 사용하면 계층구조에서 자식 데이터에서 부모 데이터(자식 → 부모) 방향으로 전개하는 순방향 전개를 한다. 
-- 그리고 PRIOR 부모 = 자식 형태를 사용하면 반대로 부모 데이터에서 자식 데이터(부모 → 자식) 방향으로 전개하는 역방향 전개를 한다.
-- - NOCYCLE : 데이터를 전개하면서 이미 나타났던 동일한 데이터가 전개 중에 다시 나타난다면 이것을 가리켜 사이클(Cycle)이 형성되었다라고 말한다.
-- 사이클이 발생한 데이터는 런타임 오류가 발생한다. 그렇지만 NOCYCLE를 추가하면 사이클이 발생한 이후의 데이터는 전개하지 않는다. 
-- ORDER SIBLINGS BY : 형제 노드(동일 LEVEL) 사이에서 정렬을 수행한다. - WHERE : 모든 전개를 수행한 후에 지정된 조건을 만족하는 데이터만 추출한다.(필터링)

-- 게시판 구조 (계층형 구조)
-- DEPTH - 계층 구조에서 SIBLING 단위로 DEPTH를 동일하게 가짐.
-- 원글
   ㄴ 댓글(1)
     ㄴ 댓글(2)
       ㄴ 댓글(3)
   ㄴ 댓글(1)


[SQLD39_21]
ID   PARENT_ID   NAME   PARENT_NAME   DEPTH
-------------------------------------------
3     0          A                    1
4     0          B                    1
5     3          C       A            2
6     3          D       A            2
7     3          E       A            2
8     3          F       A            2
9     6          G       F            3
10    4          H       B            2
11    4          I       B            2
​
SELECT ID, PARENT_ID, NAME, PARENT_NAME
FROM SQLD39_21
WHERE PARENT_ID NOT IN(3)
START WITH PARENT_ID = 0
CONNECT BY PRIOR ID = PARENT_ID
ORDER SIBLINGS BY PARENT_ID ASC, ID ASC;

1) PARENT_ID가 0이라도 3이 포함되면 전개를 멈춘다.
2) 순방향 전개다.
3) 중복이 생겼을 때 루프를 돌지 않기 위해 NO CYCLE 옵션을 사용할 수 있다.
4) ORDER SIBLINGS BY를 하면 전체 테이블 기준으로 정렬한다

​
CREATE TABLE SQLD39_21
(
ID INT,
PARENT_ID INT,
NAME VARCHAR(10),
PARENT_NAME VARCHAR(10),
"DEPTH" INT
)

INSERT INTO SQLD39_21(ID,PARENT_ID,NAME,PARENT_NAME,"DEPTH") VALUES(3,0,'A','',1);
INSERT INTO SQLD39_21(ID,PARENT_ID,NAME,PARENT_NAME,"DEPTH") VALUES(4,0,'B','',1);
INSERT INTO SQLD39_21(ID,PARENT_ID,NAME,PARENT_NAME,"DEPTH") VALUES(5,3,'C','A',2);
INSERT INTO SQLD39_21(ID,PARENT_ID,NAME,PARENT_NAME,"DEPTH") VALUES(6,3,'D','A',2);
INSERT INTO SQLD39_21(ID,PARENT_ID,NAME,PARENT_NAME,"DEPTH") VALUES(7,3,'E','A',2);
INSERT INTO SQLD39_21(ID,PARENT_ID,NAME,PARENT_NAME,"DEPTH") VALUES(8,3,'F','A',2);
INSERT INTO SQLD39_21(ID,PARENT_ID,NAME,PARENT_NAME,"DEPTH") VALUES(9,6,'G','F',3);
INSERT INTO SQLD39_21(ID,PARENT_ID,NAME,PARENT_NAME,"DEPTH") VALUES(10,4,'H','B',2);
INSERT INTO SQLD39_21(ID,PARENT_ID,NAME,PARENT_NAME,"DEPTH") VALUES(11,4,'I','B',2);

SELECT * FROM SQLD39_21
-- 조회 결과
3     0          A                    1
4     0          B                    1
5     3          C       A            2
6     3          D       A            2
7     3          E       A            2
8     3          F       A            2
9     6          G       F            3
10    4          H       B            2
11    4          I       B            2


​
SELECT ID, PARENT_ID, NAME, PARENT_NAME
FROM SQLD39_21
WHERE PARENT_ID NOT IN(3)
START WITH PARENT_ID = 0
CONNECT BY PRIOR ID = PARENT_ID
ORDER SIBLINGS BY PARENT_ID ASC, ID ASC;

--ID 순서가 왜 3-9-4-10-11일까?
--3-4-9-10-11이어야 하지 않을까?
--깊이우선탐색 / 너비우선탐색

    3       4

5 6 7 8   10 11

  9

​

--BSC는 기업의 성과를 균형 있게 관리하는 성과관리 시스템이다. 
--BSC는 KPI를 사용해서 기업을 평가하는데 KPI는 상위, 중위, 하위 등의 KPI로 세분화 된다. 
--다음의 KPI-POOL 테이블에서 특정 하나의 값에 대한 자신의 상위 KPI를 검색하는 SQL문으로 올바른 것은?

[KPIPOOL]
SUBKPI  KPINAME    MAINKPI
--------------------------
10      고객만족도      0
20      콜센터만족도    10
30      불만건수       20
40      대기시간       30
50      건의건수       40


(1)                          
SELECT * FROM KPIPOOL                       
START WITH MAINKPI = 10
CONNECT BY PRIOR SUBKPI = MAINKPI;             

(2)
SELECT * FROM KPIPOOL
WHERE SUBKPI = 30
START WITH MAINKPI = 0
CONNECT BY PRIOR MAINKPI = SUBKPI;

(3)                           
SELECT * FROM KPIPOOL                        
START WITH MAINKPI = 100       
CONNECT BY PRIOR SUBKPI = MAINKPI;                                         

(4)
SELECT * FROM KPIPOOL
WHERE SUBKPI = 30
START WITH MAINKPI = 0
CONNECT BY PRIOR SUBKPI = MAINKPI;

​
CREATE TABLE KPIPOOL
(
SUBKPI int,
KPINAME varchar(20),
MAINKPI int
);

​
INSERT INTO KPIPOOL(SUBKPI,KPINAME,MAINKPI) VALUES(10,'고객만족도',0);
INSERT INTO KPIPOOL(SUBKPI,KPINAME,MAINKPI) VALUES(20,'콜센터만족도', 10);
INSERT INTO KPIPOOL(SUBKPI,KPINAME,MAINKPI) VALUES(30,'불만건수',20);
INSERT INTO KPIPOOL(SUBKPI,KPINAME,MAINKPI) VALUES(40,'대기시간',30);
INSERT INTO KPIPOOL(SUBKPI,KPINAME,MAINKPI) VALUES(50,'건의건수',40);

DROP TABLE KPIPOOL;

SELECT * FROM KPIPOOL;

--PRIOR 자식=부모 -> 순방향전개

--PRIOR 부모=자식 -> 역방향전개

​

        0

        |

        10

        |

        20

        |

        ...

​

--MAINKPI 부모

--SUBKPI 자식

(1)                          
SELECT * FROM                 
KPIPOOL                       
START WITH MAINKPI = 0
CONNECT BY PRIOR SUBKPI = MAINKPI;             


SELECT * FROM                 
KPIPOOL                       
START WITH MAINKPI = 0
CONNECT BY PRIOR  MAINKPI = SUBKPI;             

​

[KPIPOOL]
SUBKPI  KPINAME    MAINKPI
--------------------------
10      고객만족도      0
20      콜센터만족도    10
30      불만건수       20
40      대기시간       30
50      건의건수       40

(2)
--하나가 나오는 이유?  MAINKPI = 0이고 역방향 출력 prior 부모=자식  ->루트에서 올라가봤자 없음
SELECT * FROM KPIPOOL --WHERE SUBKPI = 30
START WITH MAINKPI = 0
CONNECT BY PRIOR MAINKPI = SUBKPI;

​
--거꾸로 출력하려면? 역방향출력 prior 부모=자식
SELECT * FROM
KPIPOOL
START WITH MAINKPI = 40
CONNECT BY PRIOR MAINKPI = SUBKPI;


(3)                           
SELECT * FROM                  
KPIPOOL                        
START WITH MAINKPI = 100       
CONNECT BY PRIOR               
SUBKPI = MAINKPI;              


(4)
SELECT * FROM KPIPOOL
WHERE SUBKPI = 30
START WITH MAINKPI = 0
CONNECT BY PRIOR SUBKPI = MAINKPI;


--다음 SQL문과 결과를 확인후 (  ?  )에 올바른 것이 무엇인지 고르시오.
[SQL]
SELECT LEVEL, LPAD(' ',4 * (LEVEL-1)) || EMPNO AS EMPNO,MGR,CONNECT_BY_ISLEAF
FROM EMP
START WITH MGR IS NULL
(     ?     ) EMPNO = MGR;

-----------------------------------
[RESULT]
LEVEL  EMPNO    MGR   CONNECT_BY_ISLEAF
1     1000         	 	0
2     1001   	1000    0
3     1005   	1001    1
3     1006  	1001    0
4     1007   	1006    1
4     1008   	1006    1
3     1011   	1001    1
2     1002      1000    0
3     1009      1002    1
3     1010      1002    1
.
.
생략

1) CONNECT BY
2) GROUP BY
3) WHERE
4) HAVING




















