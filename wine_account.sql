Create table sale (
    sale_date date default sysdate Primary Key not null,
    wine_code varchar2(6) not null,
    mem_id varchar2(30) not null,
    sale_amount varchar2(5) default 0 not null ,
    sale_price varchar2(6) default 0 not null,
    sale_tot_price varchar2(15) default 0 not null,
    Foreign Key (wine_code) references wine(wine_code),
    Foreign Key (mem_id) references member(mem_id)
    );
    
insert into sale
values(default, '11111','123' , '10' , '10000' , '15000');

insert into sale
values('2022/04/01', '22222' , '456' , '7' , '50000' , '80000');

insert into sale
values('2022/03/01', '33333' , '789' , '15' , '100000' , '130000');

commit

Create table member (
    mem_id varchar2(6) Primary Key not null,
    mem_grade varchar2(20),
    mem_pw varchar2(20) not null,
    mem_birth date default sysdate not null,
    mem_tel varchar2(20),
    mem_pt varchar2(10) default 0 not null,
    Foreign Key (mem_grade) references grade_pt_rade(mem_grade)
    );

insert into member
values('123' , '1' , '1234' , '2000/10/01' , '010-1234-5678' , default);

insert into member
values('456' , '2' , '1234' , default , '010-1234-5679' , default);

insert into member
values('789' , '3' , '1234' , '1990/07/03' , '010-1234-5680' , default);

commit
    
Create table grade_pt_rade (
    mem_grade varchar2(20) Primary Key not null,
    grade_pt_rate number (3,2)
    );
    
insert into grade_pt_rade
values('1',1.50);

insert into grade_pt_rade
values('2',2.50);

insert into grade_pt_rade
values('3',3.50);

commit

    
Create table today (
    today_code varchar2(6) Primary Key not null,
    today_sens_value number(3),
    today_intell_value number(3),
    today_phy_value number(3)
    );
    
insert into today 
values('1111',10,20,30);

insert into today 
values('2222',20,30,40);

insert into today 
values('3333',30,40,50);

commit
    
Create table nation(
    nation_code varchar2(26) Primary Key not null,
    nation_name varchar2(50) not null
    );
    
insert into nation 
values('100' , '한국');

insert into nation 
values('200' , '중국');

insert into nation 
values('300' , '영국');

commit
    
Create table wine (
    wine_code varchar2(26) Primary Key not null,
    wine_name varchar2(100) not null,
    wine_url blob,
    nation_code varchar2(6),
    wine_type_code varchar2(6),
    wine_suger_code number(2),
    wine_price number(15) default 0 not null,
    wine_vintage date,
    theme_code varchar2(6),
    today_code varchar2(6),
    Foreign Key (nation_code) references nation(nation_code),
    Foreign Key (wine_type_code) references wine_type(wine_type_code),
    Foreign Key (theme_code) references theme(theme_code),
    Foreign Key (today_code) references today(today_code)
    );
    
insert into wine
values('11111' , 'a' , null , '100' , '987' , '6' , '15000' , '1900/01/26' , '500' , '1111');

insert into wine
values('22222' , 'b' , null , '200' , '876' , '8' , '80000' , '1800/04/16' , '600' , '2222');

insert into wine
values('33333' , 'c' , null , '300' , '765' , '10' , '130000' , '1600/11/14' , '700' , '3333');

commit

Create table theme (
    theme_code varchar2(6) Primary Key not null,
    theme_name varchar2(50) not null
    );
    
insert into theme
values('500' , 'aa');

insert into theme
values('600' , 'bb');

insert into theme
values('700' , 'cc');

commit
    
Create table stock_mamagement(
    stock_code varchar2(6) Primary key not null,
    wine_code varchar2(6),
    manager_id varchar2(30),
    ware_date date default sysdate not null,
    stock_amount number default 0 not null,
    Foreign Key (wine_code) references wine(wine_code),
    Foreign Key (manager_id) references manager(manager_id)
    );
    
insert into stock_mamagement
values('abc','11111' ,'zxc' , default, '5');

insert into stock_mamagement
values('bcd','22222' ,'xcv' , '2022/04/20', '6');

insert into stock_mamagement
values('cde','33333' ,'cvb' , '2022/02/21', '7');

commit

Create table manager (
    manager_id varchar2(30) Primary Key not null,
    manager_pwd varchar2(20) not null,
    manager_tel varchar2(20)
    );
    
insert into manager
values('zxc' , '1234' , '010-2345-6789');

insert into manager
values('xcv' , '1234' , '010-2345-6790');

insert into manager
values('cvb' , '1234' , '010-2345-6791');


commit
    
Create table wine_type (
    wine_type_code varchar2(6) Primary Key not null,
    wine_type_name varchar2(50)
    );
    
insert into wine_type
values('987' , 'a');

insert into wine_type
values('876' , 'a');

insert into wine_type
values('765' , 'a');


commit;

