6일차 CRUD (Create, Read, Update, Delete)

OBJECT (객체): DataBase의 존재( XE, <= Express Edition(무료 버전 <=> Standard, Enterprise 유료 버전) 
                                    (무료버전은 DB생성을 못하고 제공된 것만 사용 가능함)
              a) 테이블 , b) 뷰, c) 저장 프로시저, d) 트리거, e) 인덱스, f)함수, g) 시퀀스
              DDL (Create, Alter, Drop)
    

테이블 생성 (Create)

    Create Table 테이블명(
        컬럼명 자료형 널허용여부 [제약조건],
        컬럼명 자료형 널허용여부 [제약조건]
        컬럼명 자료형 널허용여부 [제약조건],
    );

Create Table dept( -- 테이블 생성
dno number (2) not null,
dname varchar2(14) not null,
loc varchar2(13) null
);

    DML문: 테이블의 값 (레코드, 로우)을 넣고 (insert), 수정(update), 삭제(delete) 기능을 함
           이러한 DML문은 먼저 log에 기록한 후에 DataBase에 코드를 적용함
           이 DML문은 자동으로 트랜잭션을 시작해 RAM에만 적용시켜 둠. 아직 DB에는 적용 시키지 않은 상태
           
    begin transaction; -- 트랜잭션을 시작함
    rollback; -- 트랜잭션을 롤백함. 그러나 DB를 바꾸는 것은 아님. RAM에 로드된 변경사항들을 지우는 것임
    commit; --트랜잭션을 적용함. 트랜잭션을 영구히 DB에 적용하는 것

/* insert 사용법

insert into 테이블명 (컬럼명, 컬럼명, 컬럼명 ....)
values ( 값1, 값2, 값3, ...);

하지만 컬럼명은 생략이 가능함

insert into 테이블명
values ( 값1, 값2, 값3, ...);

*/



--DML 적용해보기
insert into dept (dno, dname, loc) -- 트랜잭션에 성공함
values (10, 'MANAGER','SEOUL');

select * from dept; -- 삽입한 내용이 보임
rollback; -- 롤백완료라고 출력됨
select * from dept; -- 삽입한 내용이 사라짐

--생략된 insert 표현 사용하기
insert into dept
values (10, 'ACCOUNTING','BUSAN');

select * from dept; -- 삽입한 내용이 보임
commit;
select * from dept; -- 종료 후 재시작해도 보임


--  NULL 허용 컬럼에 값 넣지 않기

insert into dept (dno,dname)
values (30, 'RESEARCH'); -- NULL을 서용한 3번째 열에만 값을 넣지 않음

select * from dept; -- 삽입한 내용이 보임 이 때 삽입된 행에서 값을 넣지 않은 칸은
                    -- (NULL) 값이 출력됨
                    
-- 데이터 유형에 맞는 않는 값을 넣어 오류 발생시켜보기

insert into dept (dno, dname, loc)
values (300, 'SALES', 'DAEGU'); -- 컬럼1이 2자리의 넘버타입까지만 받아지므로 오류 발생함

insert into dept (dno, dname, loc)
values (300, '123456789012345', 'DAEGU'); -- 컬럼 dname은 최대 14글자까지 들어가도록 설정해서
                                          -- 15자리를 넣으면 오류가 발생함 : dname varchar2(14)

-- 컬럼 순서를 바꿔서 입력해보기

insert into dept (loc, dname , dno)
values ('DAEGU','SALES', 30); -- 정상적으로 입력됨

select * from dept

-- 이는 컬럼과 같은 위치에 들어가는 값이 해당 컬럼에서 허용하는 데이터타입을 만족하기만 하면
-- 실제 테이블의 컬럼 순서와는 무관하게 입력이 가능하고, 출력해보면 각자 제자리를 찾아서 들어감

-- 종류별 자료형(문자 자료형) 특징
   
   char(10) : 고정크기, 10바이트, 3바이트만 넣을 경우에 빈공간 7바이트가 생김
              빠르다는 장점이 있으나, 하드 공간을 낭비한다는 단점이 있음
   varchr(10): 가변크기, 최대 10바이트, 3바이트만 넣으면 3바이트만 공간을 할당함.
               느리다는 단점ㅇ ㅣ있으나, 하드의 공간 낭비가 없음.
   Nchar(10): 고정크기. 유니코드를 저장할 수 있는 코드. 
              (한글, 일본어, 중국어 등등... 바이트 계산 잘해야 함)
   Nvarchar2(10): 가변크기, 유니코드 저장 가능

-- 자료형 (숫자 자료형)
-- NUMBER(2): 정수 2자리만 입력 가능
-- NUMBER(7,3): 전체 7자리, 소숫점 3자리까지 저장이 됨
-- NUMBER(8,5): 전체 8자리, 소숫점 5자리까지 저장이 됨

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
values(3.22, 77.55555, 'aaaaa', 'bbbbbbbbbb', '한글여섯글자', '한글열자까지됩니다');

insert into test_tb1 (a,b,c,d,e,f)
values(3.22, 77.55555, '한글', '한글', '한글여섯글자', '한글열자까지됩니다');
-- 한글 1자는 3byte를 차지함. 
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
values (1, 'aaaa', 'password', '홍길동', '010-1111-1111', '서울 중구 남산동', sysdate, 'aaa@aaa.com');

insert into member1 
values (2, 'bbbb', 'password', '이순신', '010-2222-2222', '서울 중구 남산동', sysdate, 'bbb@bbb.com');

-- Null 허용 컬럼에 Null로 값을 할당.
insert into member1 (no, id, passwrd , name, phone, address, mdate, email)
values (3, 'cccc', 'password', '강감찬', NULL, NULL, sysdate, NULL);

-- Null 허용 컬럼에 Null로 값을 넣지 않을 경우 Null 값이 들어감.
insert into member1 (no, id, passwrd , name, mdate)
values (4, 'dddd', 'password', '세종대왕', sysdate);

commit;

select * from member1;

drop table member1;

    select * from member1;
    desc member1;
    
-- 데이터 수정 ( update : 데이터 수정 후 commit;
        -- 반드시 w here 조건을 사용해야 한다. 그렇지 않으면 모든 레코드가 수정됨.
/*
        update 테이블명
        set 컬럼명 = 수정 할 값
        where 컬럼명 = 값
*/

update member1
set name = '신사임당'
where no = 2;
commit;

select * from member1;

update member1
set name = '을지문덕'
where no = 3;

update member1
set id = 'abcd'
where no = 3;

update member1
set name = '김유신'
where no = 1;

update member1
set mdate = '22/01/01'
where no = 4;

update member1
set email = 'abcd@abcd.com'
where no = 1;

commit;

rollback

-- 하나의 레코드에서 여러 컬럼 동시에 수정하기

update member1
set name = '김유신', email = 'kkk@kkk.com', phone = '010-7777-7777'
where no = 1;

commit;

select * from member1;

update member1
set mdate = to_date ('2022-01-01', 'YYYY-MM-DD')
where no = 3;

-- 레코드( 로우 ) 삭제 ( delete : 반드시 where 조건을 사용해야 함. )

/*
    delete 테이블 명
    where 컬럼 명 = 값
*/

select * from member1;

delete member1
where no =3;
commit;

delete member1;         -- 모든 레코드가 삭제됨.
rollback;

/*
        update, delete는 반드시 where 조건을 사용해야 한다, 트랜 잭션을 종료 (rollback, commit)
*/

/*
    update, delete 시 where절에 사용되는 컬럼은 고유한 컬럼이어야 한다. ( Primary key, Unique 컬럼을 사용해야 한다.
    그렇지 않으면 여러 컬럼이 업데이트 되거나 삭제 될 수 있다.
    
*/
update member1
set name = '김똘똘'
where no = 4;

-- 제약 조건 : 컬럼의 무결성을 확보하기 위해서 사용, 무결성 : 결함없는 데이터 (즉, 원하는 데이터만 저장) 
    -- Primary key
                -- 하나의 테이블에 한번만 사용, 중복된 데이터를 넣지 못하도록 설정.
                -- null 값을 할당 할 수 없다.

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
values (1, 'aaaa', 'password', '홍길동', '010-1111-1111', '서울 중구 남산동', sysdate, 'aaa@aaa.com');

insert into member2 
values (2, 'bbbb', 'password', '이순신', '010-2222-2222', '서울 중구 남산동', sysdate, 'bbb@bbb.com');

-- Null 허용 컬럼에 Null로 값을 할당.
insert into member2 (no, id, passwrd , name, phone, address, mdate, email)
values (3, 'cccc', 'password', '강감찬', NULL, NULL, sysdate, NULL);

-- Null 허용 컬럼에 Null로 값을 넣지 않을 경우 Null 값이 들어감.
insert into member2 (no, id, passwrd , name, mdate)
values (4, 'dddd', 'password', '세종대왕', sysdate);

select * from member2;

update member2
set name = '김유신'
where no = 6;       -- <== 테이블에서 중복되지 않는 고유한 컬럼을 조건으로 사용해야 한다.


/*
    제약조건
        -- UNIQUE :중복되지 않는 고유한 값을 저장. 하나의 테이블에서 여러 컬럼에 지정 할 수 있다.
                -- NULL을 허용함, NULL은 한번만 저장 할 수 있다.
*/

Create table member3 (
    no number(10) not null Primary key, -- 중복된 값을 넣을 수 없다.
    id varchar2(50) not null UNIQUE,    -- 중복된 값을 넣을 수 없다.
    passwrd varchar2(50) not null,
    name Nvarchar2(10) not null,
    phone varchar2(50) null,
    address Nvarchar2 (100) null,
    mdate date not null,
    email varchar2 (50)null
);

select * from member3;

insert into member3 (no, id, passwrd , name, phone, address, mdate, email)
values (1, 'aaaa', 'password', '홍길동', '010-1111-1111', '서울 중구 남산동', sysdate, 'aaa@aaa.com');

insert into member3 
values (2, 'bbbb', 'password', '이순신', '010-2222-2222', '서울 중구 남산동', sysdate, 'bbb@bbb.com');

-- Null 허용 컬럼에 Null로 값을 할당.
insert into member3 (no, id, passwrd , name, phone, address, mdate, email)
values (3, 'cccc', 'password', '강감찬', NULL, NULL, sysdate, NULL);

-- Null 허용 컬럼에 Null로 값을 넣지 않을 경우 Null 값이 들어감.
insert into member3 (no, id, passwrd , name, mdate)
values (6, 'ffff', 'password', '세종대왕', sysdate);



