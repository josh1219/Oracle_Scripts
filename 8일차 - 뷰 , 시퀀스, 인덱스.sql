8���� - �� , ������, �ε��� 
/*
    �� (view) : ������ ���̺���  �� (view)�� �Ѵ�. 
        -- ���̺��� ����Ÿ ���� ������ �ִ�. 
        -- ��� ������ ���� ������ �ʴ´�. ���� �ڵ常 �� �ִ�. 
        -- �並 ����ϴ� ���� : 
            1. ������ ���ؼ� : ���� ���̺��� Ư�� �÷��� �����ͼ� ���� ���̺����߿� �÷��� ����� �ִ�. 
            2. ������ ������ �並 �����ؼ� ���ϰ� ����� �� �ִ�. (������ JOIN ����)
        - ��� �Ϲ������� select ������ �´�.
        - ��� insert, update, delet ������ �ü� ����. 
        - �信 ���� insert �ϸ� ���� ���̺� ����ȴ�. ���� ���̺��� ���������� �� �����ؾ� �ȴ�.
        - �信 ���� insert  �Ұ�� ���� ���̺��� �������ǿ� ���� inset �� ���� �ְ� �׷��� ���� �����ִ�. 
        - �׷��Լ��� ������ view���� insert  �� �� ����. 
*/ 

create table dept_copy60
as 
select * from department; 

create table emp_copy60
as 
select * from employee; 

-- �� ���� 
Create view v_emp_job 
as 
select eno, ename, dno, job
from emp_copy60 
where job like 'SALESMAN' 

-- �� ���� Ȯ�� 
select * from user_views; 

-- ���� ����  ( select * from ���̸�) 
select * from v_emp_job 


-- ������ ���� ������ �信 ����� �α� 

create view v_join 
as 
select e.dno, ename, job, dname, loc 
from employee e, department d
where e.dno = d.dno 
and job = 'SALESMAN' 

select * from v_join  

-- �並 ����ؼ� ���� ���̺��� �߿��� ���� �����. (����) 

select * from emp_copy60; 

create view simple_emp 
as 
select ename, job, dno 
from emp_copy50 

select * from simple_emp  -- view�� ����ؼ� ���� ���̺��� �߿� �÷��� �����.  

select * from user_views; 

--  �並 �����Ҷ� �ݵ�� ��Ī �̸��� ����ؾ� �ϴ� ��� , group by �Ҷ� 

create view v_groupping 
as
select dno , count(*) groupCount, AVG(salary )  AVG , SUM (salary ) SUM 
from emp_copy60
group by dno 

select * from v_groupping 


-- �並 �����Ҷ� as ������ select ���� �;��Ѵ�. insert, update, delete ���� �� �� ����. 
create view v_error 
as 
insert into dno 
values ( 60 , 'HR', 'PUSAN') 

-- view �� ���� insert �� �� ������? �÷��� ���� ������ �����ϸ� view���� ���� ���� �� �ִ�. 
    -- ���� ���̺� ���� insert �ȴ�. 
    
create view v_dept
as 
select dno, dname 
from dept_copy60

select * from v_dept

insert into v_dept      -- View �� ���� Insert, ���������� ��ġ�Ҷ� �� insert  �ȴ�. 
values ( 70 , 'HR') 

select * from dept_copy60

create or replace view v_dept    -- v_dept�� �������� ���� ���: create, ������ ��� : replace (����) 
as 
select dname, loc 
from dept_copy60 

select * from v_dept

insert into v_dept
values ('HR2' , 'PUSAN') 

select * from v_dept
select * from dept_copy60 

update dept_copy60
set dno = 80 
where dno is null 
commit

alter table dept_copy60
add constraint PK_dept_copy60 Primary key (dno)

select * from user_constraints

where table_name = 'DEPT_COPY60'

select * from v_dept

insert into v_dept
values ('HR3', 'PUSAN2') 


select * from user_views; 

select * from v_groupping   -- �׷��ε�  view ���� insert  �� �� ����. 

create or replace view v_groupping 
as 
select dno , count(*) groupCount, round(AVG(salary ),2)  AVG , SUM (salary ) SUM 
from emp_copy60
group by dno

select * from v_groupping

drop view v_groupping 

-- insert, update, delete �� ������ �� 
create view v_dept10
as 
select dno, dname , loc 
from dept_copy60 

insert into v_dept10 
values ( 90, 'HR4', 'PUSAN4')

select * from v_dept10; 

update v_dept10
set dname = 'HR5' , loc = 'PUSAN5' 
where dno = 90 

delete v_dept10 
where dno = 90 

commit

--�б⸸ ������ �並 ���� : (insert , update, delete ���ϵ��� ���� )  

create view v_readonly 
as 
select dno, dname, loc
from dept_copy60  with read only ;

select * from v_readonly

insert into v_readonly
values ( 88, 'HR7', 'PUSAN7' ) 

update v_readonly
set dname = 'HR77' , loc = 'PUSAN77' 
where dno = 88

delete v_readonly
where dno = 88 





08 ���̺� ���� ���� ����   <<�Ϸ� �ð� : 12: 20>>

1. ���� ǥ�� ��õ� ��� DEPT ���̺��� ���� �Ͻÿ�. 

�÷���	������Ÿ��	ũ��	NULL
---------------------------------------------------------------
DNO	    number		2	NOT NULL
DNAME	varchar2	14	NULL
LOC	    varchar2	13	NULL

select * from user_tables  --������ ���� : �ý����� ���� ������ ��� 
where table_name = 'DEPT' 

drop table dept; 

Create table dept (
    dno number(2) not null 
    , dname varchar2 (14) null 
    , loc varchar2 (13) null
    )


2. ���� ǥ�� ��õ� ��� EMP ���̺��� ���� �Ͻÿ�. 

�÷���	������Ÿ��	ũ��	NULL
---------------------------------------------------------------
ENO	    number		4	NOT NULL
ENAME	varchar2	10	NULL
DNO	    number		2	NULL

drop table EMP;

create table emp (
    eno number (4)  not null
    , ename varchar2(10) null
    , dno number(2) null 
    )
 -- DB  ������ ���� , NULL ��� ���ΰ� �ٸ��� ���õǾ� ���� �� �ִ�. 
 



3. ���̸��� ���� �� �ֵ��� EMP ���̺��� ENAME �÷��� ũ�⸦ �ø��ÿ�. 

�÷���	������Ÿ��	ũ��	NULL
---------------------------------------------------------------
ENO	    number		4	NOT NULL
ENAME	varchar2	25	NULL		<<==���� �÷�  : 10 => 25  �� �ø�
DNO	    number		2	NULL

alter table emp 
modify ename varchar2(25) 

desc emp

select length (ename) from employee
where length (ename) > 5


4. EMPLOYEE ���̺��� �����ؼ� EMPLOYEE2 �� �̸��� ���̺��� �����ϵ� �����ȣ, �̸�, �޿�, �μ���ȣ �÷��� �����ϰ� ���� ������ ���̺��� �÷����� ���� EMP_ID, NAME, SAL, DEPT_ID �� ���� �Ͻÿ�. 
create table employee2
as 
select eno, ename, salary, dno from employee; 

select * from employee2

-- ���̺� ����� ���������� ���� ���� �ʴ´�. 
    -- Primary Key, Unique, not null, check, Foreign Key, default  




5. EMP ���̺��� ���� �Ͻÿ�. 
 drop table emp
 

6. EMPLOYEE2 �� ���̺� �̸��� EMP�� ���� �Ͻÿ�. 
rename employee2 to emp ; 

desc employee2; 
desc emp; 

7. DEPT ���̺��� DNAME �÷��� ���� �Ͻÿ�
select * from dept; 

-- ���� ��ϴ� �ý��ۿ����� ���ڵ尡 ���� ����ִ�. �÷����Ž� ���ϰ� ���� �߻�, (�߰�)

alter table dept 
drop column dname 


8. DEPT ���̺��� LOC �÷��� UNUSED�� ǥ�� �Ͻÿ�.  <== ������ �÷��� ��Ȱ��ȭ. (�����ð�)
alter table dept 
set unused ( loc ) ; 


9. UNUSED Ŀ���� ��� ���� �Ͻÿ�.  (�߰��� �۾�)
alter table dept 
drop unused columns; 



09 - ������ ���۰� Ʈ����� ����. 
========================================

1. EMP ���̺��� ������ �����Ͽ� EMP_INSERT �� �̸��� �� ���̺��� ����ÿ�.  <<hiredate �÷���  date �ڷ������� �߰��ϼ���.>>

select * from emp 

create table emp_insert 
as
select * from emp  
where 0=1          --  ������ false �� �����ϸ� 


2. ������ EMP_INSERT ���̺� �߰��ϵ� SYSDATE�� �̿��ؼ� �Ի����� ���÷� �Է��Ͻÿ�. 

select * from emp_insert 

-- ���̺� �÷��� �߰��Ҷ���  NULL ����ϸ鼭 �߰� �ؾ� ��. 

alter table emp_insert 
add hiredate date; 

desc emp_insert; 

insert into emp_insert (eno, ename, salary, dno, hiredate)
values ( 1000, 'ȫ�浿', 3000.35 , 10, sysdate ) 
commit; 

3. EMP_INSERT ���̺� �� ����� �߰��ϵ� TO_DATE �Լ��� �̿��ؼ� �Ի����� ������ �Է��Ͻÿ�. 
insert into emp_insert (eno, ename, salary, dno, hiredate)
values ( 1001, '�����', 3000.35 , 10, to_date (sysdate -1) ) 
commit;

4. employee���̺��� ������ ������ �����Ͽ� EMP_COPY�� �̸��� ���̺��� ����ÿ�. 
create table emp_copy
as
select * from employee

5. �����ȣ�� 7788�� ����� �μ���ȣ�� 10������ �����Ͻÿ�. [ EMP_COPY ���̺� ���] 
select * from emp_copy

update emp_copy
set dno = 10
where eno = 7788        -- ���� :  UPDATE, DELETE �� �ݵ�� ������ ���. 

commit;         -- Ʈ����� ó�� 

rollback; 

6. �����ȣ�� 7788 �� ��� ���� �� �޿��� �����ȣ 7499�� ������ �� �޿��� ��ġ �ϵ��� �����Ͻÿ�. [ EMP_COPY ���̺� ���] 

select * from emp_copy where eno = 7788
select * from emp_copy where eno = 7499

update emp_copy
set job = (select job from emp_copy where eno = 7788), 
    salary = (select salary from emp_copy where eno = 7788)
where eno = 7499; 


7. �����ȣ 7369�� ������ ������ ����� �μ���ȣ�� ��� 7369�� ���� �μ���ȣ�� ���� �Ͻÿ�. [ EMP_COPY ���̺� ���] 
select * from emp_copy where eno = 7369; 







8. department ���̺��� ������ ������ �����Ͽ� DEPT_COPY �� �̸��� ���̺��� ����ÿ�. 
drop table dept_copy; 

create table dept_copy 
as
select * from department; 


9. DEPT_COPY�� ���̺��� �μ����� RESEARCH�� �μ��� ���� �Ͻÿ�. 
select * from dept_copy; 

delete dept_copy
where dname = 'RESEARCH'
commit




10. DEPT_COPY ���̺��� �μ���ȣ�� 10 �̰ų� 40�� �μ��� ���� �Ͻÿ�. 
delete dept_copy 
where dno in ( 10, 40 ) 
commit



10 : ������ ���Ἲ�� ���� ����, 11 �� : �Ϸ� �ð� <<6:20��>>

1. employee ���̺��� ������ �����Ͽ� emp_sample �� �̸��� ���̺��� ����ÿ�. 
��� ���̺��� �����ȣ �÷��� ���̺� ������ primary key ���������� �����ϵ� 
�������� �̸��� my_emp_pk�� �����Ͻÿ�. 

--���̺� �����Ҷ� ���������� ������� �ʴ´�. Alter table�� ����ؼ� �־���� �Ѵ�. 
create table emp_sample 
as 
select * from employee
where 0=1; 

select * from emp_sample; 

alter table emp_sample 
add constraint PK_emp_sample_eno Primary Key (eno) ; 

select * from user_constraints 
where table_name = 'EMP_SAMPLE' 


2. department ���̺��� ������ �����Ͽ� dept_sample �� �̸��� ���̺��� ����ÿ�. 
�μ� ���̺��� �μ���ȣ �÷��� ������ primary key ���� ������ �����ϵ� ���� �����̸��� my_dept_pk�� �����Ͻÿ�. 
create table dept_sample
as
select * from department
where 0=1

alter table dept_sample
add constraint PK_dept_sample_dno Primary Key (dno); 

select * from user_constraints
where table_name = 'DEPT_SAMPLE' 


3. ��� ���̺��� �μ���ȣ �÷��� �������� �ʴ� �μ��� ����� �������� �ʵ��� 
�ܷ�Ű ���������� �����ϵ� ���� �����̸��� my_emp_dept_fk �� �����Ͻÿ�. 
[���� : �� ������ ���̺��� ����Ͻÿ�]
select * from emp_sample ; 
select * from dept_sample ; 

alter table emp_sample 
add constraint FK_emp_sample_dno_dept_sample Foreign Key (dno) references dept_sample(dno); 

select * from user_constraints
where table_name in ( 'EMP_SAMPLE', 'DEPT_SAMPLE') ; 



4. ������̺��� Ŀ�Լ� �÷��� 0���� ū ������ �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. 
[���� : �� ������ ���̺��� ����Ͻÿ�]

select * from emp_sample 

alter table emp_sample 
add constraint CK_emp_sample_commission check ( commission >= 0 ) 


5. ������̺��� ���� �÷��� �⺻ ������ 1000 �� �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
-- alter table 
-- modify          <== default, Not NULL 


alter table emp_sample 
modify salary default 1000


6. ������̺��� �̸� �÷��� �ߺ����� �ʵ���  ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]

select * from user_constraints
where table_name in ( 'EMP_SAMPLE', 'DEPT_SAMPLE') ;

alter table emp_sample 
add constraint UK_emp_sample_ename Unique (ename) ; 


7. ������̺��� Ŀ�Լ� �÷��� null �� �Է��� �� ������ ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
alter table emp_sample 
modify commission NOT NULL ; 



8. ���� ������ ��� ���� ������ ���� �Ͻÿ�. 
select * from user_constraints
where table_name in ( 'EMP_SAMPLE', 'DEPT_SAMPLE') ;


 -- ���� ������ ���Ž� : Foreign Key �����ϸ� ���Ű� �ȵȴ�. 
    -- 1. Foreign Key�� ���� ������ Primary Key ���� 
    -- 2. Primary Key�� �����Ҷ� cascade �ɼ��� ��� : Foreign Key ���� ���ŵǰ� Primary Key�� ���ŵ�. 
    
alter table dept_sample 
drop Primary key cascade;

alter table emp_sample 
drop constraint PK_EMP_SAMPLE_ENO ; 

alter table emp_sample 
drop constraint CK_EMP_SAMPLE_COMMISSION ; 

alter table emp_sample 
drop constraint UK_EMP_SAMPLE_ENAME ; 

alter table emp_sample 
drop constraint SYS_C007135 ; 


�� ���� 

1. 20�� �μ��� �Ҽӵ� ����� �����ȣ�� �̸��� �μ���ȣ�� ����ϴ� select ���� �ϳ��� view �� ���� �Ͻÿ�.
	���� �̸� : v_em_dno  
    -- �� : ������ ���̺� , select ���� �ü� �ִ�. 
        -- ������ ���ؼ� - ���� ���̺��� �÷��� ����� �ִ�.  
        -- ���Ǽ��� ���ؼ� : ������ ������ view�� �����ϸ� , ������ Join 
    create table emp_view 
    as 
    select * from employee;
    
    create table dept_view
    as 
    select * from department; 
    
    --�� ����
    create view v_em_dno 
    as 
    select eno,ename, dno from emp_view
    where dno = 20 
    
    --�� ���� 
    select * from v_em_dno; 
    
2. �̹� ������ ��( v_em_dno ) �� ���ؼ� �޿� ���� ��� �� �� �ֵ��� �����Ͻÿ�. 
   create or replace view v_emp_dno    
   as 
   select eno,ename, dno , salary from emp_view
   where dno = 20 



3. ������  �並 ���� �Ͻÿ�. 
drop view v_emp_dno 

4. �� �μ��� �޿���  �ּҰ�, �ִ밪, ���, ������ ���ϴ� �並 ���� �Ͻÿ�. <<���� : ��Ī�̸� ����ؾ���.>>
	���̸� : v_sal_emp
    
    create or replace view  v_sal_emp
    as 
    select min (salary) MIN , max (salary) MAX, round (avg(salary),2) AVG , sum(salary) SUM
    from emp_view 
    group by dno 
    
    select * from v_sal_emp 
    
    
5. �̹� ������ ��( v_em_dno ) �� ���ؼ� << �б����� ���>>  �����Ͻÿ�. 

    create or replace view  v_sal_emp
    as 
    select min (salary) MIN , max (salary) MAX, round (avg(salary),2) AVG , sum(salary) SUM
    from emp_view 
    group by dno  with read only; 










������ ����. 

1. emp01 ���̺��� �Ʒ��� ���� �����Ͻÿ�. 

�÷���	������Ÿ��	ũ��	NULL		��������
-----------------------------------------------------------------------------------
empno	number		4	NOT NULL	Primary key
ename	varchar2		10	NULL
hiredate	date			NULL

2. emp01 ���̺��� �����ȣ�� �ڵ����� �����ǵ��� �������� ���� �Ͻÿ�. 
   �ʱⰪ : 1
   ������ : 1
   �ִ밪 : 100000

3. �����ȣ�� �������� ���� �߱� �����ÿ�. 




















