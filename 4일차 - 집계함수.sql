-- 4����

-- 

/* ��������: ���̺��� �÷��� �Ҵ�Ǿ �������� ���Ἲ�� Ȯ����. �� ���� ���� �����͸� ����
            �÷����� �ʿ���ϴ� �����͸��� �޾Ƶ��̴� ������ ��.
            
-- Primary Key: ���̺� �ѹ��� ����� �� ����. �ϳ��� �÷� Ȥ�� �ΰ� �̻��� �׷����ؼ� �����.
                �ߺ��� ���� ���� �� ����, null�� ���� �� ����.
-- unuque: ���̺��� ���� �÷��� �Ҵ��� �� ����. �ٸ� �ߺ��� ���� ���� �� ����. null ���� ���� �� ������,
            �ߺ��� ���� ������ ���� ������ �� 1���� ���� �� �ִ�.
-- forign Key : �ٸ� ���̺��� Ư�� �÷��� ���� �����ؼ��� ���� �� �ִ�. �̰��� ������ �ο��̸�
                �ڽ��� �÷��� ���� ���� �Ҵ����� �����Ѵ�
-- not null: null �� ����
-- check: �÷��� ���� �Ҵ��� �� üũ�ؼ� (���ǿ� �����ϴ�) ���� �Ҵ���
-- default: ���� ���� ������ �⺻���� �Ҵ��.
*/





/* 
�׷��Լ� : ������ ���� ���� �׷����ؼ� ó���ϴ� �Լ�
grout by ������ Ư�� �÷��� ������ ���, �ش� �������� ������ ������ �׷����ؼ� ������ ������

�����Լ�:
 - suim: �׷��� �հ�
 - avg: �׷��� ���
 - max: �׷��� �ִ밪
 - min: �׷��� �ּҰ�
 - count : �׷��� �� ���� (���ڵ�� record, �ο�� row)
 */
 
 select sum (salary), round(avg(salary)), max(salary), min(salary) from employee;
 
 -- ����: �����Լ��� ó���� �� ,����÷��� ���� ������ ������ �÷��� ������
 
 select sum(salary)
 from employee;
 
 SELECT ENAME
 FROM employee;
 
 SELECT * from employee;
 -- �����Լ��� null ���� �����ؼ� ó���� ������
 select sum(commission), avg(commission), max(commission), min(commission) from employee;
 
 -- count (): ���ڵ� �� , �ο� ��
 --           �ٸ� null�� ó���� �� ����
 --           ���̺� ��ü ���ڵ� ���� ������ ��� : count (*) �Ǵ� not null �÷��� count()
 --           �̷��� ���� description�� �� �� �մ� desc ��ɾ�� �ش� ������ Ȯ���ؼ�
 --           null ���� ���θ� Ȯ���ϴ� ���� ����.
 
 desc employee;
 
select eno from employee;
select count (eno) from employee;
 
select commission from employee; -- 14�� �÷� ��µ�
select count(commission) from employee; -- 4�� ��µ� // null �÷� ���� �Ұ���

-- ��ü ���ڵ� ī��Ʈ
select count (*) from employee; -- ��ó�� ��ü �÷� ���� ī�����ϴ� ����� ����

-- �ߺ����� �ʴ� ������ ����
select job from employee; -- ��ü ���� ���
select distinct job from employee; -- �ߺ� ���� ���� ����Ʈ ���
select count(distinct job)from employee; -- �ߺ� ���� �������� ��

-- �μ��� ����
select dno from employee; -- ��ü �μ� ���
select distinct dno from employee; -- �ߺ� ���� �μ� ����Ʈ ���
select count(distinct dno) from employee; -- �ߺ� ���� �μ����� ��

/* group by : Ư�� �÷��� ���� �׷����Ѵ�. �ַ� ���� �Լ��� select ������ ���� �����.
              �ٸ� select�� ��, �׷����� �� �ִ� �÷��� �� �����ؾ� ��.

    ���� ---
    select: �÷���, �����Լ� ó���� �÷�
    from ���̺�
    where ����
    group by �÷��� (����� ���)
    having ���� (group by�� ����� ����)
    order by ����

*/

select dno �μ���ȣ, trunc(avg(salary)) ��ձ޿�
from employee
group by dno; -- �׷캰�� �� �÷����� �����ؼ� �������

select dno from employee order by dno;

-- ��ü ��� �޿�
select trunc(avg(salary)) ��ձ޿� from employee;

select dno,count(dno), sum(salary), trunc(avg(salary))
from employee 
group by dno;

-- ���� �׸�� �׷����غ���
select job ��å, count(job) �ο�, trunc(avg(salary)) ��տ���, sum(salary) "��å�� ���� �Ѿ�", 
max(salary) �ְ����, min(salary) ��������
from employee
group by job; 

-- ���� �׷���

select dno �μ���, job ����, count(*) �ο�, trunc(avg(salary)) ��տ���
from employee
group by dno, job -- �� �÷��� ��ġ�ϴ� �׸���� �׷����ϸ�, �� �÷��� �� ��ġ�� ���� ó���� ��
order by dno asc;

select dno, job
from employee
where dno = 20 and job = 'CLERK';

--having group by���� ���� ����� �������� ó���� ��
    --��Ī �̸��� �������� ����ϸ� �ȵ�.
select dno �μ���, count(*) �ο�, sum(salary) �����Ѿ�, round(avg(salary),2) �������
from employee
group by dno
having sum (salary) > 9000;

-- �μ��� ������ ����� 2000 �̻��� �μ����� ���

select dno �μ���, count(*) �ο�, sum(salary) �����Ѿ�, round(avg(salary),0) �������
from employee
group by dno
having avg(salary) > 2000;

--where�� having ���� ���� ���Ǵ� ���
    -- where: ���� ���̺��� �������� �˻�
    -- having: group by ����� ���� ������ ó����.
    
select dno �μ���, count(*) �ο�, sum(salary) �����Ѿ�, round(avg(salary),0) �������
from employee
where salary > 1500
group by dno
having avg(salary) > 2000;

-- GROUP BY �������� ����ϴ� Ư���� �Լ���.
-- ���� �÷��� ������ �� ����. ���� GROUP BY �Լ����� �ڼ��� �������� ��� ������.

-- ����
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

-- rollup ������� ���� ���: 
SELECT dno, job, count(*), max(salary), sum(salary), round(avg(salary)) 
from employee
group by (dno, job)
order by dno asc;

/* �÷��� 2���� ��� �Ѿ��ϴ� ���

   �� �������� �� ��ó�� dno�� ���ؼ� ��ü������ rollup�� ����. �׸����� �Ѿ��� ��������
   ���� A �÷��� B �÷��� ��ġ�ϴ� �ͳ��� ��Ƽ� �׷����ؼ� ���������� ROLLUP�� ����.
   �� �� ���������� ��ü ����� ���� rollup���� ������ ��.

*/

-- rollup ���: �� �÷� �̻� ��� ��� ������.
SELECT dno, job, count(*), max(salary), sum(salary), round(avg(salary)) 
from employee
group by ROLLUP(dno, job) -- �ΰ��� �÷��� �����, �� �÷��� ��� ù��° ���� ������ ��
order by dno;             -- �ι�° �÷����� ���� ������ �õ���

/* �÷��� 2���� ��� ť���ϴ� ���
   �� �������� �� ��ó�� dno�� ���ؼ� ��ü������ rollup�� ����. �׸����� �Ѿ��� ��������
   ���� A �÷��� B �÷��� ��ġ�ϴ� �ͳ��� ��Ƽ� �׷����ؼ� ���������� ROLLUP�� ����.
   ť���� �Ѿ����� �Ѵܰ� �� �ڼ��ϰ�, �տ��� �׷��κ��� rollup�� ������ ��Ƽ� �ѹ� ��
   ������� ������ ���������� ��ü ����� ���� rollup���� ������ ��.
*/
 
 --cube:  �μ��� �հ�� ����� ��� ��, ������ ���ο� ��ü �հ�
SELECT dno, job, count(*), max(salary), sum(salary), round(avg(salary)) 
from employee
group by cube (dno, job)
order by dno, job;

--JOIN : 
-- department�� employee�� ���� �ϳ��� ���̺��̾�����, �𵨸�(�ߺ�����, ��������� ȿ���� ����)�� ���ؼ� �� ���̺�� �и��Ǿ���.
-- �� ���̺��� ����Ű�� (dno) �÷�, elmplyee ���̺��� dno �÷��� department���̺��� dno �÷��� �����ϰ� ����.
-- �̷��� 2�� �̻��� ���̺��� �Բ� ������ �� join�̶�� �Լ��� ����� �����.

SELECT* FROM department; -- �μ� ������ �����ϴ� ���̺�
SELECT* FROM employee; --  ����� ������ �����ϴ� ���̺�

-- EQUI JOIN : ����Ŭ���� ���� ���� ����ϴ� JOIN, oracle������ ��� ������
    -- from��: ������ ���̺��� ","�� ó����
    -- where��: �� ���̺��� ������ Ű �÷��� "="�� ó��
    -- and��: ������ ���������� ó���ϴ� ����

select * 
from employee,department 
where department.dno = employee.dno
and job = 'MANAGER';

--join�� ���̺� �˸��ƽ�(��Īȭ - ��ϱ� ���� �˸��ƽ� �ؼ� ���� ��)
select * 
from employee e,department d 
where e.dno = d.dno
AND salary >1500;

-- select ������ ���� key colunm�� ����ϴ� ��쿡��, ��� ���̺��� �÷��� ������� ����ؾ���.
SELECT eno, job, d.dno, dname -- ���� �κ��� ����ϴ� ��쿡 �̷��� d.dno��� ��� ������� ����ؾ� ��.
from employee e, department d
where e.dno = d.dno;

-- �� ���̺��� JOIN�ؼ� �μ����� ������ �ִ밪�� ��Ÿ���ÿ�

SELECT dname, count(*), max(e.salary) 
from employee e, department d
where d.dno = e.dno
GROUP by d.dname;

-- NATURAL JOIN: ORACLE 9I ����
    --EQUI JOIN�� WHERE���� ����: �� ���̺��� ������ Ű �÷��� "="�� ������
    -- ������ Ű �÷��� oralce ���������� �ڵ����� �����ؼ� ó����.
    -- �ٸ� ���� Ű�÷��� ��Ī�̸��� ����ϸ� ������ �߻��ϴ� ������ ����.
    -- �ݵ�� ���� Ű �÷��� ������ Ÿ���� ���ƾ� ��.
    
select eno, dname, ename, dno 
from employee e natural join department d;
    
-- ����: select ���� ����Ű �÷��� ��½�, ���̺� ���� ����ϸ� ������ �߻���.

select eno, dname, ename, d.dno -- �ٸ� �÷����� �� ��������, ����Ű�÷� dno���ٰ�
from employee e natural join department d; -- ���̺� �˸��ƽ� �޸� ������

-- equi join vs natural join�� ���� Ű �÷� ó��
    -- equi join: select �κп��� ���� Ű �÷��� ����� ��, ���̺� ���� �ݵ�� ����ؾ���
    -- natural join: select �κп��� ���� Ű �÷��� ����� ��, ���̺� ���� ����ϸ� ������ ��.

--where ��: ���� Ű �÷��� ó���� ���
select * 
from employee, department
where department.dno = employee.dno  -- ���� Ű ����
and job = 'MANAGER';                 -- ������ ó��

--on��: ���� Ű �÷��� ó���� ���

select * from employee e join department d
on e.dno = d.dno  -- ���� Ű ����
where job = 'MANAGER';                 -- ������ ó��

--ANSI ȣȯ: INNER JOIN < == ��� SQL���� ��� ������ JOIN ����
    --ON ��: �� ���̺��� ������ Ű �÷��� "="�� ó��
        --WHERE ��: ������ ó����

select * from employee e INNER join department d
on e.dno = d.dno  -- ���� Ű ����
where job = 'MANAGER';                 -- ������ ó��

select * from employee e INNER join department d
on e.dno = d.dno  -- ���� Ű ����
where job = 'MANAGER';                 -- ������ ó��

-- equi join ����
select ename, salary, dname, e.dno   --e.dno: equi join������ ���
from employee e, department d
where e.dno = d.dno
and salary >2000;    --equi join�� Ư���ϰ� �������� and�� ��

-- natural join ����
select ename, salary, dname, dno   --dno: natural join������ ���̺� ����ϸ� ������
from employee e natural join department
where  salary >2000;

--  Ansi : inner join
select ename, salary, dname, e.dno  
from employee e join department d
on e.dno = d.dno
where salary >2000;

--NON EQUI JOIN : EQUI JOIN���� Where ���� "="�� ������� ���� JOIN

select * from salgrade; -- ������ ����� ǥ���ϴ� ���̺�

select ename, salary, grade
from employee, salgrade
where salary between losal and hisal;

-- ���̺� 3�� ���ν�Ű��

select ename, dname, salary, grade -- ���� ���̺��� �÷����� �����
from employee e, department d, salgrade s;


-- using�� ��� 
    -- natural join :  ���� Ű �÷��� Oracle ���ο��� �ڵ�ó���ϴ� ���
    -- �ݵ�� �� ���̺��� ���� Ű �÷��� ������ Ÿ���� ���ƾ��ϴ� ������ �ִµ�,
    -- �ٸ� ��쿡 using���� ó�� ������. ���� �������� ��쿡�� using�� �����.

-- SELECT * FROM department;

-- self join : �ڱ� �ڽ��� ���̺��� �����Ѵ�. (�ַ� ����� ��� ������ ����� �� �����)
-- ��Ī(�ٸ��)�� �ݵ�� ����ؾ� ��.

select eno, ename, manager
from employee
where manager = '7788';

-- self join�� ����� ���ӻ�� �����ȣ�� ����ϱ�

-- equi join���� self join�� ó��
select e1.eno ���, e1.ename ����, nvl(e1.manager,'0') ���ӻ��, e2.ename ���ӻ���̸�, e2.eno ���ӻ�����
from employee e1, employee e2
where e1.manager = e2.eno
order by e1.ename asc;

--ansi ȣȯ: inner join���� ó����.

select e1.eno ���, e1.ename ����, nvl(e1.manager,'0') ���ӻ��, e2.ename ���ӻ���̸�, e2.eno ���ӻ�����
from employee e1 inner join employee e2
on e1.manager = e2.eno
order by e1.ename asc;

-- equi join �� self join�� �����Ͽ� ó��

select e1.ename || '�� ���ӻ����' || e1.manager || '�Դϴ�' 
from employee e1, employee e2
where e1.manager = e2.eno
order by e1.ename asc;

select e1.ename ����, e2.ename ���ӻ����
from employee e1 join employee e2
on e1.manager = e2.eno (+)
order by e1.ename asc;


--inner join���� ó����.

select e1.ename || '�� ���ӻ����' || e1.manager || '�Դϴ�' 
from employee e1 inner join employee e2
on e1.manager = e2.eno
order by e1.ename asc;

--OUTER JOIN:
    -- Ư�� �÷��� �� ���̺��� ���������� �ʴ� ������ ����ؾ� �� ��,
    -- ������� �ʴ� �÷��� NULL�� �����
    -- ��ȣ�� ����ؼ� ����ϴ°� Oracle������ ����� ������.
    -- ANSI ȣȯ: OUTER JOIN ������ ����ؼ� �����. ��� DMMS���� ȣȯ��.

select e1.ename ����, e2.ename ���ӻ����
from employee e1 join employee e2
on e1.manager = e2.eno (+) -- ���� �ۿ��� �ҷ����̱�
order by e1.ename asc;

--ansi ȣȯ�� ����ؼ� ���
    --Left outer join: ������ �κ��� ������ ������ ������ ��� ���
    --Right outer join: ������ �κ��� ������ �������� ������ ��� ���
    --FULL outer join: ������ �κ��� ������ ���� ������ ��� ���
    
select e1.ename, e2.ename 
from employee e1 Left outer join employee e2
on e1.manager = e2.eno
order by e1.ename asc;

