-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE departments (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);


CREATE TABLE dept_emp (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL
);

CREATE TABLE dept_manager (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL
);

CREATE TABLE employees (
    "emp_no" INT   NOT NULL,
    "emp_title" VARCHAR   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE salaries (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE titles (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE dept_emp ADD CONSTRAINT "fk_Dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES employees ("emp_no");

ALTER TABLE dept_emp ADD CONSTRAINT "fk_Dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES departments ("dept_no");

ALTER TABLE dept_manager ADD CONSTRAINT "fk_Dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES departments ("dept_no");

ALTER TABLE dept_manager ADD CONSTRAINT "fk_Dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES employees ("emp_no");

ALTER TABLE salaries ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES employees ("emp_no");

ALTER TABLE employees ADD CONSTRAINT "fk_Employees_emp_title" FOREIGN KEY("emp_title")
REFERENCES titles ("title_id");



select e.emp_no, e.first_name, e.last_name, e.sex, s.salary
from employees e
inner join salaries s on e.emp_no = s.emp_no;

select first_name, last_name, hire_date 
from employees
where extract(year from hire_date) = 1986;



select e.emp_no, e.first_name, e.last_name, d.dept_name, m.dept_no
from employees e 
inner join dept_manager m on e.emp_no = m.emp_no
inner join departments d on d.dept_no = m.dept_no;


select e.emp_no, e.first_name, e.last_name, d.dept_name, de.dept_no
from employees e 
inner join dept_emp de on e.emp_no = de.emp_no
inner join departments d on d.dept_no = de.dept_no;

select first_name, last_name, sex 
from employees
where first_name = 'Hercules' and last_name LIKE 'B%';

select emp_no, last_name, first_name
from employees where emp_no in (
	select emp_no
	from dept_emp
	where dept_no in(
		select dept_no
		from departments
		where dept_name = 'Sales'
	));
	
	
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees e
inner join dept_emp de ON e.emp_no = de.emp_no
inner join departments d ON de.dept_no = d.dept_no
where d.dept_name IN ('Sales', 'Development');

select last_name, count(last_name) as "# of last names"
from employees 
group by last_name
order by "# of last names" DESC;

