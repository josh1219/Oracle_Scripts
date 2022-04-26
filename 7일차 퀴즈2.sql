-- 7일차 퀴즈2

Create table member (
    id varchar2(20) not null constraint PK_member_id Primary Key,
    pwd varchar2(20),
    name varchar2(50),
    zipcode varchar2(7),
    address varchar2(20),
    tel varchar2(13),
    indate date default sysdate,
    constraint FK_member_id_tb_zipcode Foreign Key (zipcode) references tb_zipcode(zipcode)
    );
    
Alter table member drop constraint FK_member_id_tb_zipcode;
    
select * from member;
    
insert into member
values ('1111', '1234','홍길동','123-456','시흥','010-1234-5678',default);

insert into member
values ('2222', '1234','유관순','456-789','시흥','010-1234-5679',default);

insert into member
values ('3333', '1234','이순신','456-790','시흥','010-1234-5680',default);
    
commit;

Create table tb_zipcode (
    zipcode varchar2(7) not null constraint PK_tb_zipcode_zipcode Primary Key,
    sido varchar2(30),
    gugum varchar2(30),
    dong varchar2(30),
    bungi varchar2(30)
    );
    
    Alter table tb_zipcode
    add (ZIP_SEQ varchar2(30));
    
    Alter table tb_zipcode
    modify dong Nvarchar2(30);
    
    Alter table tb_zipcode 
    rename column gugum to gugun;
    
    Alter table tb_zipcode 
    rename column bungi to bunji;
    
    Alter table tb_zipcode drop constraint PK_tb_zipcode_zipcode;

select * from tb_zipcode;
    

insert into tb_zipcode
values ('123-456', '경기도','시흥시','정왕동','117-32번지'); 

insert into tb_zipcode
values ('456-789', '경기도','시흥시','정왕2동','117-33번지');
    
insert into tb_zipcode
values ('456-790', '경기도','시흥시','정왕3동','117-34번지');    
    
commit;    
    
Create table products (
    product_code varchar2(20) not null constraint PK_products_product_code Primary Key,
    product_name varchar2(100),
    product_kind char(1),
    product_price1 varchar2(10),
    product_price2 varchar2(10),
    product_content varchar2(1000),
    product_image varchar2(50),
    sizeSt varchar2(5),
    sizeEt varchar2(5),
    product_quantity varchar2(5),
    useyn char(1),
    indate date
    );   
    
insert into products 
values ('11111', '장난감', 'Y','5000','8000','어린이들 장난감','로봇','1','3','3','N','2022/01/01');

insert into products 
values ('22222', '라면', 'Y','500','800','신라면','라면','1','2','10','N','2022/02/02');

insert into products 
values ('33333', '젓가락', 'Y','1000','1500','젓가락','젓가락','1','2','5','N','2022/03/03');

commit;

Create table orders (
    o_seq number(10) not null constraint PK_orders_o_seq Primary Key,
    product_code varchar2(20),
    id varchar2(16),
    product_size varchar2(5),
    quantity varchar2(5),
    result char(1),
    indate date,
    constraint FK_orders_product_code Foreign Key (product_code) references products (product_code),
    constraint FK_orders_id_member Foreign Key (id) references member(id)
    );
    
insert into orders
values (111111,'11111','1111','2','2','Y','2022/03/12');

insert into orders
values (222222,'22222','2222','2','5','Y','2022/03/20');

insert into orders
values (333333,'33333','3333','1','5','Y','2022/04/05');
  
commit;  
    

    
select * from member;
select * from tb_zipcode;
select * from products;
select * from orders;

