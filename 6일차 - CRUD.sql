6���� CRUD (Create, Read, Update, Delete)

OBJECT (��ü): DataBase�� ����( XE, <= Express Edition(���� ���� <=> Standard, Enterprise ���� ����) 
                                    (��������� DB������ ���ϰ� ������ �͸� ��� ������)
              a) ���̺� , b) ��, c) ���� ���ν���, d) Ʈ����, e) �ε���, f)�Լ�, g) ������
              DDL (Create, Alter, Drop)
    

���̺� ���� (Create)

    Create Table ���̺��(
        �÷��� �ڷ��� ����뿩�� [��������],
        �÷��� �ڷ��� ����뿩�� [��������]
        �÷��� �ڷ��� ����뿩�� [��������],
    );

Create Table dept( -- ���̺� ����
dno number (2) not null,
dname varchar2(14) not null,
loc varchar2(13) null
);

    DML��: ���̺��� �� (���ڵ�, �ο�)�� �ְ� (insert), ����(update), ����(delete) ����� ��
           �̷��� DML���� ���� log�� ����� �Ŀ� DataBase�� �ڵ带 ������
           �� DML���� �ڵ����� Ʈ������� ������ RAM���� ������� ��. ���� DB���� ���� ��Ű�� ���� ����
           
    begin transaction; -- Ʈ������� ������
    rollback; -- Ʈ������� �ѹ���. �׷��� DB�� �ٲٴ� ���� �ƴ�. RAM�� �ε�� ������׵��� ����� ����
    commit; --Ʈ������� ������. Ʈ������� ������ DB�� �����ϴ� ��

/* insert ����

insert into ���̺�� (�÷���, �÷���, �÷��� ....)
values ( ��1, ��2, ��3, ...);

������ �÷����� ������ ������

insert into ���̺��
values ( ��1, ��2, ��3, ...);

*/
desc dept;


--DML �����غ���
insert into dept (dno, dname, loc) -- Ʈ����ǿ� ������
values (10, 'MANAGER','SEOUL');

select * from dept; -- ������ ������ ����
rollback; -- �ѹ�Ϸ��� ��µ�
select * from dept; -- ������ ������ �����

--������ insert ǥ�� ����ϱ�
insert into dept
values (10, 'ACCOUNTING','BUSAN');

select * from dept; -- ������ ������ ����
commit;
select * from dept; -- ���� �� ������ص� ����


--  NULL ��� �÷��� �� ���� �ʱ�

insert into dept (dno,dname)
values (30, 'RESEARCH'); -- NULL�� ������ 3��° ������ ���� ���� ����

select * from dept; -- ������ ������ ���� �� �� ���Ե� �࿡�� ���� ���� ���� ĭ��
                    -- (NULL) ���� ��µ�
                    
-- ������ ������ �´� �ʴ� ���� �־� ���� �߻����Ѻ���

insert into dept (dno, dname, loc)
values (300, 'SALES', 'DAEGU'); -- �÷�1�� 2�ڸ��� �ѹ�Ÿ�Ա����� �޾����Ƿ� ���� �߻���

insert into dept (dno, dname, loc)
values (300, '123456789012345', 'DAEGU'); -- �÷� dname�� �ִ� 14���ڱ��� ������ �����ؼ�
                                          -- 15�ڸ��� ������ ������ �߻��� : dname varchar2(14)

-- �÷� ������ �ٲ㼭 �Է��غ���

insert into dept (loc, dname , dno)
values ('DAEGU','SALES', 30); -- ���������� �Էµ�

select * from dept

-- �̴� �÷��� ���� ��ġ�� ���� ���� �ش� �÷����� ����ϴ� ������Ÿ���� �����ϱ⸸ �ϸ�
-- ���� ���̺��� �÷� �����ʹ� �����ϰ� �Է��� �����ϰ�, ����غ��� ���� ���ڸ��� ã�Ƽ� ��

-- ������ �ڷ���(���� �ڷ���) Ư¡
   
   char(10) : ����ũ��, 10����Ʈ, 3����Ʈ�� ���� ��쿡 ����� 7����Ʈ�� ����
              �����ٴ� ������ ������, �ϵ� ������ �����Ѵٴ� ������ ����
   varchr(10): ����ũ��, �ִ� 10����Ʈ, 3����Ʈ�� ������ 3����Ʈ�� ������ �Ҵ���.
               �����ٴ� ������ ��������, �ϵ��� ���� ���� ����.
   Nchar(10): ����ũ��. �����ڵ带 ������ �� �ִ� �ڵ�. 
              (�ѱ�, �Ϻ���, �߱��� ���... ����Ʈ ��� ���ؾ� ��)
   Nvarchar2(10): ����ũ��, �����ڵ� ���� ����

-- �ڷ��� (���� �ڷ���)
-- NUMBER(2): ���� 2�ڸ��� �Է� ����
-- NUMBER(7,3): ��ü 7�ڸ�, �Ҽ��� 3�ڸ����� ������ ��
-- NUMBER(8,5): ��ü 8�ڸ�, �Ҽ��� 5�ڸ����� ������ ��

create table test_tb1(
a number (10,2) not null,
b number (10,5) not null,
c char(6) null,
d varchar2(10) null,
e Nchar (6) null,
f Nvarchar2(10) null
);

desc test_tb1;

insert into test_tb1 (a,b,c,d,e,f)
values(3.22, 77.55555, 'aaaaa', 'bbbbbbbbbb', '�ѱۿ�������', '�ѱۿ��ڱ����˴ϴ�');

insert into test_tb1 (a,b,c,d,e,f)
values(3.22, 77.55555, '�ѱ�', '�ѱ�', '�ѱۿ�������', '�ѱۿ��ڱ����˴ϴ�');
-- �ѱ� 1�ڴ� 3byte�� ������. 
commit;
select * from test_tb1;

--
Create table member1(
    no number(10) not null,
    id varchar2(50) not null,
    passwrd varchar2(50) not null,
    name Nvarchar2(10) not null,
    phone varchar2(50) null,
    address Nvarchar2 (100) null,
    mdate date not null,
    email varchar2 (50)null
);

insert into member1 (no, id, passwrd , name, phone, address, mdate, email)
values (1, 'aaaa', 'password', 'ȫ�浿', '010-1111-1111', '���� �߱� ���굿', sysdate, 'aaa@aaa.com');

insert into member1 
values (2, 'bbbb', 'password', '�̼���', '010-2222-2222', '���� �߱� ���굿', sysdate, 'bbb@bbb.com');

-- Null ��� �÷��� Null�� ���� �Ҵ�.
insert into member1 (no, id, passwrd , name, phone, address, mdate, email)
values (3, 'cccc', 'password', '������', NULL, NULL, sysdate, NULL);

-- Null ��� �÷��� Null�� ���� ���� ���� ��� Null ���� ��.
insert into member1 (no, id, passwrd , name, mdate)
values (4, 'dddd', 'password', '�������', sysdate);

commit;

select * from member1;

drop table member1;

    select * from member1;
    desc member1;
    
-- ������ ���� ( update : ������ ���� �� commit;
        -- �ݵ�� w here ������ ����ؾ� �Ѵ�. �׷��� ������ ��� ���ڵ尡 ������.
/*
        update ���̺��
        set �÷��� = ���� �� ��
        where �÷��� = ��
*/

update member1
set name = '�Ż��Ӵ�'
where no = 2;
commit;

select * from member1;

update member1
set name = '��������'
where no = 3;

update member1
set id = 'abcd'
where no = 3;

update member1
set name = '������'
where no = 1;

update member1
set mdate = '22/01/01'
where no = 4;

update member1
set email = 'abcd@abcd.com'
where no = 1;

commit;

rollback

-- �ϳ��� ���ڵ忡�� ���� �÷� ���ÿ� �����ϱ�

update member1
set name = '������', email = 'kkk@kkk.com', phone = '010-7777-7777'
where no = 1;

commit;

select * from member1;

update member1
set mdate = to_date ('2022-01-01', 'YYYY-MM-DD')
where no = 3;

-- ���ڵ�( �ο� ) ���� ( delete : �ݵ�� where ������ ����ؾ� ��. )

/*
    delete ���̺� ��
    where �÷� �� = ��
*/

select * from member1;

delete member1
where no =3;
commit;

delete member1;         -- ��� ���ڵ尡 ������.
rollback;

/*
        update, delete�� �ݵ�� where ������ ����ؾ� �Ѵ�, Ʈ�� ����� ���� (rollback, commit)
*/

/*
    update, delete �� where���� ���Ǵ� �÷��� ������ �÷��̾�� �Ѵ�. ( Primary key, Unique �÷��� ����ؾ� �Ѵ�.
    �׷��� ������ ���� �÷��� ������Ʈ �ǰų� ���� �� �� �ִ�.
    
*/
update member1
set name = '��ʶ�'
where no = 4;

-- ���� ���� : �÷��� ���Ἲ�� Ȯ���ϱ� ���ؼ� ���, ���Ἲ : ���Ծ��� ������ (��, ���ϴ� �����͸� ����) 
    -- Primary key
                -- �ϳ��� ���̺� �ѹ��� ���, �ߺ��� �����͸� ���� ���ϵ��� ����.
                -- null ���� �Ҵ� �� �� ����.

Create table member2 (
    no number(10) not null Primary key,
    id varchar2(50) not null,
    passwrd varchar2(50) not null,
    name Nvarchar2(10) not null,
    phone varchar2(50) null,
    address Nvarchar2 (100) null,
    mdate date not null,
    email varchar2 (50)null
);

insert into member2 (no, id, passwrd , name, phone, address, mdate, email)
values (1, 'aaaa', 'password', 'ȫ�浿', '010-1111-1111', '���� �߱� ���굿', sysdate, 'aaa@aaa.com');

insert into member2 
values (2, 'bbbb', 'password', '�̼���', '010-2222-2222', '���� �߱� ���굿', sysdate, 'bbb@bbb.com');

-- Null ��� �÷��� Null�� ���� �Ҵ�.
insert into member2 (no, id, passwrd , name, phone, address, mdate, email)
values (3, 'cccc', 'password', '������', NULL, NULL, sysdate, NULL);

-- Null ��� �÷��� Null�� ���� ���� ���� ��� Null ���� ��.
insert into member2 (no, id, passwrd , name, mdate)
values (4, 'dddd', 'password', '�������', sysdate);

select * from member2;

update member2
set name = '������'
where no = 6;       -- <== ���̺��� �ߺ����� �ʴ� ������ �÷��� �������� ����ؾ� �Ѵ�.


/*
    ��������
        -- UNIQUE :�ߺ����� �ʴ� ������ ���� ����. �ϳ��� ���̺��� ���� �÷��� ���� �� �� �ִ�.
                -- NULL�� �����, NULL�� �ѹ��� ���� �� �� �ִ�.
*/

Create table member3 (
    no number(10) not null Primary key, -- �ߺ��� ���� ���� �� ����.
    id varchar2(50) not null UNIQUE,    -- �ߺ��� ���� ���� �� ����.
    passwrd varchar2(50) not null,
    name Nvarchar2(10) not null,
    phone varchar2(50) null,
    address Nvarchar2 (100) null,
    mdate date not null,
    email varchar2 (50)null
);

select * from member3;

insert into member3 (no, id, passwrd , name, phone, address, mdate, email)
values (1, 'aaaa', 'password', 'ȫ�浿', '010-1111-1111', '���� �߱� ���굿', sysdate, 'aaa@aaa.com');

insert into member3 
values (2, 'bbbb', 'password', '�̼���', '010-2222-2222', '���� �߱� ���굿', sysdate, 'bbb@bbb.com');

-- Null ��� �÷��� Null�� ���� �Ҵ�.
insert into member3 (no, id, passwrd , name, phone, address, mdate, email)
values (3, 'cccc', 'password', '������', NULL, NULL, sysdate, NULL);

-- Null ��� �÷��� Null�� ���� ���� ���� ��� Null ���� ��.
insert into member3 (no, id, passwrd , name, mdate)
values (6, 'ffff', 'password', '�������', sysdate);



