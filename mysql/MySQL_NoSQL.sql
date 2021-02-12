select * from Chat;
select * from ChatUser;
select * from User;
drop table Agent;

insert into User(name, tel1, tel2, tel3, addr, loginid, passwd)
          values('김일수', '010', '1111', '1111', '서울 관악구', 'user1', sha2('1111', 512));
          
insert into User(name, tel1, tel2, tel3, addr, loginid, passwd)
          values('김이수', '010', '2222', '2222', '서울 도봉구', 'user2', sha2('2222', 512));

insert into User(name, tel1, tel2, tel3, addr, loginid, passwd)
          values('김삼수', '010', '3333', '3333', '서울 금천구', 'user3', sha2('3333', 512));
          
select uuid_short(), uuid_short();

select * from message;

select m.doc->>'$._id' as chat, jtm.*
  from message m, 
   JSON_TABLE(m.doc, '$.msgs[*]'
      COLUMNS ( id varchar(20) path '$.id',
                sender int path '$.sender',
                sentdt timestamp path '$.sentdt',
                mtype char(1) path '$.mtype',
                receivers JSON path '$.receivers',
                msg text path '$.msg')
    ) as jtm
 where m.doc->>'$._id' = 1;
 
select * from v_msg where chat = 1 order by id desc limit 10;

select id from v_msg where chat = 1 order by id desc limit 1;

select f_lastmsgid(1);

-- 발신자 이름 구하기
select v.*, u.name senderName
  from v_msg v inner join User u on v.sender = u.id
 where v.chat = 1;
 
select t.*
  from message, json_table(doc, '$.pins[*]' columns( pin varchar(20) path '$')) as t
 where doc->>'$._id' = 1;
 
-- 핀된 대화 목록
select v.*
  from v_msg v
 where v.chat = 1
   and v.id in (select t.pin
                  from message, json_table(doc, '$.pins[*]' columns( pin varchar(20) path '$')) as t
                 where doc->>'$._id' = 1);
                 
-- 대화방 목록
select c.remark, cu.chatname, v.sentdt, v.msg
  from Chat c inner join ChatUser cu on c.id = cu.chat 
              inner join v_msg v on c.id = v.chat and v.id = f_lastmsgid(c.id)
 where cu.user = 1;
 
 