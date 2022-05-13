create table guestboard (
    name varchar2(10),
    email varchar2(50),
    inputdate varchar2(40) Primary key,
    subject varchar2(20),
    content varchar2(2000));
    
    
    
drop table guestboard;
    
select * from guestboard;

select name, email,inputdate,subject,content
from freeboard;