-- 4����
/*
    �׷� �Լ� : ������ ���� ���ؼ� �׷����ؼ� ó���ϴ� �Լ�
        group by ���� Ư�� �÷��� ���� �� ���, �ش� �÷��� ������ ������ �׷����ؼ� ������ ����.
        
    �����Լ� : 
        - SUM : �׷��� �հ�
        - AVG : �׷��� ���
        - MAX : �׷��� �ִ밪
        - MIN : �׷��� �ּҰ�
        - COUNT : �׷��� �� ���� (���ڵ� �� record, �ο� �� row)
*/

select sum (salary), round (avg (salary)), max (salary), min (salary)
from employee;

-- ���� : ���� �Լ��� ó�� �� ��, ��� �÷��� ���� ������ ������ �÷��� ����

select sum (salary)
from employee;

select ename
from employee;

select * from employee;

-- �����Լ��� null ���� ó���ؼ� �����Ѵ�.
select sum (commission), avg(commission), max(commission), min(commission)
from employee;

-- count () : ���ڵ� ��, �ο� ��
    -- NULL�� ó������ �ʴ´�.

select eno from employee;
select count (eno) from employee;

select commission from employee;
select count(commission) from employee;

select count(*) from employee;
select *from employee;

-- ��ü ���ڵ� ī��Ʈ
select count(*) from employee;
select count(eno) from employee;

-- �ߺ����� �ʴ� ������ ����
select job from employee;

select count (distinct job) from employee;

-- �μ��� ���� (dno)

select count (distinct dno) from employee;

-- Group by : Ư�� �÷��� ���� �׷��� �Ѵ�. �ַ� �����Լ��� select ������ ���� ����Ѵ�.
/*
    select �÷���, �����Լ� ó���� �÷�
    from ���̺�
    where ����
    group by �÷���
    having ���� (group by�� ����� ����)
    order by ����
 
*/

select dno as �μ���ȣ , avg(salary) as ��ձ޿�
from employee
group by dno;   -- dno �÷��� �ߺ��� ���� �׷��� �Ѵ�.

select dno from employee order by dno;

--��ü ��� �޿�.

select avg(salary) as ��ձ޿�
from employee;

-- group by�� ����ϸ鼭 select���� ������ �÷��� �� �����ؾ� �Ѵ�.
select dno , count(dno), sum (salary) , avg(salary), max(commission), min(commission)
from employee
group by dno;

-- 
select job from employee;

-- ������ ��å�� �׷����ؼ� ������ ���, �հ�, �ִ밪, �ּҰ��� ���.

select job, count(job), avg(salary), sum (salary), max(commission), min(commission)
from employee
group by job        -- ������ ��å�� �׷����ؼ� ���踦 �Ѵ�.

-- ���� �÷��� �׷��� �ϱ�.

select dno, job, count(*), sum (salary)
from employee
group by dno, job;             -- �� �÷� ��� ��ġ�ϴ� ���� �׷���

select dno, job
from employee
where dno = 20 and job = 'CLERK';

-- having : group by���� ���� ����� �������� ó�� �� ��.
    -- ��Ī�̸��� �������� ����ϸ� �ȵȴ�.
    
--�μ��� ������ �հ谡 9000 �̻� ���.
select dno, count(*), sum (salary) �μ����հ�, round (avg(salary) , 2) as �μ������
from employee
group by dno
having sum (salary) > 9000;

--�μ��� ������ ����� 2000 �̻� ���.
select dno, count(*), sum (salary) �μ����հ�, round (avg(salary) , 2) as �μ������
from employeeen
group by dno
having round (avg(salary) , 2) > 2000.00;

-- ������ 1500 ���ϴ� �����ϰ� �� �μ����� ������ ����� ���ϵ� ������ ����� 2500�̻��� �͸� ����϶�.
select dno, count(*), round( avg(salary)) as �μ������
from employee
where salary > 1500
group by dno
having round( avg(salary)) > 2500

-- ROLLUP
--CUBE
    -- Group by ������ ����ϴ� Ư���� �Լ�
    -- ���� �÷��� ���� �� �� �ִ�.
    -- group by ���� �ڼ��� ������ ���...

-- Rollup, cube�� ������� �ʴ� ���    
SELECT dno, count(*), sum(salary), round(avg(salary)) 
from employee
group by dno
order by dno;

-- rollup ���: �μ��� �հ�� ����� ��� ��, ������ ���ο� ��ü�� ���� �� �÷��� �����
--              �Լ��� �ٽ� ����ؼ� �ش� �÷� ��ü�� ���� �����.
SELECT dno, count(*), sum(salary), round(avg(salary)) 
from employee
group by ROLLUP(dno)
order by dno;

--cube:  �μ��� �հ�� ����� ��� ��, ������ ���ο� ��ü �հ�, ���
SELECT dno, count(*), sum(salary), round(avg(salary)) 
from employee
group by cube(dno)
order by dno;

-- rollup ���: �� �÷� �̻� ��� ��� ������.
SELECT dno, job, count(*), max(salary), sum(salary), round(avg(salary)) 
from employee
group by ROLLUP(dno, job) -- �ΰ��� �÷��� �����, �� �÷��� ��� ù��° ���� ������ ��

SELECT dno, job, count(*), max(salary), sum(salary), round(avg(salary)) 
from employee
group by (dno, job) -- �ΰ��� �÷��� �����, �� �÷��� ��� ù��° ���� ������ ��
order by dno asc;             -- �ι�° �÷����� ���� ������ �õ���

-- cube
SELECT dno, job, count(*), max(salary), sum(salary), round(avg(salary)) 
from employee
group by cube(dno, job)
order by dno, job

-- JOIN : ���� ���̺��� ���ļ� �� ���̺��� �÷��� �����´�.
    -- department �� employee�� ������ �ϳ��� ���̺� �̾����� �𵨸�(�ߺ�����, �������)�� ���ؼ� �� ���̺��� �и�
    -- �� ���̺��� ����Ű �÷� (dno) , employee ���̺��� dno �÷��� department ���̺��� dno �÷��� �����Ѵ�.
    -- �ΰ� �̻��� ���̺��� �÷��� JOIN������ ����ؼ� ���.

select * from department;       -- �μ������� �����ϴ� ���̺�
select * from employee;         -- ��������� �����ϴ� ���̺�\

-- EQUI JOIN : ����Ŭ���� ���� ���� ����ϴ� JOIN , Oracle������ ��밡��
    -- from �� : ���� �� ���̺��� , �� ó��.
    -- where �� : �� ���̺��� ������ Ű �÷��� " = " �� ó��
        -- and �� : ������ ó��
    -- on �� : �� ���̺��� ������ Ű �÷��� " = " �� ó��
        -- where �� : ������ ó��
        
-- Where �� : ���� Ű �÷��� ó���� ���
select *
from department,employee
where department.dno = employee.dno     -- ���� Ű ����
and job = 'MANAGER'                     -- ������ ó��

-- ANSI ȣȯ : INNER JOIN     <== ��� SQL���� ��� ������ JOIN
-- ON �� : ���� Ű �÷��� ó���� ���
select *
from employee e JOIN department d
on e.dno = d.dno 
where job = 'MANAGER';

-- join�� ���̺� �˸�� (���̺� �̸��� ��Ī���� �ΰ� ���� ���)
select *
from employee e, department d
where e.dno = d.dno
and salary > 1500;

-- select ������ ������ Ű �÷��� ��½ÿ� ��� ���̺��� �÷����� ��� : dno
select eno, job,d.dno, dname
from employee e, department d
where e.dno = d.dno

-- �� ���̺��� JOIN �ؼ� �μ���[��]�� ����(salary)�� �ִ밪�� ����� ������.
select dname , count(*) , max(salary)
from department d , employee e
where d.dno = e.dno
group by dname;

-- NATURAL JOIN : Oracle 9i ����
    -- EQUI JOIN�� Where ���� ����. : �� ���̺��� ������ Ű �÷��� ���� " = "
    -- ������ Ű �÷��� Oracle ���������� �ڵ����� �����ؼ� ó��.
    -- ���� Ű �÷��� ��Ī �̸��� ����ϸ� ������ �߻�.
    -- �ݵ�� ���� Ű �÷��� ������ Ÿ���� ���ƾ� �Ѵ�.
    -- from ���� natural join Ű���带 ���.
    
select eno, ename, dname, dno
from employee e natural join department d

-- ���� : select ���� ����Ű �÷��� ��½� ���̺���� ����ϸ� ���� �߻�.

-- EQUI JOIN vs NATURAL JOIN�� ���� Ű �÷� ó��
    -- EQUI JOIN : select���� �ݵ�� ���� Ű �÷��� ��� �� �� ���̺���� �ݵ�� ���.
    -- NATURAL JOIN : select���� �ݵ�� ���� Ű �÷��� ��� �� �� ���̺���� �ݵ�� ������� �ʾƾ� �Ѵ�.
    
-- EQUI
select ename, salary, dname, d.dno      -- e.dno : EQUI JOIN ������ ���
from employee e, department d
where e.dno = d.dno
and salary > 2000;

--NATURAL
select ename, salary, dname, dno        -- dno : NATURAL JOIN ������ ���̺� ���� ����ϸ� �ȵȴ�.
from employee e natural join department d
where salary >2000;

-- ANSI : INNER JOIN
select ename , salary, dname, e.dno
from employee e join department d
on e.dno = e.dno;
where salary > 2000;

-- NON EQUI JOIN : EQUI JOIN���� Where ���� "="�� ������� �ʴ� JOIN

select * from salgrade; -- ������ ����� ǥ���ϴ� ���̺�

select ename, salary, grade
from employee, salgrade
where salary between losal and hisal;

-- ���̺� 3�� ����
select ename, dname, salary, grade
from employee e, department d, salgrade s
where e.dno = d.dno
and salary between losal and hisal





