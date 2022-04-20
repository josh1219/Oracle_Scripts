-- 2���� : DQL : Select

desc department;

select * from department;

/*
SQL : ����ȭ�� ���� ���

Select ������ ��ü �ʵ� ����

Select   <== �÷���
Distinct <== �÷����� ���� �ߺ��� �����ض�.
From     <== ���̺� ��, �� ��.
Where    <== ����
Group By <== Ư�� ���� �׷���
Having   <== �׷��� �� ���� ����
Order by <== ���� �����ؼ� ���
(���� �߿�)
*/
desc employee;
select *
from employee;

-- Ư�� �÷��� ��� �ϱ�
select eno, ename from employee;

-- Ư�� �÷��� ������ ���
select eno, ename, eno, ename, ename from employee;

-- �÷��� ������ ���� �� �� �ִ�.
select eno, ename, salary, salary * 12 from employee;

-- �÷��� �˸��(Alias) : �÷��� �̸��� ����,
    -- �÷��� ������ �ϰų� �Լ��� ����ϸ� �÷����� ��������.
select eno, ename, salary, salary *12 as ���� from employee;
select eno as �����ȣ , ename as �����, salary as ����, salary *12 as ���� from employee;
select eno �����ȣ , ename �����, salary ����, salary *12 ���� from employee;
    -- �����̳� Ư�����ڰ� ��� ������ ""���� ó���ؾ� �Ѵ�.
select eno "��� #��ȣ" , ename "���?��", salary ����, salary *12 ���� from employee;

-- nvl �Լ� : ����ÿ� null�� ó���ϴ� �Լ�
select * from employee;

-- nvl �Լ��� ������� �ʰ� ��ü ������ ���.  (null�� ���Ե� �÷��� ������ �����ϸ� null)
    -- null�� 0���� ó���ؼ� ���� �ؾ� �Ѵ�. : NVL
select eno �����ȣ, ename �����, salary ����, commission ���ʽ�,
salary * 12,
salary *12 + commission       -- ��ü ����
from employee;

-- nvl �Լ��� ����ؼ� ����
select eno �����ȣ, ename �����, salary ����, commission ���ʽ�,
salary * 12,
salary *12 + NVL(commission, 0)       -- ��ü ����
from employee;

-- Ư�� �÷��� ������ �ߺ� ������ ���
select * from employee;
select dno from employee;
select distinct dno from employee;

-- select ename, distinct dno from employee; -- �ٸ��÷� ������ ������ �� �� �ִ�.

-- ������ ����ؼ� �˻� (Where)
select * from employee;
select eno �����ȣ, ename �����, job ��å, manager ���ӻ��, hiredate �Ի糯¥,
    salary ����, commission ���ʽ�, dno �μ���ȣ
    from employee;
    
-- ��� ��ȣ�� 7788�� ����� �̸��� �˻�.
select * from employee
where eno = 7788;

select ename from employee
where eno = 7788;

-- ��� ��ȣ�� 7788�� ����� �μ���ȣ, ���ް� �Ի糯¥�� �˻�.
select dno �μ���ȣ, salary ����, hiredate �Ի糯¥ from employee
where eno = 7788;

desc employee;

select *
from employee
where ename = 'SMITH';

-- ���ڵ带 �����ö� 
    -- number �϶��� ''�� ������ �ʴ´�.
    -- ���� ������(Char, Varchar2)�� ��¥(Date)�� �����ö���  ''�� ó��.
    -- ��ҹ��ڸ� ����
    
-- �Ի糯¥�� '81/12/03' �� ��� ���
select ename, hiredate
from employee
where hiredate = '81/12/03';

-- �μ� �ڵ尡 10�� ��� ������� ���
select ename , dno
from employee
where dno = 10;

select * from employee;

-- ������ 3000�̻��� ����� �̸��� �μ��� �Ի� ��¥, ������ ���.
select ename, dno, hiredate, salary
from employee
where salary >= 3000 ;

-- null �˻� : is Ű���� ���.
select *
from employee
where commission is null;

-- commission�� 300 �̻��� ����̸���, ��å, ������ ���
select ename, job, salary, commission
from employee
where commission >= 300;

-- Ŀ�Լ��� ���� ������� �̸��� ���.
select ename, commission
from employee
where commission is null;

-- ���ǿ��� and, or, not

-- ������ 500 �̻� 2500 �̸��� ������� �̸�, �����ȣ, �Ի糯¥, ������ ���.
select ename, eno, hiredate, salary
from employee
where salary >= 500 and salary < 2500;

-- 1. ��å�� SALESMAN �̰ų�, �μ��ڵ尡 20�� ��� �̸�, ��å, ����, �μ��ڵ�
select * from employee;

select ename, job, salary, dno
from employee
where job = 'SALESMAN' or dno = 20;

-- 2. Ŀ�Լ��� ���� ������߿� �μ��ڵ尡 20�� ������� �̸�, �μ��ڵ�� �Ի糯¥�� ���.
select ename, dno, hiredate
from employee
where commission is null and dno = 20;

-- 3. Ŀ�Լ��� null�� �ƴ� ������� �̸� , �Ի糯¥, ����.
select ename, hiredate, salary
from employee
where commission is not null;


-- ��¥ �˻� : 
select * from employee;


-- 1982/1/1 ~ 1983/12/31 ���̿� �Ի��� ����� �̸� , ��å, �Ի糯¥
select ename, job, hiredate
from employee
where hiredate >= '82/01/01' and hiredate < '83/12/31' ;

-- 1981�⵵�� �Ի��� ����� �̸� , ��å, �Ի糯¥
select ename, job, hiredate
from employee
where hiredate>= '81/01/01' and hiredate < '81/12/31';

-- between A and B      : A �̻� B ����
select ename, job, hiredate
from employee
where hiredate between '81/01/01' and '81/12/31' ;

-- IN ������

-- Ŀ�Լ��� 300, 500, 1400�� ����� �̸�, ��å, �Ի����� ���.
select ename, job, hiredate, commission
from employee
where commission = 300 or commission = 500 or commission = 1400;

select ename, job, hiredate, commission
from employee
where commission in (300,500,1400);

-- like : �÷����� Ư���� ���ڿ��� �˻�
    -- % : �ڿ� � ���ڰ� �͵� ��� ����.
    -- _ : �ѱ��ڰ� � ���� �͵� ��� ����.
    
-- F�� �����ϴ� �̸��� ���� ����� ��� �˻��ϱ�.

select * from employee
where ename like 'A%';

-- �̸��� ES�� ������ ����� �˻��ϱ�.
select ename from employee
where ename like '%ES';

-- J�� ���۵ǰ� J���� �α��ڰ� ����� �͵� ������� ��� ���. �ڿ��� ES
select ename from employee
where ename like 'J_MES';

-- ������ ���ڰ� R�� ������ ��� ����ϱ�
select * from employee
where ename like '%R';

-- Man �ܾ �� ��å�� ���
select * from employee
where job like '%MAN%';

-- 81�⵵�� �Ի��� ����� ����ϱ�.
select *
from employee
where hiredate >= '81/01/01' and hiredate < '81/12/31';

select *
from employee
where hiredate between '81/01/01' and '81/12/31';

select *
from employee
where hiredate like '81%';

-- 81�� 2���� �Ի��� ����� ���

select *
from employee
where hiredate >= '81/02/01' and hiredate < '81/02/28';

select *
from employee
where hiredate between '81/02/01' and '81/02/28';

select *
from employee
where hiredate like '81/02%';

-- ���� : order by

select * 
from employee
order by eno;

select * 
from employee
order by eno asc ;

select * 
from employee
order by eno desc ;

-- �̸� �÷��� ����
select * 
from employee
order by ename asc;

select * 
from employee
order by ename desc;

-- ��¥����
select * 
from employee
order by hiredate asc;

select * 
from employee
order by hiredate desc;

-- �����亯�� �Խ��ǿ��� �ַ� ���. �ΰ� �̻��� �÷��� ���� �� ��

select * from employee
order by dno desc;

-- �ΰ��� �÷��� ���� : ���� ó�� �ø��� ������ �ϰ�, ������ ���� ���ؼ� �ι��� �÷��� ����.
select dno, ename
from employee
order by dno , ename;

select dno, ename
from employee
order by dno desc , ename desc;

-- where ���� order ���� ���� ��� �� ��.
select *
from employee
where commission is null
order by ename desc;

-- �پ��� �Լ� ����ϱ�

/*
    1. ���ڸ� ó���ϴ� �Լ�
    - UPPER : �빮�ڷ� ��ȯ
    - LOWER : �ҹ��ڷ� ��ȯ
    - INITCAP : ù�ڴ� �빮�ڷ� �������� �ҹ��ڷ� ��ȯ
    
    dual ���̺� : �ϳ��� ����� ��� �ϵ��� �ϴ� ���̺�
*/

SELECT '�ȳ��ϼ���' as �ȳ�
from dual; --������ �̷� ���̺��� ������, �׳� ����ϵ��� ����

SELECT 'Oracle mania', UPPER ('Oracle mania'), LOWER ('Oracle mania'),
initcap ('Oracle mania')
from dual;

SELECT * FROM employee;


SELECT ename, lower(ename), UPPER(ename), initcap(ename)
from employee;

SELECT * FROM employee
WHERE ename = 'allen'; -- �˻��� �ȵ�.

SELECT * FROM employee
WHERE lower(ename) = 'allen';

SELECT * FROM employee
WHERE initcap(ename) = 'Allen';

-- ���� ���̸� ����ϴ� �Լ�
    --length: ������ ���̸� ��ȯ, �����̳� �ѱ� ������� ���ڼ��� ������
    --lengthb: ������ ���̸� ��ȯ, ������ 1byte �ѱ� 3byte�� ��ȯ

SELECT LENGTH ('Oracle mania'), length ('����Ŭ �ŴϾ�')from dual;

SELECT LENGTHb ('Oracle mania'), lengthb ('����Ŭ �ŴϾ�')from dual;

SELECT * FROM employee;

SELECT ename, length (ename), job, length(job) from employee;

-- ���� ���� �Լ�
    -- concat : ���ڿ� ���ڸ� �����ؼ� ���
    -- substr : ���ڸ� Ư�� ��ġ���� �߶���� �Լ� (����, �ѱ� ��� 1byte�� ó��)
    -- substrb : ���ڸ� Ư�� ��ġ���� �߶���� �Լ� (������ 1byte, �ѱ��� 3byte�� ó��)
    -- instr : ������ Ư�� ��ġ�� �ε��� ���� ��ȯ
    -- instrb : ������ Ư�� ��ġ�� �ε��� ���� ��ȯ (������ 1byte, �ѱ��� 3byte�� ó��)
    -- lpad,rpad : �Է� ���� ���ڿ����� Ư���� ���ڸ� ����.
    -- trm : �߶󳻰� ���� ���ڸ� ��ȯ.
    
-- concat : ���ڿ� ���ڸ� �����ؼ� ���
select 'Oracle', 'mania', concat ('Oracle' , 'mania') from dual;
-- substr : ���ڸ� Ư�� ��ġ���� �߶���� �Լ� // ����, �ѱ� 1byte
-- substr ( ���, ������ġ, ���ⰹ�� )
    -- ������ġ�� - �� ������ �ڿ��� ���� ��
select 'Oracle mania', substr ('Oracle mania', 4, 3),substr ('����Ŭ �ŴϾ�', 2, 3),
substrb ('Oracle mania', 4, 3),substrb ('����Ŭ �ŴϾ�', 2, 3)
from dual;

select 'Oracle mania', substr ('Oracle mania', -8, 4),substr ('����Ŭ �ŴϾ�', -5, 3),
substrb ('Oracle mania', -3, 2),substrb ('����Ŭ �ŴϾ�', -2, 3)
from dual;

select ename, substr (ename, 3, 2), substrb(ename, -4, 3)
from employee;

select concat ( ename, ' ' || job) from employee;
select '�̸��� : ' || ename || ' �̰�, ��å�� : ' || job || ' �Դϴ�.' as �÷�����
from employee;

select '�̸��� : ' || ename || ' �̰�, ����� ��ȣ�� ' || manager || ' �Դϴ�.' as A
from employee;

-- �̸��� N ���� ������ ����� ����ϱ� ( substr �Լ� ��� )
select *
from employee
where substr(ename, -1, 1) = 'N';

select *
from employee
where ename like '%N';

-- 87 �⵵ �Ի��� ����� ����ϱ�
select *
from employee
where substr(hiredate, 1, 2) = '87';

select *
from employee
where hiredate like '87%';

-- instr : ������ Ư�� ��ġ�� �ε��� ���� ��ȯ
-- instr ( ���, ã�� ����, ������ġ, �� ��° �߰� )

select 'Oracle mania' , instr ('Oracle mania', 'O') from dual;
select 'Oracle mania' ,
instr ('Oracle mania', 'a'),
instr ('Oracle mania', 'a', 5),
instr ('Oracle mania', 'a', 5, 2),
instr ('Oracle mania', 'a', -5, 1)
from dual;

select distinct job from employee
where lower(job) = 'manager';

select distinct instr( job, 'A', 1, 1)
from employee
where lower(job) = 'manager';

-- lpad, rpad : Ư�� ���̸�ŭ ���ڿ��� �����ؼ� ����, �������� ������ Ư�� ���ڷ� ó��
select lpad (salary, 10, '*') from employee;
select rpad (salary, 10, '*') from employee;

select lpad (1234 , 10, '*'), rpad (1234 , 10, '*') from dual;

-- Trim : ��������, Ư�� ���ڵ� ����
    -- ltrim : ���� ���� ����
    -- rtrim : ������ ���� ����
    -- trim : ���� ,������ ���� ����
    
select ltrim('     Oracle mania     '),
rtrim('       Oracle mania       '),
trim('      Oracle mania     ')
from dual;



