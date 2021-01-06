select d.id, d.dname, format(avg(e.salary) * 10000, 0) avgsal
  from Dept d inner join Emp e on d.id = e.dept
 group by d.id
UNION
 select d.id, d.dname, format(avg(e.salary) * 10000, 0) avgsal
  from Dept d inner join Emp e on d.id = e.dept
 group by d.id limit 2;
 
-- 기본 CTE
WITH 
  AvgSal AS (
    select d.dname, avg(e.salary) avgsal
      from Dept d inner join Emp e on d.id = e.dept
     group by d.id
  ),
  MaxAvgSal AS (
    select * from AvgSal order by avgsal desc limit 1
  ),
  MinAvgSal AS (
    select * from AvgSal order by avgsal limit 1
  ),
  SumUp AS (
    select '최고' as gb, m1.* from MaxAvgSal m1
    UNION
    select '최저' as gb, m2.* from MinAvgSal m2
  )
select gb, dname, format(avgsal * 10000,0) from SumUp
UNION
select '', '평균급여차액', format( (max(avgsal) - min(avgsal)) * 10000, 0) from SumUp;

-- 재귀 CTE
WITH RECURSIVE fibonacci (n, fib_n, next_fib_n) AS
(
    select 1, 0, 1
    UNION ALL
    select n + 1, next_fib_n, fib_n + next_fib_n
      from fibonacci where n < 10
)
select * from fibonacci;

select * from Dept;

insert into Dept(pid, dname) values(6, '인프라셀');
insert into Dept(pid, dname) values(6, 'DB셀');
insert into Dept(pid, dname) values(7, '모바일셀');

select d2.dname as pname, d1.*
  from Dept d1 inner join Dept d2 on d1.pid = d2.id;

-- root row  
select * from Dept where pid = 0;

select cast('' as char);
  
WITH RECURSIVE CteDept(id, pid, pname, dname, d, h) AS 
(
    select id, pid, cast('' as char(31)), dname, 0, cast(id as char(10)) from Dept where pid = 0
    UNION ALL
    select d.id, d.pid, cte.dname, d.dname, d + 1, concat(cte.h, '-', d.id) from Dept d inner join CteDept cte on d.pid = cte.id
)
select /*+ SET_VAR(cte_max_recursion_depth = 5) */ d, dname from CteDept order by h;


-- 재귀 CTE 횟수 제한하기
SET SESSION cte_max_recursion_depth = 20;
WITH RECURSIVE cte (n) AS
(
  SELECT 1
  UNION ALL
  SELECT n + 1 FROM cte
)
SELECT * FROM cte;

WITH RECURSIVE cte (n) AS
(
  SELECT 1
  UNION ALL
  SELECT n + 1 FROM cte limit 10
)
SELECT /*+ SET_VAR(cte_max_recursion_depth = 20) */ * FROM cte;

