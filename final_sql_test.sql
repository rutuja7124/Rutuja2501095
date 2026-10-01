create database company_sql_test;
use company_sql_test;

create table department (
department_id int primary key,
department_name varchar(100) not null,
location varchar(100)
);

create table employees (
employee_id int primary key,
department_id int not null,
employee_name varchar(50) not null,
phone varchar(15),
salary decimal(8,2),
hire_date date,
foreign key (department_id) references department(department_id)
);

insert into department 
(department_id, department_name,location)
values
(1,'IT','pune'),
(2,'Finance','Mumbai'),
(3,'Sales','Delhi'),
(4,'Marketing','hyderabad'),
(5,'HR','pune');

insert into employees
(employee_id,department_id,employee_name,phone,salary,hire_date)
values
(1,1,'Amit','9809765434',60000,'2024-08-09'),
(2,1,'Rutuja','9809761928',65000,'2024-09-11'),
(3,2,'Saee','9834565434',70000,'2024-09-20'),
(4,2,'Priya','9808701434',50000,'2024-11-12'),
(5,2,'Samay','9809765554',64000,'2025-01-09'),
(6,3,'Rahul','9809785434',50000,'2025-03-15'),
(7,3,'Tejashri','9049765434',75000,'2025-04-10'),
(8,4,'Swara','9809775434',68000,'2025-06-22'),
(9,4,'Nikita','9808715434',80000,'2025-08-14'),
(10,5,'Sakshi','9809098134',85000,'2025-09-21');

-- 3.
alter table employees add column email varchar(50) not null;
-- 4.
alter table employees add column status varchar(50) default 'active';
-- 5
update employees set status='inactive' where employee_id=2;

-- 6
select employee_name,salary from employees where salary between 50000 and  90000 order by salary desc;

-- 7
select employee_name from employees where employee_name like 'A%' or employee_name like '%r%';

-- 8
select e.department_id,d.department_name, count(e.employee_id) from employees e inner join department d on d.department_id=e.department_id group by department_id;

-- 9.
select d.department_name, from department d;

-- 10
select e.employee_name,d.department_name,d.location,e.salary from employees e inner join department d on e.department_id=d.department_id;

-- 11
select employee_name,salary from employees where salary > (select avg(salary) from employees);

-- 12
select e.employee_name,e.salary,e.department_id
from employees e where e.salary > (
select avg(e2.salary) from employees e2 where e2.department_id = e.department_id);

-- 12
select d.department_id, d.department_name
from department d where exists(
select 1
from employees e
where e.department_id=d.department_id
);

select d.department_id, d.department_name
from department d where not exists(
select 1
from employees e
where e.department_id=d.department_id
);

-- 13
select employee_name,department_id,salary, dense_rank() over (order by salary desc) as salary_rank from employees;

-- 14
with ranked_employees as(
	select 
		employee_name,
		department_id,
		salary,
		dense_rank() over (
			partition by department_id
			order by salary desc
		) as rnk
	from employees
)
select * from ranked_employees where rnk<=2;

