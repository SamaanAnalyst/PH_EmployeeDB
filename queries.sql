-- Fixing the keys and order of columns in dept_emp table.
DROP TABLE dept_emp CASCADE;

-- Query for confirmation
SELECT * FROM departments; 
SELECT * FROM employees;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
SELECT * FROM dept_emp;
SELECT * FROM titles; 

-- Determine Retirement Eligibility
-- any employee born between 1952 and 1955 will begin to retire.
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Refine the list by looking only at how many employees were born in 1952.
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Refine the list by looking only at how many employees were born in 1953.
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

-- Refine the list by looking only at how many employees were born in 1954.
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

-- Refine the list by looking only at how many employees were born in 1955.
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Narrow Retirement Elegibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring 
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create a table for retirement-eligible employees then export to a CSV file.
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Query the new table of retirement-eligible employees.
SELECT * FROM retirement_info;
SELECT COUNT (first_name)
FROM retirement_info;

-- Drop the retirement_info table to recreate it with emp_no.
DROP TABLE retirement_info;

-- Create new table for retiring employees including their emp_no.
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables.
SELECT d.dept_name, 
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables, and use aliases, 
SELECT ri.emp_no, 
	ri.first_name,
	ri.last_name,
	de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

-- Joining retirement_info and dept_emp tables, use aliases, and filter for 'still employed' using date.
-- and create a new table 'current_emp' to hold the info.
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Check new table
SELECT * FROM current_emp;
SELECT COUNT (first_name)
FROM current_emp;

-- Retiring employees count by department number, create a new table, and export it to a CSV file.
SELECT COUNT(ce.emp_no), de.dept_no
INTO count_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- Check count_dept table.
SELECT * FROM count_dept;
SELECT SUM(cd.count)
FROM count_dept as cd

-- Create an employee information table: 
-- emp_no, first_name, last_name, gender, to_date, salary.
SELECT * FROM salaries
ORDER BY to_date DESC;
-- The most recent date can't be that far back, so we need to pull employment dates from the dept_emp table again.
-- Join with salaries tables to get to_date, and salary.
SELECT e.emp_no,
	e.first_name,
	e.last_name, 
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');
-- Check table
SELECT * FROM emp_info;
SELECT COUNT (first_name)
FROM emp_info;

-- Another option to create a table of all employees info using current_emp filtered table.
-- trial join for employee info.
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	e.gender,
	s.salary,
	ce.to_date
INTO retire_emp
FROM current_emp AS ce
	INNER JOIN employees AS e
		ON (ce.emp_no = e.emp_no)
	INNER JOIN salaries AS s
		ON (ce.emp_no = s.emp_no);
-- Check trial table.
-- the only difference here is that the (to_date) column is ordered by DESC from the current_emp table. 
SELECT * FROM retire_emp;
SELECT COUNT(first_name)
FROM retire_emp;

-- List of managers per department.
SELECT dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
INTO manager_info
FROM dept_manager as dm
	INNER JOIN departments as d
		ON (dm.dept_no = d.dept_no)
	INNER JOIN current_emp AS ce
		ON (dm.emp_no = ce.emp_no);
-- Check table
SELECT * FROM manager_info;	


-- Add department info to the current_emp table. 
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);
-- Check table
SELECT * FROM dept_info;	
SELECT COUNT(first_name)
FROM dept_info;


-- Create a table of current, retirement-eligible employees in the Sales department.
SELECT * 
INTO sales_emp
FROM dept_info AS di
WHERE (di.dept_name = 'Sales');
-- Check sales retiring emp table.
SELECT * FROM sales_emp;
SELECT COUNT(first_name) 
FROM sales_emp;

-- Create a table of current, retirement-eligible employees for Sales and Development teams.
SELECT *
INTO mentors_emp
FROM dept_info
WHERE dept_name IN ('Sales', 'Development');
-- Check mentors_emp table.
SELECT * FROM mentors_emp;
SELECT COUNT(first_name) 
FROM mentors_emp;


-- Recreate the dept_emp table for retirement-eligible employees' count per department,
-- show department name.
SELECT cd.count,
	d.dept_name
INTO dept_count_name
FROM count_dept as cd
	LEFT JOIN departments as d
		ON cd.dept_no = d.dept_no
ORDER BY cd.count DESC;

SELECT * FROM dept_count_name;






















