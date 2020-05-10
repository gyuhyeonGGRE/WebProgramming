create table memo_Test (
  num number,
  name varchar2(15),
  title varchar2(100),
  pass varchar2(10),
  indate date default sysdate,
  primary key(num)
  );
