select * from Emp order by ename;
select * from Emp where ename like '박%' order by dept, salary desc;

select row_number() over(order by dept, salary desc) '순번', 
    e.*,
    rank() over(partition by dept order by salary desc) '부서내 순위',
    sum(salary) over(partition by dept order by salary desc) '급여 누적치'
  from Emp e where ename like '박%'; -- order by dept, salary desc;
  
select ROW_NUMBER() OVER(order by dept, salary desc) '순번', 
    e.*,
    RANK() OVER w '부서내 순위',
    SUM(salary) OVER w '급여 누적치'
  from Emp e where ename like '박%'
 WINDOW w as (partition by dept order by salary desc);
 
select ROW_NUMBER() OVER(order by dept, salary desc) '순번', 
    e.*,
    RANK() OVER w '부서내 순위',
    DENSE_RANK() OVER w '부서내 순위2',
    PERCENT_RANK() OVER w '부서내 %순위',
    CUME_DIST() OVER w '부서내 %경계',
    NTILE(3) OVER w '급여 등급'
  from Emp e where ename like '박%'
 WINDOW w as (partition by dept order by salary desc);
 
select ROW_NUMBER() OVER(order by dept, salary desc) '순번', 
    e.*,
    SUM(salary) OVER w '급여 누적치',
    FIRST_VALUE(concat(id, '-', salary)) OVER w '부서내 1등 급여',
    NTH_VALUE(salary, 2) OVER w '부서내 2등 급여',
    LAG(salary, 1) OVER w '이전 순위 급여',
    LEAD(salary, 1) OVER w '다음 순위 급여'
  from Emp e where ename like '박%'
 WINDOW w as (partition by dept order by salary desc);
 
select d.id, d.dname, avg(e.salary) avgsal, max(e.salary) maxsal,
    RANK() OVER(order by avg(e.salary) desc) as salrank
  from Dept d inner join Emp e on d.id = e.dept
 where d.id > 3
 group by d.id;
 


select d.id, d.dname, avg(e.salary) avgsal, max(e.salary) maxsal,
    rank() over(order by max(e.salary) desc) as salrank,
    dense_rank() over(order by max(e.salary) desc) as salrank_without_gab,
    percent_rank() over(order by max(e.salary) desc) as salrank_percent,
    CUME_DIST() over(order by max(e.salary) desc) as sal_cumulative,
    row_number() over(order by max(e.salary) desc) as rnum
  from Dept d inner join Emp e on d.id = e.dept
 group by d.id;
 
select row_number() over(order by id), id, dname, empcnt from Dept;
select row_number() over(), id, dname, empcnt from Dept order by id;
select row_number() over() rnum, rank() over(order by empcnt desc) rnk, id, dname, empcnt from Dept order by empcnt desc;
select row_number() over(order by empcnt desc) rnum, rank() over(order by empcnt desc) rnk, id, dname, empcnt from Dept order by empcnt desc;
select row_number() over w rnum, rank() over w rnk, id, dname, empcnt
  from Dept where pid <> 0
  WINDOW w AS (order by empcnt desc);

select row_number() over () rnum, rank() over w rnk, pid, id, dname, empcnt
  from Dept where pid <> 0
  WINDOW w AS (partition by pid order by empcnt desc);

select d.id, d.dname, avg(e.salary) avgsal, max(e.salary) maxsal,
    rank() over(order by max(e.salary) desc) as salrank,
    dense_rank() over(order by max(e.salary) desc) as salrank_without_gab,
    row_number() over(order by max(e.salary) desc) as rnum
  from Dept d inner join Emp e on d.id = e.dept
 group by d.id;
 
select * from Dept;
select * from Emp where dept is null;
select * from Emp order by salary desc;

select dept, max(salary) maxsal from Emp group by dept;
select * from Emp where salary = 900 order by dept;
select id, dept, max(salary) from Emp where salary>=900 group by dept order by dept;
select id from Emp where salary>=900 group by dept order by dept;
select * from Emp where id in (select max(id) from Emp where salary=900 group by dept order by dept);
select 900 + FLOOR(rand() * 10);
select *, 900 + FLOOR(rand() * 9) from Emp where id in (select max(id) from Emp where salary=900 group by dept order by dept);

-- Error Code: 1093. You can't specify target table 'Emp' for update in FROM clause
update Emp set salary = 900 + FLOOR(rand() * 9) where id in (select max(id) from Emp where salary=900 group by dept order by dept);

with cte AS (
    select id from Emp where salary=900 group by dept order by dept
)
update Emp set salary=(900 + FLOOR(rand() * 9)) where id in (select id from cte);
-- select *, 900 + FLOOR(rand() * 9) from Emp where id in (select id from cte);
-- select e.* from Emp e inner join cte c on e.id = c.id;

select * from Emp where salary > 900;

start transaction;
update Emp set salary=900 where salary > 900;


rollback;

select ifnull(dept, 'Total'), format(sum(salary),0), left(ename,1)
  from Emp
 where dept is not null
 group by left(ename,1), dept
 WITH ROLLUP;

select row_number() over() rownum, 
    d.id dept, max(d.dname), sum(e.salary)
  from Dept d inner join Emp e on d.id = e.dept
 group by d.id with rollup;
 
select d.pid, max(d.dname), sum(e.salary)
  from Dept d inner join Emp e on d.id = e.dept
 group by d.pid, d.id with rollup;
 
select d.pid, d.id dept, 
    (select dname from Dept
      where id = d.pid) '상위부서',
    max(d.dname) '부서',
    sum(e.salary) '급여합'
  from Dept d inner join Emp e
    on d.id = e.dept
 group by d.pid, d.id
 with rollup;
 
select d.pid, d.id, 
      (case when d.id is not null
            then max(d.dname) else '소계' end) '부서',
       format(sum(e.salary),0) '급여합'
  from Dept d inner join Emp e
    on d.id = e.dept
 group by d.pid, d.id
 with rollup;
 
select (case when p.id is not null
            then max(p.dname)
            else 'Total' end
        ) as '상위부서', 
       (case when d.id is not null
            then max(d.dname)
            else '- 소계 -' end
        ) as '부서',
       format(sum(e.salary), 0) as '급여합'
  from Dept p
        inner join Dept d on p.id = d.pid
        inner join Emp e on d.id = e.dept
 group by p.id, d.id
 with rollup;
 
select * from Dept;

select max(d.dname) '구분',
    format(avg(e.salary) * 10000, 0) '평균급여',
    format(sum(e.salary) * 10000, 0) '급여합계',
    format(min(e.salary) * 10000, 0) '최소급여',
    format(max(e.salary) * 10000, 0) '최대급여'
  from Dept d inner join Emp e on d.id = e.dept
  group by d.id
  order by d.id;


select '평균급여' as '구분',
        format(avg(case when dept = 3 then salary end) * 10000, 0) as '영업1팀',
        format(avg(case when dept = 4 then salary end) * 10000, 0) as '영업2팀',
        format(avg(case when dept = 5 then salary end) * 10000, 0) as '영업3팀',
        format(avg(case when dept = 6 then salary end) * 10000, 0) as '서버팀',
        format(avg(case when dept = 7 then salary end) * 10000, 0) as '클라팀'
    from Emp
UNION
select '급여합계',
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
    from Emp;

select ~0;

-- JSON
alter table Emp add column remark JSON;
desc Emp;
{
  "age": 50,
  "addr": "서울"
}
select * from Emp where id < 5;

select json_valid('{addr: }'),
    json_valid('{addr: "서울"}'),
    json_valid('{"addr": "서울"}'),
    json_pretty('{"addr": "서울", "age": 50}');
    
update Emp set remark = '{addr:'
 where id = 1;

    
update Emp set remark = '{"addr": "서울"}'
 where id = 1;
update Emp set remark = '{"addr": "부산", "age": 39}'
 where id = 2;
update Emp set remark = '{"addr": "대구", "age": 29, "family": [{"name": "논개", "relation":"모"}]}'
 where id = 3;
update Emp set remark = '{"addr": "강원", "age": 49, "family": [{"name": "조조", "relation":"부"}, {"name": "배철균", "relation": "모"}]}'
 where id = 4;
 
select id, ename, remark from Emp where id < 5;
select id, ename, remark from Emp where id = 2;
select id, ename, remark from Emp where id in (3, 4);

update Emp set remark = '{"addr": "서울", "addr": "대전"}'
 where id = 1;
 
update Emp set remark = JSON_OBJECT('addr', '부산', 'age', 39, 'age', 19, 'family')
 where id = 2;
 
update Emp
    set remark = JSON_OBJECT('addr', '대구', 'age', 19, 
          'family', 
            JSON_ARRAY(
                JSON_OBJECT('name', '논개', 'relation', '모')
            ))
 where id = 3;
 
update Emp
    set remark = JSON_OBJECT('addr', '강원', 'age', 49, 
          'family', 
            JSON_ARRAY(
                JSON_OBJECT('name', '조조', 'relation', '부'), 
                JSON_OBJECT('name', '배철균', 'relation', '모') 
            ))
 where id = 4;
 
-- 특정 값만 추출하기 - inline path(->) 사용하기
select remark, 
    remark->'$.addr' addr1,
    remark->>'$.addr' addr2,
    json_value(remark, '$.addr') jv_addr,
    json_value(remark, '$.age' RETURNING DECIMAL(4,2)) jv_age,
    json_extract(remark, '$.addr') ext1,
    json_unquote(json_extract(remark, '$.addr')) ext2
  from Emp where remark is not null;
  
select remark,
    json_type( json_value(json_object('a', 2.3),'$.a')),
    json_type(remark->'$') jt_all,
    json_type(remark->'$.age') jt_age,
    json_type(remark->'$.addr') jt_addr,
    json_type(remark->'$.family') jt_family
 from Emp where remark is not null;
 
select remark, 
    json_length(remark) jlen,
    json_depth(remark) depth, 
    json_keys(remark) jkeys
  from Emp where remark is not null;

  
-- JSON_SEARCH() 함수로 패스 찾기, 특정 값의 존재 유무 확인
select remark, 
    json_search(remark, 'one', '부산') path_ps,
    json_search(remark, 'one', '배철균') path_bae
  from Emp where remark is not null;

select remark, 
    json_contains(remark, '"대전"', '$.addr') has_dj,
    json_contains(remark, '19', '$.age') has19
  from Emp where remark is not null;
  
-- json path 사용법
select remark,
    remark->>'$.family' as family,
    remark->>'$.family[0].name' as family2
  from Emp e
 where json_contains(remark, '19', '$.age');

-- Error Code: 3141. Invalid JSON text in argument 2 to function json_contains: "Invalid value." at position 0.

-- JSON_REPLACE() 함수
select json_replace(remark, '$.age', 1) a1,
    json_replace(remark, 
        '$.age', 2, 
        '$.addr', '대구',
        '$.family[0].name', concat(remark->>'$.family[0].name', '님')) a2
  from Emp where remark->'$.age' > 10;

-- JSON_OBJECT() 함수와 JSON_ARRAY() 함수 
-- 인라인 패스(Inline Path)
-- JSON_EXTRACT() 함수
-- JSON_SEARCH() 함수
-- JSON_CONTAINS() 함수
-- JSON_REPLACE() 함수
-- JSON_INSERT(), JSON_SET(), JSON_REMOVE() 함수
-- JSON_MERGE(), JSON_MERGE_PRESERVE(), JSON_MERGE_PATCH() 함수
-- update: JSON_INSERT(), JSON_SET(), JSON_REMOVE()
select remark, 
    json_insert(remark, '$.age', 29) json_insert_age,
    json_set(remark, '$.age', 29) json_set_age
  from Emp where remark is not null;
  
select remark, 
    json_remove(remark, '$.family[0]'),
    JSON_SET(remark, '$.family[0]', null)
  from Emp where remark is not null;
  
-- merge: JSON_MERGE(), JSON_MERGE_PRESERVE(), JSON_MERGE_PATCH() 함수
select remark, 
    json_merge(remark, json_object('id', id), json_object('addr', '충남'))
  from Emp where id = 1;
  
-- merge: JSON_MERGE() 함수 동일키 -> 배열
select remark, 
    json_merge(remark,
        json_object('id', id),
        json_object('addr', (case id when 1 then '충남' else '부산' end))
    ) merged_json
  from Emp where id <= 2;
  
-- merge: JSON_MERGE_PRESERVE() 함수, 기존 것 유지
select remark, 
    json_merge_preserve(remark,
        json_object('id', id),
        json_object('addr', '대구')
    ) meged_json
 from Emp where id = 3;
  
-- merge: JSON_MERGE_PATCH() 함수, 기존 것 대치
select remark, 
    json_merge_patch(remark,
        json_object('id', id),
        json_object('addr', '속초')
    ) meged_json
 from Emp where id = 4;
  
select remark from Emp
 where remark is not null
 order by remark->>'$.age';
 
select json_valid('[ {"id": 1, "age": 29, "addr": "서울"}, {"id": 2, "age": 39, "no": 99} ]');
 
-- JSON_TABLE() 함수
select *
  from json_table(
    '[ {"id": 1, "addr": "서울"}, {"id": 2, "age": "xx", "no": 5, "arr": [1, 9]} ]',
    '$[*]'
    COLUMNS( 
        rownum FOR ORDINALITY,
        j_id   INT PATH '$.id',
        j_age  INT PATH '$.age' DEFAULT '1' ON EMPTY   DEFAULT '999' ON ERROR,
        j_addr VARCHAR(9) PATH '$.addr' DEFAULT '"비었음"' ON EMPTY DEFAULT '"에러"' ON ERROR,
        j_num  INT EXISTS PATH '$.no'
    )
  ) as jtbl;
  
select *
  from Json_Table(
    '[ {"id": 1, "addr": "서울"}, {"id": 2, "age": "xx", "no": 5} ]',
    '$[*]'
    COLUMNS( 
        rownum FOR ORDINALITY,
        j_id   INT PATH '$.id',
        j_age  INT PATH '$.age' DEFAULT '1' ON EMPTY   DEFAULT '999' ON ERROR,
        j_addr VARCHAR(9) PATH '$.addr' DEFAULT '"비었음"' ON EMPTY DEFAULT '"에러"' ON ERROR,
        j_num  INT EXISTS PATH '$.no'
    )
  ) as jtbl
            inner join Emp e on jtbl.j_id = e.id
  order by jtbl.j_id;

  

 
-- JSON_ARRAYAGG(), JSON_OBJECTAGG() 함수
select json_arrayagg(remark)
 from Emp where remark is not null;
 
select json_objectagg(ename, salary)
 from Emp;
 
-- JSON_STORAGE_FREE(), JSON_STORAGE_SIZE() 함수
select id, remark->>'$.age' as age, charset(remark) chrset, remark,
    json_storage_free(remark) sf,
    json_storage_size(remark) ss, LENGTH(remark) len
  from Emp where remark is not null
 order by remark->>'$.age';
 
update Emp set remark = json_set(remark, '$.addr', '대전광역시') where id = 1;
update Emp set remark = json_set(remark, '$.addr', '대') where id = 1;

select id, remark,
    json_storage_free(remark) sf,
    json_storage_size(remark) ss, length(remark) len
  from Emp
 where id = 1;

select remark, remark->>'$.addr', 
    json_merge_patch(remark, json_object('addr', substring(remark->>'$.addr', 1, 1))) from Emp
-- update Emp set remark = json_merge_patch(remark, json_object('addr', substring(remark->>'$.addr', 1, 1)))
 where id in (1,2);

select CHARSET(remark), COLLATION(remark) from Emp where remark is not null;
-- alter table Emp drop column remark;


select @@global.port, @@global.mysqlx_port, @@global.socket,  @@global.mysqlx_socket;

show processlist;

rename table T to Test;

desc ttt;

select * from Emp;

select sha2('abcd', 512), length(sha2('abcd', 512));

alter table Emp add column extra varchar(255);

update Emp set extra='00006004ef6f0000000000000001' where id=1;

select doc, doc->>'$.addr', json_value(doc, '$.addr')
  from empextra where _id = '00006004ef6f0000000000000001';

select e.id, e.ename, ex.doc->>'$.addr' addr
  from Emp e inner join empextra ex on e.id = ex.doc->>'$.id';

-- alter table Emp drop column extra;
select * from Emp;
select * from empextra;

truncate table empextra;

create table User like mydealdb.User;
create table Chat(
  id int unsigned not null auto_increment Primary key,
  message varbinary(32) not null);
  
create table ChatUser(
  id int unsigned not null auto_increment Primary key,
  chat int unsigned not null,
  user int unsigned not null,
  lastread bigint not null default 0,
  chatname varchar(63) null
);

select * from Chat;
select * from ChatUser;
  
select doc->>'$.msgs[*]', json_extract(doc, '$.msgs[*].id'), json_extract(doc, '$.msgs[0]', '$.msgs[1]') from message;
select doc->>'$.msgs', json_value(doc, '$.msgs') from message;
select json_search(doc, 'all', 'msgs'), json_keys(doc, '$'), json_length(doc, '$.msgs') from message;

select json_search(doc, 'one', '99084618157785115'), json_search(doc->>'$.msgs[*].id', 'all', '99084618157785115') from message;

select doc->>'$.msgs[*].id', json_contains(doc->>'$.msgs[*].id', '99084618157785115'),
  json_contains(doc->>'$.msgs[*].id', '99084618157785114') from message;

select doc->>'$.msgs' from message where json_contains(doc->>'$.msgs[*].id', '99084618157785115');
select doc from message where doc->>'$.msgs[*].id' = '99084618157785115';

select json_extract(doc, "$.msgs[2]"), json_extract(doc->>'$.msgs', "$[2]"),
    JSON_SEARCH(doc, 'one', '333') from message where doc->>'$.chat' = 4;
    
select doc, json_extract(doc, '$.msgs[*].id'), 
    replace(replace(replace(json_extract(doc, '$.msgs[*].id'), ', ', '", "'), '[', '["'), ']', '"]'),
   JSON_SEARCH(replace(replace(replace(json_extract(doc, '$.msgs[*].id'), ', ', '", "'), '[', '["'), ']', '"]'), 'one', 2) from message;
   
SELECT REPLACE(JSON_SEARCH(doc, 'one', '333'), '.msg"', '.id"') from message;
SELECT json_value(doc, REPLACE(JSON_SEARCH(doc, 'one', '333'), '.msg"', '.id"') ) from message;
SELECT JSON_EXTRACT(doc, REPLACE(JSON_SEARCH(doc, 'one', '333'), '.msg"', '.id"')) from message;

select m.doc->>'$.chat', msg.* 
  from message m, 
       json_table( doc, "$.msgs[*]" 
        columns(id int path '$.id', sender int path '$.sender',
                msg varchar(4096) path '$.msg', sentdt timestamp path '$.sentdt')) as msg
 where m.doc->>'$.chat' = 1;
 
select * from v_msg where chat = 2;
select doc->'$.pins', json_value(doc, '$.pins') from message where doc->>'$._id'=3;

select m.doc, t.pin from message m, json_table(doc, '$.pins[*]' columns( pin int path '$')) as t where doc->>'$._id' = 3;

-- pin messages
select * from v_msg v
 where v._id = 8 
   and v.id in
    (select t.pin from message, json_table(doc, '$.pins[*]' columns( pin bigint path '$')) as t where doc->>'$._id' = 8);
    
-- 목록
select * from v_msg where chat = 4 order by id desc limit 2;

select * from v_msg where chat = 2 and id in (select json_value(doc, '$.pins') from message where doc->>'$._id' = 3);
select * from v_msg where chat = 2 and id in (10, 15);
select doc->>'$.msgs[*].sender' from message;
select uuid(), uuid_to_bin(uuid()), hex(uuid());
select uuid(), f_uuid(), uuid_short(), ~0;
select uuid_short(), convert(9.908461815778512e16, unsigned integer),
    cast(99084618157785121 as unsigned integer), cast(uuid_short() as char);

select * from Test;
alter table Test add column t text(2)
-- update Test set uid=uuid_short() where id=5;

select id from v_msg where chat=4 order by id desc limit 1;
select * from v_msg where _id=8;

-- msg.modify('_id=3').arrayAppend('msgs', {id: mysqlx.expr("ifnull(json_length(msgs),0) + 1"), msg: '334'})
-- msg.modify('_id=4').set('chat', mysqlx.expr('uuid_short()'));
-- msg.modify('_id=4').set('msgs[1].sentdt', mysqlx.expr("current_timestamp()"))
select count(*) from Emp;
explain select * from Emp where id = 10;
explain select * from Dept d inner join Emp e on d.id = e.dept where e.id=10;
explain select * from Dept where id in (select distinct dept from Emp);
explain select * from Emp where id = 1 UNION select * from Emp where id = 2;
explain select * from Emp where ename = '홍길동';
explain select * from Emp where dept = 1;
select * from Emp where ename = '홍길동';


select * from Emp where dept > 1;
select * from Emp where dept > 1 limit 5 offset 10;

show index from Emp;
show table status where Name in ('Emp', 'User');
analyze table Emp;

show global status like 'Innodb_pages%';
select * from Emp where dept = 5 order by ename;
show global status like 'Innodb_pages_read';
select 261 * 62;

explain select * from Emp where dept = 5 order by ename;

explain select * from Emp where id in (select distinct captain from Dept);
explain select * from Emp e where exists (select distinct captain from Dept where captain = e.id);

select * from Emp where id in (select distinct captain from Dept);
select * from Emp e where  not exists (select distinct captain from Dept where captain = e.id);

select * from Emp;

drop index idx_Emp_dept_ename on Emp;
alter table Emp DROP index idx_Emp_dept_ename;
-- Error Code: 1553. Cannot drop index 'idx_Emp_dept_ename': needed in a foreign key constraint

create table Notice(
  id int unsigned not null auto_increment Primary Key,
  createdate timestamp not null default CURRENT_TIMESTAMP comment '작성일',
  workdate timestamp not null default CURRENT_TIMESTAMP on Update CURRENT_TIMESTAMP comment '수정일',
  title varchar(255) not null comment '제목',
  writer int unsigned null comment '작성자',
  contents text null comment '내용'
);

ALTER TABLE Notice ADD CONSTRAINT fk_Notice_user
  FOREIGN KEY (writer) REFERENCES User(id) ON DELETE SET NULL;

insert into Notice(title, contents) values('세종대왕', '조선의 제4대 국왕이다.');
insert into Notice(title, contents) values('단군', '단군왕검(檀君王儉)은 한민족의 시조이자 고조선(古朝鮮)의 국조(國祖), 대종교의 시작.');
insert into Notice(title, contents) values('정약용', '조선 후기의 문신이자 실학자·저술가·시인·철학자·과학자·공학자이다.');
insert into Notice(title, contents) values('계백', '백제 말기의 군인이다.');
insert into Notice(title, contents) values('이순신', '조선 중기의 무신이었다. 본관은 덕수(德水), 자는 여해(汝諧), 시호는 충무(忠武).');
insert into Notice(title, contents) values('김유신', '신라의 화랑의 우두머리였으며 태대각간(太大角干)이었고 신라에 귀순한 가야 왕족의 후손.');
-- show create table Notice;
show index from Notice;

CREATE FULLTEXT INDEX ft_idx_Notice_contents on Notice(title, contents);
drop index ft_idx_Notice_contents on Notice;
select * from Notice;
explain select * from Notice where contents like '%조선%';
select id, title, contents from Notice where contents like '%조선%';
select * from Notice where match(title, contents) against('조선');
select * from Notice where match(contents) against('한민족의');

show variables like 'innodb_ft%';
show variables like 'innodb_ft_aux_table';
-- select * from iformation_schema.innodb_ft_default_stopword;

select * from Notice where match(title, contents) against('조선');
select * from Notice where match(title, contents) against('세종' IN NATURAL LANGUAGE MODE);
select * from Notice where match(title, contents) against('조선' IN BOOLEAN MODE);
select * from Notice where match(title, contents) against('조선*' IN BOOLEAN MODE);
select * from Notice where match(title, contents) against('계백' IN BOOLEAN MODE);
select * from Notice where match(title, contents) against('무신*' IN BOOLEAN MODE);
select * from Notice where match(title, contents) against(concat('세종', '*') IN BOOLEAN MODE);
select * from Notice where match(title, contents) against('대종교' IN BOOLEAN MODE);

show variables like 'innodb_optimize_fulltext_only';
SET GLOBAL innodb_optimize_fulltext_only=ON;
OPTIMIZE TABLE Notice;
          
set global innodb_ft_aux_table = 'testdb/Notice';
select * from information_schema.innodb_ft_index_table;
select * from information_schema.innodb_ft_index_table where word='조선';

create table StopWord(value varchar(31) not null);

truncate table StopWord;
select * from StopWord;
select value, count(*) from StopWord group by value having count(*) > 1;
-- set global innodb_ft_server_stopword_table='mydealdb/StopWord';

drop table Notice;
drop table StopWord;


-- Partition --------------------------------------------------------
create table PartiRangeTest (
  studentno varchar(7) not null,
  enteryear smallint not null,
  studentname varchar(31) not null )
  
  partition by RANGE(enteryear) (
    partition p1 values less than(2000),
    partition p2 values less than(2010),
    partition p3 values less than MAXVALUE
);

insert into PartiRangeTest(studentno, enteryear, studentname)
  values ('8809080', 1988, '팔팔학번'),
         ('0809080', 2008, '공팔학번'),
         ('1809080', 2018, '일팔학번');

select * from PartiRangeTest;

select * from information_schema.partitions
 where table_name='PartiRangeTest';

explain select * from PartiRangeTest where enteryear = 2018;
select * from PartiRangeTest where enteryear = 2018;

explain select * from PartiRangeTest where studentno = '0809080';
select * from PartiRangeTest where studentno = '0809080';

delete from PartiRangeTest where enteryear = 2010;

create table PartiListTest (
  studentno varchar(7) not null,
  dept varchar(31) not null)
  
  partition by LIST COLUMNS (dept) (
    partition p1 values IN ('컴공', '산공'),
    partition p2 values IN ('사학', '철학')
);

insert into PartiListTest(studentno, dept)
  values ('8809080', '컴공'),
         ('0809080', '산공'),
         ('1809080', '철학');

select * from PartiListTest;

select * from information_schema.partitions
 where table_name='PartiListTest';

explain select * from PartiListTest where dept='컴공';

alter table PartiRangeTest
    REORGANIZE Partition p3 INTO (
        partition p3 values less than (2020),
        partition p4 values less than MAXVALUE
    );

optimize table PartiRangeTest;
    
select * from information_schema.partitions
 where table_name='PartiRangeTest';

explain select * from PartiRangeTest where enteryear = 2009;

Alter table PartiRangeTest
    REORGANIZE Partition p1, p2 INTO (
        partition p1_2 values less than(2010)
    );

optimize table PartiRangeTest;
    
select * from information_schema.partitions
 where table_name='PartiRangeTest';

explain select * from PartiRangeTest where enteryear = 2009;

Alter table PartiRangeTest DROP Partition p1_2;

optimize table PartiRangeTest;
    
select * from information_schema.partitions
 where table_name='PartiRangeTest';

drop table PartiRangeTest;
drop table PartiListTest;
desc Test;
select * from Test;
select * from Test where id < 1;
insert into Test(ttt, dept) values ('bbb', 5), ('ccc', 6);
update Test set ttt='CCC' where id = 7;
delete from Test where id = 6;
delete from Test where id=4;
delete from Test where id=3;
delete from Test where id=2;

select * from Dept;
update Dept set empcnt=21 where id=14;
delete from Dept where id = 14;

use mydealdb;
select * from Dept;

drop table Dept;

use testdb;

drop table Test;
show binary logs;

show databases;

create table Test (
  id int unsigned not null auto_increment Primary Key,
  ttt varchar(31) not null,
  dept tinyint unsigned not null
);

insert into Test(ttt, dept)
         values ('aaa1', 3), ('aaa2', 4), ('aaa3', 5),
                ('aaa4', 6), ('aaa5', 7);

delete from Test where id in (3,4,5);

select * from Test;

delete from Test where id in (6,7);

insert into Test(ttt, dept) values ('bbb', 5), ('ccc', 6);
update Test set ttt='CCC' where id = 7;

insert into Test(ttt, dept) values('씨씨뷐', 7);

delete from Test where id > 0;