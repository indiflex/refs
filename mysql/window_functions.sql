select * from Emp
 where ename like '박%'
 order by dept, salary desc;
 
select row_number() over(order by dept, salary desc) '순번',
    e.*,
    rank() over w '부서내 순위',
    dense_rank() over w '부서내 순위',
    percent_rank() over w '부서내 %순위',
    cume_dist() over w '부서내 %경계',
    ntile(3) over w '급여등급'
  from Emp e
 where ename like '박%'
 WINDOW w as (partition by dept order by dept, salary desc)
 ;
 
select row_number() over(order by dept, salary desc) '순번',
    e.*,
    sum(salary) over w '급여 누적치',
    first_value(salary) over w '부서내 1등 급여',
    last_value(salary) over w '부서내 현재까지의 꼴등 급여',
    nth_value(salary, 2) over w '부서내 2등 급여',
    lag(salary, 1) over w '이전 급여',
    lead(salary, 1) over w '다음 급여'
  from Emp e
 where ename like '박%'
 WINDOW w as (partition by dept order by dept, salary desc)
 ;