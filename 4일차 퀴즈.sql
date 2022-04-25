-- 4���� ����

-- 1. ��� ����� �޿� �ְ��, ������, �Ѿ�, �� ��� �޿��� ��� �Ͻÿ�. �÷��� ��Ī�� ����(�ְ��, ������, �Ѿ�, ���)�ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø� �Ͻÿ�. 
select max (salary) �ְ��, min (salary) ������,sum (salary) �Ѿ�, round (avg (salary)) as ���
from employee;

-- 2. �� ������ �������� �޿� �ְ��, ������, �Ѿ� �� ��վ��� ����Ͻÿ�. �÷��� ��Ī�� ����(�ְ��, ������, �Ѿ�, ���)�ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø� �Ͻÿ�. 
select job,count(job), max (salary) �ְ��, min (salary) ������,sum (salary) �Ѿ�, round (avg (salary)) as ���
from employee
group by job;

-- 3. count(*)�Լ��� ����Ͽ� ��� ������ ������ ������� ����Ͻÿ�. 
select job , count(*) as "������ ������ �����"
from employee
group by job;

-- 4. ������ ���� ���� �Ͻÿ�. �÷��� ��Ī�� "�����ڼ�" �� ���� �Ͻÿ�. 
select manager, count(*) as �����ڼ�
from employee
group by manager;

-- 5. �޿� �ְ��, ���� �޿����� ������ ��� �Ͻÿ�, �÷��� ��Ī�� "DIFFERENCE"�� �����Ͻÿ�. 
select max(salary) as �ְ��, min(salary) as ������, (max(salary) - min(salary)) as DIFFERENCE
from employee;

-- 6. ���޺� ����� ���� �޿��� ����Ͻÿ�. �����ڸ� �� �� ���� ��� �� ���� �޿��� 2000�̸��� �׷��� ���� ��Ű�� ����� �޿��� ���� ������������ �����Ͽ� ��� �Ͻÿ�. 
select job, min(salary) as �����޿�
from employee
group by job
having min(salary) > 2000
order by min(salary) desc;

-- 7. �� �μ������� �μ���ȣ, �����, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�. �÷��� ��Ī�� [�μ���ȣ, �����, ��ձ޿�] �� �ο��ϰ� ��ձ޿��� �Ҽ��� 2°�ڸ����� �ݿø� �Ͻÿ�. 
select dno as �μ���ȣ, count(*) as �����, round (avg(salary) , 1) as ��ձ޿�
from employee
group by dno;

-- 8. �� �μ��� ���� �μ���ȣ�̸�, ������, �����, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�.  �ᷳ�� ��Ī�� [�μ���ȣ�̸�, ������, �����,��ձ޿�] �� �����ϰ� ��ձ޿��� ������ �ݿø� �Ͻÿ�.  
select dno, decode (dno, 10, 'ACCOUNTING',
                         20, 'RESEARCH',
                         30, 'SALES',
                         0) as �μ���ȣ�̸�,
            decode (dno, 10, 'NEW YORK',
                         20, 'DALLS',
                         30, 'CHICAGO',
                         0) as ������,
            count(*) as �����, round(avg(salary)) as ��ձ޿�
from employee
group by dno;




--------------------------------------------------------------------------------

-- ���̺� ���� ����

select * from employee;
select * from department;
-- 1. EQUI ������ ����Ͽ� SCOTT ����� �μ� ��ȣ�� �μ� �̸��� ��� �Ͻÿ�. 
select ename, e.dno, dname
from employee e, department d
where e.dno = d.dno
and ename = 'SCOTT';

-- 2. INNER JOIN�� ON �����ڸ� ����Ͽ� ����̸��� �Բ� �� ����� �Ҽӵ� �μ��̸��� �������� ����Ͻÿ�. 
select ename, dname, loc
from employee e JOIN department d
on e.dno = d.dno;

-- 3. INNER JOIN�� USING �����ڸ� ����Ͽ� 10�� �μ��� ���ϴ� ��� ��� ������ ������ ���(�ѹ����� ǥ��)�� �μ��� �������� �����Ͽ� ��� �Ͻÿ�. 
desc employee;
desc department;

select dno, job, loc
from employee e inner join department d
using(dno)
where dno = 10;

-- 4. NATUAL JOIN�� ����Ͽ� Ŀ�Լ��� �޴� ��� ����� �̸�, �μ��̸�, �������� ��� �Ͻÿ�. 
select ename, dname, loc       
from employee e natural join department d
where commission is not null;

-- 5. EQUI ���ΰ� WildCard�� ����Ͽ� �̸��� A �� ���Ե� ��� ����� �̸��� �μ����� ��� �Ͻÿ�. 
select ename, dname, e.dno     
from employee e, department d
where e.dno = d.dno
and ename like '%A%';

-- 6. NATURAL JOIN�� ����Ͽ� NEW YORK�� �ٹ��ϴ� ��� ����� �̸�, ����, �μ���ȣ �� �μ����� ����Ͻÿ�. 
select ename, job, dno, dname
from employee e natural join department d
where loc = 'NEW YORK';