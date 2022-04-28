-- 7���� ����

1. ���� ǥ�� ��õ� ��� DEPT ���̺��� ���� �Ͻÿ�. 

�÷���	������Ÿ��	ũ��	NULL
---------------------------------------------------------------
DNO	number		2	NOT NULL
DNAME	varchar2		14	NULL
LOC	varchar2		13	NULL

Create Table dept( -- ���̺� ����
    dno number (2) not null,
    dname varchar2(14) null,
    loc varchar2(13) null
    );


2. ���� ǥ�� ��õ� ��� EMP ���̺��� ���� �Ͻÿ�. 

�÷���	������Ÿ��	ũ��	NULL
---------------------------------------------------------------
ENO	number		4	NOT NULL
ENAME	varchar2		10	NULL
DNO	number		2	NULL

Create Table EMP( -- ���̺� ����
    eno number (4) not null,
    ename varchar2(10) null,
    dno number(2) null
    );

3. ���̸��� ���� �� �ֵ��� EMP ���̺��� ENAME �÷��� ũ�⸦ �ø��ÿ�. 

�÷���	������Ÿ��	ũ��	NULL
---------------------------------------------------------------
ENO	number		4	NOT NULL
ENAME	varchar2		25	NULL		<<==���� �÷�  : 10 => 25  �� �ø�
DNO	number		2	NULL

Alter table EMP
modify ename varchar2 (25);

4. EMPLOYEE ���̺��� �����ؼ� EMPLOYEE2 �� �̸��� ���̺��� �����ϵ� �����ȣ, �̸�, �޿�, �μ���ȣ �÷��� �����ϰ� ���� ������ ���̺��� �÷����� ���� EMP_ID, NAME, SAL, DEPT_ID �� ���� �Ͻÿ�. 

create table EMPLOYEE2
as
select eno EMP_ID, ename NAME, salary SAL , dno DEPT_ID
from employee;

5. EMP ���̺��� ���� �Ͻÿ�. 

drop table EMP;

6. EMPLOYEE2 �� ���̺� �̸��� EMP�� ���� �Ͻÿ�. 

rename EMPLOYEE2 to EMP;

7. DEPT ���̺��� DNAME �÷��� ���� �Ͻÿ�

Alter table dept
drop column dname;

8. DEPT ���̺��� LOC �÷��� UNUSED�� ǥ�� �Ͻÿ�. 

Alter table dept
rename column loc to UNUSED;

9. UNUSED Ŀ���� ��� ���� �Ͻÿ�. 

Alter table dept
drop column unused;


09 - ������ ���۰� Ʈ����� ����. 
========================================

1. EMP ���̺��� ������ �����Ͽ� EMP_INSERT �� �̸��� �� ���̺��� ����ÿ�. 

create table EMP_INSERT
as
select * from EMP
where 0 = 1; 


2. ������ EMP_INSERT ���̺� �߰��ϵ� SYSDATE�� �̿��ؼ� �Ի����� ���÷� �Է��Ͻÿ�. 

Alter table EMP_INSERT
add (hiredate date);

select * from emp_insert;
desc emp_insert;

insert into EMP_INSERT (EMP_ID, name, sal, DEPT_ID, hiredate)
values (1, '������', 1000, 10, sysdate);


3. EMP_INSERT ���̺� �� ����� �߰��ϵ� TO_DATE �Լ��� �̿��ؼ� �Ի����� ������ �Է��Ͻÿ�.

insert into EMP_INSERT (EMP_ID, name, sal, DEPT_ID, hiredate)
values (2, '������', 1000, 20, to_date('2022/04/26','YYYY/MM/DD'));

4. employee���̺��� ������ ������ �����Ͽ� EMP_COPY�� �̸��� ���̺��� ����ÿ�. 

create table EMP_COPY
as
select * from employee;

5. �����ȣ�� 7788�� ����� �μ���ȣ�� 10������ �����Ͻÿ�. [ EMP_COPY ���̺� ���]

select * from EMP_COPY where eno = '7788' ; 

update EMP_COPY
set dno = 10
where eno = 7788;
commit;

6. �����ȣ�� 7788 �� ��� ���� �� �޿��� �����ȣ 7499�� ������ �� �޿��� ��ġ �ϵ��� �����Ͻÿ�. [ EMP_COPY ���̺� ���] 

select * from EMP_COPY where eno = '7788' ;
select * from EMP_COPY where eno = '7499' ;

update EMP_COPY
set job = (select job from EMP_COPY where eno = '7499'),salary=(select salary from EMP_COPY where eno = '7499')
where eno = 7788;
commit;

7. �����ȣ 7369�� ������ ������ ����� �μ���ȣ�� ��� 7369�� ���� �μ���ȣ�� ���� �Ͻÿ�. [ EMP_COPY ���̺� ���]

select * from EMP_COPY where job = 'CLERK';

update EMP_COPY
set dno = 20
where job ='CLERK' ;
commit;

update EMP_COPY
set dno = (select dno from EMP_COPY where eno = '7369' )
where job =(select job from EMP_COPY where eno = '7369' ) ;
commit;


8. department ���̺��� ������ ������ �����Ͽ� DEPT_COPY �� �̸��� ���̺��� ����ÿ�. 

create table DEPT_COPY
as
select * from department;

9. DEPT_COPY�� ���̺��� �μ����� RESEARCH�� �μ��� ���� �Ͻÿ�. 

select * from dept_copy

delete dept_copy
where dname ='RESEARCH';
commit;

10. DEPT_COPY ���̺��� �μ���ȣ�� 10 �̰ų� 40�� �μ��� ���� �Ͻÿ�. 

select * from dept_copy

delete dept_copy
where dno = 10 or dno = 40;
commit;





