8일차 - 뷰 , 시퀀스, 인덱스 
/*
    뷰 (view) : 가상의 테이블을  뷰 (view)라 한다. 
        -- 테이블은 데이타 값을 가지고 있다. 
        -- 뷰는 데이터 값을 가지지 않는다. 실행 코드만 들어가 있다. 
        -- 뷰를 사용하는 목적 : 
            1. 보안을 위해서 : 실제 테이블의 특정 컬럼만 가져와서 실제 테이블의중요 컬럼을 숨길수 있다. 
            2. 복잡한 쿼리를 뷰를 생성해서 편리하게 사용할 수 있다. (복잡한 JOIN 쿼리)
        - 뷰는 일반적으로 select 구문이 온다.
        - 뷰는 insert, update, delet 구문이 올수 없다. 
        - 뷰에 값을 insert 하면 실제 테이블에 저장된다. 실제 테이블의 제약조건을 잘 만족해야 된다.
        - 뷰에 값을 insert  할경우 실제 테이블의 제약조건에 따라서 inset 될 수도 있고 그렇지 않을 수도있다. 
        - 그룹함수를 적용한 view에는 insert  할 수 없다. 
*/ 

create table dept_copy60
as 
select * from department; 

create table emp_copy60
as 
select * from employee; 

-- 뷰 생성 
Create view v_emp_job 
as 
select eno, ename, dno, job
from emp_copy60 
where job like 'SALESMAN' 

-- 뷰 생성 확인 
select * from user_views; 

-- 뷰의 실행  ( select * from 뷰이름) 
select * from v_emp_job 


-- 복잡한 조인 쿼리를 뷰에 만들어 두기 

create view v_join 
as 
select e.dno, ename, job, dname, loc 
from employee e, department d
where e.dno = d.dno 
and job = 'SALESMAN' 

select * from v_join  

-- 뷰를 사용해서 실제 테이블의 중요한 정보 숨기기. (보안) 

select * from emp_copy60; 

create view simple_emp 
as 
select ename, job, dno 
from emp_copy50 

select * from simple_emp  -- view를 사용해서 실제 테이블의 중요 컬럼을 숨긴다.  

select * from user_views; 

--  뷰를 생성할때 반드시 별칭 이름을 사용해야 하는 경우 , group by 할때 

create view v_groupping 
as
select dno , count(*) groupCount, AVG(salary )  AVG , SUM (salary ) SUM 
from emp_copy60
group by dno 

select * from v_groupping 


-- 뷰를 생성할때 as 하위에 select 문이 와야한다. insert, update, delete 문은 올 수 없다. 
create view v_error 
as 
insert into dno 
values ( 60 , 'HR', 'PUSAN') 

-- view 에 값을 insert 할 수 있을까? 컬럼의 제약 조건을 만족하면 view에도 값을 넣을 수 있다. 
    -- 실제 테이블에 값이 insert 된다. 
    
create view v_dept
as 
select dno, dname 
from dept_copy60

select * from v_dept

insert into v_dept      -- View 에 값을 Insert, 제약조건일 일치할때 잘 insert  된다. 
values ( 70 , 'HR') 

select * from dept_copy60

create or replace view v_dept    -- v_dept가 존재하지 않을 경우: create, 존재할 경우 : replace (수정) 
as 
select dname, loc 
from dept_copy60 

select * from v_dept

insert into v_dept
values ('HR2' , 'PUSAN') 

select * from v_dept
select * from dept_copy60 

update dept_copy60
set dno = 80 
where dno is null 
commit

alter table dept_copy60
add constraint PK_dept_copy60 Primary key (dno)

select * from user_constraints

where table_name = 'DEPT_COPY60'

select * from v_dept

insert into v_dept
values ('HR3', 'PUSAN2') 


select * from user_views; 

select * from v_groupping   -- 그룹핑된  view 에는 insert  할 수 없다. 

create or replace view v_groupping 
as 
select dno , count(*) groupCount, round(AVG(salary ),2)  AVG , SUM (salary ) SUM 
from emp_copy60
group by dno

select * from v_groupping

drop view v_groupping 

-- insert, update, delete 가 가능한 뷰 
create view v_dept10
as 
select dno, dname , loc 
from dept_copy60 

insert into v_dept10 
values ( 90, 'HR4', 'PUSAN4')

select * from v_dept10; 

update v_dept10
set dname = 'HR5' , loc = 'PUSAN5' 
where dno = 90 

delete v_dept10 
where dno = 90 

commit

--읽기만 가능한 뷰를 생성 : (insert , update, delete 못하도록 설정 )  

create view v_readonly 
as 
select dno, dname, loc
from dept_copy60  with read only ;

select * from v_readonly

insert into v_readonly
values ( 88, 'HR7', 'PUSAN7' ) 

update v_readonly
set dname = 'HR77' , loc = 'PUSAN77' 
where dno = 88

delete v_readonly
where dno = 88 





08 테이블 생성 수정 제거   <<완료 시간 : 12: 20>>

1. 다음 표에 명시된 대로 DEPT 테이블을 생성 하시오. 

컬럼명	데이터타입	크기	NULL
---------------------------------------------------------------
DNO	    number		2	NOT NULL
DNAME	varchar2	14	NULL
LOC	    varchar2	13	NULL

select * from user_tables  --데이터 사전 : 시스템의 각종 정보를 출력 
where table_name = 'DEPT' 

drop table dept; 

Create table dept (
    dno number(2) not null 
    , dname varchar2 (14) null 
    , loc varchar2 (13) null
    )


2. 다음 표에 명시된 대로 EMP 테이블을 생성 하시오. 

컬럼명	데이터타입	크기	NULL
---------------------------------------------------------------
ENO	    number		4	NOT NULL
ENAME	varchar2	10	NULL
DNO	    number		2	NULL

drop table EMP;

create table emp (
    eno number (4)  not null
    , ename varchar2(10) null
    , dno number(2) null 
    )
 -- DB  설정에 따라서 , NULL 허용 여부가 다르게 셋팅되어 있을 수 있다. 
 



3. 긴이름을 넣을 수 있도록 EMP 테이블의 ENAME 컬럼의 크기를 늘리시오. 

컬럼명	데이터타입	크기	NULL
---------------------------------------------------------------
ENO	    number		4	NOT NULL
ENAME	varchar2	25	NULL		<<==수정 컬럼  : 10 => 25  로 늘림
DNO	    number		2	NULL

alter table emp 
modify ename varchar2(25) 

desc emp

select length (ename) from employee
where length (ename) > 5


4. EMPLOYEE 테이블을 복사해서 EMPLOYEE2 란 이름의 테이블을 생성하되 사원번호, 이름, 급여, 부서번호 컬럼만 복사하고 새로 생성된 테이블의 컬럼명은 각각 EMP_ID, NAME, SAL, DEPT_ID 로 지정 하시오. 
create table employee2
as 
select eno, ename, salary, dno from employee; 

select * from employee2

-- 테이블 복사시 제약조건은 복사 되지 않는다. 
    -- Primary Key, Unique, not null, check, Foreign Key, default  




5. EMP 테이블을 삭제 하시오. 
 drop table emp
 

6. EMPLOYEE2 란 테이블 이름을 EMP로 변경 하시오. 
rename employee2 to emp ; 

desc employee2; 
desc emp; 

7. DEPT 테이블에서 DNAME 컬럼을 제거 하시오
select * from dept; 

-- 실제 운영하는 시스템에서는 레코드가 많이 들어있다. 컬럼제거시 부하가 많이 발생, (야간)

alter table dept 
drop column dname 


8. DEPT 테이블에서 LOC 컬럼을 UNUSED로 표시 하시오.  <== 제거할 컬럼을 비활성화. (업무시간)
alter table dept 
set unused ( loc ) ; 


9. UNUSED 커럼을 모두 제거 하시오.  (야간에 작업)
alter table dept 
drop unused columns; 



09 - 데이터 조작과 트랜잭션 문제. 
========================================

1. EMP 테이블의 구조만 복사하여 EMP_INSERT 란 이름의 빈 테이블을 만드시오.  <<hiredate 컬럼을  date 자료형으로 추가하세요.>>

select * from emp 

create table emp_insert 
as
select * from emp  
where 0=1          --  조건을 false 로 설정하면 


2. 본인을 EMP_INSERT 테이블에 추가하되 SYSDATE를 이용해서 입사일을 오늘로 입력하시오. 

select * from emp_insert 

-- 테이블에 컬럼을 추가할때는  NULL 허용하면서 추가 해야 함. 

alter table emp_insert 
add hiredate date; 

desc emp_insert; 

insert into emp_insert (eno, ename, salary, dno, hiredate)
values ( 1000, '홍길동', 3000.35 , 10, sysdate ) 
commit; 

3. EMP_INSERT 테이블에 옆 사람을 추가하되 TO_DATE 함수를 이용해서 입사일을 어제로 입력하시오. 
insert into emp_insert (eno, ename, salary, dno, hiredate)
values ( 1001, '옆사람', 3000.35 , 10, to_date (sysdate -1) ) 
commit;

4. employee테이블의 구조와 내용을 복사하여 EMP_COPY란 이름의 테이블을 만드시오. 
create table emp_copy
as
select * from employee

5. 사원번호가 7788인 사원의 부서번호를 10번으로 수정하시오. [ EMP_COPY 테이블 사용] 
select * from emp_copy

update emp_copy
set dno = 10
where eno = 7788        -- 주의 :  UPDATE, DELETE 시 반드시 조건을 사용. 

commit;         -- 트랜잭션 처리 

rollback; 

6. 사원번호가 7788 의 담당 업무 및 급여를 사원번호 7499의 담당업무 및 급여와 일치 하도록 갱신하시오. [ EMP_COPY 테이블 사용] 

select * from emp_copy where eno = 7788
select * from emp_copy where eno = 7499

update emp_copy
set job = (select job from emp_copy where eno = 7788), 
    salary = (select salary from emp_copy where eno = 7788)
where eno = 7499; 


7. 사원번호 7369와 업무가 동일한 사원의 부서번호를 사원 7369의 현재 부서번호로 갱신 하시오. [ EMP_COPY 테이블 사용] 
select * from emp_copy where eno = 7369; 







8. department 테이블의 구조와 내용을 복사하여 DEPT_COPY 란 이름의 테이블을 만드시오. 
drop table dept_copy; 

create table dept_copy 
as
select * from department; 


9. DEPT_COPY란 테이블에서 부서명이 RESEARCH인 부서를 제거 하시오. 
select * from dept_copy; 

delete dept_copy
where dname = 'RESEARCH'
commit




10. DEPT_COPY 테이블에서 부서번호가 10 이거나 40인 부서를 제거 하시오. 
delete dept_copy 
where dno in ( 10, 40 ) 
commit



10 : 테이터 무결성과 제약 조건, 11 뷰 : 완료 시간 <<6:20분>>

1. employee 테이블의 구조를 복사하여 emp_sample 란 이름의 테이블을 만드시오. 
사원 테이블의 사원번호 컬럼에 테이블 레벨로 primary key 제약조건을 지정하되 
제약조건 이름은 my_emp_pk로 지정하시오. 

--테이블 복사할때 제약조건은 복사되지 않는다. Alter table을 사용해서 넣어줘야 한다. 
create table emp_sample 
as 
select * from employee
where 0=1; 

select * from emp_sample; 

alter table emp_sample 
add constraint PK_emp_sample_eno Primary Key (eno) ; 

select * from user_constraints 
where table_name = 'EMP_SAMPLE' 


2. department 테이블의 구조를 복사하여 dept_sample 란 이름의 테이블을 만드시오. 
부서 테이블의 부서번호 컬럼에 레벨로 primary key 제약 조건을 지정하되 제약 조건이름은 my_dept_pk로 지정하시오. 
create table dept_sample
as
select * from department
where 0=1

alter table dept_sample
add constraint PK_dept_sample_dno Primary Key (dno); 

select * from user_constraints
where table_name = 'DEPT_SAMPLE' 


3. 사원 테이블의 부서번호 컬럼에 존재하지 않는 부서의 사원이 배정되지 않도록 
외래키 제약조건을 지정하되 제약 조건이름은 my_emp_dept_fk 로 지정하시오. 
[주의 : 위 복사한 테이블을 사용하시오]
select * from emp_sample ; 
select * from dept_sample ; 

alter table emp_sample 
add constraint FK_emp_sample_dno_dept_sample Foreign Key (dno) references dept_sample(dno); 

select * from user_constraints
where table_name in ( 'EMP_SAMPLE', 'DEPT_SAMPLE') ; 



4. 사원테이블의 커밋션 컬럼에 0보다 큰 값만을 입력할 수 있도록 제약 조건을 지정하시오. 
[주의 : 위 복사한 테이블을 사용하시오]

select * from emp_sample 

alter table emp_sample 
add constraint CK_emp_sample_commission check ( commission >= 0 ) 


5. 사원테이블의 웝급 컬럼에 기본 값으로 1000 을 입력할 수 있도록 제약 조건을 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]
-- alter table 
-- modify          <== default, Not NULL 


alter table emp_sample 
modify salary default 1000


6. 사원테이블의 이름 컬럼에 중복되지 않도록  제약 조건을 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]

select * from user_constraints
where table_name in ( 'EMP_SAMPLE', 'DEPT_SAMPLE') ;

alter table emp_sample 
add constraint UK_emp_sample_ename Unique (ename) ; 


7. 사원테이블의 커밋션 컬럼에 null 을 입력할 수 없도록 제약 조건을 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]
alter table emp_sample 
modify commission NOT NULL ; 



8. 위의 생성된 모든 제약 조건을 제거 하시오. 
select * from user_constraints
where table_name in ( 'EMP_SAMPLE', 'DEPT_SAMPLE') ;


 -- 제약 조건을 제거시 : Foreign Key 참조하면 제거가 안된다. 
    -- 1. Foreign Key를 먼저 제거후 Primary Key 제거 
    -- 2. Primary Key를 제거할때 cascade 옵션을 사용 : Foreign Key 먼저 제거되고 Primary Key가 제거됨. 
    
alter table dept_sample 
drop Primary key cascade;

alter table emp_sample 
drop constraint PK_EMP_SAMPLE_ENO ; 

alter table emp_sample 
drop constraint CK_EMP_SAMPLE_COMMISSION ; 

alter table emp_sample 
drop constraint UK_EMP_SAMPLE_ENAME ; 

alter table emp_sample 
drop constraint SYS_C007135 ; 


뷰 문제 

1. 20번 부서에 소속된 사원의 사원번호과 이름과 부서번호를 출력하는 select 문을 하나의 view 로 정의 하시오.
	뷰의 이름 : v_em_dno  
    -- 뷰 : 가상의 테이블 , select 문만 올수 있다. 
        -- 보안을 위해서 - 실제 테이블의 컬럼을 숨길수 있다.  
        -- 편의성을 위해서 : 복잡한 구문을 view를 생성하면 , 복잡한 Join 
    create table emp_view 
    as 
    select * from employee;
    
    create table dept_view
    as 
    select * from department; 
    
    --뷰 생성
    create view v_em_dno 
    as 
    select eno,ename, dno from emp_view
    where dno = 20 
    
    --뷰 실행 
    select * from v_em_dno; 
    
2. 이미 생성된 뷰( v_em_dno ) 에 대해서 급여 역시 출력 할 수 있도록 수정하시오. 
   create or replace view v_emp_dno    
   as 
   select eno,ename, dno , salary from emp_view
   where dno = 20 



3. 생성된  뷰를 제거 하시오. 
drop view v_emp_dno 

4. 각 부서의 급여의  최소값, 최대값, 평균, 총합을 구하는 뷰를 생성 하시오. <<주의 : 별칭이름 사용해야함.>>
	뷰이름 : v_sal_emp
    
    create or replace view  v_sal_emp
    as 
    select min (salary) MIN , max (salary) MAX, round (avg(salary),2) AVG , sum(salary) SUM
    from emp_view 
    group by dno 
    
    select * from v_sal_emp 
    
    
5. 이미 생성된 뷰( v_em_dno ) 에 대해서 << 읽기전용 뷰로>>  수정하시오. 

    create or replace view  v_sal_emp
    as 
    select min (salary) MIN , max (salary) MAX, round (avg(salary),2) AVG , sum(salary) SUM
    from emp_view 
    group by dno  with read only; 










시퀀스 문제. 

1. emp01 테이블을 아래와 같이 생성하시오. 

컬럼명	데이터타입	크기	NULL		제약조건
-----------------------------------------------------------------------------------
empno	number		4	NOT NULL	Primary key
ename	varchar2		10	NULL
hiredate	date			NULL

2. emp01 테이블의 사원번호가 자동으로 생성되도록 시퀀스를 생성 하시오. 
   초기값 : 1
   증가값 : 1
   최대값 : 100000

3. 사원번호를 시퀀스로 부터 발급 받으시오. 




















