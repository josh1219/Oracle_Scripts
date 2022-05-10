-- sys 계정   <최고 관리자 계정으로 접속>

-- Autication (인증) : credential ( ID + Pass)
Create user user_test10 identified by 1234;  -- 계정 생성.

-- Authorization (허가) : system 권한 할당.
grant create session, create table, create view to user_test10;

-- 계정을 생성하면 system 테이블 스페이스를 사용한다. <== 관리자만 사용가능한 테이블 스페이스
-- 테이블 스페이스 바꾸기. (USERS)
Alter user user_test10
default tablespace "USERS"
temporary tablespace "TEMP"

-- 테이블 스페이스 용량 할당. (
Altet user "USER_TEST10" Quota unlimised

-- 특정 계정에서 객체를 생성하면 그 계정이 그 객체를 소유하게 된다.
select * from dba_tables
where owner in ('HR', 'USER_TEST10');

-- 다른 사용자의 테이블을 접근할려면 권한을 가져야 한다.
grant select on hr.employee to user_test10;

-- 권한을 부여 할 때
grant insert, update, delete on hr.emp_copy55 to user_test10;

--권한을 해제 할 때
revoke insert on hr.emp_copy55 from user_test10;

/* with grant option : 특정 계정에게 권한을 부여하면서 해당 권한을 다른 사용자에게도 부여 할 수 있는 권한
    -- 부여받은 권한을 다른 사용자에게 부여해 줄 수 있는 권한.
*/

grant select on hr.employee to user_test10 with grant option;
    -- user_test10 계정은 hr.eployee 테이블에 대해서 다른 사용자에게 select 권한을 부여 할 수 있다.



/* Public : 모든 사용자에게 권한을 부여하는 것. */
grant select, insert,update, delete on hr.dept_copy56 to public


/* 룰 (Role) : 자주 사용하는 여러개의 권한을 묶어 놓은 것
    
    1. dba : 시스템의 모든 권한이 적용된 role , -- sys (최고 관리자 권한)
    2. connect :
    3. resource :
*/

-- 사용자 정의 Role 생성 : 자주 사용하는 권한들을 묶어서 role을 생성.
1. 롤 생성 :
    create role roletest1;

2. 롤에 자주 사용하는 권한을 적용.
    grant create session, create table, create view, create sequence,
    
    
    
    
    
    
    
-- 실습 : 
hr.dept_copy57을 생성

-- 롤 생성 roletest3
roletest3 : hr.dept_copy57 (select, insert, delete) 객체 롤
user_test10 적용.

