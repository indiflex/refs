use testdb;
create table Test (
  id int unsigned not null auto_increment Primary Key,
  ttt varchar(31) not null,
  dept tinyint unsigned not null
);

insert into Test(ttt, dept)
         values ('aaa1', 3), ('aaa2', 4), ('aaa3', 5),
                ('aaa4', 6), ('aaa5', 7);

delete from Test where id in (3,4,5);

-- -------------------------------- fullbackup
select * from Test;

insert into Test(ttt, dept) values ('bbb', 5), ('ccc', 6);

update Test set ttt='CCC' where id = 7;

-- -------------------------------- mistake
delete from Test where id > 0;

delete from Test where id in (6,7);

select @@server_id;
show master status;

