12���� - PL/SQL : ����Ŭ���� ���α׷��� ��Ҹ� ������ SQL , �����ϰ� ó���ؼ� ����. 
        MSSQL : T-SQL 
    SQL : ����ȭ�� ���Ǿ�� , ���� : ������ ���α׷��� ����� ������ �� ����. 
    
set serveroutput on     -- PL/SQL�� ����� Ȱ��ȭ 


/* PL SQL�� �⺻ �ۼ� ���� */ 

begin 
    -- PL/SQL ���� 
end;
/


show user; 

-- PL/SQL���� �⺻ ��� 

set serveroutput on 
begin
    dbms_output.put_line('Welcome to Oracle');
end;
/

-- PL / SQL���� ���� ���� �ϱ�.

   ������ :=  �� 
   
 desc employee;  
 
   -- �ڷ��� ���� 
      1.  Oracle �� �ڷ����� ���. 
      2. �����ڷ��� : ���̺��� �÷��� ����� �ڷ����� �����ؼ� ���. 
            %type  : ���̺��� Ư���÷��� �ڷ����� �����ؼ� ���. (���̺��� �÷� 1�� ����)
            %rowtype : ���̺� ��ü �÷��� �ڷ����� ��� ���� �ؼ� ���. 
   
   
   
 set serveroutput on 
 
 declare  -- ���� ���� (���� �����)
     v_eno number(4) ;              -- ����Ŭ�� �ڷ���       
     v_ename employee.ename%type;   -- ���� �ڷ��� : ���̺��� �÷��� �ڷ����� �����ؼ� ����. 
 begin 
    v_eno := 7788;              -- :=  ������ ���� �Ҵ� �Ҷ� ���. 
    v_ename := 'SCOTT';
    
    dbms_output.put_line('�����ȣ    ����̸�'); 
    dbms_output.put_line('------------------'); 
    dbms_output.put_line(v_eno || '    ' || v_ename); 
 
 end;
 /
 
 /* �����ȣ�� ����̸� ��� �ϱ� */ 
 
  set serveroutput on 
  declare
    v_eno employee.eno%type; 
    v_ename employee.ename%type; 
  begin
      dbms_output.put_line('�����ȣ    ����̸�'); 
      dbms_output.put_line('------------------'); 
      
      select eno, ename into v_eno, v_ename
      from employee
      where ename = 'SCOTT'; 
 
     dbms_output.put_line(v_eno || '    ' || v_ename); 
  
  end;
  /
  
  select eno, ename
  from employee
  where ename = 'SCOTT' 
  
  /* PL/sql���� ��� ����ϱ� */ 
  
  /* If ~ End if �� ����ϱ� */ 
  
  set serveroutput on 
  declare
     v_employee employee%rowtype; -- rowtype :  employee���̺��� ��� �÷��� �ڷ����� �����ؼ� ���.
                            -- v_employee ������ employee���̺��� ��� �÷��� ����. 
     annsal number (7,2);   -- �ѿ����� �����ϴ� ���� 
  begin
    select * into v_employee
    from employee
    where ename = 'SCOTT';   
    if (v_employee.commission is null) then 
        v_employee.commission := 0 ; 
    end if;  
    annsal := v_employee.salary *12 + v_employee.commission; 
    dbms_output.put_line('�����ȣ   ����̸�   ����');
    dbms_output.put_line('-----------------------');
    dbms_output.put_line(v_employee.eno || '   ' || v_employee.ename || '    ' ||
                annsal );
  end;
  /
  
  /*
        v_employee.eno  := 7788
        v_employee.ename := 'SCOTT'
        v_employee.job := ANALYST
        v_employee.manager := 7566
        v_employee.hiredate := 87/07/13
        v_employee.salary := 3000
        v_employee.commission := null
        v_employee.dn0 = 20 
  */

select * from employee
where ename = 'SCOTT'

/* PL/SQL �� ����ؼ� department ���̺��� . 
    ������ dno = 20 �� ������ ��Ƽ� ��� �غ�����. 
*/ 

1. %type  : ������ data type�� ���̺��� �÷��ϳ��ϳ��� �����ؼ� �Ҵ�. 
set serveroutput on
declare 
  v_dno department.dno%type; 
  v_dname department.dname%type;
  v_loc department.loc%type; 
begin 
   select dno, dname, loc into v_dno, v_dname, v_loc
   from department
   where dno =20 ;
   
   dbms_output.put_line('�μ���ȣ   �μ���   ��ġ');
   dbms_output.put_line('---------------------');
    dbms_output.put_line(v_dno || '   ' || v_dname || '   ' || v_loc );
end;
/




2. %rowtype : ���̺��� ��� �÷��� �����ؼ� ���. 
set serveroutput on
declare 
  v_department department%rowtype;  
begin 
   select dno, dname, loc into v_department
   from department
   where dno =20 ;
   
   dbms_output.put_line('�μ���ȣ   �μ���   ��ġ');
   dbms_output.put_line('---------------------');
    dbms_output.put_line(v_department.dno || '   ' || v_department.dname || '   ' || 
    v_department.loc );
end;
/

/* IF ~ ELSIF ~ END IF */

set serveroutput on
declare 
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_dno employee.dno%type;
    v_dname department.dname%type := null ;
begin
    select eno, ename, dno into v_eno, v_ename, v_dno
    from employee
    where ename = 'SCOTT' ;
    
    if (v_dno = 10) then
        v_dname := 'ACCOUNT';
    elsif (v_dno = 20 ) then
        v_dname := 'SESEARCH';
    elsif (v_dno =30) then
        v_dname := 'SALES';
    elsif (v_dno = 40 ) then
        v_dname := 'OPERATIONS';
    end if; 
    
    dbms_output.put_line('�����ȣ  �����   �μ���');
    dbms_output.put_line('----------------------');
    dbms_output.put_line( v_eno || '   ' || v_ename || '   ' || v_dname);

end;
/

select * from employee where ename='SCOTT' 

/* employee ���̺��� eno, ename, salary, dno �� PL/SQL �� ����ؼ� ��� 
    ���� �� ���ʽ� 1400�� ��� �� ���ؼ�  */
 
 �Ϸ�ð� : 4:45 �б���    
    
1. %type 

set serveroutput on
declare 
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_salary employee.salary%type;
    v_dno employee.dno%type;
begin
    select eno, ename,salary, dno into v_eno, v_ename,v_salary, v_dno
    from employee
    where commission = 1400;
    dbms_output.put_line('�����ȣ   �����   ����   �μ���ȣ'); 
    dbms_output.put_line('--------------------------------'); 
    dbms_output.put_line(v_eno ||'   '|| v_ename||'    '||v_salary||'   '|| v_dno); 
end;
/ 


2. %rowtype 
    
 set serveroutput on
declare 
    v_employee employee%rowtype; 
begin
    select * into v_employee
    from employee
    where commission = 1400;
    dbms_output.put_line('�����ȣ   �����   ����   �μ���ȣ'); 
    dbms_output.put_line('--------------------------------'); 
    dbms_output.put_line(v_employee.eno ||'   '|| v_employee.ename||'    '||
        v_employee.salary||'   '|| v_employee.dno); 
end;
/   

/* Ŀ�� (cursor) : PL/SQL���� select �� ����� ���� ���ڵ尡 �ƴ϶� ���ڵ� ���� ��쿡 Ŀ���� �ʿ��ϴ�. 
*/ 

declare 
  cursor  Ŀ����                   1. Ŀ�� ���� 
  is 
  Ŀ���� ������ select ���� 
begin
  open Ŀ���� ;                    2. Ŀ�� ���� 
  loop 
    fetch ����                    3. Ŀ���� �̵��ϰ� ���
  end loop ; 
  close Ŀ���� ;                   4. Ŀ���� ����.
end;
/

/* Ŀ���� ����ؼ� department ���̺��� ��� ������ ��� �ϱ� */ 

set serveroutput on 
declare
    v_dept department%rowtype;   --���� ���� 
    cursor c1                       --1. Ŀ�� ����  
    is 
    select * from department;  
begin
    dbms_output.put_line('�μ���ȣ   �μ���   �μ���ġ');
    dbms_output.put_line('-----------------------');
    open c1;                        -- 2. Ŀ�� ���� 
    loop 
        fetch c1 into v_dept.dno, v_dept.dname, v_dept.loc; 
        exit when c1%notfound;
        dbms_output.put_line(v_dept.dno || '   ' || v_dept.dname || '   ' || v_dept.loc); 
    end loop;
    close c1;                       -- 4 Ŀ�� ����. 
end;
/

/* Ŀ���� �Ӽ��� ��Ÿ���� �Ӽ��� 
 Ŀ����%notfound : Ŀ������ ���� ��� �ڷᰡ FETCH�Ǿ��ٸ� true
 Ŀ����%fount : Ŀ������ ����   FETCH ���� �ʴ� �ڷᰡ �����ϸ� true
 Ŀ����%isopen : Ŀ���� ���µǾ��ٸ� true
 Ŀ����%rowcount : Ŀ���� ���� ���ڵ� ���� 
*/ 

/* 
  �����,  �μ���, �μ���ġ, ���� �� ��� �ϼ��� . PL/SQL �� ����ؼ� ����ϼ���. <Ŀ���� �̿�> 
  �Ϸ�ð� : 6�� 10��
*/ 

2. rowtype �� ����ؼ� ó�� 

set serveroutput on 
declare 
    v_emp employee%rowtype; 
    v_dept department%rowtype;
    cursor c2
    is 
    select ename, dname, loc, salary 
    from employee e, department d
    where e.dno = d.dno ; 
    
begin
    dbms_output.put_line('�����   �μ���   �μ���ġ   ����');
    dbms_output.put_line('-----------------------------');
    open c2;
    loop 
        fetch c2 into v_emp.ename, v_dept.dname, v_dept.loc, v_emp.salary; 
        exit when c2%notfound;
        dbms_output.put_line(v_emp.ename ||'   ' ||v_dept.dname||'   '||v_dept.loc ||'   '||
         v_emp.salary);
    end loop;
    close c2;

end;
/

/* cursor  for loop ������ Ŀ���� ����ؼ� ���� ���ڵ�� ��� �ϱ�. 
    - open, close �� ���� �ؼ� ���;
    - �� ���̺��� ��ü ������ ��� �Ҷ� ���. 
*/ 

set serveroutput on
declare
    v_dept department%rowtype; 
    cursor c1                   --Ŀ�� ���� 
    is 
    select * from department; 
begin
    dbms_output.put_line('�μ���ȣ   �μ���   ������');
    dbms_output.put_line('-----------------------'); 
    for v_dept in c1 loop
        dbms_output.put_line ( v_dept.dno || '   ' || v_dept.dname ||'   ' || v_dept.loc ); 
    end loop ;
end;
/ 


/* employee ���̺��� ��� ������ cursor for loop�� ����ؼ� ����� ������. */ 

/* employee ���̺��� �����ȣ,�����,����,�μ���ȣ �� ���,  ������ 2000 �̻� , �μ��� 20,30 �μ��� ��� 
    cursor for loop�� ���
*/ 


���� ���ν��� ����  : �Ϸ� �ð� : 4:00 ���� �Ϸ� 

1. �� �μ����� �ּұ޿�, �ִ�޿�, ��ձ޿��� ����ϴ� �������ν����� �����Ͻÿ�. 
	[employee, department ] ���̺� �̿�
    
    set serveroutput on 
    
    create or replace procedure sp_ex1 
    is  --���� �����, Ŀ�� ���� 
        v_dno employee.dno%type; 
        v_min employee.salary%type; 
        v_max employee.salary%type; 
        v_avg employee.salary%type; 
        
        cursor c1 
        is 
        select dno, min(salary), max(salary), avg(salary)
        from employee
        group by dno ; 
        
    begin
        dbms_output.put_line( '�μ���ȣ   �ּұ޿�   �ִ�޿�  ��ձ޿�');  
        dbms_output.put_line( '-----------------------------------');  
        open c1;   --Ŀ�� ���� 
        loop
            fetch c1 into v_dno, v_min, v_max, v_avg ; 
            exit when c1%notfound ;    -- ���ڵ��� ���� ���̻� �������� ������ 
            dbms_output.put_line( v_dno||'   '||v_min||'   '||v_max||'   '||v_avg) ;           
        end loop;         
        close c1; 
    end;
    / 
    
exec sp_ex1 ;     
    
    

2.  �����ȣ, ����̸�, �μ���, �μ���ġ�� ����ϴ� �������ν����� �����Ͻÿ�.  
	[employee, department ] ���̺� �̿�
    create or replace procedure sp_ex2 
    is
        v_eno employee.eno%type; 
        v_ename employee.ename%type; 
        v_dname department.dname%type; 
        v_loc department.loc%type; 
        
        cursor c1
        is 
        select eno, ename, dname, loc 
        from employee e , department d
        where e.dno = d.dno ;
   
    begin
        dbms_output.put_line( '�����ȣ   ����̸�   �μ���   �μ���ġ');  
        dbms_output.put_line( '-----------------------------------'); 
        open c1; 
        loop
            fetch c1 into v_eno, v_ename, v_dname, v_loc; 
            exit when c1%notfound; 
            dbms_output.put_line( v_eno||'   '|| v_ename||'   ' || v_dname||'   '||v_loc);
        end loop ;   
        close c1; 
    end;
    / 
    
  exec sp_ex2  
    
    


3. �޿��� �Է� �޾�  �Է¹��� �޿����� ���� ����� ����̸�, �޿�, ��å�� ��� �ϼ���.
	�������ν����� : sp_salary_b
    create or replace procedure sp_ex3 (
        v_salary in employee.salary%type )   --���� : in,out ������ ; ó���ϸ� �ȵ�. 
    is
        v_emp employee%rowtype;   --��� �÷��� �ڷ����� ���� 
        cursor c1 
        is 
        select ename, salary, job
        from employee
        where salary > v_salary; 
        
    begin
        dbms_output.put_line( '����̸�   �޿�   ��å');  
        dbms_output.put_line( '--------------------'); 
        open c1;
        loop
            fetch c1 into v_emp.ename, v_emp.salary, v_emp.job; 
            exit when c1%notfound; 
            dbms_output.put_line( v_emp.ename|| '   '||v_emp.salary||'   '||v_emp.job );
        end loop;      
        close c1; 
    end; 
    / 
      
    exec sp_ex3( 2500 );   
    
4. ��ǲ �Ű����� : emp_c10, dept_c10  �ΰ��� �Է� �޾� ���� employee, department ���̺��� �����ϴ� �������ν����� �����ϼ���. 
	�������ν����� : sp_copy_table
    
    -- PL/SQL ���ο��� �͸� ������� ���̺��� ���� : grant create table to public;  < sys �������� ���� > 
    -- �������ν��� ������ : revoke create table from public;
    create or replace procedure sp_ex4 (
        v_emp in varchar2 , v_dept in varchar2 )  -- ���� : ';'�� ������ �ȵ�, �ڷ����� ũ�⸦ �����ϸ�ȵ�
    is
        c1 integer;   --Ŀ�� ���� ���� 
        v_sql1 varchar2(500); -- ���̺� ���� ������ ���� ���� 
        v_sql2 varchar2(500);
    begin
        v_sql1 := 'create table ' || v_emp || ' as select * from employee' ;
        v_sql2 := 'create table ' || v_dept || ' as select * from department';
        
        c1 := dbms_sql.open_cursor;         -- Ŀ�� ���� 
        dbms_sql.parse(c1, v_sql1, dbms_sql.v7); 
        dbms_sql.parse(c1, v_sql2, dbms_sql.v7);
        dbms_sql.close_cursor(c1);   -- Ŀ�� ����       
    end;
    /
    
    exec sp_ex4 ( 'emp_c10', 'dept_c10');  
    
    select * from emp_c10; 
    select * from dept_c10; 

5. dept_c10 ���̺��� dno, dname, loc �÷��� ���� ��ǲ �޾� ��ǲ ���� ���� insert�ϴ� �������ν����� �����Ͻÿ�. 
	�Է� �� : 50  'HR'  'SEOUL'
	�Է� �� : 60  'HR2'  'PUSAN' 
    
    exec sp_ex5 ( 50, 'HR', 'SEOUL'); 
     exec sp_ex5 ( 60, 'HR2', 'PUSAN'); 
    select * from dept_c10; 
    
    
create or replace procedure sp_ex5 (
    v_dno in dept_c10.dno%type, v_dname in dept_c10.dname%type, v_loc in dept_c10.loc%type  )
   is
   begin
        insert into dept_c10 
        values ( v_dno, v_dname, v_loc ); 
        
        dbms_output.put_line( ' ���������� �� �Է��� �Ǿ����ϴ�' ); 
       
   end;
   / 
   
   select * from dept_c10; 
    
    
    

6. emp_c10 ���̺��� ��� �÷��� ���� ��ǲ �޾� ��ǲ ���� ���� insert�ϴ� �������ν����� �����Ͻÿ�. 
	�Է� �� : 8000  'SONG'    'PROGRAMER'  7788  sysdate  4500  1000  50 
   select * from emp_c10; 
   
   exec sp_ex6(8000,  'SONG' ,   'PROGRAMER' , 7788,  sysdate , 4500 , 1000,  50 ); 
   
   create or replace procedure sp_ex6 (
        v_eno in emp_c10.eno%type ,
        v_ename in emp_c10.ename%type,
        v_job in emp_c10.job%type,
        v_manager in emp_c10.manager%type,
        v_hiredate in emp_c10.hiredate%type,
        v_salary in emp_c10.salary%type,
        v_commission in emp_c10.commission%type,
        v_dno in emp_c10.dno%type
   )
   is 
   begin
        insert into emp_c10 
        values ( v_eno, v_ename, v_job, v_manager, v_hiredate, v_salary, v_commission, v_dno) ; 
        
        dbms_output.put_line('�� �Է� �Ǿ����ϴ�.'); 
   end;
   / 
    
    
    


7. dept_c10 ���̺��� 4�������� �μ���ȣ 50�� HR �� 'PROGRAM' ���� �����ϴ� �������ν����� �����ϼ���. 
	<�μ���ȣ�� �μ����� ��ǲ�޾� �����ϵ��� �Ͻÿ�.> 
	�Է°� : 50  PROGRAMER 
    select * from dept_c10; 
    exec sp_ex7 ( 50, 'PROGRAMER' ) 
    
    create or replace procedure sp_ex7 (
        v_dno in dept_c10.dno%type, 
        v_dname in dept_c10.dname%type)
    is
    begin
        update dept_c10 
        set dname = v_dname
        where dno = v_dno; 
        
        dbms_output.put_line('�� ������Ʈ �Ǿ����ϴ�.' ); 
    end;
    / 
    
    

8. emp_c10 ���̺��� �����ȣ�� ��ǲ �޾� ������ �����ϴ� ���� ���ν����� �����Ͻÿ�. 
	�Է� �� : 8000  6000
    create or replace procedure sp_ex8 (
        v_eno in emp_c10.eno%type, 
        v_salary in emp_c10.salary%type)
    is
        
    begin
        update emp_c10 
        set salary = v_salary
        where eno = v_eno ; 
        
        dbms_output.put_line('�� �����Ǿ����ϴ�'); 
    
    end;
    / 
    exec sp_ex8 (8000, 6000); 
    
    select * from emp_c10; 
    
    
    

9. ���� �� ���̺���� ��ǲ �޾� �� ���̺��� �����ϴ� �������ν����� ���� �Ͻÿ�. 
create or replace procedure sp_ex9 (
        v_emp in varchar2 , v_dept in varchar2 )  -- ���� : ';'�� ������ �ȵ�, �ڷ����� ũ�⸦ �����ϸ�ȵ�
    is
        c1 integer;   --Ŀ�� ���� ���� 
        v_sql1 varchar2(500); -- ���̺� ���� ������ ���� ���� 
        v_sql2 varchar2(500);
    begin
        v_sql1 := 'drop table ' || v_emp  ;
        v_sql2 := 'drop table ' || v_dept ;
        
        c1 := dbms_sql.open_cursor;         -- Ŀ�� ���� 
        dbms_sql.parse(c1, v_sql1, dbms_sql.v7); 
        dbms_sql.parse(c1, v_sql2, dbms_sql.v7);
        dbms_sql.close_cursor(c1);   -- Ŀ�� ����       
    end;
    /

    select * from emp_c10; 
    select * from dept_c10; 
    exec sp_ex9 ( 'emp_c10', 'dept_c10'); 




10. ����̸��� ��ǲ �޾Ƽ� �����, �޿�, �μ���ȣ, �μ���, �μ���ġ�� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� 
PL / SQL���� ȣ��
create or replace procedure sp_ex10 ( 
    v_ename in employee.ename%type, 
    v_o_ename out employee.ename%type,
    v_salary out employee.salary%type, 
    v_dno out employee.dno%type, 
    v_dname out department.dname%type,
    v_loc out department.loc%type) 
 is 
 begin
    select ename, salary, e.dno, dname, loc  into v_o_ename, v_salary, v_dno, v_dname,v_loc 
    from employee e , department d
    where e.dno = d.dno 
    and ename = v_ename;    -- v_ename�� ���������ؼ� 
 
 end;
 / 
 
 
 declare -- OUT �Ķ��Ÿ ���� ���� ���� 
    v_ename employee.ename%type; 
    v_salary employee.salary%type; 
    v_dno employee.dno%type; 
    v_dname department.dname%type; 
    v_loc department.loc%type;
 begin
    -- �͸� ��������� exec / execute �� ���� ��. 
    sp_ex10( 'SCOTT' , v_ename, v_salary, v_dno, v_dname, v_loc ); 
    
    dbms_output.put_line ('�����   ����   �μ���ȣ   �μ���   �μ���ġ');
    dbms_output.put_line( '---------------------------------------');
    dbms_output.put_line( v_ename||'   '|| v_salary || '   ' || v_dno||'   ' || v_dname||'   '||
        v_loc); 
 end; 
 / 

11. �����ȣ �� �޾Ƽ� �����, �޿�, ��å,  �μ���, �μ���ġ �� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� PL / SQL���� ȣ��

create or replace procedure ex11 ( 
    v_eno in employee.eno%type, 
    v_ename out employee.ename%type, 
    v_salary out employee.salary%type,
    v_job out employee.job%type, 
    v_dname out department.dname%type,
    v_loc out department.loc%type)   
    is 
    begin
        select ename, salary, job, dname, loc into v_ename, v_salary, v_job, v_dname, v_loc
        from employee e, department d
        where e.dno = d.dno
        and eno = v_eno ; 
    end;
    / 


declare 
    v_ename  employee.ename%type; 
    v_salary  employee.salary%type;
    v_job  employee.job%type; 
    v_dname  department.dname%type;
    v_loc  department.loc%type; 
begin
    ex11( 7788 , v_ename, v_salary, v_job, v_dname, v_loc); 
    
    dbms_output.put_line('�����   ����   ��å   �μ���   ��ġ');
    dbms_output.put_line('---------------------------------');
    dbms_output.put_line(v_ename || '   ' || v_salary || '   '|| v_job || '   ' || 
        v_dname ||'   '|| v_loc);
end;
/ 


/* Ʈ���� (Trigger) : ������ ��Ƽ� (Ʈ����), ��Ƽ踦 ���� �Ѿ��� �߻��. 
        - ���̺� �����Ǿ� �ִ�. 
        - ���̺� �̺�Ʈ�� �߻��ɶ� �ڵ����� �۵��Ǵ� ���α׷� �ڵ� 
        - ���̺� �߻��Ǵ� �̺��� (Insert , Update, Delete)
        - Ʈ���ſ��� ���ǵ� begin ~ end  ������ ������ �����. 
        - before Ʈ���� : ���̺���  Ʈ���Ÿ� ���� ������ Insert, Update, Delete  �� ����
        - after Ʈ���� :  Insert, Update, delete�� ������ Ʈ���Ÿ� ����. 
        -- ��) �ֹ� ���̺� ���� �־����� ��� ���̺� �ڵ����� ���� 
        -- ��) �߿� ���̺��� �α׸� ���涧�� ����. 
        -- :new : ������ �ӽ����̺� , Ʈ���Ű� ������ ���̺� ���Ӱ� ������ ���ڵ��� �ӽ� ���̺� 
        -- :old : ������ �ӽ����̺�, Ʈ���Ű� ������ ���̺� �����Ǵ� ���ڵ��� �ӽ� ���̺� 
        -- Ʈ���Ŵ� �ϳ��� ���̺� �� 3������ ������, (insert, update, delete) 
*/ 

-- �ǽ� ���̺� 2�� ���� : ���̺��� ������ ���� (dept_original, dept_copy) 
create table dept_original 
as 
select * from department
where 0=1 ; 

create table dept_copy
as
select * from department
where 0=1; 

drop table dept_copy

select * from dept_original; 
select * from dept_copy; 

--Ʈ���� ���� (dept_original ���̺� ����, insert �̺�Ʈ�� �߻��ɶ� �ڵ����� �۵�) 

create or replace trigger tri_sample1 
    -- Ʈ���Ű� ������ ���̺�, �̺�Ʈ(Insert, update, delete), Before, After, 
    after insert       --insert �̺�Ʈ�� �۵��� Ʈ���Ű� �۵� ( begin ~ end ������ �ڵ�) 
    on dept_original   --on ������ ���̺� 
    for each row       --��� row �� ���ؼ� 
        
begin       --Ʈ���Ű� ������ �ڵ� 
    if inserting then 
        dbms_output.put_line('Insert Trigger �߻� !!!!' ); 
        insert into dept_copy
        values ( :new.dno, :new.dname, :new.loc ) ; -- new ���� �ӽ� ���̺�    
    end if; 
end;
/ 

/* Ʈ���� Ȯ�� ������ ���� : user_source */ 
select * from user_source where name = 'TRI_SAMPLE1'; 

select * from dept_original;
select * from dept_copy; 

insert into dept_original 
values ( 15, 'PROGRAM5' , 'PUSAN5' ); 

/* delete Ʈ���� :  dept_orginal ���� ���� ===> dept_copy ���� �ش� ������ ���� */ 

create or replace trigger tri_del 
    -- Ʈ���Ű� �۵���ų ���̺�, �̺�Ʈ 
    after delete   --���� ���̺��� delete�� ���� ������ Ʈ���� �۵�
    on dept_original    -- dept_original���̺� Ʈ���� ���� 
    for each row   
begin   --Ʈ���Ű� �۵��� �ڵ� 
    dbms_output.put_line('Delete Trigger �߻��� !!!!'); 
    delete dept_copy
    where dept_copy.dno = :old.dno;     --dept_original���� �����Ǵ� ���� �ӽ� ���̺� : old 
   
end; 
/ 

select * from dept_original;
select * from dept_copy; 

delete dept_original
where dno = 13; 

/* update Ʈ���� : dept_original ���̺��� Ư�� ���� �����ϸ� dept_copy ���̺��� ������ ������Ʈ �� */ 

create or replace trigger tri_update 
    after update
    on dept_original
    for each row
begin
    dbms_output.put_line('update trigger �߻� !!!');
    update dept_copy
    set dept_copy.dname = :new.dname
    where dept_copy.dno = 13 ;    
end;
/

select * from dept_original;    -- <<�ֹ� ���̺� ����>>
select * from dept_copy;        -- <<��� ���̺� ����>> 

update dept_original 
set dname = 'prog'
where dno = 13; 













































  
 
 
   















