-- 7일차 퀴즈

1. 다음 표에 명시된 대로 DEPT 테이블을 생성 하시오. 

컬럼명	데이터타입	크기	NULL
---------------------------------------------------------------
DNO	number		2	NOT NULL
DNAME	varchar2		14	NULL
LOC	varchar2		13	NULL

Create Table dept( -- 테이블 생성
    dno number (2) not null,
    dname varchar2(14) null,
    loc varchar2(13) null
    );


2. 다음 표에 명시된 대로 EMP 테이블을 생성 하시오. 

컬럼명	데이터타입	크기	NULL
---------------------------------------------------------------
ENO	number		4	NOT NULL
ENAME	varchar2		10	NULL
DNO	number		2	NULL

Create Table EMP( -- 테이블 생성
    eno number (4) not null,
    ename varchar2(10) null,
    dno number(2) null
    );

3. 긴이름을 넣을 수 있도록 EMP 테이블의 ENAME 컬럼의 크기를 늘리시오. 

컬럼명	데이터타입	크기	NULL
---------------------------------------------------------------
ENO	number		4	NOT NULL
ENAME	varchar2		25	NULL		<<==수정 컬럼  : 10 => 25  로 늘림
DNO	number		2	NULL

Alter table EMP
modify ename varchar2 (25);

4. EMPLOYEE 테이블을 복사해서 EMPLOYEE2 란 이름의 테이블을 생성하되 사원번호, 이름, 급여, 부서번호 컬럼만 복사하고 새로 생성된 테이블의 컬럼명은 각각 EMP_ID, NAME, SAL, DEPT_ID 로 지정 하시오. 

create table EMPLOYEE2
as
select eno EMP_ID, ename NAME, salary SAL , dno DEPT_ID
from employee;

5. EMP 테이블을 삭제 하시오. 

drop table EMP;

6. EMPLOYEE2 란 테이블 이름을 EMP로 변경 하시오. 

rename EMPLOYEE2 to EMP;

7. DEPT 테이블에서 DNAME 컬럼을 제거 하시오

Alter table dept
drop column dname;

8. DEPT 테이블에서 LOC 컬럼을 UNUSED로 표시 하시오. 

Alter table dept
rename column loc to UNUSED;

9. UNUSED 커럼을 모두 제거 하시오. 

Alter table dept
drop column unused;


09 - 데이터 조작과 트랜잭션 문제. 
========================================

1. EMP 테이블의 구조만 복사하여 EMP_INSERT 란 이름의 빈 테이블을 만드시오. 

create table EMP_INSERT
as
select * from EMP
where 0 = 1; 


2. 본인을 EMP_INSERT 테이블에 추가하되 SYSDATE를 이용해서 입사일을 오늘로 입력하시오. 

Alter table EMP_INSERT
add (hiredate date);

select * from emp_insert;
desc emp_insert;

insert into EMP_INSERT (EMP_ID, name, sal, DEPT_ID, hiredate)
values (1, '조승현', 1000, 10, sysdate);


3. EMP_INSERT 테이블에 옆 사람을 추가하되 TO_DATE 함수를 이용해서 입사일을 어제로 입력하시오.

insert into EMP_INSERT (EMP_ID, name, sal, DEPT_ID, hiredate)
values (2, '신장현', 1000, 20, to_date('2022/04/26','YYYY/MM/DD'));

4. employee테이블의 구조와 내용을 복사하여 EMP_COPY란 이름의 테이블을 만드시오. 

create table EMP_COPY
as
select * from employee;

5. 사원번호가 7788인 사원의 부서번호를 10번으로 수정하시오. [ EMP_COPY 테이블 사용]

select * from EMP_COPY where eno = '7788' ; 

update EMP_COPY
set dno = 10
where eno = 7788;
commit;

6. 사원번호가 7788 의 담당 업무 및 급여를 사원번호 7499의 담당업무 및 급여와 일치 하도록 갱신하시오. [ EMP_COPY 테이블 사용] 

select * from EMP_COPY where eno = '7788' ;
select * from EMP_COPY where eno = '7499' ;

update EMP_COPY
set job = (select job from EMP_COPY where eno = '7499'),salary=(select salary from EMP_COPY where eno = '7499')
where eno = 7788;
commit;

7. 사원번호 7369와 업무가 동일한 사원의 부서번호를 사원 7369의 현재 부서번호로 갱신 하시오. [ EMP_COPY 테이블 사용]

select * from EMP_COPY where job = 'CLERK';

update EMP_COPY
set dno = 20
where job ='CLERK' ;
commit;

update EMP_COPY
set dno = (select dno from EMP_COPY where eno = '7369' )
where job =(select job from EMP_COPY where eno = '7369' ) ;
commit;


8. department 테이블의 구조와 내용을 복사하여 DEPT_COPY 란 이름의 테이블을 만드시오. 

create table DEPT_COPY
as
select * from department;

9. DEPT_COPY란 테이블에서 부서명이 RESEARCH인 부서를 제거 하시오. 

select * from dept_copy

delete dept_copy
where dname ='RESEARCH';
commit;

10. DEPT_COPY 테이블에서 부서번호가 10 이거나 40인 부서를 제거 하시오. 

select * from dept_copy

delete dept_copy
where dno = 10 or dno = 40;
commit;





