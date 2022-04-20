-- 2일차 : DQL : Select

desc department;

select * from department;

/*
SQL : 구조화된 질의 언어

Select 구문의 전체 필드 내용

Select   <== 컬럼명
Distinct <== 컬럼내의 값의 중복을 제거해라.
From     <== 테이블 명, 뷰 명.
Where    <== 조건
Group By <== 특정 값을 그룹핑
Having   <== 그룹핑 한 값을 정렬
Order by <== 값을 정렬해서 출력
(순서 중요)
*/
desc employee;
select *
from employee;

-- 특정 컬럼만 출력 하기
select eno, ename from employee;

-- 특정 컬럼을 여러번 출력
select eno, ename, eno, ename, ename from employee;

-- 컬럼에 연산을 적용 할 수 있다.
select eno, ename, salary, salary * 12 from employee;

-- 컬럼명 알리어스(Alias) : 컬럼의 이름을 변경,
    -- 컬럼에 연산을 하거나 함수를 사용하면 컬럼명이 없어진다.
select eno, ename, salary, salary *12 as 연봉 from employee;
select eno as 사원번호 , ename as 사원명, salary as 월급, salary *12 as 연봉 from employee;
select eno 사원번호 , ename 사원명, salary 월급, salary *12 연봉 from employee;
    -- 공백이나 특수문자가 들어 갈때는 ""으로 처리해야 한다.
select eno "사원 #번호" , ename "사원?명", salary 월급, salary *12 연봉 from employee;

-- nvl 함수 : 연산시에 null을 처리하는 함수
select * from employee;

-- nvl 함수를 사용하지 않고 전체 연봉을 계산.  (null이 포함된 컬럼에 연산을 적용하면 null)
    -- null을 0으로 처리해서 연산 해야 한다. : NVL
select eno 사원번호, ename 사원명, salary 월급, commission 보너스,
salary * 12,
salary *12 + commission       -- 전체 연봉
from employee;

-- nvl 함수를 사용해서 연산
select eno 사원번호, ename 사원명, salary 월급, commission 보너스,
salary * 12,
salary *12 + NVL(commission, 0)       -- 전체 연봉
from employee;

-- 특정 컬럼의 내용을 중복 제거후 출력
select * from employee;
select dno from employee;
select distinct dno from employee;

-- select ename, distinct dno from employee; -- 다른컬럼 때문에 오류가 날 수 있다.

-- 조건을 사용해서 검색 (Where)
select * from employee;
select eno 사원번호, ename 사원명, job 직책, manager 직속상관, hiredate 입사날짜,
    salary 월급, commission 보너스, dno 부서번호
    from employee;
    
-- 사원 번호가 7788인 사원의 이름을 검색.
select * from employee
where eno = 7788;

select ename from employee
where eno = 7788;

-- 사원 번호가 7788인 사원의 부서번호, 월급과 입사날짜를 검색.
select dno 부서번호, salary 월급, hiredate 입사날짜 from employee
where eno = 7788;

desc employee;

select *
from employee
where ename = 'SMITH';

-- 레코드를 가져올때 
    -- number 일때는 ''를 붙히지 않는다.
    -- 문자 데이터(Char, Varchar2)나 날짜(Date)를 가져올때는  ''를 처리.
    -- 대소문자를 구분
    
-- 입사날짜가 '81/12/03' 인 사원 출력
select ename, hiredate
from employee
where hiredate = '81/12/03';

-- 부서 코드가 10인 모든 사원들을 출력
select ename , dno
from employee
where dno = 10;

select * from employee;

-- 월급이 3000이상인 사원의 이름과 부서와 입사 날짜, 월급을 출력.
select ename, dno, hiredate, salary
from employee
where salary >= 3000 ;

-- null 검색 : is 키워드 사용.
select *
from employee
where commission is null;

-- commission이 300 이상인 사원이름과, 직책, 월급을 출력
select ename, job, salary, commission
from employee
where commission >= 300;

-- 커밋션이 없는 사원들의 이름을 출력.
select ename, commission
from employee
where commission is null;

-- 조건에서 and, or, not

-- 월급이 500 이상 2500 미만인 사원들의 이름, 사원번호, 입사날짜, 월급을 출력.
select ename, eno, hiredate, salary
from employee
where salary >= 500 and salary < 2500;

-- 1. 직책이 SALESMAN 이거나, 부서코드가 20인 사원 이름, 직책, 월급, 부서코드
select * from employee;

select ename, job, salary, dno
from employee
where job = 'SALESMAN' or dno = 20;

-- 2. 커밋션이 없는 사용자중에 부서코드가 20인 사용자의 이름, 부서코드와 입사날짜를 출력.
select ename, dno, hiredate
from employee
where commission is null and dno = 20;

-- 3. 커밋션이 null이 아닌 사용자의 이름 , 입사날짜, 월급.
select ename, hiredate, salary
from employee
where commission is not null;


-- 날짜 검색 : 
select * from employee;


-- 1982/1/1 ~ 1983/12/31 사이에 입사한 사원의 이름 , 직책, 입사날짜
select ename, job, hiredate
from employee
where hiredate >= '82/01/01' and hiredate < '83/12/31' ;

-- 1981년도에 입사한 사원들 이름 , 직책, 입사날짜
select ename, job, hiredate
from employee
where hiredate>= '81/01/01' and hiredate < '81/12/31';

-- between A and B      : A 이상 B 이하
select ename, job, hiredate
from employee
where hiredate between '81/01/01' and '81/12/31' ;

-- IN 연산자

-- 커밋션이 300, 500, 1400인 사원의 이름, 직책, 입사일을 출력.
select ename, job, hiredate, commission
from employee
where commission = 300 or commission = 500 or commission = 1400;

select ename, job, hiredate, commission
from employee
where commission in (300,500,1400);

-- like : 컬럼내의 특정한 문자열을 검색
    -- % : 뒤에 어떤 글자가 와도 상관 없다.
    -- _ : 한글자가 어떤 값이 와도 상관 없다.
    
-- F로 시작하는 이름을 가진 사원을 모두 검색하기.

select * from employee
where ename like 'A%';

-- 이름이 ES로 끝나는 사원을 검색하기.
select ename from employee
where ename like '%ES';

-- J로 시작되고 J뒤의 두글자가 어떤것이 와도 상관없는 사원 출력. 뒤에는 ES
select ename from employee
where ename like 'J_MES';

-- 마지막 글자가 R로 끝나는 사원 출력하기
select * from employee
where ename like '%R';

-- Man 단어가 들어간 직책을 출력
select * from employee
where job like '%MAN%';

-- 81년도에 입사한 사원을 출력하기.
select *
from employee
where hiredate >= '81/01/01' and hiredate < '81/12/31';

select *
from employee
where hiredate between '81/01/01' and '81/12/31';

select *
from employee
where hiredate like '81%';

-- 81년 2월에 입사한 사원만 출력

select *
from employee
where hiredate >= '81/02/01' and hiredate < '81/02/28';

select *
from employee
where hiredate between '81/02/01' and '81/02/28';

select *
from employee
where hiredate like '81/02%';

-- 정렬 : order by

select * 
from employee
order by eno;

select * 
from employee
order by eno asc ;

select * 
from employee
order by eno desc ;

-- 이름 컬럼을 정렬
select * 
from employee
order by ename asc;

select * 
from employee
order by ename desc;

-- 날짜정렬
select * 
from employee
order by hiredate asc;

select * 
from employee
order by hiredate desc;

-- 질문답변형 게시판에서 주로 사용. 두개 이상의 컬럼을 정렬 할 때

select * from employee
order by dno desc;

-- 두개의 컬럼이 정렬 : 제일 처음 컬림이 정렬을 하고, 동일한 값에 대해서 두번쨰 컬럼을 정렬.
select dno, ename
from employee
order by dno , ename;

select dno, ename
from employee
order by dno desc , ename desc;

-- where 절과 order 절이 같이 사용 될 때.
select *
from employee
where commission is null
order by ename desc;

-- 다양한 함수 사용하기

/*
    1. 문자를 처리하는 함수
    - UPPER : 대문자로 변환
    - LOWER : 소문자로 변환
    - INITCAP : 첫자는 대문자로 나머지는 소문자로 변환
    
    dual 테이블 : 하나의 결과를 출력 하도록 하는 테이블
*/

SELECT '안녕하세요' as 안녕
from dual; --실제로 이런 테이블은 없지만, 그냥 출력하도록 해줌

SELECT 'Oracle mania', UPPER ('Oracle mania'), LOWER ('Oracle mania'),
initcap ('Oracle mania')
from dual;

SELECT * FROM employee;


SELECT ename, lower(ename), UPPER(ename), initcap(ename)
from employee;

SELECT * FROM employee
WHERE ename = 'allen'; -- 검색이 안됨.

SELECT * FROM employee
WHERE lower(ename) = 'allen';

SELECT * FROM employee
WHERE initcap(ename) = 'Allen';

-- 문자 길이를 출력하는 함수
    --length: 문자의 길이를 반환, 영문이나 한글 관계없이 글자수를 리턴함
    --lengthb: 문자의 길이를 반환, 영문은 1byte 한글 3byte로 반환

SELECT LENGTH ('Oracle mania'), length ('오라클 매니아')from dual;

SELECT LENGTHb ('Oracle mania'), lengthb ('오라클 매니아')from dual;

SELECT * FROM employee;

SELECT ename, length (ename), job, length(job) from employee;

-- 문자 조작 함수
    -- concat : 문자와 문자를 연결해서 출력
    -- substr : 문자를 특정 위치에서 잘라오는 함수 (영문, 한글 모두 1byte로 처리)
    -- substrb : 문자를 특정 위치에서 잘라오는 함수 (영문은 1byte, 한글은 3byte로 처리)
    -- instr : 문자의 특정 위치의 인덱스 값을 반환
    -- instrb : 문자의 특정 위치의 인덱스 값을 반환 (영문은 1byte, 한글은 3byte로 처리)
    -- lpad,rpad : 입력 받은 문자열에서 특수를 문자를 적용.
    -- trm : 잘라내고 남은 문자를 반환.
    
-- concat : 문자와 문자를 연결해서 출력
select 'Oracle', 'mania', concat ('Oracle' , 'mania') from dual;
-- substr : 문자를 특정 위치에서 잘라오는 함수 // 영문, 한글 1byte
-- substr ( 대상, 시작위치, 추출갯수 )
    -- 시작위치에 - 가 붙으면 뒤에서 부터 셈
select 'Oracle mania', substr ('Oracle mania', 4, 3),substr ('오라클 매니아', 2, 3),
substrb ('Oracle mania', 4, 3),substrb ('오라클 매니아', 2, 3)
from dual;

select 'Oracle mania', substr ('Oracle mania', -8, 4),substr ('오라클 매니아', -5, 3),
substrb ('Oracle mania', -3, 2),substrb ('오라클 매니아', -2, 3)
from dual;

select ename, substr (ename, 3, 2), substrb(ename, -4, 3)
from employee;

select concat ( ename, ' ' || job) from employee;
select '이름은 : ' || ename || ' 이고, 직책은 : ' || job || ' 입니다.' as 컬럼연결
from employee;

select '이름은 : ' || ename || ' 이고, 상관의 번호는 ' || manager || ' 입니다.' as A
from employee;

-- 이름이 N 으로 끝나는 사원들 출력하기 ( substr 함수 사용 )
select *
from employee
where substr(ename, -1, 1) = 'N';

select *
from employee
where ename like '%N';

-- 87 년도 입사한 사원들 출력하기
select *
from employee
where substr(hiredate, 1, 2) = '87';

select *
from employee
where hiredate like '87%';

-- instr : 문자의 특정 위치의 인덱스 값을 반환
-- instr ( 대상, 찾을 글자, 시작위치, 몇 번째 발견 )

select 'Oracle mania' , instr ('Oracle mania', 'O') from dual;
select 'Oracle mania' ,
instr ('Oracle mania', 'a'),
instr ('Oracle mania', 'a', 5),
instr ('Oracle mania', 'a', 5, 2),
instr ('Oracle mania', 'a', -5, 1)
from dual;

select distinct job from employee
where lower(job) = 'manager';

select distinct instr( job, 'A', 1, 1)
from employee
where lower(job) = 'manager';

-- lpad, rpad : 특정 길이만큼 문자열을 지정해서 왼쪽, 오른쪽의 공백을 특정 문자로 처리
select lpad (salary, 10, '*') from employee;
select rpad (salary, 10, '*') from employee;

select lpad (1234 , 10, '*'), rpad (1234 , 10, '*') from dual;

-- Trim : 공백제거, 특정 문자도 제거
    -- ltrim : 왼쪽 공백 제거
    -- rtrim : 오른쪽 공백 제거
    -- trim : 왼쪽 ,오른쪽 공백 제거
    
select ltrim('     Oracle mania     '),
rtrim('       Oracle mania       '),
trim('      Oracle mania     ')
from dual;



