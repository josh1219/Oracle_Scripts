-- 9일차 시퀀스 , 인덱스,

/*
    시퀀스 : 자동 번호 발생기
        -- 번호가 자동 발생이 되면 뒤로 되돌릴 수 없다. (삭제 후 다시 생성해야 한다.)
*/

-- 초기값 : 10 , 증가값 : 10
create sequence sample_seq
    increment by 10         -- 증가값
    start with 10;          -- 초기값
    
-- 시퀀스의 정보를 출력하는 데이터 사전
select * from user_sequences;

select sample_seq.nextval from dual;    -- 시퀀스의 다음 값을 출력
select sample_seq.currval from dual;    -- 현재 시퀀스의 값을 출력

-- 초기값 : 2 , 증가값 : 2
create sequence sample_seq2
    increment by 2
    start with 2
    nocache;                 -- 캐쉬를 사용하지 않겠다. (RAM)  -- 서버의 부하를 줄여줄수 있다.
    
select sample_seq2.nextval from dual;
select sample_seq2.currval from dual;

-- 시퀀스를 Primary Key에 적용하기

create table dept_copy80
as
select * from department
where 0 = 1;

select * from dept_copy80;

-- 시퀀스 생성 : 초기값 10, 증가값 : 10
create sequence dept_seq
    increment by 10
    start with 10
    nocache;
    
    /* Sequence에 cache를 사용하는 경우 / 사용하지 않는 경우 */
        -- chche : 서버의 성능을 향상 하기 위해서 사용 (기본값 : 20개)
        -- 서버가 다운된 경우 :  캐쉬된 넘버링이 모두 날라간다. 새로운 값을 할당 받는다.
        
    
insert into dept_copy80 (dno, dname, loc)
values (dept_seq.nextval , 'HR' , 'SEOUL');

select * from dept_copy80;

-- 시퀀스 생성
create sequence emp_seq_no
    increment by 1
    start with 1
    nocache;
    
create table emp_copy80
as
select * from employee
where 0=1;

select * from emp_copy80;

-- 시퀀스를 테이블의 특정 컬럼에 적용

insert into emp_copy80
values (emp_seq_no.nextval , 'SMITH' , 'SALESMAN' , 2222 , sysdate , 3000 , 3000 , 20);

-- 기존의 시퀀스 수정

select * from user_sequences;

Alter sequence emp_seq_no
    maxvalue 1000;       -- 최대값 : 1000
    
Alter sequence emp_seq_no
    cycle;               -- 최대값이 적용되고 다시 처음부터 순환
    
    
Alter sequence emp_seq_no
    nocache;
    
select * from user_sequences;

drop sequence sample_seq;

/*
    INDEX : 테이블의 컬럼에 생성 , 특정 컬럼의 검색을 빠르게 사용 할 수 있도록 한다.
        - INDEX Page : 컬럼의 중요 키워드를 걸러서 위치 정보를 담아놓은 페이지.
            - DB 공간의 10% 정도 차지
        - 색인(index) : 책의 색인 , 책의 내용의 중요 키워드를 수집해서 위치를 알려준다.
        - 테이블 스캔 : 레코드의 처음 ~ 마지막 까지 검색 (검색 속도가 느리다.) , 인덱스를 사용하지 않고 검색.
            -- Index가 생성되어 있지 않은 컬럼은 테이블 스캔을 한다.
        - Primary Key , Unique 키가 적용된 컬럼은 Index Page가 생성되어 검색을 빠르게 한다.
        - Where 절에서 자주 검색을 하는 컬럼에 Index를 생성.
        - 테이블의 검색을 자주 하는 컬럼에 Index를 생성, 테이블 스캔을 하지 않고
            Index Page를 검색해서 위치를 빠르게 찾는다.
        - Index를 생성할때 부하가 많이 걸린다. 주로 업무시간을 피해서 야간에 생성함.
        - Index는 잘 생성해야 한다. 
*/

-- index 정보가 저장되어 있는 데이터 사전.
    -- user_colums , user_ind_colums
    
select * from user_tab_columns;
select * from user_ind_columns;

select * from user_tab_columns
where table_name in ('EMPLOYEE' , 'DEPARTMENT');

select index_name , table_name , column_name
from user_ind_columns
where table_name in ('EMPLOYEE' , 'DEPARTMENT');

select * from employee;     -- ENO 컬럼에 Primary Key  <== 자동으로 Index가 생성됨.

/*
    Index 자동 생성 , (Primary Key , Unique) 컬럼에는 Index Page가 자동으로 생성된다.
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
where ename = 'KING';   -- ename 컬럼에 Index가 없으므로 KING을 검색하기 위해서 테이블 스캔 한다.

select * from emp_copy90
where job = 'SALESMAN';



-- ename 컬럼에 index 생성하기. (야간에 작업해야 한다. 부하가 많이 걸린다.)

-- 컬럼에 index가 생성되어 있지 않으면 테이블 스캔을 한다. 처음부터 하나하나 검색한다.
-- 컬럼에 index가 생성되어 있으면 Index Page(책의 목차)를 검색한다.

create index id_emp_ename
on emp_copy90(ename);

drop index id_emp_ename;

/*
    Index는 주기적으로 REBUILD 해줘야 한다 .
         - Index Page는 (Insert , Update , Delete) 빈번하게 일어나면 조각난다.
*/
    
-- Index REBUILD를 해야하는 정보 얻기
    -- Index의 Tree 깊이가 4 이상인 경우가 조회가 되면 rebuild 할 필요가 있다.

SELECT I.TABLESPACE_NAME,I.TABLE_NAME,I.INDEX_NAME, I.BLEVEL,
       DECODE(SIGN(NVL(I.BLEVEL,99)-3),1,DECODE(NVL(I.BLEVEL,99),99,'?','Rebuild'),'Check') CNF
FROM   USER_INDEXES I
WHERE   I.BLEVEL > 4
ORDER BY I.BLEVEL DESC;

-- index rebuild : 

Alter index id_emp_ename rebuild;   -- index를 새롭게 생성한다.

select * from emp_copy90;

/*
    Index를 사용해야 하는 경우
        1. 테이블의 행(로우,레코드)의 갯수가 많은 경우.
        2. Where 절에서 자주 사용되는 컬럼.
        3. Join 시 사용되는 키 컬럼.
        4. 검색 결과가 원본 테이블 데이터의 2~4% 정도 되는 경우
        5. 해당 컬럼이 null이 포함되는 경우. (색인은 null은 제외)
        
    Index를 사용하면 안 좋은 경우
        1. 테이블의 행의 갯수가 적은 경우.
        2. 검색 결과가 원본 테이블의 많은 비중을 차지하는 경우.
        3. insert, update, delete가 빈번하게 일어나는 컬럼.
*/

/*
    index 종류
        1. 고유 인덱스 (Unique Index) : 컬럼의 중복되지 않는 고유한 값을 갖는 Index (Primary Key, Unique)
        2. 단일 인덱스 (Single Index) : 한 컬럼에 부여되는 Index
        3. 결합 인덱스 (Composite Index) : 여러 컬럼을 묶어서 생성한 Index
        4. 함수 인덱스 (Function Base Index) : 함수를 적용한 컬럼에 생성한 Index
*/

select * from emp_copy90;

-- 단일 인덱스
create index inx_emp_copy90_salary
on emp_copy90 (salary);

-- 결합 인덱스 생성 : 두 컬럼 이상을 결합해서 인덱스 생성.
create table dept_copy91
as
select * from department;

create index idx_dept_copy91_dname_loc
on dept_copy91 (dname,loc);

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('DEPT_COPY91');

-- 함수 기반 인덱스 : 함수를 적용한 컬럼에 부여되는 index

create table emp_copy91
as
select * from employee;

create index idx_emp_copy91_allsal
on emp_copy91 (salary * 12);        -- 컬럼에 함수, 계산식을 적용한 index.

/* 인덱스 삭제 */

drop index idx_emp_copy91_allsal;


/* 권한 관리 */
/*
    사용 권한 : DBMS는 여러명이 사용
    - 각 사용자별로 계정을 생성 : DBMS에 접속 할 수 있는 사용자를 생성.
        (인증 (Authentication : Credential ( Identity + Password) 확인
        (허가 (Authorization : 인증된 사용자에게 Oracle의 시스템 권한 , 객체 (테이블, 뷰, 트리거, 함수) 권한
            - System Privileges : 오라클의 전반적인 권한 할당
            - Object Privileges : 테이블, 뷰, 트리거, 함수, 저장 프로시저, 시퀀스, 인덱스) 접근 권한.
*/

-- Oracle에서 계정 생성. (일반 계정에서는 계정을 생성 할 수 있는 권한이 없다.)
show user

-- 최고 관리자 계정 (sys) : 계정을 생성 할 수 있는 권한을 가지고 있다.

-- 아이디 : usertest01 , 암호 : 1234
create user usertest01 identified by 1234;

-- 계정과 암호를 생성했다고 해서 오라클에 접속 할 수 있는 권한을 부여 받아야 접속 가능

-- System Privileges :
    -- Create Session : 오라클에 접속 할 수 있는 권한.
    -- Create Table : 오라클에서 테이블을 생성 할 수 있는 권한.
    -- Create Sequence : 시퀀스를 생성 할 수 있는 권한.
    -- Create View : 뷰를 생성 할 수 있는 권한.
    
DDL : 객체 생성 (Create, Alter, Drop)
DML : 레코드 조작 (Insert, Update, Delete)
DQL : 레코드 검색 (Select)
DTL : 트랜잭션 (Begin transaction, rollback, commit)
DCL : 권한 관리 ( Grant, Revoke, Deny)
-- 생성한 계정에게 오라클에 접속 할 수 있는 Create Session 권한을 부여.
-- grant 부여 할 권한 to 계정명
grant create session to usertest01

-- 오라클에 접속했다 라고 해서 테이블에 접근 할 수 있는 권한이 없다.

grant create table to usertest01;

/* 테이블 스페이스 (Table Space) : 객체(테이블, 뷰, 시퀀스, 인덱스, 트리거, 저장 프로시저, 함수...)
    를 저장하는 공간. 관리자 계정에서 각 사용자별 테이블 스페이스를 확인.
    SYSTEM : DBA (관리자 계정에서만 접근 가능)
*/
select * from dba_users;    -- dba_ : sys (최고 관리자 계정에서 확인)

select username,default_tablespace as DataFile ,temporary_tablespace as LogFile
from dba_users
where username in ('HR','USERTEST01');

-- 계정에게 테이블 스페이스 변경 (SYSTEM ==> USERS) 변경
Alter user usertest01
default tablespace users        -- DataFile 저장 : 객체가 저장되는 공간 (테이블, 뷰, 트리거, 인덱스 . . . . .)
temporary tablespace temp       -- LOG를 저장 : DML (Insert, Update, Delete)
                                -- LOG를 호칭 할 때 Transaction Log. 시스템의 문제 발생시 백업 시점이 아니라 오류난 시점까지 복원

-- 계정에게 Users 테이블 스페이스를 사용 할 수 있는 공간 할당. ( users 테이블 스페이스에 2mb를 사용 공간 할당)
Alter user usertest01
quota 2m on users;


-- Object Privileges : 테이블, 뷰, 트리거, 함수,
    -- 저장 프로시저, 시퀀스, 인덱스에 부여되는 권한 할당.
















문제 : usertest02 계정을 생성후에 users 테이블 스페이스에서 테이블 (tb12) 생성 후 insert.



create user usertest02 identified by 1234;

grant create session to usertest02;

grant create table to usertest02;

Alter user usertest02
default tablespace users
temporary tablespace temp

Alter user usertest02
quota 2m on users;

select * from All_tables    -- 테이블의 소유주를 출력 해준다. 계정별로 소유한 테이블을 출력 할 수 있다.
where owner in ('HR', 'USERTEST01', 'USERTEST02');