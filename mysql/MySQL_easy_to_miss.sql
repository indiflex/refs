select * from Emp;
select * from Dept;

-- rollup
select 
    (case when d.pid is not null then max(p.dname) else 'Total' end) '상위부서',
    (case when d.id is not null then max(d.dname) else '- 소계 -' end) '부서명', 
    format(sum(e.salary), 0) '급여합(단위:만원)'
  from Dept p inner join Dept d on p.id = d.pid
              inner join Emp e on d.id = e.dept
 group by d.pid, d.id
 with rollup;
 
-- pivot
select d.id, max(d.dname) '구분',
    format(avg(e.salary) * 10000, 0) '평균급여',
    format(sum(e.salary) * 10000, 0) '급여합계',
    format(min(e.salary) * 10000, 0) '최소급여',
    format(max(e.salary) * 10000, 0) '최대급여'
 from Dept d inner join Emp e on d.id = e.dept
 group by d.id
 order by d.id;
 
select dept, dept = 3
  from Emp where id < 10;
  
select ~0;
 
select '평균급여' as '구분',
    format(avg(case when dept = 3 then salary end) * 10000, 0) '영업1팀',
    format(avg(case when dept = 4 then salary end) * 10000, 0) '영업2팀',
    format(avg(case when dept = 5 then salary end) * 10000, 0) '영업3팀',
    format(avg(case when dept = 6 then salary end) * 10000, 0) '서버팀',
    format(avg(case when dept = 7 then salary end) * 10000, 0) '클라팀'
  from Emp
UNION
select '급역합계',
    format(sum(salary * (dept = 3)) * 10000, 0), 
    format(sum(salary * (dept = 4)) * 10000, 0), 
    format(sum(salary * (dept = 5)) * 10000, 0), 
    format(sum(salary * (dept = 6)) * 10000, 0), 
    format(sum(salary * (dept = 7)) * 10000, 0)
  from Emp
UNION
select '최소급여',    
    format(min(IF(dept = 3, salary, ~0)) * 10000, 0),
    format(min(IF(dept = 4, salary, ~0)) * 10000, 0),
    format(min(IF(dept = 5, salary, ~0)) * 10000, 0),
    format(min(IF(dept = 6, salary, ~0)) * 10000, 0),
    format(min(IF(dept = 7, salary, ~0)) * 10000, 0)
  from Emp
UNION
select '최대급여',    
    format(max(IF(dept = 3, salary, 0)) * 10000, 0),
    format(max(IF(dept = 4, salary, 0)) * 10000, 0),
    format(max(IF(dept = 5, salary, 0)) * 10000, 0),
    format(max(IF(dept = 6, salary, 0)) * 10000, 0),
    format(max(IF(dept = 7, salary, 0)) * 10000, 0)
  from Emp
  ;

select dept, avg(salary) from Emp group by dept;