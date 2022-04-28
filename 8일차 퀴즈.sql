10 : ������ ���Ἲ�� ���� ����, 11 ��

1. employee ���̺��� ������ �����Ͽ� emp_sample �� �̸��� ���̺��� ����ÿ�. ��� ���̺��� �����ȣ �÷��� ���̺� ������ primary key ���������� �����ϵ� �������� �̸��� my_emp_pk�� �����Ͻÿ�. 
    -- ���̺� ���� �� �� ���������� ������� �ʴ´�. Alter table�� ����ؼ� �־���� �Ѵ�.
create table emp_sample
as
select * from employee
where 0 = 1;

select * from emp_sample;

alter table emp_sample
add constraint PK_emp_sample_eno Primary Key (eno) ;

select * from user_constraints
where table_name = 'EMP_SAMPLE';

2. department ���̺��� ������ �����Ͽ� dept_sample �� �̸��� ���̺��� ����ÿ�. �μ� ���̺��� �μ���ȣ �÷��� ������ primary key ���� ������ �����ϵ� ���� �����̸��� my_dept_pk�� �����Ͻÿ�. 

create table dept_sample
as
select * from department
where 0 = 1;

alter table dept_sample
add constraint PK_dept_sample_dno Primary Key (dno);

select * from user_constraints
where table_name = 'DEPT_SAMPLE';

3. ��� ���̺��� �μ���ȣ �÷��� �������� �ʴ� �μ��� ����� �������� �ʵ��� �ܷ�Ű ���������� �����ϵ� ���� �����̸��� my_emp_dept_fk �� �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]

select * from emp_sample;
select * from dept_sample;

alter table emp_sample
add constraint FK_emp_sample_don_dept_sample Foreign Key (dno) references dept_sample(dno);

select * from user_constraints
where table_name in ('EMP_SAMPLE','DEPT_SAMPLE');

4. ������̺��� Ŀ�Լ� �÷��� 0���� ū ������ �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]

select * from emp_sample

alter table emp_sample
add constraint CK_emp_sample_commission check (commission >= 0)

5. ������̺��� ���� �÷��� �⺻ ������ 1000 �� �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
-- Alter table
-- modify       <== default , not null

alter table emp_sample
modify salary default 1000;


6. ������̺��� �̸� �÷��� �ߺ����� �ʵ���  ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]

select * from user_constraints
where table_name in ('EMP_SAMPLE','DEPT_SAMPLE');

Alter table emp_sample
add constraint UK_emp_sample_ename Unique (ename);

7. ������̺��� Ŀ�Լ� �÷��� null �� �Է��� �� ������ ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]

Alter table emp_sample
modify commission not null;

8. ���� ������ ��� ���� ������ ���� �Ͻÿ�. 

select * from user_constraints
where table_name in ('EMP_SAMPLE','DEPT_SAMPLE');

-- ���� ������ ���Ž�  : Foreign Key �����ϸ� ���Ű� �ȵȴ�.
    -- 1. Foreign Key�� ���� ���� �� Primary Key ����
    -- 2. Primary Key�� ���� �� �� cascade�ɼ��� ��� : Foreign Key�� ���� ���� �� �� Primary Key�� ���� �ȴ�.

Alter table dept_sample
drop Primary Key cascade;

Alter table emp_sample
drop constraint PK_EMP_SAMPLE_ENO;

Alter table emp_sample
drop constraint CK_EMP_SAMPLE_COMMISSION;

Alter table emp_sample
drop constraint UK_EMP_SAMPLE_ENAME;

Alter table emp_sample
drop constraint SYS_C007110;

�� ���� 

1. 20�� �μ��� �Ҽӵ� ����� �����ȣ�� �̸��� �μ���ȣ�� ����ϴ� select ���� �ϳ��� view �� ���� �Ͻÿ�.
	���� �̸� : v_em_dno  
    -- �� : ������ ���̺� , select ���� �� �� �ִ�.
        -- ������ ���ؼ� ���  : ���� ���̺��� �÷��� ����� �ִ�.
        -- ���Ǽ��� ���ؼ� ��� : ������ ������ view�� �����ϸ� , ������ Join

create table emp_view
as
select * from employee;

create table dept_view
as
select * from department;

-- �� ����
create view v_emp_dno
as
select eno, ename, dno from emp_view
where dno = 20;

-- �� ����
select * from v_emp_dno;

2. �̹� ������ ��( v_em_dno ) �� ���ؼ� �޿� ���� ��� �� �� �ֵ��� �����Ͻÿ�. 

create or replace view v_emp_dno
as
select eno, ename, dno, salary from emp_view
where dno = 20;


3. ������  �並 ���� �Ͻÿ�. 
drop view v_emp_dno


4. �� �μ��� �޿���  �ּҰ�, �ִ밪, ���, ������ ���ϴ� �並 ���� �Ͻÿ�. << ���� : ��Ī �̸� ����ؾ���. >>
	���̸� : v_sal_emp

create or replace view v_sal_emp
as
select min(salary) MIN, max(salary) MAX, round(avg(salary),2) AVG, sum(salary) SUM
from emp_view
group by dno

select * from v_sal_emp

5. �̹� ������ ��( v_em_dno ) �� ���ؼ� << �б� ���� �� >>�� �����Ͻÿ�. 

create or replace view v_sal_emp
as
select min(salary) MIN, max(salary) MAX, round(avg(salary),2) AVG, sum(salary) SUM
from emp_view
group by dno with read only;



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



