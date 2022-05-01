Create table sale (
    sale_date date not null default sysdate Primary Key,
    wine_code varchar2(6) not null,
    mem_id varchar2(30) not null,
    sale_amount varchar2(5) not null default 0,
    sale_price varchar2(6) not null default 0,
    sale_tot_price varchar2(15) not null default 0,
    constraint FK_sale_wine_code_wine Foreign Key (wine_code) references wine(wine_code),
    constraint FK_sale_mem_id_member Foreign Key (mem_id) references member(mem_id)
    );
    
    Create table member (
    mem_id varchar2(6) not null Primary Key,
    mem_grade varchar2(20),
    mem_id varchar2(30) not null,
    sale_amount varchar2(5) not null default 0,
    sale_price varchar2(6) not null default 0,
    sale_tot_price varchar2(15) not null default 0,
    constraint FK_sale_wine_code_wine Foreign Key (wine_code) references wine(wine_code),
    constraint FK_sale_mem_id_member Foreign Key (mem_id) references member(mem_id)
    );