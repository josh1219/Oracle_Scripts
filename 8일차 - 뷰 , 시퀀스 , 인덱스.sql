-- 8���� view, sequence, index

/* �� (view) 

- ������ ���̺��� ���� Ī��. 
- ���̺��� �����Ͱ��� ��������, ��� �����Ͱ��� ������ ����.
- ������ ���� �ڵ常�� ������ ����.
- �׷�����, �並 ����ϴ� ������ ������ ����.
        1. ����: ���� ���̺��� Ư�� �÷����� ������ �� �־, ���� ���� ������.
        2. ������ ����(ex ������ join ����)�� �並 ���ϸ� ���ϰ� ����� ������ 
- ��� �Ϲ������� select �������� ����Ѵ�
- �� ������ as �������� insert, update, delete ����� �Ұ����ϴ�.
- �ٸ� �� ��ü�� insert, update, delete �ϸ� ���� ���̺� ������ �ȴ�. 
- �� �� �ݵ�� �ش� ���� ���̺��� ���� ������ �����ؾ� �Ѵ�.
- �׷��Լ��� ������ �信�� insert�� �� �� ����.

*/

create table dept_copy60
as
select * from department;

create table emp_copy60
as
select * from employee;

-- �� �����ϱ�

create view v_emp_job -- ���
as
select eno, ename, dno, job  -- �Ʒ��� �� �䰡 ������ �ڵ���� �Է���
from emp_copy60
where job like 'SALESMAN';

select * from user_views;

-- ���� ����

select * from v_emp_job; -- ���� ���̺��� �ε���

-- ������ ���� ������ ��� ó���ϱ�

create view v_join
as
select e.dno, ename, job, dname, loc
from employee e, department d
where e.dno = d.dno
and job = 'SALESMAN';

select * from v_join;

-- �並 ����ؼ� ���� ���̺��� �߿��� ���� �����

select * from emp_copy60; -- ���� ���̺��� ����

create view simple_emp -- ���� ���̺��� ������ �並 �̿��� �ҷ���
as
select ename, job, dno
from emp_copy60;

select * from simple_emp; -- ���� ���̺��� �����, �䰪�� ����ؼ� ����ڵ鿡�� ������

select * from user_views; -- ����� ���� ����� �� �ڵ�� Ȯ���� ������.

create view v_groupping
as
select dno, count(*) "number of people", trunc(AVG(salary)) "average salary", SUM(salary) "sum of salary"--  ���� �̸��� �� ��Ī���� ��������� ��
from emp_copy60
group by dno;

select * from v_groupping; -- ���������� ���̺�ó�� ��Ÿ����


-- �並 �����Ҷ��� �ݵ�� select ������ ����ؾ� ��
create view v_error
as
insert into dnop  -- �ٷ� ������ �߻���.
values (60, 'HR', 'BUSAN');

--view�� ���� insert �� �� ������? �÷��� ���� ������ �����ϸ� view���� ���� ������ �ִ�,
    -- ���� ���̺� ���� insert �Ǳ� ��
    
create view v_dept
as
select dno, dname
from dept_copy60;

select * from v_dept;

insert into v_dept   -- VIEW �� ���� INSERT �õ�
values ( 70, 'HR'); -- �޽��� �����δ� ���ԵǾ��ٰ� ��.

select * from v_dept; -- ������ �信 ���� ���Ե�
select * from department; -- �翬�ϰԵ�, ���� ����� �Ǵ� ���̺��� �Էµ��� ����.

create or replace view v_dept -- (���)�� �����ϸ� ��ü�ϰ�, ������ ���� ������
as
select dname, loc
from dept_copy60;  -- ������ �ִ� �並 ��ü�ؼ� ������ ������ �Է���.

select * from v_dept; -- ���������� �ԷµǾ� ����

insert into v_dept -- �� �ϳ��� �߰��غ���
values('HR2', 'BUSAN')

select * from v_dept; -- ���������� �ԷµǾ� ����
SELECT * FROM DEPT_COPY60;

update dept_copy60
set dno = 80
where dno is null; -- �����̸Ӹ�Ű�� �ֱ� ���� ���� �־��� ���� dno �÷��� null���� ä����.

alter table dept_copy60
add constraint PK_dept_copy60_dno Primary Key (dno); -- �����̸Ӹ� Ű �Է�

select * from user_constraints
where table_name = ('DEPT_COPY60') -- ���������� �Էµ� ����� �� �� ����.

insert into v_dept
values ('HR3','INCHEON'); -- DNO�� �Է����� �ʰ� NULL�� ���� ������ �߻���
                          -- �����̸Ӹ� Ű�� NULL �� �Է��� �ź���

-- �� ���� ��ü�ϱ�2

create or replace view v_groupping
as
select dno, count(*) "number of people", round(AVG(salary),2) "average salary", SUM(salary) "sum of salary"
from emp_copy60
group by dno;

select * from v_groupping; -- ���������� ������ ��ü��

-- �� ���� �����ϱ�
drop view v_groupping; -- ���̺� ��ü�� ������.

-- insert, update, delete�� ������ ��

create view v_dept10
as
select dno, dname, loc
from dept_copy60;

insert into v_dept10 -- insert �غ���
values (90, 'HR4', 'BUSAN');

SELECT * FROM v_dept10; -- �信 �� ���� �Ϸ�
SELECT * FROM dept_copy60; -- ���� ���̺� �� ���� �Ϸ�

update v_dept10  -- update �غ���
set dname = 'HR5', loc = 'BUSAN5'
where dno = 90;
commit;

SELECT * FROM v_dept10; -- �信 �� ������Ʈ �Ϸ�
SELECT * FROM dept_copy60; -- ���� ���̺� �� ������Ʈ �Ϸ�

delete v_dept10; -- delete �غ���

-- �б⸸ ������ �並 ����:

create view v_read_only
as
select dno, dname, loc
from dept_copy50 with read only;

select * from v_read_only;

insert into v_read_only
values (88, 'HR7', 'BUSAN7') -- v_read_only�� �б������̶�� ��� ��

UPDATE v_read_only
set dname = 'HR7', loc = 'BUSAN7', dno = 88; -- v_read_only�� �б������̶�� ��� ��

DELETE v_read_only -- v_read_only�� �б������̶�� ��� ��


