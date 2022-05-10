-- sys ����   <�ְ� ������ �������� ����>

-- Autication (����) : credential ( ID + Pass)
Create user user_test10 identified by 1234;  -- ���� ����.

-- Authorization (�㰡) : system ���� �Ҵ�.
grant create session, create table, create view to user_test10;

-- ������ �����ϸ� system ���̺� �����̽��� ����Ѵ�. <== �����ڸ� ��밡���� ���̺� �����̽�
-- ���̺� �����̽� �ٲٱ�. (USERS)
Alter user user_test10
default tablespace "USERS"
temporary tablespace "TEMP"

-- ���̺� �����̽� �뷮 �Ҵ�. (
Altet user "USER_TEST10" Quota unlimised

-- Ư�� �������� ��ü�� �����ϸ� �� ������ �� ��ü�� �����ϰ� �ȴ�.
select * from dba_tables
where owner in ('HR', 'USER_TEST10');

-- �ٸ� ������� ���̺��� �����ҷ��� ������ ������ �Ѵ�.
grant select on hr.employee to user_test10;

-- ������ �ο� �� ��
grant insert, update, delete on hr.emp_copy55 to user_test10;

--������ ���� �� ��
revoke insert on hr.emp_copy55 from user_test10;

/* with grant option : Ư�� �������� ������ �ο��ϸ鼭 �ش� ������ �ٸ� ����ڿ��Ե� �ο� �� �� �ִ� ����
    -- �ο����� ������ �ٸ� ����ڿ��� �ο��� �� �� �ִ� ����.
*/

grant select on hr.employee to user_test10 with grant option;
    -- user_test10 ������ hr.eployee ���̺� ���ؼ� �ٸ� ����ڿ��� select ������ �ο� �� �� �ִ�.



/* Public : ��� ����ڿ��� ������ �ο��ϴ� ��. */
grant select, insert,update, delete on hr.dept_copy56 to public


/* �� (Role) : ���� ����ϴ� �������� ������ ���� ���� ��
    
    1. dba : �ý����� ��� ������ ����� role , -- sys (�ְ� ������ ����)
    2. connect :
    3. resource :
*/

-- ����� ���� Role ���� : ���� ����ϴ� ���ѵ��� ��� role�� ����.
1. �� ���� :
    create role roletest1;

2. �ѿ� ���� ����ϴ� ������ ����.
    grant create session, create table, create view, create sequence,
    
    
    
    
    
    
    
-- �ǽ� : 
hr.dept_copy57�� ����

-- �� ���� roletest3
roletest3 : hr.dept_copy57 (select, insert, delete) ��ü ��
user_test10 ����.

