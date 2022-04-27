-- 7����  - ���� ����

--���̺� ���� : ���̺��� ��ü�� ������.
    -- ���̺��� �����ϸ�, �÷��� ���ڵ常 ���簡 ��.
    -- ���̺��� �Ҵ�� ���������� ���� ���� �ʴ´�. (Alter Rable�� ����ؼ� �Ҵ� �ؾ� �Ѵ�.)
    -- ���� ���� : �÷��� �Ҵ�Ǿ� �ִ�. ���Ἲ�� üũ
            -- NOT NULL, Primary Key, Unique, Foreign Key, check, default
    
-- ���̺��� ��ü ���ڵ带 ����.
create table dept_copy
as
select * from department;

desc department;
desc dept_copy;

select * from dept_copy;

create table emp_copy
as
select * from employee;

select * from emp_copy;

-- ���̺� ���� : Ư�� �÷��� �����ϱ�.

create table emp_second
as
select eno,ename,salary,dno from employee;

select * from emp_second;

-- ���̺� ���� : ������ ����ؼ� ���̺� ����.

create table emp_third
as
select eno,ename,salary from employee
where salary > 2000;

select * from emp_third;

-- ���̺� ���� : �÷����� �ٲپ ����

create table emp_forth
as
select eno �����ȣ, ename �����, salary ���� 
from employee;

select �����ȣ, �����, ���� from emp_forth;    -- ���̺��, �÷���, <== ���� ����� ����.

-- ���̺� ���� : ������ �̿��ؼ� ���̺� ����: �ݵ�� ��Ī �̸��� ����ؾ� �Ѵ�.

create table emp_fifth
as 
select eno, ename ,salary * 12 as salary from employee;

select * from emp_fifth;

-- ���̺� ���� : ���̺� ������ ����, ���ڵ�� �������� �ʴ´�.

create table emp_sixth
as
select * from employee
where 0 = 1;        -- where ���� : false�� ����

select * from emp_sixth;
desc emp_sixth;

-- ���̺� ���� : Alter Table
create table dept20
as
select * from department;

desc dept20;
select * from dept20;

-- ������ ���̺��� �÷��� �߰���. ���� : �ݵ�� �߰� �� �÷��� NULL�� ����ؾ� �Ѵ�.
Alter table dept20
add (birth date);

Alter table dept20
add (email varchar2(100)); 

Alter table dept20
add (address varchar2(200));

-- �÷��� �ڷ����� ����
desc dept20;

Alter table dept20
modify dname varchar2 (100);

Alter table dept20
modify dno number(4);

Alter table dept20
modify address Nvarchar2 (200);

-- Ư�� �÷� ���� : �����ð� �ܿ� �۾�. (���ϰ� ���� �ɸ��� �ִ�.)

Alter table dept20
drop column birth;

select * from dept20;

Alter table dept20
drop column email;

-- �÷��� �����ÿ� ���ϰ� ���� �߻��� ��.
    -- SET UNUSED : Ư�� �÷��� ��� ���� (������) , �߰��� ����

Alter table dept20      -- �������϶� Ư�� �÷��� ��� ����
SET UNUSED (address) ;  

desc dept20;

Alter table dept20  -- �߰��� ��� ������ �÷��� ����
drop unused column; -- ������� �ʴ� �÷��� ������.

-- �÷� �̸� ����

Alter table dept20
rename column loc to locations;

Alter table dept20
rename column dno to D_Number;

-- ���̺� �̸� ����

rename dept20 to dept30;

desc dept30;

-- ���̺� ����

drop table dept30;

/*
    DDL : Create (����) , Alter (����) , Drop (����)
        << ��ü >>
        ���̺� , �� , �ε��� , Ʈ���� , ������ , �Լ� , ���� ���ν��� . . . .
*/

/*
    DML : Insert (���ڵ� �߰�) , Update (���ڵ� ����) , Delete (���ڵ� ����)
        << ���̺��� �� (���ڵ� , �ο�) >>
*/

/*
    DQL : Select 
*/

/*
    ���̺��� ��ü �����̳� ���̺� ������
    1. delete   : ���̺��� ���ڵ带 ���� , where�� ������� ���� ��� ��� ���ڵ� ����.  << ���� >>
    2. truncate : ���̺��� ���ڵ带 ���� , �ӵ��� ������ ������.   << ���� ���� >>
    3. drop     : ���̺� ��ü�� ����
*/

create table emp30
as
select * from employee;

select * from emp10;

-- emp 10 : delete�� ����ؼ� ����.
    delete emp10
    commit;
    
    select * from emp10;
-- emp 20 : truncate�� ����ؼ� ����.
    truncate table emp20;
    
    select * from emp20;
-- emp 30 : drop�� ����ؼ� ����.
    drop table emp30;
    
    select * from emp30;

drop table EMP
drop table emp_copy

/*

    ������ ���� : �ý����� ���� ������ ��� ���ִ� ���̺�
        user_   : �ڽ��� ������ ���� ��ü ������ ���.
        all_    : �ڽ��� ������ ������ ��ü�� ������ �ο� ���� ��ü ������ ���.
        dba_    : ������ ���̽� �����ڸ� ���� ������ ��ü ������ ���.

*/

show user;
select * from user_tables;          -- ����ڰ� ������ ���̺� ���� ���
select table_name from user_tables;
select * from user_views;           -- ����ڰ� ������ �信 ���� ���� ���
select * from user_indexes;         -- ����ڰ� ������ �ε��� ���� ���
select * from user_constraints      -- ���� ���� Ȯ��
select * from user_constraints
where table_name = 'EMPLOYEE'
select * from user_sequences;       

select * from all_tables;           -- ��� ���̺��� ���, ������ �ο����� ���̺� ���.
select * from all_views;            

select * from dba_tables;           -- ������ ���������� ���� ����

/*
    ���� ���� : ���̺��� ���Ἲ�� Ȯ���ϱ� ���ؼ� �÷��� �ο��Ǵ� ��Ģ.
        1. Primary Key
        2. Unique
        3. NOT NULL
        4. CHECK
        5. FOREIGN KEY
        6. DEFAULT
*/

-- 1. Primary Key : �ߺ��� ���� ���� �� ����.

    -- a. ���̺� ������ �÷��� ���� ���� �ο�
        -- ���� ���� �̸� : �������� ���� ��� : Oracle���� ������ �̸����� ����,
            -- ���� ������ ���� �� �� ���� ���� �̸��� ����ؼ� ����.
            -- PK_customer01_id  : Primary Key , customer01 , id
            -- NN_customer01_pwd : Not Null , customer01(���̺��) , pwd (�÷���) 
  create table customer01 (
    id varchar2(20) not null constraint PK_customer01_id Primary Key,
    pwd varchar2(20) constraint NN_customer01_pwd not null,
    name varchar2(20) constraint NN_customer01_name not null,
    phone varchar2(30) null,
    address varchar(100) null
    );
    
    select * from user_constraints
    where table_name = 'CUSTOMER01'
    
    
    create table customer02 (
    id varchar2(20) not null Primary Key,
    pwd varchar2(20) not null,
    name varchar2(20) not null,
    phone varchar2(30) null,
    address varchar(100) null
    );
    
    select * from user_constraints
    where table_name = 'CUSTOMER02'
        
-- ���̺��� �÷� ���� �� ���� ���� �Ҵ�.
  create table customer03 (
    id varchar2(20) not null,
    pwd varchar2(20) constraint NN_customer03_pwd not null,
    name varchar2(20) constraint NN_customer03_name not null,
    phone varchar2(30) null,
    address varchar(100) null,
     constraint PK_customer03_id Primary Key (id)
    );
    
/*
    Foreign Key (����Ű) : �ٸ� ���̺�(�θ�)�� Primary Key , Unique �÷��� �����ؼ� ���� �Ҵ�. 
    check : �÷��� ���� �Ҵ� �� �� check�� �´� ���� �Ҵ�.
*/
-- �θ� ���̺�
Create table parentTbl (
    name varchar2(20),
    age number(3) constraint CK_ParentTbl_age check (AGE > 0 and AGE < 200),
    gender varchar(3) constraint CK_ParentTbl_gender check (gender IN ('M','W')),
    infono number constraint PK_ParentTbl_infono Primary Key
    )
    
desc parentTbl;

select * from user_constraints
where table_name = 'PARENTTBL';

select * from ParentTbl;
insert into ParentTbl
values ( 'ȫ�浿' , 30 , 'M' , 1)

insert into ParentTbl
values ( '��ʶ�' , 300 , 'K' , 1)     -- ���� �߻� : 300 (check ����) , K (check ����) , 1 (Primary Key ����)

insert into ParentTbl
values ( '��ʶ�' , 50 , 'M' , 2) 


-- �ڽ� ���̺�
create table ChildTbl (
    id varchar2(40) constraint PK_ChildTbl_id Primary Key,
    pw varchar2(40),
    infono number,
    constraint FK_ChildTbl_infono Foreign Key (infono) references ParentTbl(infono)
    );
    
insert into ChildTbl
values ('aaa' , '1234' , 1) 

insert into ChildTbl
values ('bbb' , '1234' , 2)

commit;

select * from ChildTbl;

-- �θ� ���̺�
Create table ParentTbl2 (
    dno number(2) not null Primary Key,
    dname varchar2(50) ,
    loc varchar2(50)
    );
    
    insert into ParentTbl2
    values (10 , 'SALES' , 'SEOUL');
    
-- �ڽ� ���̺�    
Create table ChildTbl2 (
    no number(2) not null,
    ename varchar2(50),
    dno number(2) not null,
    foreign key (dno) references ParentTbl2 (dno)
    );
    
    insert into ChildTbl2
    values (1 , 'Park' , 10);
    
    select * from ChildTbl2
    
-- default ���� ���� : ���� �Ҵ� ���� ������ default ���� �Ҵ�.

Create Table emp_sample01 (
    eno number(4) not null Primary key,
    ename varchar(50),
    salary number(7,2) default 1000
    );
    
select * from emp_sample01; 

-- default �÷��� ���� �Ҵ��� ���
insert into emp_sample01
values ( 1111,'ȫ�浿',1500);

-- default �÷��� ���� �Ҵ����� �ʴ� ���. default�� �Ҵ�� ���� ����
insert into emp_sample01 (eno, ename)
values (2222, 'ȫ���');

insert into emp_sample01
values (3333, '������', default);

Create Table emp_sample02 (
    eno number(4) not null Primary key,
    ename varchar(50) default 'ȫȫȫ',
    salary number(7,2) default 1000
    );
    
insert into emp_sample02 (eno)
values (10);

select * from emp_sample02;

insert into emp_sample02
values (20, default, default);

/*
    Primary Key , Foreign Key , Unique , Check , Default , Not Null
*/

Create table member10 (
    no number not null constraint PK_member10_no Primary Key,
    name varchar(50) constraint NN_member10_name not null,
    birthday date default sysdate,
    age number(3) check (age > 0 and age < 150),
    gender char(1) check (gender in ('M' , 'W')),
    dno number(2) unique
    );

insert into member10
values (1, 'ȫ�浿', default, 30, 'M', 10);

insert into member10
values (2, '������', default, 30, 'M', 20);

select * from member10;

Create table orders10 (
    no number not null Primary Key,
    p_no varchar(100) not null ,
    P_name varchar(100) not null,
    price number check (price > 10),
    phone varchar(100) default '010-0000-0000',
    dno number(2) not null,
    foreign key (dno) references member10(dno)
    );

insert into orders10
values (1,'11111','������',5000,default,10);

select * from orders10;

-- ���������� ����

-- 1. �������Ǹ����� �����ϱ�
alter table (���̺��) drop constraint (���������̸�) 
-- �̸� ������ �� ���������� �̸��� �Է�, �̷��� ���� ������ �������Ǹ��� �� �ľ��ؾ���.

-- 2. Ű �̸����� �����ϱ�
alter table (���̺��) drop PRIMARY KEY;

-- 3. cascade constraints ����ؼ� ���̺�� �Բ� �����
drop table (���̺��) cascade constraints; -- �� ����� ��� ���ʹ� �� �ٸ�. ���̺� ���� �ɷ��ִ����� �׳� �Ѳ����� ������ �ڵ���.
                                          --  ��ǻ� ���� ���� ����ϴ� ����̶�� �Ͻ�

-- 4.���� ���� ��Ȱ��ȭ �ϱ�
alter table (���̺��) disable constraint (�������Ǹ�); -- ���� �̷��� ġ�� ��ǥ ���̺��� �ٸ� ���̺��� �������̶�� ������ ���
                                                    -- �̶� �ٸ� ���̺��� �ɸ����Ÿ��� ���̺��̶�� Ī�ϰ���.
                                                    -- �ϴ� ���� �ɸ����Ÿ����� �Ʒ� �ڵ带 �Է��ؼ� ��Ȳ�� �ľ�����
                                                    
select constraint_name, table_name, status from user_constraints where table_name IN (('��ǥ ���̺��'),('�ɸ����Ÿ��� ���̺��'));
-- �̴� ��ȣ�ȿ� �� �̸��� �ݵ�� ��ҹ��ڸ� �����ؼ� ���̺��� ��Ī�� ��ġ������� �Ѵ�.
-- �̷��� ã���� ��ǥ ���̺�� �ɸ����Ÿ��� ���̺� ���� Ű���� � ������� �����ִ��� �ľ��� �����ϴ�
                                                    
alter table (���̺��) disable constraint (�������Ǹ�) cascade;  -- �̷��� �о������ ��ǥ���̺�� �ɸ����Ÿ��� ���̺� �ɷ��ִ�
                                                              -- ���� Ű���� �ѹ��� �� Ǯ����� �� ����. ��� Ǯ��� �Ұ�����.
                                                              
select constraint_name, table_name, status from user_constraints where table_name IN (('��ǥ ���̺��'),('�ɸ����Ÿ��� ���̺��'));
-- �ٽ� Ű ������ Ȯ���� �� �ִ� �ڵ带 �Է��غ��� ��� Ű���� DIASABLED �� ���� �� �� ����.

-- ���������� ���� (alter table): ���� ���̺��� ���� ������ ������

create table emp_copy50 as select * from employee;  -- ���� �������� ������ �ǽ��� ���̺���� ������ ��
create table dept_copy50 as select * from department; -- �ٸ� �̷��� �����ص� ���������� ������ �� ����.

select * from user_constraints
where table_name in ('EMPLOYEE','DEPARTMENT'); -- ���� ���̺��� ���� ���� ��ȸ - 3���� ���� ����

select * from user_constraints
where table_name in ('EMP_COPY50','DEPT_COPY50'); -- ���� ���̺��� ���� ���� ��ȸ - 0�� - ���������� ������� ����

select * from emp_copy50

alter table emp_copy50
add constraint PK_emp_copy50_eno Primary Key (eno); --  add constraint �������Ǹ� Primary Key (�ش� �÷���);

alter table dept_copy50
add constraint PK_dept_copy50_dno Primary Key (dno);

alter table emp_copy50
add constraint FK_emp_copy50_dno_dept_copy50 Foreign Key (dno) references dept_copy50 (dno);

-- NOT NULL ���� ���� �߰�
  -- �ٸ� �������ǵ�� ������ �ٸ�. add ��� modify�� �����.

desc employee;
desc emp_copy50; -- Not Null�� ���� �ʾ�����, Primary Key ���� ������ not null�� �ڵ����� �Ҵ���.
desc department;
desc dept_copy50; -- Not Null�� ���� �ʾ�����, Primary Key ���� ������ not null�� �ڵ����� �Ҵ���.

-- �翬�� �̾߱�����, ������ null ���� �ִ� ������ ������ �� ����

select ename from emp_copy50
where ename is null -- ���� �ش� �÷��� null ���� �ִ����� üũ��

alter table emp_copy50
modify ename constraint NN_emp_copy50_ename not null; --modify (�÷���) constraint (�������Ǹ�) not null;

alter table emp_copy50
modify commission constraint NN_emp_copy50_commission not null;  -- cannot enable: null values found

update emp_copy50
set commission = 0
where commission is null; --  commission �÷��� null ���� 0���� ��ü��

alter table emp_copy50
modify commission constraint NN_emp_copy50_commission not null;  -- null ���� �������� ���������� �����

desc emp_copy50; -- commission �÷��� not null�� ���������� ����Ǿ����� �� �� ����.

-- Unique ���� ����: �÷��� �ߺ��� ���� ������ �Ҵ��� �� ����

select ename, count(*)
from emp_copy50
group by ename
having count (*)>2; -- ename �÷��� �ߺ��� ���� �ִ��� Ȯ���ϴ� �ڵ� : ��� ��� ����

alter table emp_copy50
add constraint UK_emp_copy50_enmae unique (ename);

-- check ���� ���� �߰�: ��� �÷��� �����͵��� üũ ���� ���� �ȿ� �����ص� ���� ��ġ�ؾ� ��

alter table emp_copy50
add constraint CK_emp_copy50_salary check ( salary > 0 and salary < 100000);

--default ���� ���� �߰�
    -- ��� default�� ���������� �ƴ�. ��� �������Ǹ��� �Ҵ��� �� ����. �⺻���� ������.
    -- ���� ���� ���� ��� default ���� ���� ��.
    
alter table emp_copy50
modify salary default 1000;

insert into emp_copy50 (eno, ename, commission)
values (9999,'JULI',100);

alter table emp_copy50
modify hiredate default sysdate;

insert into emp_copy50
values (8888,'JULLIA',NULL, NULL, DEFAULT, DEFAULT, 1500, NULL);

-- �������� ���� : alter table ���̺�� drop

alter table emp_copy50
drop primary key;

alter table dept_copy50 -- �̰�쿡�� �ȵ�. this key is referenced by some foreign keys  ��µ�
drop primary key cascade; -- ���� ���� �ٸ� Ű���� ������ �Ŀ� primary key�� ������

select * from user_constraints
where table_name in ('EMP_COPY50','DEPT_COPY50');

--not null �÷� ����: - ���� ���� �̸����� �����ϱ�

alter table emp_copy50
drop constraint NN_EMP_COPY50_ENAME;  

alter table emp_copy50
drop constraint UK_EMP_COPY50_ENMAE;  

alter table emp_copy50
drop constraint NN_EMP_COPY50_COMMISSION;  

--default�� null ��� �÷��� default null�� ����: default ���� ������ �����ϴ� ��.
  -- default�� ���������� �ƴϱ� ������ �̷��� null�� ���� ���½�Ŵ.

alter table emp_copy50
modify hiredate default null;

-- �������� isable & enable
    -- ���� ������ ��� ������Ŵ.
    -- �뷮���� �����͸� �ִ� ���(bulk insert)�� ���ϰ� ���� �ɸ���  disable => enable
    -- index�� �����ÿ� ���ϰ� ���� �ɸ��� disable => enable

alter table dept_copy50
add constraint PK_dept_copy50_dno Primary Key (dno);

alter table emp_copy50
add constraint PK_emp_copy50_eno Primary Key (eno);

alter table emp_copy50
add constraint FK_emp_copy50_dno Foreign Key (dno) references dept_copy50(dno);

select * from user_constraints
where table_name in ('EMP_COPY50','DEPT_COPY50')

select * from emp_copy50;
select * from dept_copy50;

insert into emp_copy50 (eno, ename, dno)
values(8989, 'aaaa', 50); -- Foreign key ������ �Է��� �Ұ�����

alter table emp_copy50
disable constraint FK_emp_copy50_dno; -- Foreign key ��� �ߴ�

insert into emp_copy50 (eno, ename, dno)
values(8989, 'aaaa', 50); -- �ٽ� ���������� �־���

insert into dept_copy50
values(50, 'DINGDOO', 'INCHEON');  -- emp_copy50 ���̺��� dno = 50�� �����ϴ� ���� dept_copy50 ���̺��� �־���











