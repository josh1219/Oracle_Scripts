-- 9���� ������ , �ε���,

/*
    ������ : �ڵ� ��ȣ �߻���
        -- ��ȣ�� �ڵ� �߻��� �Ǹ� �ڷ� �ǵ��� �� ����. (���� �� �ٽ� �����ؾ� �Ѵ�.)
*/

-- �ʱⰪ : 10 , ������ : 10
create sequence sample_seq
    increment by 10         -- ������
    start with 10;          -- �ʱⰪ
    
-- �������� ������ ����ϴ� ������ ����
select * from user_sequences;

select sample_seq.nextval from dual;    -- �������� ���� ���� ���
select sample_seq.currval from dual;    -- ���� �������� ���� ���

-- �ʱⰪ : 2 , ������ : 2
create sequence sample_seq2
    increment by 2
    start with 2
    nocache;                 -- ĳ���� ������� �ʰڴ�. (RAM)  -- ������ ���ϸ� �ٿ��ټ� �ִ�.
    
select sample_seq2.nextval from dual;
select sample_seq2.currval from dual;

-- �������� Primary Key�� �����ϱ�

create table dept_copy80
as
select * from department
where 0 = 1;

select * from dept_copy80;

-- ������ ���� : �ʱⰪ 10, ������ : 10
create sequence dept_seq
    increment by 10
    start with 10
    nocache;
    
    /* Sequence�� cache�� ����ϴ� ��� / ������� �ʴ� ��� */
        -- chche : ������ ������ ��� �ϱ� ���ؼ� ��� (�⺻�� : 20��)
        -- ������ �ٿ�� ��� :  ĳ���� �ѹ����� ��� ���󰣴�. ���ο� ���� �Ҵ� �޴´�.
        
    
insert into dept_copy80 (dno, dname, loc)
values (dept_seq.nextval , 'HR' , 'SEOUL');

select * from dept_copy80;

-- ������ ����
create sequence emp_seq_no
    increment by 1
    start with 1
    nocache;
    
create table emp_copy80
as
select * from employee
where 0=1;

select * from emp_copy80;

-- �������� ���̺��� Ư�� �÷��� ����

insert into emp_copy80
values (emp_seq_no.nextval , 'SMITH' , 'SALESMAN' , 2222 , sysdate , 3000 , 3000 , 20);

-- ������ ������ ����

select * from user_sequences;

Alter sequence emp_seq_no
    maxvalue 1000;       -- �ִ밪 : 1000
    
Alter sequence emp_seq_no
    cycle;               -- �ִ밪�� ����ǰ� �ٽ� ó������ ��ȯ
    
    
Alter sequence emp_seq_no
    nocache;
    
select * from user_sequences;

drop sequence sample_seq;

/*
    INDEX : ���̺��� �÷��� ���� , Ư�� �÷��� �˻��� ������ ��� �� �� �ֵ��� �Ѵ�.
        - INDEX Page : �÷��� �߿� Ű���带 �ɷ��� ��ġ ������ ��Ƴ��� ������.
            - DB ������ 10% ���� ����
        - ����(index) : å�� ���� , å�� ������ �߿� Ű���带 �����ؼ� ��ġ�� �˷��ش�.
        - ���̺� ��ĵ : ���ڵ��� ó�� ~ ������ ���� �˻� (�˻� �ӵ��� ������.) , �ε����� ������� �ʰ� �˻�.
            -- Index�� �����Ǿ� ���� ���� �÷��� ���̺� ��ĵ�� �Ѵ�.
        - Primary Key , Unique Ű�� ����� �÷��� Index Page�� �����Ǿ� �˻��� ������ �Ѵ�.
        - Where ������ ���� �˻��� �ϴ� �÷��� Index�� ����.
        - ���̺��� �˻��� ���� �ϴ� �÷��� Index�� ����, ���̺� ��ĵ�� ���� �ʰ�
            Index Page�� �˻��ؼ� ��ġ�� ������ ã�´�.
        - Index�� �����Ҷ� ���ϰ� ���� �ɸ���. �ַ� �����ð��� ���ؼ� �߰��� ������.
        - Index�� �� �����ؾ� �Ѵ�. 
*/

-- index ������ ����Ǿ� �ִ� ������ ����.
    -- user_colums , user_ind_colums
    
select * from user_tab_columns;
select * from user_ind_columns;

select * from user_tab_columns
where table_name in ('EMPLOYEE' , 'DEPARTMENT');

select index_name , table_name , column_name
from user_ind_columns
where table_name in ('EMPLOYEE' , 'DEPARTMENT');

select * from employee;     -- ENO �÷��� Primary Key  <== �ڵ����� Index�� ������.

/*
    Index �ڵ� ���� , (Primary Key , Unique) �÷����� Index Page�� �ڵ����� �����ȴ�.
*/

Create table tbl1 (
    a number(4) constraint PK_tbl1_a Primary Key,
    b number(4),
    c number(4)
    );

select index_name , table_name , column_name
from user_ind_columns
where table_name in ('TBL1' , 'TBL2' , 'EMPLOYEE' , 'DEPARTMENT');
    
select * from tbl1;

create table tbl2 (
    a number(4) constraint PK_tbl2_a Primary Key ,
    b number(4) constraint UK_tbl2_b Unique,
    c number(4) constraint UK_tbl2_c Unique,
    d number(4),
    e number(4)
    );
    
create table emp_copy90
as
select * from employee

select index_name , table_name , column_name
from user_ind_columns
where table_name in ('EMP_COPY90');

select * from emp_copy90
where ename = 'KING';   -- ename �÷��� Index�� �����Ƿ� KING�� �˻��ϱ� ���ؼ� ���̺� ��ĵ �Ѵ�.

select * from emp_copy90
where job = 'SALESMAN';



-- ename �÷��� index �����ϱ�. (�߰��� �۾��ؾ� �Ѵ�. ���ϰ� ���� �ɸ���.)

-- �÷��� index�� �����Ǿ� ���� ������ ���̺� ��ĵ�� �Ѵ�. ó������ �ϳ��ϳ� �˻��Ѵ�.
-- �÷��� index�� �����Ǿ� ������ Index Page(å�� ����)�� �˻��Ѵ�.

create index id_emp_ename
on emp_copy90(ename);

drop index id_emp_ename;

/*
    Index�� �ֱ������� REBUILD ����� �Ѵ� .
         - Index Page�� (Insert , Update , Delete) ����ϰ� �Ͼ�� ��������.
*/
    
-- Index REBUILD�� �ؾ��ϴ� ���� ���
    -- Index�� Tree ���̰� 4 �̻��� ��찡 ��ȸ�� �Ǹ� rebuild �� �ʿ䰡 �ִ�.

SELECT I.TABLESPACE_NAME,I.TABLE_NAME,I.INDEX_NAME, I.BLEVEL,
       DECODE(SIGN(NVL(I.BLEVEL,99)-3),1,DECODE(NVL(I.BLEVEL,99),99,'?','Rebuild'),'Check') CNF
FROM   USER_INDEXES I
WHERE   I.BLEVEL > 4
ORDER BY I.BLEVEL DESC;

-- index rebuild : 

Alter index id_emp_ename rebuild;   -- index�� ���Ӱ� �����Ѵ�.

select * from emp_copy90;

/*
    Index�� ����ؾ� �ϴ� ���
        1. ���̺��� ��(�ο�,���ڵ�)�� ������ ���� ���.
        2. Where ������ ���� ���Ǵ� �÷�.
        3. Join �� ���Ǵ� Ű �÷�.
        4. �˻� ����� ���� ���̺� �������� 2~4% ���� �Ǵ� ���
        5. �ش� �÷��� null�� ���ԵǴ� ���. (������ null�� ����)
        
    Index�� ����ϸ� �� ���� ���
        1. ���̺��� ���� ������ ���� ���.
        2. �˻� ����� ���� ���̺��� ���� ������ �����ϴ� ���.
        3. insert, update, delete�� ����ϰ� �Ͼ�� �÷�.
*/

/*
    index ����
        1. ���� �ε��� (Unique Index) : �÷��� �ߺ����� �ʴ� ������ ���� ���� Index (Primary Key, Unique)
        2. ���� �ε��� (Single Index) : �� �÷��� �ο��Ǵ� Index
        3. ���� �ε��� (Composite Index) : ���� �÷��� ��� ������ Index
        4. �Լ� �ε��� (Function Base Index) : �Լ��� ������ �÷��� ������ Index
*/

select * from emp_copy90;

-- ���� �ε���
create index inx_emp_copy90_salary
on emp_copy90 (salary);

-- ���� �ε��� ���� : �� �÷� �̻��� �����ؼ� �ε��� ����.
create table dept_copy91
as
select * from department;

create index idx_dept_copy91_dname_loc
on dept_copy91 (dname,loc);

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('DEPT_COPY91');

-- �Լ� ��� �ε��� : �Լ��� ������ �÷��� �ο��Ǵ� index

create table emp_copy91
as
select * from employee;

create index idx_emp_copy91_allsal
on emp_copy91 (salary * 12);        -- �÷��� �Լ�, ������ ������ index.

/* �ε��� ���� */

drop index idx_emp_copy91_allsal;


/* ���� ���� */
/*
    ��� ���� : DBMS�� �������� ���
    - �� ����ں��� ������ ���� : DBMS�� ���� �� �� �ִ� ����ڸ� ����.
        (���� (Authentication : Credential ( Identity + Password) Ȯ��
        (�㰡 (Authorization : ������ ����ڿ��� Oracle�� �ý��� ���� , ��ü (���̺�, ��, Ʈ����, �Լ�) ����
            - System Privileges : ����Ŭ�� �������� ���� �Ҵ�
            - Object Privileges : ���̺�, ��, Ʈ����, �Լ�, ���� ���ν���, ������, �ε���) ���� ����.
*/

-- Oracle���� ���� ����. (�Ϲ� ���������� ������ ���� �� �� �ִ� ������ ����.)
show user

-- �ְ� ������ ���� (sys) : ������ ���� �� �� �ִ� ������ ������ �ִ�.

-- ���̵� : usertest01 , ��ȣ : 1234
create user usertest01 identified by 1234;

-- ������ ��ȣ�� �����ߴٰ� �ؼ� ����Ŭ�� ���� �� �� �ִ� ������ �ο� �޾ƾ� ���� ����

-- System Privileges :
    -- Create Session : ����Ŭ�� ���� �� �� �ִ� ����.
    -- Create Table : ����Ŭ���� ���̺��� ���� �� �� �ִ� ����.
    -- Create Sequence : �������� ���� �� �� �ִ� ����.
    -- Create View : �並 ���� �� �� �ִ� ����.
    
DDL : ��ü ���� (Create, Alter, Drop)
DML : ���ڵ� ���� (Insert, Update, Delete)
DQL : ���ڵ� �˻� (Select)
DTL : Ʈ����� (Begin transaction, rollback, commit)
DCL : ���� ���� ( Grant, Revoke, Deny)
-- ������ �������� ����Ŭ�� ���� �� �� �ִ� Create Session ������ �ο�.
-- grant �ο� �� ���� to ������
grant create session to usertest01

-- ����Ŭ�� �����ߴ� ��� �ؼ� ���̺� ���� �� �� �ִ� ������ ����.

grant create table to usertest01;

/* ���̺� �����̽� (Table Space) : ��ü(���̺�, ��, ������, �ε���, Ʈ����, ���� ���ν���, �Լ�...)
    �� �����ϴ� ����. ������ �������� �� ����ں� ���̺� �����̽��� Ȯ��.
    SYSTEM : DBA (������ ���������� ���� ����)
*/
select * from dba_users;    -- dba_ : sys (�ְ� ������ �������� Ȯ��)

select username,default_tablespace as DataFile ,temporary_tablespace as LogFile
from dba_users
where username in ('HR','USERTEST01');

-- �������� ���̺� �����̽� ���� (SYSTEM ==> USERS) ����
Alter user usertest01
default tablespace users        -- DataFile ���� : ��ü�� ����Ǵ� ���� (���̺�, ��, Ʈ����, �ε��� . . . . .)
temporary tablespace temp       -- LOG�� ���� : DML (Insert, Update, Delete)
                                -- LOG�� ȣĪ �� �� Transaction Log. �ý����� ���� �߻��� ��� ������ �ƴ϶� ������ �������� ����

-- �������� Users ���̺� �����̽��� ��� �� �� �ִ� ���� �Ҵ�. ( users ���̺� �����̽��� 2mb�� ��� ���� �Ҵ�)
Alter user usertest01
quota 2m on users;


-- Object Privileges : ���̺�, ��, Ʈ����, �Լ�,
    -- ���� ���ν���, ������, �ε����� �ο��Ǵ� ���� �Ҵ�.
















���� : usertest02 ������ �����Ŀ� users ���̺� �����̽����� ���̺� (tb12) ���� �� insert.



create user usertest02 identified by 1234;

grant create session to usertest02;

grant create table to usertest02;

Alter user usertest02
default tablespace users
temporary tablespace temp

Alter user usertest02
quota 2m on users;

select * from All_tables    -- ���̺��� �����ָ� ��� ���ش�. �������� ������ ���̺��� ��� �� �� �ִ�.
where owner in ('HR', 'USERTEST01', 'USERTEST02');