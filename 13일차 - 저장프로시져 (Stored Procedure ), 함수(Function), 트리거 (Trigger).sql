13���� - �������ν��� (Stored Procedure ), �Լ�(Function), Ʈ���� (Trigger) 

/*
    �������ν����� ���� 
        1. PL/SQL�� ��밡���ϴ�. �ڵ�ȭ 
        2. ������ ������.  
            �Ϲ����� SQL ���� : �����м� -> ��ü�̸�Ȯ�� -> ������Ȯ�� ->����ȭ-> ������ -> ���� 
            �������ν��� ó������ : �����м� -> ��ü�̸�Ȯ�� -> ������Ȯ�� ->����ȭ-> ������ -> ���� 
            �������ν��� �ι�°���� ���� : ������(�޸𸮿��ε�) ->����
            
        3. �Է� �Ű�����, ��� �Ű������� ����� �� �ִ�. 
        4. �Ϸ��� �۾��� ��� ���� ( ���ȭ�� ���α׷����� �����ϴ�. 
*/ 

1. �������ν��� ����. 
-- ���� ����� ������ ��� �ϴ� ���� ���ν��� 
Create procedure sp_salary 
is
    v_salary employee.salary%type;   -- �������ν����� is ������� ������ ���� 
begin
    select salary into v_salary
    from employee
    where ename= 'SCOTT' ; 
    
    dbms_output.put_line ( 'SCOTT �� �޿��� : ' || v_salary || ' �Դϴ�' ); 
end; 
/ 

/* �������ν��� ������ Ȯ���ϴ� ������ ���� */ 
select * from user_source 
where name = 'SP_SALARY'; 

3. ���� ���ν��� ���� 
EXECUTE sp_salary;   -- ��ü �̸�
EXEC sp_salary;     -- ��� �̸� 


4. ���� ���ν��� ���� 

Create or replace procedure sp_salary  --sp_salary �� �������� ������ ����, �����ϸ� ���� 
is
    v_salary employee.salary%type;   -- �������ν����� is ������� ������ ���� 
    v_commission employee.commission%type; 
begin
    select salary, commission into v_salary, v_commission 
    from employee
    where ename= 'SCOTT' ; 
    
    dbms_output.put_line ( 'SCOTT �� �޿��� : ' || v_salary ||  
                            '���ʽ��� : ' || v_commission || ' �Դϴ�'); 
end; 
/ 

4. ���� ���ν��� ���� 

drop procedure sp_salary ; 


----------<<��ǲ �Ű������� ó���ϴ� ���� ���ν���>>--------------------------
create or replace procedure sp_salary_ename (   -- �Է� �Ű����� (in), ��� �Ű����� (out)�� ����  
    v_ename in employee.ename%type     -- ������ in �ڷ���  <== ���� :   << ;�� ����ϸ� �ȵȴ�.  >>
)
is      -- �������� (���� ���ν������� ����� ���� ������
    v_salary employee.salary%type; 
begin
    select salary into v_salary   -- ���� 
    from employee
    where ename = v_ename ;     -- ��ǲ �Ű����� : v_ename 
    
    dbms_output.put_line( v_ename || ' �� �޿��� ' || v_salary || '�Դϴ�' ); 
end;
/ 

exec sp_salary_ename ( 'SCOTT'); 
exec sp_salary_ename ( 'SMITH'); 
exec sp_salary_ename ( 'KING'); 
select * from employee; 

-- �Ϸ�ð� : 12:00 ���� 
/* �μ� ��ȣ �� ��ǲ �޾Ƽ�  �̸�, ��å, �μ���ȣ�� ����ϴ� ���� ���ν����� �����ϼ���.  (Ŀ���� ����ؾ���)*/
create or replace procedure sp_dno (
    v_dno employee%type 
    )
is 

begin 

end;
/




/* ���̺��̸��� ��ǲ �޾Ƽ� employee ���̺��� �����ؼ�  �����ϴ� �������ν����� ���� �ϼ���. 
    ��ǲ �� : emp_copy33
*/ 


/* ���� ���ν����� ����ؼ�  ���̺� ���� */ 

create or replace procedure sp_createTable ( 
    v_name in varchar2
    )
is
    cursor1 INTEGER; 
    v_sql varchar2 (100) ;   -- SQL������ �����ϴ� ���� 
begin
    v_sql := 'CREATE TABLE ' || v_name || ' as select * from employee' ;  -- ���̺� ���������� ������ �Ҵ�. 

    cursor1 := DBMS_SQL.OPEN_CURSOR;                -- Ŀ�� ���
    DBMS_SQL.PARSE ( cursor1, v_sql, dbms_sql.v7);  -- Ŀ���� ����ؼ� sql ������ ����. 
    DBMS_SQL.CLOSE_CURSOR(cursor1);                 -- Ŀ�� ���� 
end;
/ 

grant create table to public;               -- <<sys �������� ����>>

exec sp_createTable ( 'emp_copy101');

select * from emp_copy101; 
drop table emp_copy101; 




------------------------------------------------

create or replace procedure sp_copy_table(
    v_emp_c10 in varchar2,
    v_dept_c10 in varchar2
)
is
    cursor1 integer;
    v_sql1 varchar2(100); 
    v_sql2 varchar2(100);
begin
    v_sql1 := 'create table '||v_emp_c10||' as select * from employee'; 
    v_sql2 :='create table '||v_dept_c10||' as select * from department';
    cursor1 :=DBMS_SQL.OPEN_CURSOR; 
    DBMS_SQL.PARSE(cursor1,v_sql1,dbms_sql.v7); 
    DBMS_SQL.PARSE(cursor1,v_sql2,dbms_sql.v7); 
    DBMS_SQL.CLOSE_CURSOR(cursor1); 
end;
/

exec sp_copy_table ('emp_copy22', 'dept_copy22');

drop table emp_copy22

select * from emp_copy22
select * from dept_copy22

------------<<��� �Ű����� ���>>---------------------
/*  ���� ���ν��� : ��� �Ű������� ����(�������� ) ,  �Լ� : ��� �Ű������� �ϳ��� ����.
        -- OUT  Ű���带 ���. 
        -- �������ν����� ȣ��� ���� ��� �Ű����� ���������� ȣ���� ����. 
        -- ȣ��� ��¸Ű����� �̸��տ� ':������(��¸Ű�������)'
        -- ��� �Ű������� ����ϱ� ���ؼ� PRINT ��ɹ��̳� PL/SQL�� ����ؼ� ����Ҽ� �ִ�. 
*/

create or replace procedure sp_salary_ename2 (   --  �Է�/��� �Ű����� �����
    v_ename in employee.ename%type,     --�Է� �Ű� ����
    v_salary out employee.salary%type   --��� �Ű� ���� 
    )
is
begin
    select salary into v_salary
    from employee
    where ename= v_ename; 

end;
/
-- �ּ� ó�� ���� :
variable var_salary varchar2(50) ;   
exec sp_salary_ename2 ('KING', :var_salary); 
print var_salary; 

select * from user_source where name = 'SP_SALARY_ENAME2'  -- ������ �������� Ȯ��

-- OUT �Ķ���͸� ������ ������ �������ν��� ���� �� ��� (PL/SQL)
--�����ȣ�� ��ǲ �޾Ƽ�  ����̸�, �޿�, ��å�� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� PL/SQL�� ����ؼ� ���. 
create or replace procedure sel_empno (  --IN, OUT : �ڷ����� �����ڷ���(%type) ,
    v_eno in number,                        -- �⺻�ڷ��� ����Ʈ���� ����
    v_ename out varchar2,
    v_sal out number,
    v_job out varchar2
    )
is
begin
    select ename, salary, job into v_ename , v_sal, v_job
    from employee
    where eno = v_eno ; 
end;
/

-- PL/SQL�� ����ؼ�  ���� ���ν��� ȣ�� 
declare 
    var_ename varchar2(50); 
    var_sal number;
    var_job varchar2(50); 
begin
    -- �͸� ��Ͽ����� �������� ���� ȣ��� exec/execute �� ������ �ʴ´�. 
    sel_empno (7788, var_ename, var_sal, var_job);   -- �������ν��� ȣ�� 
    dbms_output.put_line('��ȸ��� : ' ||var_ename|| '   ' ||var_sal || '   ' || var_job); 
end;
/ 

/* �Լ� (Function) : ���� �־ �ϳ��� ���� ��ȯ �޾ƿ´�.       <== SQL ���� ������ ��� ����
    -- �� , �������ν����� out �Ű������� ������ ��ȯ�޾ƿü� �ִ�. <==SQL ���� �������� ���Ұ�.
*/ 
create or replace function fn_salary_ename (  -- ��ǲ �Ű�����
     v_ename in employee.ename%type
)
RETURN number             --ȣ���ϴ� ������ ���� ������.  ������ �ڷ���.  
is
    v_salary number(7,2); 
begin
    select salary into v_salary
    from employee
    where ename = v_ename;     -- ��ǲ �Ű� ���� 
    RETURN v_salary; 
end;
/ 
/* �Լ��� ������ ���� */
select * from user_source
where name = 'FN_SALARY_ENAME';

-- 1. �Լ���� 
variable var_salary number;
exec :var_salary := fn_salary_ename('SCOTT'); 
print var_salary; 

-- 2. �Լ���� (SQL  ���� ������ �Լ� ���) 
select ename , fn_salary_ename('SCOTT') as ����
from employee
where ename = 'SCOTT'; 

-- �Լ� ���� 
drop function fn_salary_ename




















    
    



































