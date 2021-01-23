select * from Emp where id < 5;

alter table Emp add column remark JSON;

desc Emp;

select json_valid('{"addr": "서울", "age": 20, "didreg": ["XX", 2, 3]}');

select '{"addr": "서울", "age": 20, "didreg": ["XX", 2, 3]}', json_pretty('{"addr": "서울", "age": 20, "didreg": ["XX", 2, 3]}');

update Emp set remark = '{"addr": "서울"}'
 where id = 1;

update Emp set remark = '{"addr": "부산", "age": 39}'
 where id = 2;
 
update Emp set remark = '{"addr": "대구", "age": 29, "family": [ {"name": "논개", "relation": "모"} ]}'
 where id = 3;
 
update Emp set remark = '{"addr": "강원", "age": 49, "family": [  {"name": "조조", "relation": "부"},  {"name": "배철균", "relation": "모"} ]}'
 where id = 4;
 
update Emp set remark = '{"addr": "서울", "addr": "대전"}'
 where id = 1;  
 
update Emp set remark = json_object('addr', "부산", "age", 38)
 where id = 2;
 
select * from Emp where id < 5;

-- '{"addr":  [ {"name": "논개", "relation": "모"} ]}'
update Emp set remark = json_object('addr', "대구", "age", 28, 
            "family", json_array(
                json_object('name', '논개', 'relation', '모')
            )) 
 where id = 3;
 
update Emp set remark = json_object('addr', "강원", "age", 48, 
            "family", json_array(
                json_object("name", "조조", "relation", "부"), 
                json_object("name", "배철균", "relation", "모")
            ))
 where id = 4;

select remark,
    remark->'$.addr',
    remark->>'$.addr',
    json_value(remark, '$.addr'),
    json_value(remark, '$.age' returning decimal(4,2)),
    json_extract(remark, '$.addr'),
    json_unquote(json_extract(remark, '$.addr'))
  from Emp
 where remark is not null;

select remark,
    json_type(remark->'$.addr'),
    json_type(remark->'$.age'),
    json_type(remark->'$.family')
  from Emp
 where remark is not null;
 
select remark,
    json_length(remark),
    json_depth(remark),
    json_keys(remark)
  from Emp
 where remark is not null;
 
select remark,
    json_search(remark, 'one', '부산'),
    json_search(remark, 'one', '배철균'),
    json_value(remark, "$.family[0].name")
  from Emp
 where remark is not null;

select remark,
    json_contains(remark, '"부산"', '$.addr'),
    json_contains(remark, '48', '$.age')
  from Emp
 where remark is not null;
 
select * from Emp where json_contains(remark, '48', '$.age');
select * from Emp where json_value(remark, '$.age') = 48;
select * from Emp where remark->>'$.age' = 48;

select json_replace(remark, '$.age', remark->>'$.age' * 100) 
  from Emp where remark->>'$.age' > 40;
  
select remark,
    json_insert(remark, '$.age', 10),
    json_set(remark, '$.age', 100)
 from Emp where remark is not null;
 
select remark,
    json_remove(remark, '$.family[0]'),
    json_remove(remark, '$.addr')
 from Emp where remark is not null;
 
select remark,
    json_merge( remark, json_object('id', id) )
  from Emp where remark is not null;
  
select json_merge(remark, '{}')  from Emp where remark is not null;

select remark,
    json_merge_preserve( remark,
        json_object('id', id),
        json_object('addr', '대구')
    )
 from Emp where remark is not null;
 
select remark,
    json_merge_patch( remark,
        json_object('id', id),
        json_object('addr', '대구')
    )
 from Emp where remark is not null;
 
-- json_table( json-data-string, json-path($[*]) columns( col1 int .... default val on [ empty | error ]) ) 
select * from
    json_table('[{"id":1,"addr":12},{"id":2,"age":20, "no": "xx"}]',
        '$[*]'
        columns(
            rownumxx for ordinality,
            j_id int path '$.id',
            j_age int path '$.age' default '999' on empty,
            j_addr varchar(9) path '$.addr' default '"비었음"' on empty  default '"에러!"' on error,
            j_num tinyint exists path '$.no' default '0' on empty default '-1' on error
        )
    ) jtbl
      inner join Emp e on jtbl.j_id = e.id
    ;
    
select json_arrayagg(remark)
  from Emp where remark is not null;

select json_objectagg(concat('sal', id), salary)
  from Emp where remark is not null;
  
-- 12:  [1][2]
-- 12345: [1][2][3][4][5]
-- 123: [1][2][3][][]
select remark,
    json_storage_free(remark), 
    json_storage_size(remark), length(remark)
from Emp where remark is not null;

update Emp set remark = json_object('addr', '서울특별시')
 where id =1;
 
update Emp set remark = json_set(remark, '$.addr', '서울')
 where id =1;


select * from Emp where id < 5;