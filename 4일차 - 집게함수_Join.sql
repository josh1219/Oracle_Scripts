-- 4일차
/*
    그룹 함수 : 동일한 값에 대해서 그룹핑해서 처리하는 함수
        group by 절에 특정 컬럼을 정의 할 경우, 해당 컬럼의 동일한 값들을 그룹핑해서 연산을 적용.
        
    집계함수 : 
        - SUM : 그룹의 합계
        - AVG : 그룹의 평균
        - MAX : 그룹의 최대값
        - MIN : 그룹의 최소값
        - COUNT : 그룹의 총 개수 (레코드 수 record, 로우 수 row)
*/

select sum (salary), round (avg (salary)), max (salary), min (salary)
from employee;

-- 주의 : 집계 함수를 처리 할 때, 출력 컬럼이 단일 값으로 나오는 컬럼을 정의

select sum (salary)
from employee;

select ename
from employee;

select * from employee;

-- 집계함수는 null 값을 처리해서 연산한다.
select sum (commission), avg(commission), max(commission), min(commission)
from employee;

-- count () : 레코드 수, 로우 수
    -- NULL은 처리되지 않는다.

select eno from employee;
select count (eno) from employee;

select commission from employee;
select count(commission) from employee;

select count(*) from employee;
select *from employee;

-- 전체 레코드 카운트
select count(*) from employee;
select count(eno) from employee;

-- 중복되지 않는 직업의 갯수
select job from employee;

select count (distinct job) from employee;

-- 부서의 갯수 (dno)

select count (distinct dno) from employee;

-- Group by : 특정 컬럼의 값을 그룹핑 한다. 주로 집계함수를 select 절에서 같이 사용한다.
/*
    select 컬럼명, 집계함수 처리된 컬럼
    from 테이블
    where 조건
    group by 컬럼명
    having 조건 (group by한 결과의 조건)
    order by 정렬
 
*/

select dno as 부서번호 , avg(salary) as 평균급여
from employee
group by dno;   -- dno 컬럼의 중복된 값을 그룹핑 한다.

select dno from employee order by dno;

--전체 평균 급여.

select avg(salary) as 평균급여
from employee;

-- group by를 사용하면서 select절에 가져올 컬럼을 잘 지정해야 한다.
select dno , count(dno), sum (salary) , avg(salary), max(commission), min(commission)
from employee
group by dno;

-- 
select job from employee;

-- 동일한 직책을 그룹핑해서 월급의 평균, 합계, 최대값, 최소값을 출력.

select job, count(job), avg(salary), sum (salary), max(commission), min(commission)
from employee
group by job        -- 동일한 직책을 그룹핑해서 집계를 한다.

-- 여러 컬럼을 그룹핑 하기.

select dno, job, count(*), sum (salary)
from employee
group by dno, job;             -- 두 컬럼 모두 일치하는 것을 그룹핑

select dno, job
from employee
where dno = 20 and job = 'CLERK';

-- having : group by에서 나온 결과를 조건으로 처리 할 때.
    -- 별칭이름을 조건으로 사용하면 안된다.
    
--부서별 월급의 합계가 9000 이상만 출력.
select dno, count(*), sum (salary) 부서별합계, round (avg(salary) , 2) as 부서별평균
from employee
group by dno
having sum (salary) > 9000;

--부서별 월급의 평균이 2000 이상만 출력.
select dno, count(*), sum (salary) 부서별합계, round (avg(salary) , 2) as 부서별평균
from employeeen
group by dno
having round (avg(salary) , 2) > 2000.00;

-- 월급이 1500 이하는 제외하고 각 부서별로 월급의 평균을 구하되 월급의 평균이 2500이상인 것만 출력하라.
select dno, count(*), round( avg(salary)) as 부서별평균
from employee
where salary > 1500
group by dno
having round( avg(salary)) > 2500

-- ROLLUP
--CUBE
    -- Group by 절에서 사용하는 특수한 함수
    -- 여러 컬럼을 나열 할 수 있다.
    -- group by 절의 자세한 정보를 출력...

-- Rollup, cube를 사용하지 않는 경우    
SELECT dno, count(*), sum(salary), round(avg(salary)) 
from employee
group by dno
order by dno;

-- rollup 사용: 부서별 합계와 평균을 출력 후, 마지막 라인에 전체에 대해 각 컬럼에 적용된
--              함수를 다시 사용해서 해당 컬럼 전체의 값을 출력함.
SELECT dno, count(*), sum(salary), round(avg(salary)) 
from employee
group by ROLLUP(dno)
order by dno;

--cube:  부서별 합계와 평균을 출력 후, 마지막 라인에 전체 합계, 평균
SELECT dno, count(*), sum(salary), round(avg(salary)) 
from employee
group by cube(dno)
order by dno;

-- rollup 사용: 두 컬럼 이상 묶어서 사용 가능함.
SELECT dno, job, count(*), max(salary), sum(salary), round(avg(salary)) 
from employee
group by ROLLUP(dno, job) -- 두개의 컬럼에 적용됨, 두 컬럼을 잡고 첫번째 먼저 정렬한 뒤

SELECT dno, job, count(*), max(salary), sum(salary), round(avg(salary)) 
from employee
group by (dno, job) -- 두개의 컬럼에 적용됨, 두 컬럼을 잡고 첫번째 먼저 정렬한 뒤
order by dno asc;             -- 두번째 컬럼으로 하위 정렬을 시도함

-- cube
SELECT dno, job, count(*), max(salary), sum(salary), round(avg(salary)) 
from employee
group by cube(dno, job)
order by dno, job

-- JOIN : 여러 테이블을 합쳐서 각 테이블의 컬럼을 가져온다.
    -- department 와 employee는 원래는 하나의 테이블 이었으나 모델링(중복제거, 성능향상)을 통해서 두 테이블을 분리
    -- 두 테이블의 공통키 컬럼 (dno) , employee 테이블의 dno 컬럼은 department 테이블의 dno 컬럼을 참조한다.
    -- 두개 이상의 테이블의 컬럼을 JOIN구문을 사용해서 출력.

select * from department;       -- 부서정보를 저장하는 테이블
select * from employee;         -- 사원정보를 저장하는 테이블\

-- EQUI JOIN : 오라클에서 제일 많이 사용하는 JOIN , Oracle에서만 사용가능
    -- from 절 : 조인 할 테이블을 , 로 처리.
    -- where 절 : 두 테이블의 공통의 키 컬럼을 " = " 로 처리
        -- and 절 : 조건을 처리
    -- on 절 : 두 테이블의 공통의 키 컬럼을 " = " 로 처리
        -- where 절 : 조건을 처리
        
-- Where 절 : 공통 키 컬럼을 처리한 경우
select *
from department,employee
where department.dno = employee.dno     -- 공통 키 적용
and job = 'MANAGER'                     -- 조건을 처리

-- ANSI 호환 : INNER JOIN     <== 모든 SQL에서 사용 가능한 JOIN
-- ON 절 : 공통 키 컬럼을 처리한 경우
select *
from employee e JOIN department d
on e.dno = d.dno 
where job = 'MANAGER';

-- join시 테이블 알리어스 (테이블 이름을 별칭으로 두고 많이 사용)
select *
from employee e, department d
where e.dno = d.dno
and salary > 1500;

-- select 절에서 공통의 키 컬럼을 출력시에 어느 테이블의 컬럼인지 명시 : dno
select eno, job,d.dno, dname
from employee e, department d
where e.dno = d.dno

-- 두 테이블을 JOIN 해서 부서별[명]로 월급(salary)의 최대값을 출력해 보세요.
select dname , count(*) , max(salary)
from department d , employee e
where d.dno = e.dno
group by dname;

-- NATURAL JOIN : Oracle 9i 지원
    -- EQUI JOIN의 Where 절을 없앰. : 두 테이블의 공통의 키 컬럼을 정의 " = "
    -- 공통의 키 컬럼을 Oracle 내부적으로 자동으로 감지해서 처리.
    -- 공통 키 컬럼을 별칭 이름을 사용하면 오류가 발생.
    -- 반드시 공통 키 컬럼은 데이터 타입이 같아야 한다.
    -- from 절에 natural join 키워드를 사용.
    
select eno, ename, dname, dno
from employee e natural join department d

-- 주의 : select 절의 공통키 컬럼을 출력시 테이블명을 명시하면 오류 발생.

-- EQUI JOIN vs NATURAL JOIN의 공통 키 컬럼 처리
    -- EQUI JOIN : select에서 반드시 공통 키 컬럼을 출력 할 때 테이블명을 반드시 명시.
    -- NATURAL JOIN : select에서 반드시 공통 키 컬럼을 출력 할 때 테이블명을 반드시 명시하지 않아야 한다.
    
-- EQUI
select ename, salary, dname, d.dno      -- e.dno : EQUI JOIN 에서는 명시
from employee e, department d
where e.dno = d.dno
and salary > 2000;

--NATURAL
select ename, salary, dname, dno        -- dno : NATURAL JOIN 에서는 테이블 명을 명시하면 안된다.
from employee e natural join department d
where salary >2000;

-- ANSI : INNER JOIN
select ename , salary, dname, e.dno
from employee e join department d
on e.dno = e.dno;
where salary > 2000;

-- NON EQUI JOIN : EQUI JOIN에서 Where 절의 "="를 사용하지 않는 JOIN

select * from salgrade; -- 월급의 등급을 표시하는 테이블

select ename, salary, grade
from employee, salgrade
where salary between losal and hisal;

-- 테이블 3개 조인
select ename, dname, salary, grade
from employee e, department d, salgrade s
where e.dno = d.dno
and salary between losal and hisal





