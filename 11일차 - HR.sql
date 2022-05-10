
-- 객체를 출력시 객체명 앞에 객체를 소유주명을 넣어줘야 한다.

select * from hr.employee;

select * from employee;

create table emp_copy55
as
select * from employee;