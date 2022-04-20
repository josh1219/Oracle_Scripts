-- 1. SUBSTR �Լ��� ����Ͽ� ������� �Ի��� �⵵�� �Ի��� �޸� ��� �Ͻÿ�.
select hiredate, substr (hiredate,1,5)
from employee;

-- 2. SUBSTR �Լ��� ����Ͽ� 4���� �Ի��� ����� ��� �Ͻÿ�.
select *
from employee
where hiredate like '%04%';

-- 3. MOD �Լ��� ����Ͽ� ���ӻ���� Ȧ���� ����� ����Ͻÿ�.
select * from employee
where mod(manager , 2)!=0;

-- 3-1. MOD �Լ��� ����Ͽ� ������ 3�� ����� ����鸸 ����ϼ���.
select * from employee
where mod(salary , 3)=0;

-- 4. �Ի��� �⵵�� 2�ڸ� (YY), ���� (MON)�� ǥ���ϰ� ������ ��� (DY)�� �����Ͽ� ��� �Ͻÿ�. 
select hiredate, to_char(hiredate, 'YY/MON/DY')
from employee;

-- 5. ���� �� ���� �������� ��� �Ͻÿ�. ���� ��¥���� ���� 1�� 1���� �� ����� ����ϰ� TO_DATE �Լ��� ����Ͽ�
--   ������ ������ ��ġ ��Ű�ÿ�. 
select sysdate , trunc (sysdate - to_date(20220101,'YYYYMMDD'))

from dual;

-- 5-1. �ڽ��� �¾ ��¥���� ������� �� ���� �������� ��� �ϼ���. 
select sysdate , trunc (sysdate - to_date(19971219,'YYYYMMDD')) as "1997.12.19 ~ TODAY"
from dual;

-- 5-2. �ڽ��� �¾ ��¥���� ������� �� ������ �������� ��� �ϼ���. 
select trunc (months_between (sysdate,to_date ('1997/12/19','YYYY/MM/DD'))) as "�� ���� ���� ��"
from dual;

-- 6. ������� ��� ����� ����ϵ� ����� ���� ����� ���ؼ��� null ����� 0���� ��� �Ͻÿ�. 
select ename, manager, coalesce (manager,0) as "����� null = 0"
from employee;

-- 7.  DECODE �Լ��� ���޿� ���� �޿��� �λ��ϵ��� �Ͻÿ�. ������ 'ANAIYST' ����� 200 , 'SALESMAN' ����� 180,
--    'MANAGER'�� ����� 150, 'CLERK'�� ����� 100�� �λ��Ͻÿ�.
select ename, salary, job, decode (job, 'ANALYST', salary+200,
                                       'SALESMAN', salary+180,
                                       'MANAGER', salary+150,
                                       'CLERK', salary+100,
                                       salary) as "���޺� �޿�"
from employee;


-- 8. �����ȣ, [�����ȣ 2�ڸ��� ��� �������� *����] as "������ȣ", �̸�, [�̸��� ù�ڸ� ��� �� 4�ڸ��� ���, 3�ڸ��� *�� ����]

select rpad(substr(eno,1,2), 4, '*') as �����ȣ ,rpad(substr(ename,1,1),4,'*') as �̸�
from employee;


-- 9. �ֹι�ȣ�� ����ϵ� 801210-1****** ó�� ��� , ��ȭ��ȣ�� 010-11*******
--      dual ���̺� ���
select rpad (substr('801210-1234567',1,8) , 14, '*'), rpad (substr('010-1111-2222',1,6) , 13, '*') from dual;

-- 10. �����ȣ, �����, ���ӻ��, 
--        [���ӻ���� ��� ��ȣ�� ������� : 0000]
--         ���ӻ���� ��� ��ȣ�� �� 2�ڸ��� 75�� ��� : 5555
--         ���ӻ���� ��� ��ȣ�� �� 2�ڸ��� 76�� ��� : 6666
--         ���ӻ���� ��� ��ȣ�� �� 2�ڸ��� 77�� ��� : 7777
--         ���ӻ���� ��� ��ȣ�� �� 2�ڸ��� 78�� ��� : 8888

select * from employee;
select eno, ename,manager, case when (substr(manager,1,2)) = 75 then 5555
                                when (substr(manager,1,2)) = 76 then 6666
                                when (substr(manager,1,2)) = 77 then 7777
                                when (substr(manager,1,2)) = 78 then 8888
                                when manager is null then 0 
                                ELSE manager
                           END as �����ȣ
from employee;

