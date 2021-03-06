\use testdb
db.getTables()
db.Dept.select()
db.Dept.select().limit(3)
db.Dept.select('dname').limit(3)
db.Dept.select(['id', 'dname']).limit(3)
db.Dept.select('dname').orderBy(['pid', 'empcnt desc')
db.Dept.select('dname').orderBy(['pid', 'empcnt desc'])
db.Dept.select().orderBy(['pid', 'empcnt desc'])
db.Dept.select().where("pid = 1")
db.Dept.select().where("pid = 1 and empcnt > 50")
db.Dept.select().where("dname like 'DB%'")
db.Emp.select().limit(10)
db.Emp.select(['id', 'name', 'salary']).limit(10)
db.Emp.select(['id', 'ename', 'salary']).limit(10)
db.Emp.select(['id', 'ename', 'salary * 10000']).limit(10)
db.Emp.select(['id', 'ename', 'format(salary * 10000, 0)']).limit(10)
db.Emp.select(['id', 'ename', 'format(salary * 10000, 0) sal']).limit(10)
db.Emp.select(['id', 'ename', 'format(salary * 10000, 0) as sal']).limit(10)
db.Emp.select(['ename', 'format(salary * 10000, 0) as sal']).limit(10)
db.Dept.select().limit(3)
db.Dept.select().limit(3).offset(2)
db.Dept.select().where("dname like 'DB%'")
db.Dept.select().where("dname like :dname")
db.Dept.select().where("dname like :dname").bind('dname', 'DB%')
db.Dept.select().where("id between :sid and :eid").bind('sid', '3').bind('edi', 5)
db.Dept.select().where("id between :sid and :eid").bind('sid', '3','edi', 5)
db.Dept.select().where("id between :sid and :eid").bind('sid', '3').bind('eid', 5)
db.Dept.select().where("dname like :dname").bind('dname', 'DB%')
db.Dept.select().where("id between :sid and :eid").bind('sid', '3').bind('eid', 5)
db.Dept.select().where("id between :sid and :eid") \
\desc Dept
\sql desc Dept
db.Dept.insert('pid', 'dname', 'captain').values(1, '영업4팀', null)
db.Dept.select()
db.Dept.insert('pid', 'dname', 'captain').values(1, '영업5팀', None)
db.Dept.insert('id', 'pid', 'dname', 'captain').values(None, 1, '영업4팀', null)
db.Dept.update().set('captain', 1).where('id=15')
db.Dept.select()
db.Dept.update().set('captain', 1).set('empcnt', 100).where('id=15')
db.Dept.select().orderBy('id desc').limit(5)
db.Dept.delete().where('id=15')
db.Dept.select().orderBy('id desc').limit(5)
\history
\option --persist history.autoSave=1
\quit
\use testdb
db.createCollection('message')
db.message.add({chat: 1, msgs:[ {id: 1, sender:1, sentdt: CURRENT_TIMESTAMP(), msg: '111'} ]})
db.message.add({chat: 1, msgs:[ {id: 1, sender:1, sentdt: new Date(), msg: '111'} ]})
db.message.find()
db.Chat
db.Chat.insert('message').values("00006004ef6f0000000000000002");
db.Chat.select()
db.getTables()
db.Chat.select()
db.Chat.insert('message').values("00006004ef6f0000000000000002");
db.Chat.select()
db.message.find()
mysql_insert_id()
db.mysql_insert_id()
db.message.mysql_insert_id()
db.message.add({chat: 1, msgs:[ {id: 1, sender:1, sentdt: now(), msg: '111'} ]})
db.message.add({chat: 1, msgs:[ {id: 1, sender:1, sentdt: now(), msg: concat('111', '222')} ]})
db.message.add({chat: 1, msgs:[ {id: 2, sender:1, sentdt: new Date(), msg: concat('111', '222')} ]})
db.message.add({chat: 1, msgs:[ {id: 2, sender:1, sentdt: 'now()', msg: '222'} ]})
msg=db.message
msg.find()
msg.find('msgs["id"]=2')
msg.find('msgs')
msg.find('msgs[1]')
msg.find('msgs[*]')
msg.find('msgs[*][id] = 2')
msg.find('msgs[*]["id"] = 2')
msg.find('msgs[*].id = 2')
msg.find('msgs.id = 2')
msg.find('msgs[*].id = 2')
msg.find('$.msgs[*].id = 2')
msg.find('$.msgs[*][].id = 2')
msg.find('$.msgs[*].id = 2')
msg.find('chat=1')
msg.find('msgs[]')
msg.find('msgs[*]')
msg.find('msgs[]')
msg.find('msgs.[]')
msg.find('msgs.[*]')
msg.find('msgs[1]')
msg.find('msgs[1].id=1')
msg.removeOne('00006004ef6f0000000000000003')
msg.find()
f = msg.find('_id="00006004ef6f0000000000000002"')
f
f.msgs
f.msgs[*]
f.fields('msgs')
f.fields('msgs').arrayAppend({id:2, msg:'222',sentdt: new Date()})
msg.last_insert_id()
t = db.getCollectionAsTable('message')
t.last_insert_id()
t.select()
t.select('msgs')
t.select('doc->msgs')
t.select('doc->$.msgs')
t.select('doc->"$.msgs"')
t.select("doc->'$.msgs'")
t.select("doc->>'$.msgs'")
t.getAutoIncrementValue()
mysqlx.Result()
session
msg.find()
msg.modify('_id="00006004ef6f0000000000000002"').arrayAppend({id:2, sender:2, msg: '222'}_
msg.modify('_id="00006004ef6f0000000000000002"').arrayAppend({id:2, sender:2, msg: '222'})
msg.modify('_id="00006004ef6f0000000000000002"').arrayAppend(msgs, {id:2, sender:2, msg: '222'})
msg.modify('_id="00006004ef6f0000000000000002"').arrayAppend('msgs', {id:2, sender:2, msg: '222'})
msg.find()
msg.find('_id="00006004ef6f0000000000000002"')
msg.find('_id="00006004ef6f0000000000000002"').find('chat=1')
msg.find('_id="00006004ef6f0000000000000002" and chat=1')
msg.find('_id="00006004ef6f0000000000000002" and msgs')
msg.find('_id="00006004ef6f0000000000000002" and msgs[0]')
msg.find('_id="00006004ef6f0000000000000002" and chat=1')
msg.find('_id="00006004ef6f0000000000000002" and msgs.id=1')
msg.find('_id="00006004ef6f0000000000000002" and msgs[].id=1')
msg.find('_id="00006004ef6f0000000000000002" and msgs[*].id=1')
msg.find('_id="00006004ef6f0000000000000002" and msgs.*.id=1')
msg.find('_id="00006004ef6f0000000000000002" and msgs.$.id=1')
msg.find('_id="00006004ef6f0000000000000002" and msgs.id=1')
msg.find('_id="00006004ef6f0000000000000002" and msgs[*].id=1')
msg.find('_id="00006004ef6f0000000000000002" and msgs[id]=1')
msg.find('_id="00006004ef6f0000000000000002" and msgs["id"]=1')
msg.find('_id="00006004ef6f0000000000000002" and msgs."id"=1')
msg.find('_id="00006004ef6f0000000000000002" and msgs.length > 1')
msg.find('_id="00006004ef6f0000000000000002" and msgs.length > 0')
msg.find('_id="00006004ef6f0000000000000002" and length(msgs) > 0')
msg.find('_id="00006004ef6f0000000000000002" and length(msgs) > 1')
msg.find('_id="00006004ef6f0000000000000002" and length(msgs) > 2')
msg.find('_id="00006004ef6f0000000000000002" and length(msgs) > 3')
msg.find('_id="00006004ef6f0000000000000002" and len(msgs) > 3')
msg.find('_id="00006004ef6f0000000000000002" and msgs.length > 3')
msg.find('_id="00006004ef6f0000000000000002" and msgs.length > 0')
msg.find('_id="00006004ef6f0000000000000002" and msgs.length')
msg.find('_id="00006004ef6f0000000000000002" and msgs > 0')
msg.find('_id="00006004ef6f0000000000000002" and msgs.id > 0')
msg.find('_id="00006004ef6f0000000000000002" and msgs.*.id > 0')
msg.find('_id="00006004ef6f0000000000000002" and msgs.*')
msg.find('_id="00006004ef6f0000000000000002" and msgs[1]')
msg.find('_id="00006004ef6f0000000000000002" and msgs[1].id=1')
msg.find('_id="00006004ef6f0000000000000002" and msgs[*.*].id=1')
msg.find('_id="00006004ef6f0000000000000002" && msgs[1].id=1')
msg.find('_id="00006004ef6f0000000000000002" && msgs[0]')
msg.find('_id="00006004ef6f0000000000000002" and msgs[0]')
msg.find('_id="00006004ef6f0000000000000002" and msgs[0]["id"]')
msg.find('_id="00006004ef6f0000000000000002" and msgs[0]["id"] = 1 ')
msg.find('_id="00006004ef6f0000000000000002" and msgs["id"] = 1 ')
msg.find('_id="00006004ef6f0000000000000002" and msgs[0] = 1 ')
msg.find('_id="00006004ef6f0000000000000002" and msgs[0]')
msg.find('_id="00006004ef6f0000000000000002" and $.msgs[0]')
msg.find()
msg.add({chat:2, msgs: [ {             "id": 1,             "msg": "111",             "sender": 1,             "sentdt": "2021-02-10 19:07:31.976000"         }]}) ;
msg.find()
msg.find('_id="00006004ef6f0000000000000002" and $.msgs[0]')
msg.find('_id="00006004ef6f0000000000000002" and $.msgs')
msg.find('_id="00006004ef6f0000000000000002" and msgs')
msg.find('_id="00006004ef6f0000000000000002" and msgs[0][id]=1')
msg.find('_id="00006004ef6f0000000000000002" and msgs.$[id]=1')
msg.find('_id="00006004ef6f0000000000000002" and msgs.$.[id]=1')
msg.find('_id="00006004ef6f0000000000000002" and msgs.$.id=1')
msg.find('msgs')
msg.find('msgs[0]')
msg.find('msgs[0].id=1')
msg.find('msgs[0].id=2')
msg.find('msgs[1].id=2')
msg.find('msgs[*].id=2')
msg.find('msgs[].id=2')
msg.find('msgs["*"].id=2')
msg.find('msgs[*].id=2')
msg.find('msgs[1].id=2')
msg.find('msgs[].id=2')
msg.find('msgs.id=2')
msg.find('msgs[id]=2')
msg.find('msgs["id"]=2')
msg.find('msgs.id=2')
msg.find('msgs[1].id=2')
msg.find('msgs["*.*'].id=2')
msg.find('msgs["*.*"].id=2')
msg.find('msgs[*.*].id=2')
msg.find('msgs.*.id=2')
msg.find('msgs.id=2')
msg.find('msgs[*.id]=2')
msg.find('msgs[*id]=2')
msg.find('msgs[id]=2')
msg.find('msgs["id"]=2')
msg.find('msgs.id=2')
msg.find('msgs[].id=2')
msg.find('msgs[*].id=2')
msg.find('msgs.length=2')
msg.find('msgs.length=1')
msg.find('msgs.length')
msg.find("JSON_CONTAINS($.chat, :chat)").bind("chat", 1)
msg.find("JSON_CONTAINS($.chat, :chat)").bind("chat", '1)
msg.find("JSON_CONTAINS($.chat, :chat)").bind("chat", '1')
msg.find("JSON_CONTAINS($.chat, :chat)").bind("chat", '2')
msg.find("JSON_CONTAINS($.msgs, :chat)").bind("chat", '2')
msg.find("JSON_CONTAINS($.msgs.id, :chat)").bind("chat", '2')
msg.find("JSON_CONTAINS($.msgs, :chat)").bind("chat", 'id=2')
msg.find("JSON_CONTAINS($.msgs.id, :chat)").bind("chat", '2')
msg.find("JSON_CONTAINS($.msgs, :chat)").bind("chat", 'id:2')
msg.find("JSON_CONTAINS($.msgs, :chat)").bind("chat", '{id:2}')
msg.find().sort('msgs')
msg.find().sort('_id')
msg.find().sort('_id desc')
msg.find().sort('msgs')
msg.find().sort('msgs.id')
msg.find().sort('msgs.id desc')
msg.find().sort('chat desc')
msg.find().fields('msgs')
msg.find().fields('msgs[0..1]')
msg.find().fields('msgs[0 .. 1]')
msg.find().fields('msgs[0]')
msg.find().fields('msgs.length')
msg.find().fields('msgs.id')
msg.find().fields('msgs[].id')
msg.find().fields('msgs[$].id')
msg.find().fields('msgs["$"].id')
msg.find().fields('msgs["id"]')
msg.find().fields('msgs.id')
msg.find().fields('msgs').fields('id')
msg.find().fields('msgs[*}')
msg.find().fields('msgs[*]')
msg.find().fields('msgs[*].id')
msg.find('msgs[*].id')
msg.find('msgs[*].id = 2')
msg.find('msgs[].id = 2')
msg.find('msgs[*].id = "2"')
msg.find('msgs[*]["id'} = 2')
msg.find('msgs[*]["id'] = 2')
msg.find('msgs[*]["id"] = 2')
msg.find('msgs[1].id = 2')
msg.find('msgs[1].id = 2').fields('id')
msg.find('msgs[1].id = 2').fields('msgs.id')
msg.find('msgs[1].id = 2').fields('msgs[*].id')
msg.find('msgs[1].id = 2').fields('msgs[*].msg')
msg.find('msgs[1].id = 2').fields('msgs')
msg.find('msgs[1].id = 2').fields('msgs').limit(1)
ms = msg.find('msgs[1].id = 2').fields('msgs')
ms
ms.length
ms[1]
ms.msgs[1]
ms['msgs'][1]
ms['msgs']
ms.msgs
ms
length(ms)
ms->'$.id'
ms->'$.msgs'
ms->>'$.msgs'
ms
JSON_VALUE(ms, 'msgs')
JSON_OBJECT(ms, 'msgs')
ms
ms.limit(1)
ms.msgs
ms['msgs']
ms->msgs
ms-msgs
ms.msgs
ms.find()
ms.fields('id')
ms.fields('msgs')
type(ms)
msg.find()
ms[0].msgs
ms[0]
ms
msg.find()
msg.find().limit(1)
a = msg.find()
m.forEach( _m => print(_m))
m
a.forEach( _m => print(_m))
a.forEach( _m => console.log(_m))
console.log("**"0
console.log("**")
print(a)
a
print(a.length)
print(a.count())
a.count()
msg.count()
ms.count()
ms.count('msgs')
a = msg.find().execute()
a
a.fetchOne()
o = a.fetchOne()
o
a
a = msg.find()
a
a.chat
a.fields('chat')
a.fields('chat').limit(1)
a.limit(1)
ms
ms.limit(1)
ms.msgs
ms.msgs[0]
ms
json_search()
history
\history
msg.find(" json_search(msgs, 'one', '1') ")
msg.find(" json_search(msgs, 'id', '1') ")
msg.find(" json_search(msgs, 'all', '1') ")
msg.find(" json_value(msgs, '$.msgs[0].id') ")
msg.find().fields(" json_value(msgs, '$.msgs[0].id') ")
msg.find().fields(mysqlx.expr(" json_value(msgs, '$.msgs[0].id') "))
msg.find().fields(" json_value(msgs, '$.msgs[0].id') ")
msg.find(" json_contains(msgs, '2', '$.id') ")
msg.find(" json_contains(msgs, '1', '$.id') ")
msg.find(" json_contains(msgs, 1, '$.id') ")
msg.find(" json_contains(msgs, '1', '$.id') ")
msg.find()
msg.find(" json_contains(msgs, '1', '$.id') ")
msg.find(" json_value(msgs, '$.id') = 2 ")
msg.find(" json_value(msgs, '$.id') = 1 ")
msg.find( json_value(msgs, '$.id') = 1 )
msg.find(mysqlx.expr(" json_value(msgs, '$.id') = 1 "))
msg.find('mysqlx.expr(" json_value(msgs, '$.id') = 1 ")')
msg.find( expr(" json_value(msgs, '$.id') = 1 ") )
msg.find().fields('msgs[*]')
msg.find().fields('msgs')
msg.find().fields('msgs**id')
msg.find().fields('[msgs]**id')
msg.find().fields('[msgs]')
msg.find().fields('[msgs]')[0]
msg.find().fields('msgs[*]')
msg.find().fields('msgs[*]**id')
msg.find(" json_contains(msgs, '1', '$.msgs.id') ")
msg.find(" json_contains(msgs, '1', '$.msgs[*].id') ")
msg.find(" json_contains(msgs, '1', '$.id') ")
msg.find(" json_contains(msgs, 1, '$.id') ")
msg.find(" json_contains(msgs, '111', '$.msg') ")
msg.find(" json_contains(msgs, '111', '$.msgs') ")
msg.find(" json_contains(msgs, '{id:1}', '$.msgs') ")
msg.find(" json_contains(msgs, '{id:"1"}', '$.msgs') ")
msg.find(" json_contains(msgs, '{id:1}', '$.msgs') ")
msg.find().fields('msgs')
msg.find().fields('msgs[0]')
msg.find().fields('msgs[ json_length(doc, '$.msgs') ]')
msg.find().fields("msgs[ json_length(doc, '$.msgs') ]")
msg.find().fields('msgs[1]')
msg.find().fields('msgs[1] as mm')
msg.find().fields('msgs[0]')
set @i = 1
\sql
@a
print(@a)
msg.find().fields('msgs[@a]')
\sql
db.getTables();
db.message
db.message.select()
db.message.select("_id")
db.message.select(["_id"])
db.message.select(["*"])
db.Dept.select()
db.message.select()
db.getSession()
session
session.get_default_schema()
\py
msg
msg = db.message
msg.getOne()
msg.find()
msg.getOne("00006004ef6f0000000000000002")
msg.getOne("00006004ef6f0000000000000002").fields('msgs')
msg.getOne("00006004ef6f0000000000000002")
msg.getName()
msg.getSchema()
msg.getSchema().getName()
msg.count()
who_am_i()
db.who_am_i()
msg.who_am_i()
session.get_uri()
session.getUri()
session.whoAmI()
session.who_am_i()
session.isOpen()
session.query("select * from Dept")
session.query("select * from Dept", null)
session.runSql("select * from Dept", null)
session.runSql("select * from Dept")
a = session.runSql("select * from Dept")
a
db.runSql("select * from Dept")
db.query("select * from Dept")
db.sql("select * from Dept")
session.sql("select * from Dept")
sr = session.sql("select * from Dept")
sr
sr.affectedRowCount()
sr.count()
\sql explain message;
db.amIReal()
r = msg.add({_id: 3})
r.getAffectedItemsCount()
r.getAutoIncrementValue()
r.getDocumentId()
r.get_document_id()
r
r._id
r.execute()
r.getLastInsertId()
r.getDocumentId()
msg.getLastInsertId()
msg.getAffectedItemsCount()
msg.last_insert_id()
\py
\use mydealdb
db.message.find()
\sql truncate table message;
db.message.find()
db.message.add({chat:111})
r = db.message.add({chat:222}).excute()
\sql truncate table message;
db.message.find()
db.message.add({chat:111})
r = db.message.add({chat:222}).execute()
r.getAffectedItemsCount()
db.message.find()
\sql truncate table message;
db.message.add({chat:111})
r = db.message.add({_id: 222, chat:222}).execute()
r.getAffectedItemsCount()
db.message.find()
db.message.add([{chat:333}, {chat:444}])
db.message.find()
\sql truncate table message;
db.message.find()
db.getTables()
chat = db.Chat.insert().values();
chat = db.Chat.insert('remark').values('테스트 채팅');
db.Chat.select()
session.sql('select last_insert_id()')
db.message.add({ _id: mysqlx.expr("last_insert_id()"),   pins: [],   msgs: [     { id: mysqlx.expr("uuid_short()"),       sender: 1, sentdt: mysqlx.expr("CURRENT_TIMESTAMP()"),       mtype: 'T', msg: '안녕하세요!' }   ] })
db.message.find()
db.ChatUser.select()
session.sql('select last_insert_id()')
db.ChatUser.insert('chat', 'user', 'lastread')
db.ChatUser.select()
db.ChatUser.insert('chat', 'user', 'lastread')
db.ChatUser.insert('chat', 'user', 'lastread').   values(last_insert_id(), 1, 99084618157785120)
db.ChatUser.insert('chat', 'user', 'lastread').   values(mysqlx.expr("last_insert_id()"), 1, 99084618157785120)
db.ChatUser.select()
session.sql('select last_insert_id()')
db.ChatUser.insert('chat', 'user', 'lastread').   values(mysqlx.expr("last_insert_id()"), 1, 0)
session.sql('select last_insert_id()')
\sql truncate table ChatUser;
db.ChatUser.insert('chat', 'user', 'lastread').   values(1, 1, 99084618157785120).   values(1, 2, 0)
db.ChatUser.select()
db.message.find('_id=1')
db.message.find('_id=:id').bind('id', 1)
db.message.find('_id=1').fields('_id')
db.message.find().fields('_id', 'msgs')
db.message.find().fields(['_id', 'msgs'])
db.message.find().fields(['_id', 'msgs[0] as first_msg'])
db.message.find('_id=1').fields('_id').sort('_id desc')
db.message.add([{_id:111}, {_id: 222}, {id:333}])
db.message.find('_id=1').fields('_id').sort('_id desc')
db.message.find().fields('_id').sort('_id desc')
db.message.find()
db.message.remove('_id > 10')
db.message.find()
db.message.add([{_id:111}, {_id: 222}, {_id:333}])
db.message.find()
db.message.find().sort('_id desc')
db.message.find().sort('_id desc').limit(2).offset(1)
db.ChatUser.select()
db.Chatuser.select()
db.message.find()
db.message.modify('_id=1').arrayAppend('msgs',   { id: mysqlx.expr('uuid_short()'), sender: 2,     sentdt: mysqlx.expr('CURRENT_TIMESTAMP()'),     mtype: 'T', msg: '네 무엇을 도와드릴까요?'   })
db.message.find('_id=1')
db.ChatUser.update().set('lastread', 99084618157785122).   where('chat=1 and user=2')
db.ChatUser.select()
db.ChatUser.select().where('chat=1 and user=2')
db.ChatUser.update().set('lastread', 99084618157785122).   where('chat=1 and user=2')
db.ChatUser.select().where('chat=1 and user=2')
db.message.find()
db.message.modify('_id=1').set('pins', [99084618157785122]);
db.message.find('_id=1')
db.message.find('_id=1').fields('pins')
db.message.find('pins[0]=99084618157785122')
db.message.modify('_id=1').set('pins', []);
db.message.find('_id=1')
db.message.modify('_id=1').set('pins', ['99084618157785122'])
db.message.find('_id=1')
db.message.modify('_id=1').set('pins', [99084618157785122])
db.message.find('_id=1')
db.message.modify('_id=1').set('pins', [99084618157785122])
db.message.find('_id=1').fields('pins')
db.message.find('_id=1')
db.message.modify('_id=1').   set('msgs[0].id', '99084618157785120')  .set('msgs[1].id', '99084618157785122')
db.message.find('_id=1')
db.sql('select 1')
session.sql('select 1')
session.sql('alter table ChatUser modify column lastread varchar(20)')
\sql alter table ChatUser modify column lastread varchar(20);
\sql desc ChatUser;
db.ChatUser.select()
db.message.modify('_id=1').arrayAppend('msgs',    { id: mysqlx.expr("cast(uuid_short() as char)"),     sender: 1, sentdt: mysqlx.expr("CURRENT_TIMESTAMP()"),     mtype: 'T', msg: '계약 만료일이 언제에요?' } )
db.message.find('_id=1')
db.message.modify('_id=1').   set('pins', ['99084618157785122'])
db.message.find('_id=1').fields('pins')
db.message.modify('_id=1').   set('msgs[2].receivers', [2])
db.message.find('_id=1').fields('pins')
db.message.find('_id=1')
db.message.modify('_id=1').set('msgs[2].receivers', [2])
db.ChatUser.select()
db.ChatUser.insert(chat, user, lastread).  values(1, 3, mysqlx.expr("f_lastmsgid(1)"))
db.ChatUser.insert('chat', 'user', 'lastread').  values(1, 3, mysqlx.expr("f_lastmsgid(1)"))
db.ChatUser.select()
db.message.modify('_id=1').arrayAppend('msgs',   { id: mysqlx.expr("cast(uuid_short() as char)"),     sender: 1, sentdt: mysqlx.expr("CURRENT_TIMESTAMP()"),     mtype: 'S', msg: '1번 사용자가 3번 사용자를 초했습니다' } )
db.message.find('_id=1').fields('msgs')
db.ChatUser.update().   set('lastread', mysqlx.expr('f_lastmsgid(1)')).   where('chat = 1 and user = 1')
db.ChatUser.select()
session.startTransaction()
db.message.find('_id=1').fields('pins')
db.message.modify('_id=1').arrayDelete('pins[0]')
db.message.find('_id=1').fields('pins')
session.rollback()
db.message.find('_id=1').fields('pins')
session.startTransaction()
session.setSavepoint('Tx1')
db.message.modify('_id=1').arrayDelete('pins[0]')
db.message.find('_id=1').fields('pins')
db.message.modify('_id=1').arrayAppend('pins', '000000')
db.message.find('_id=1').fields('pins')
session.rollback()
db.message.find('_id=1').fields('pins')
session.rollbackTo('Tx1')
session.startTransaction()
session.setSavepoint('Tx-rm')
db.message.modify('_id=1').arrayDelete('pins[0]')
db.message.find('_id=1').fields('pins')
session.setSavepoint('Tx-append')
db.message.modify('_id=1').arrayAppend('pins', '000')
db.message.find('_id=1').fields('pins')
session.rollbackTo('Tx-append')
db.message.find('_id=1').fields('pins')
session.commit()
db.message.find('_id=1').fields('pins')
session.sql('show index from message')
db.sql('show index from message')
db.sql('select 1')
db.sql('show index from message\G')
session.sql('show index from message\G')
session.sql('show index from message \G')
\sql show index from message\G
db.message.find('_id=1')
session.startTransaction()
db.message.remove('_id=1')
db.message.find()
session.rollback()
db.message.find()
session.startTransaction()
session.setSavepoint('Tx1')
db.message.find('_id > 100').fields('_id')
db.message.remove('_id > 100')
db.message.find().fields('_id')
session.setSavepoint('Tx2')
db.message.remove('_id=1')
db.message.find().fields('_id')
session.rollbackTo('Tx2')
db.message.find().fields('_id')
session.commit()
db.message.find().fields('_id', 'msgs[0]')
\sql show index from message\G
db.message.createIndex("idx_msgs_id",  { fields: [     { field: "$.msgs[*].id", type: "char(20)",       required: true }    ]  })
db.message.find().fields('msgs[*].id')
db.message.createIndex("idx_msgs_id",  { fields: [     { field: "$.msgs[*].id", type: "char",       required: true }    ]  })
db.message.createIndex("idx_msgs_id",  { fields: [     { field: "$.msgs[*].id", type: "text(30)",       required: true }    ]  })
db.message.dropIndex("idx_msgs_id")
db.message.createIndex("idx_msgs_id",  { fields: [     { field: "$.msgs[*].id", type: "char(30)",       required: true }    ]  })
db.message.createIndex("idx_msgs_id",  { fields: [     { field: "$.msgs[*].id", type: "text",       required: true }    ]  })
\sql show index from message\G
db.message.createIndex("idx_msgs_id",  { fields: [     { field: "$.msgs[*].id", type: "char(40)",       required: true }    ]  })
db.message.createIndex("idx_msgs_id",  { fields: [     { field: "$.msgs[*].id", type: "char(50)",       required: true }    ]  })
db.message.createIndex("idx_msgs_id",  { fields: [     { field: "$.msgs[*].id", type: "char(60)",       required: true }    ]  })
db.message.createIndex("idx_msgs_id",  { fields: [     { field: "$.msgs[*].id", type: "char(80)",       required: true }    ]  })
db.message.createIndex("idx_msgs_id",  { fields: [     { field: "$.msgs[*].id", type: "text(8)",       required: true }    ]  })
db.message.dropIndex("idx_msgs_id")
db.message.createIndex("idx_msgs_id",  { fields: [     { field: "$.msgs[*].id", type: "text(1)",       required: true }    ]  })
db.message.dropIndex("idx_msgs_id")
db.message.createIndex("idx_msgs_id",  { fields: [     { field: "$.msgs[*].id", type: "char(255)",       required: true }    ]  })
db.message.dropIndex("idx_msgs_id")
db.message.createIndex("idx_msgs_id",  { fields: [     { field: "$.msgs[*].id", type: "text",       required: true }    ]  })
db.message.dropIndex("idx_msgs_id")
db.message.createIndex("idx_msgs_id",  { fields: [     { field: "$.msgs[*].id", type: "text(20)",       required: true }, {field: "$.msgs[*].sender", type: "int", required: true    ]  })
db.message.createIndex("idx_msgs_id",  { fields: [     { field: "$.msgs[*].id", type: "text(20)",       required: true }, {field: "$.msgs[*].sender", type: "int", required: true }   ]  })
db.message.createIndex("idx_msgs_id",  { fields: [     { field: "$.msgs[*].id", type: "text(20)",       required: true }, {field: "$.msgs[*].sender", type: "integer", required: true }   ]  })
db.message.createIndex("idx_msgs_id",  { fields: [     { field: "$.msgs[*].id", type: "text(20)",       required: true }, {field: "$.msgs[*].sender", type: "INT", required: true }   ]  })
db.message.createIndex("idx_msgs_id",  { fields: [     { field: "$.msgs[*].id", type: "text(20)",       required: true }, {field: "$.msgs[*].sender", type: "INT UNSIGNED", required: true }   ]  })
\sql show index from message\G
db.message.find()
db.message.createIndex("idx_msgs_id",  { fields: [     { field: "$.msgs[*].id", type: "text(20)",       required: true }, {field: "$.msgs[*].sender", type: "INT UNSIGNED", required: true }   ]  })
db.message.createIndex("idx_msgs_id",  { fields: [     { field: "$.msgs[*].id", type: "text(20)",       required: true }, {field: "$.msgs[*].sender", type: "NUMERIC UNSIGNED", required: true }   ]  })
db.message.createIndex("idx_msgs_id",  { fields: [     { field: "$.msgs[*].id", type: "text(20)",       required: true }, {field: "$.msgs[*].sender", type: "BIGINT UNSIGNED", required: true }   ]  })
db.message.createIndex("idx_msgs_id",  { fields: [     { field: "$.msgs", type: "text(20)",       required: true }    ]  })
\sql show index from message\G
db.message.createIndex("idx_msgs_id2",  { fields: [     { field: "$.msgs[*].id", type: "text(20)",       required: true }, {field: "$.msgs[*].sender", type: "BIGINT UNSIGNED", required: true }   ]  })
db.message.createIndex("idx_msgs_id2",  { fields: [     { field: "$.msgs.id", type: "text(20)",       required: true }    ]  })
db.message.createIndex("idx_msgs_id2",  { fields: [     { field: "$.msgs.id", type: "text(20)"}    ]  })
\sql show index from message\G
\sql show create table message\G
db.message.createIndex("idx_msgs_id2",  { fields: [     { field: "$.msgs.id", type: "text(20)"}    ]  })
db.message.dropIndex("idx_msgs_id2")
db.message.createIndex("idx_msgs_id2",  { fields: [     { field: "$.msgs.id", type: "text(20)", required: true, array: true}    ]  })
db.message.createIndex("idx_msgs_id2",  { fields: [     { field: "$.msgs.id", type: "char(255)", required: true, array: true}    ]  })
db.message.createIndex("idx_msgs_id2",  { fields: [     { field: "$.msgs.id", type: "char(255)", required: true}    ]  })
db.message.createIndex("idx_msgs_id2",  { fields: [     { field: "$.msgs[*].id", type: "char(255)", required: true}    ]  })
db.message.dropIndex("idx_msgs_id2")
db.message.createIndex("idx_msgs_id2",  { fields: [     { field: "$.msgs[*].id", type: "char(255)", required: true, array: true}    ]  })
\sql show index from message\G
db.message.createIndex("idx_msgs_id2",  { fields: [     { field: "$.msgs[*].id", type: "char(255)", required: true}    ]  })
\sql show index from message\G
db.message.dropIndex("idx_msgs_id2")
db.message.dropIndex("idx_msgs_id")
\sql show index from message\G
db.message.createIndex("idx_msgs_id2", mysqlx.IndexType.UNIQUE,  { fields: [     { field: "$.msgs[*].id", type: "char(255)", required: true}    ]  })
db.message.createIndex("idxx", mysqlx.IndexType.UNIQUE).field("$.msgs[*].id", "text(20)", true)
db.message.createIndex("idxx", mysqlx.IndexType.UNIQUE).field("$.msgs[*].id", "text(20)", true).execute()
\py
db.message.createIndex("idx_msgs_id2", mysqlx.IndexType.UNIQUE,  { fields: [     { field: "$.msgs[*].id", type: "char(255)", required: true, unique: true}    ]  })
db.message.createIndex("idx_msgs_id2",  { fields: [     { field: "$.msgs[*].id", type: "char(255)", required: true, unique: true}    ]  })
\sql show index from message\G
db.message.dropIndex("idx_msgs_id2")
\sql show index from message\G
db.message.createIndex("idx_message_msgs_id",    { fields: [      { field: "$.msgs[*].id",         type: "TEXT(20)",         required: true }     ] })
\sql show index from message\G
db.message.createIndex("idx_message_pins",  { fields: [     { field: "$.pins",       type: "CHAR(255)",       required: true,       array: true }    ] })
db.message.createIndex("idx_message_pins",  { fields: [     { field: "$.pins",       type: "CHAR(255)",       required: false,       array: true }    ] })
db.message.dropIndex("idx_message_pins")
db.message.find()
db.message.createIndex("idx_message_pins",   { fields: [     { field: "$.pins",       type: "CHAR(255)",       required: false,       array: true }    ] } )
db.message.dropIndex("idx_message_pins")
db.dropCollection('message')
db.getCollections()
\use testdb
db.getCollections()
db.dropCollection('empextra')
db.dropCollection('message')
db.getCollections()
\quit
\?
\py
\sql select user()
\q