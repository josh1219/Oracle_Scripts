-- 4일차 퀴즈

-- 1. 모든 사원의 급여 최고액, 최저액, 총액, 및 평균 급여를 출력 하시오. 컬럼의 별칭은 동일(최고액, 최저액, 총액, 평균)하게 지정하고 평균에 대해서는 정수로 반올림 하시오. 
select max (salary) 최고액, min (salary) 최저액,sum (salary) 총액, round (avg (salary)) as 평균
from employee;

-- 2. 각 담당업무 유형별로 급여 최고액, 최저액, 총액 및 평균액을 출력하시오. 컬럼의 별칭은 동일(최고액, 최저액, 총액, 평균)하게 지정하고 평균에 대해서는 정수로 반올림 하시오. 
select job,count(job), max (salary) 최고액, min (salary) 최저액,sum (salary) 총액, round (avg (salary)) as 평균
from employee
group by job;

-- 3. count(*)함수를 사용하여 담당 업무가 동일한 사원수를 출력하시오. 
select job , count(*) as "업무가 동일한 사원수"
from employee
group by job;

-- 4. 관리자 수를 나열 하시오. 컬럼의 별칭은 "관리자수" 로 나열 하시오. 
select manager, count(*) as 관리자수
from employee
group by manager;

-- 5. 급여 최고액, 최저 급여액의 차액을 출력 하시오, 컬럼의 별칭은 "DIFFERENCE"로 지정하시오. 
select max(salary) as 최고액, min(salary) as 최저액, (max(salary) - min(salary)) as DIFFERENCE
from employee;

-- 6. 직급별 사원의 최저 급여를 출력하시오. 관리자를 알 수 없는 사원 및 최저 급여가 2000미만인 그룹은 제외 시키고 결과를 급여에 대한 내림차순으로 정렬하여 출력 하시오. 
select job, min(salary) as 최저급여
from employee
group by job
having min(salary) > 2000
order by min(salary) desc;

-- 7. 각 부서에대해 부서번호, 사원수, 부서내의 모든 사원의 평균 급여를 출력하시오. 컬럼의 별칭은 [부서번호, 사원수, 평균급여] 로 부여하고 평균급여는 소숫점 2째자리에서 반올림 하시오. 
select dno as 부서번호, count(*) as 사원수, round (avg(salary) , 1) as 평균급여
from employee
group by dno;

-- 8. 각 부서에 대해 부서번호이름, 지역명, 사원수, 부서내의 모든 사원의 평균 급여를 출력하시오.  결럼의 별칭은 [부서번호이름, 지역명, 사원수,평균급여] 로 지정하고 평균급여는 정수로 반올림 하시오.  
select dno, decode (dno, 10, 'ACCOUNTING',
                         20, 'RESEARCH',
                         30, 'SALES',
                         0) as 부서번호이름,
            decode (dno, 10, 'NEW YORK',
                         20, 'DALLS',
                         30, 'CHICAGO',
                         0) as 지역명,
            count(*) as 사원수, round(avg(salary)) as 평균급여
from employee
group by dno;




--------------------------------------------------------------------------------

-- 테이블 조인 문제

select * from employee;
select * from department;
-- 1. EQUI 조인을 사용하여 SCOTT 사원의 부서 번호와 부서 이름을 출력 하시오. 
select ename, e.dno, dname
from employee e, department d
where e.dno = d.dno
and ename = 'SCOTT';

-- 2. INNER JOIN과 ON 연산자를 사용하여 사원이름과 함께 그 사원이 소속된 부서이름과 지역명을 출력하시오. 
select ename, dname, loc
from employee e JOIN department d
on e.dno = d.dno;

-- 3. INNER JOIN과 USING 연산자를 사용하여 10번 부서에 속하는 모든 담당 업무의 고유한 목록(한번씩만 표시)을 부서의 지역명을 포함하여 출력 하시오. 
desc employee;
desc department;

select dno, job, loc
from employee e inner join department d
using(dno)
where dno = 10;

-- 4. NATUAL JOIN을 사용하여 커밋션을 받는 모든 사원의 이름, 부서이름, 지역명을 출력 하시오. 
select ename, dname, loc       
from employee e natural join department d
where commission is not null;

-- 5. EQUI 조인과 WildCard를 사용하여 이름에 A 가 포함된 모든 사원의 이름과 부서명을 출력 하시오. 
select ename, dname, e.dno     
from employee e, department d
where e.dno = d.dno
and ename like '%A%';

-- 6. NATURAL JOIN을 사용하여 NEW YORK에 근무하는 모든 사원의 이름, 업무, 부서번호 및 부서명을 출력하시오. 
select ename, job, dno, dname
from employee e natural join department d
where loc = 'NEW YORK';