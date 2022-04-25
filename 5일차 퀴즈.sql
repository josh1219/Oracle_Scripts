subquery ����. 

Join ����.

�Ϸ� �ð� : 6:20�б���.  :  ����� 12 ~ �Ͽ��� ���� 10�� : ����Ŭ : < �����ͺ��̽� ����. >

7. SELF JOIN�� ����Ͽ� ����� �̸� �� �����ȣ�� ������ �̸� �� ������ ��ȣ�� �Բ� ��� �Ͻÿ�. 
 	������ ��Ī���� �ѱ۷� �����ÿ�. 
    -- Self JOIN : �ݵ�� ���̺��� ��Ī�� ���. Select �÷��� ��� �Ҷ� ��Ī�̸�.�÷��� 
        -- �������� ���, ����� ���ӻ�� ������ ���.
    select ename, eno, manager, eno from employee;
    
    -- EQUI JOIN : ����Ŭ ������ ����ϴ� ����  , �� ���̺��� Ű�� ��ġ�ϴ� �͸� ��� 
    -- ANSI : INNER JOIN���� ��ȯ ���� ( ��� DBMS���� ���� ���� , MSSQL, MYSQL, IBM DB2)
    
    select e1.ename as ����̸�, e1.eno as �����ȣ, e1.manager �����ڹ�ȣ, e2.ename �������̸� 
    from employee e1 , employee e2
    where e1.manager = e2.eno 
    
    select * from employee; 
    
    select e1.ename as ����̸�, e1.eno as �����ȣ, e1.manager �����ڹ�ȣ, e2.ename �������̸� 
    from employee e1 Inner JOIN employee e2
    ON e1.manager = e2.eno   
    

8. OUTER JOIN, SELF JOIN�� ����Ͽ� �����ڰ� ���� ����� �����Ͽ� �����ȣ�� �������� �������� �����Ͽ� ��� �Ͻÿ�. 
   
    select e1.ename as ����̸�, e1.eno as �����ȣ, e1.manager �����ڹ�ȣ, e2.ename �������̸� 
    from employee e1 , employee e2
    where e1.manager = e2.eno (+)
    order by e1.eno desc
    
`   select e1.ename as ����̸�, e1.eno as �����ȣ, e1.manager �����ڹ�ȣ, e2.ename �������̸� 
    from employee e1 Left Outer JOIN employee e2
    ON e1.manager = e2.eno  
    order by e1.eno desc
    
9. SELF JOIN�� ����Ͽ� ������ ���<<('SCOTT')>>�� �̸�, �μ���ȣ, ������ ���('SCOTT')�� ������ �μ����� �ٹ��ϴ� ����� ����Ͻÿ�. 
   ��, �� ���� ��Ī�� �̸�, �μ���ȣ, ����� �Ͻÿ�. 
   
   select e1.ename �̸�, e1.dno �μ���ȣ, e2.ename ���� 
   from employee e1, employee e2
   where e1.dno = e2.dno               -- <== �� ���̺��� �μ� �÷��� ����Ű�� ���. 
   and e1.ename = 'SCOTT' and e2.ename != 'SCOTT' 
   
   select * from employee where ename = 'SCOTT' ; 
   select * from employee where dno = 20 
   
   select ename, dno , ename, dno from employee; 


10. SELF JOIN�� ����Ͽ� WARD ������� �ʰ� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�.
select * from employee;

select * from employee
where hiredate > '81/02/22'

select * from employee
where hiredate > to_date ( 19810222, 'YYYYMMDD')

select * from employee
where hiredate > to_date ( '1981_02_22', 'YYYY_MM_DD')


select ename, hiredate , ename, hiredate from employee; 

select e2.ename �̸�, e2.hiredate �Ի��� 
from employee e1, employee e2
where e2.hiredate > e1.hiredate
and e1.ename = 'WARD'
order by e2.hiredate asc;


11. SELF JOIN�� ����Ͽ� ������ ���� ���� �Ի��� ��� ����� �̸� �� �Ի����� ������ �̸� �� �Ի��ϰ� �Բ� ����Ͻÿ�. 
    ��, �� ���� ��Ī�� �ѱ۷� �־ ��� �Ͻÿ�. 
    
    select eno, ename, manager, hiredate from employee; 
    
    select e1.ename ����̸�, e1.hiredate ������Ի���, e2.ename �������̸�, e2.hiredate �������Ի���  
    from employee e1, employee e2
    where e1.manager = e2.eno 
    and  e1.hiredate < e2.hiredate 
    
    select eno, ename, manager, hiredate,  eno, ename, manager, hiredate from employee; 
   
<<�Ʒ� ������ ��� Subquery�� ����Ͽ� ������ Ǫ����.>>

1. �����ȣ�� 7788�� ����� ��� ������ ���� ����� ǥ��(����̸� �� ������) �Ͻÿ�.  

select job , ename from employee where eno = '7788' ; 
select ename, job from employee where job = 'ANALYST' 

select ename, job from employee where job = (select job from employee where eno = '7788'  )


2. �����ȣ�� 7499�� ������� �޿��� ���� ����� ǥ�� (����̸� �� ������) �Ͻÿ�. 

select ename ����̸�, job ������, salary ���� 
from employee
where salary > (select salary from employee where eno = 7499)

3. �ּ� �޿��� �޴� <<���޺�>>��, ����� �̸�, ��� ���� �� �޿��� ǥ�� �Ͻÿ�(�׷� �Լ� ���)

select job , count(*), min (salary) 
from employee
group by job 

select ename ����̸�, job ������, salary �޿�
from employee
where salary in ( select min (salary) 
                from employee
                group by job )
                
4.  <<���޺��� ��� �޿��� ���ϰ�, ���� ����  ���� ��տ���   ���� ����  �����  ���ް�  �޿��� ǥ���Ͻÿ�.>>

select job, round( AVG(salary)) from employee 
group by job 
select * from employee where job = 'CLERK'

select ename �̸�,  job ����, salary �޿� 
from employee
where salary = ( select min(salary) from employee
                    group by Job 
                    having avg(salary) = (select min (avg(salary))
                    from employee group by job)
                )

select min (salary) �޿�, job ����
from employee 
group by job 
having avg (salary) <= all (select avg(salary) 
                            from employee 
                            group by job); 

5. �� �μ��� �ʼ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.

select ename ����̸�, job ������, salary �޿�
from employee
where salary in ( select min (salary) 
                from employee
                group by job )

6. ��� ������ �м���(ANALYST) �� ������� �޿��� �����鼭 ������ �м����� �ƴ� ������� ǥ�� (�����ȣ, �̸�, ������, �޿�) �Ͻÿ�.
    select * from employee where job = 'ANALYST' ; 

    select eno, ename, job, salary 
    from employee 
    where salary < all ( select salary 
                        from employee 
                        where job = 'ANALYST') and job <> 'ANALYST' 
7. ���������� ���� ����� �̸��� ǥ�� �Ͻÿ�. 
select * from employee; 


8. ���������� �ִ� ����� �̸��� ǥ�� �Ͻÿ�. 
select eno, ename 
from employee
where eno in ( select manager 
                    from employee 
                    where manager is not null )
select * from employee; 

9. BLAKE �� ������ �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�(��, BLAKE �� ����). 
select * from employee where ename = 'BLAKE'

select ename  ����, hiredate �Ի���, dno �μ��� 
from employee 
where dno = ( select dno from employee where ename = 'BLAKE' ) and  ename != 'BLAKE'


10. �޿��� ��պ��� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���ؼ� ���� �������� ���� �Ͻÿ�. 
    select eno, ename, salary 
    from employee 
    where salary > ( select round (avg(salary)) from employee ) 
    order by salary asc; 

11. �̸��� K �� ���Ե� ����� ���� �μ����� ���ϴ� ����� �����ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. 
select dno, ename
from employee
where dno in ( select dno from employee where ename like '%K%' )

select * from employee where ename like '%K%' 

12. �μ� ��ġ�� DALLAS �� ����� �̸��� �μ� ��ȣ �� ��� ������ ǥ���Ͻÿ�. 
select * from department; 

-- JOIN �� ���
select ename, e.dno, job, loc             -- �� ���̺��� ���� Ű �÷�, EQUI JOIN������ ���̺���� ��� 
from employee e , department d
where e.dno = d.dno
and loc = 'DALLAS'

--Sub Query 
select ename, e.dno , job , loc 
from employee e, department d 
where e.dno =d.dno
and e.dno in (select dno from department where loc = 'DALLAS')  


13. KING���� �����ϴ� ����� �̸��� �޿��� ǥ���Ͻÿ�. 
select * from employee; 

select ename, salary, manager
from employee
where manager = ( select eno from employee where ename='KING' ) 


14. RESEARCH �μ��� ����� ���� �μ���ȣ, ����̸� �� ��� ������ ǥ�� �Ͻÿ�.
select * from department

-- JOIN 
select eno �μ���ȣ, ename ����̸�, job ������, dname �μ��� 
from employee e, department d
where e.dno  = d.dno 
and d.dname = 'RESEARCH' 

-- Sub Query 
select eno �μ���ȣ, ename ����̸�, job ������, dname �μ��� 
from employee e, department d
where e.dno  = d.dno 
and e.dno in ( Select dno from department where dname = 'RESEARCH')  


15. ��� �޿����� ���� �޿��� �ް� �̸��� M�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�. 
select round(avg (salary )) from employee 

select eno �����ȣ, ename �̸�, salary �޿�
from employee 
where salary > (select round(avg (salary )) from employee)  
        and dno IN ( select dno from employee where ename like '%M%') 

select * from employee where ename like '%M%' 

16. ��� �޿��� ���� ���� ������ ã���ÿ�. 
select job ���� , round ( avg (salary)) ��ձ޿�
from employee
group by job
having avg(salary) = ( select min ( avg(salary) ) from employee group by job )


17. �������� MANAGER�� ����� �Ҽӵ� �μ��� ������ �μ��� ����� ǥ���Ͻÿ�. 
select ename ����� 
from employee
where dno in ( select dno from employee where job = 'MANAGER' )

select * from employee where job ='MANAGER' 