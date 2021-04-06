use tloan;

select * from tloan.Comp;

insert into tloan.Comp
select 3, createdate, workdate, compgroup, '㈜비에스앤파트너스', 'BS&Partners', '비에스앤파트너스', comptype, state, tel, mobile, email, 
corpno, fax, homepage, emp, ceo, zipcode, addr, logo, judge, smstel, smsamt from tloan.Comp where id = 2;

select * from Emp where isdel=1;

select * from Emp where isdel=0 and emprank is null;

select * from Emp where cid=3;

update Emp set passwd=sha2(md5('1234'), 256), state=36 where id=17;

select sha2(md5('1234'), 256);
select * from Folder;

select * from Emp where (email='bsnpartners' or oldid='bsnpartners') and passwd=sha2(md5('1234'), 256)
 and isdel=0 and state in (select v.id from v_code v where v.kk < 9);
 
select * from v_code v where v.kk < 9;

select c.*,
       'KEB하나은행 249-910012-65304 (주)인에이블자산대부' account0, 
       'KEB하나은행 393-910041-79204 (주)인에이블자산대부' account1
  from Comp c where id = 3;