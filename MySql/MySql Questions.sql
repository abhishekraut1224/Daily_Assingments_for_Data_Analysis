create database daily_assingments;
use daily_assingments;

CREATE TABLE Employee (
    EmpID int NOT NULL,
    EmpName Varchar(20),
    Gender Char,
    Salary int,
    City Char(20)
);

INSERT INTO Employee
VALUES 
(1, 'Arjun', 'M', 75000, 'Pune'),
(2, 'Ekadanta', 'M', 125000, 'Bangalore'),
(3, 'Lalita', 'F', 150000, 'Mathura'),
(4, 'Madhav', 'M', 250000, 'Delhi'),
(5, 'Visakha', 'F', 120000, 'Mathura');

CREATE TABLE EmployeeDetail (
    EmpID int NOT NULL,
    Project Varchar(20),
    EmpPosition Char(20),
    DOJ date
);

INSERT INTO EmployeeDetail
VALUES 
(1, 'P1', 'Executive', '2019-01-26'),
(2, 'P2', 'Executive', '2020-05-04'),
(3, 'P1', 'Lead', '2021-10-21'),
(4, 'P3', 'Manager', '2019-11-29'),
(5, 'P2', 'Manager', '2020-08-01');


-- 1) Find the list of employees whose salary ranges between 2L to 3L
select empid, empname, salary from employee
where salary between 200000 and 300000;

-- 2) write a query to retrive list of employees from the same city
select e.empname, e.city
from employee as e
join employee as ep
on e.city = ep.city
where e.empname <> ep.empname;

-- 3)  find the null values in the employee table
select * from employee
where empid is null;

-- 4) find the cumulative sum of employee's salary
select empid, salary, sum(salary) over(
		order by empid
	)as cumulative_sum
 from employee;



-- 5)what is the male and female ratio
select 
	gender, 
	count(*) as `count`,
	count(*) *100/(select count(*) from employee) as male_female_ratio
from employee
group by gender;

-- Also

select 
	concat(
		sum(case when gender = 'M' then 1 else 0 end), 
        ":",
        sum(case when gender = 'F' then 1 else 0 end)) as M_F_Ratio
from employee;

-- 6) write a query to fetch 50 percent record from the table
select * from employee
where empid <= (select count(empid)/2 from employee);

-- 7) Query to fetch the employee's salary but replace LAST 2 digit with 'XX'
select empid, salary, concat(left(salary, length(salary) -2), 'XX') as salary from employee;

-- 8) Write a query to fetch the even and odd rows from employee table

-- fetch even rows
with row_numbers as (
	select *, 
	row_number() over(
		order by empid) as numbers
from employee
)
select * from row_numbers
where numbers %2 = 0 ;

-- fetch odd rows
with row_numbers as (
	select *, 
	row_number() over(
		order by empid) as numbers
from employee
)
select * from row_numbers
where numbers %2 <> 0;
    
/* Q9) Write a query to find all the Employee names whose name:
-- Begin with ‘A’
-- Contains ‘A’ alphabet at second place
-- Contains ‘Y’ alphabet at second last place
-- Ends with ‘L’ and contains 4 alphabets
-- Begins with ‘V’ and ends with ‘A’ */

select * from employee where empname like '%A%';
select * from employee where empname like '_a%';
select * from employee where empname like '%y_';
select * from employee where empname like'%____l';
select * from employee where empname like'V%' and empname like '%A'; 

/* Q10) Find the Nth heighst salary from employee table with and without using top/Limit keyword
Q11) write a query to find and remove duplicate records from a table
Q12) Write a query to retrive the list of employee working in the same project 
Q13) show the employee with the heighst salary from each project 
Q14) Query to find the total count of employee joined each year 
Q15) Create 3 groups based on salary col, salary less 1L is low, between 1L to 2L is medium, and above 2L is high */

/* Bonus Query to Pivot the data in the employee table and retrieve the total salary for each city 
The resut should display the EmpId, EmpName, and saperate columns for each city (Mathura, Pune, Delhi),
containing the corresponding total salary */ 


