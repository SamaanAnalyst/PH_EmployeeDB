-- Deliverable 1: The number of retiring employees by title.

-- 1a. Create a Retirement Titles table that holds all the titles of employees 
-- who were born between Jan 1, 1952 and Dec 31, 1955.
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;
-- Check table.
SELECT * FROM retirement_titles;
SELECT COUNT(first_name) 
FROM retirement_titles;


-- 1b. Create a table of retirement-eligible employees that 
-- contains only the most recent title of each employee.
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON(rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles AS rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;
-- Check table.
SELECT * FROM unique_titles;
SELECT COUNT(first_name)
FROM unique_titles;


-- 1c. Create a table that has the number of retirement-age
-- employees by their most recent job title.
-- Use the COUNT() function.
-- first: retrieve the number of titles from the Unique Titles table.
-- second: Create a Retiring Titles table.
SELECT COUNT(emp_no), title
INTO retiring_titles 
FROM unique_titles
GROUP BY(title)
ORDER BY (count) DESC;
-- Check table.
SELECT * FROM retiring_titles;


-- Deliverable 2: The employees eligible for the mentorship program.

-- Create a Mentorship Eligibility table that holds the current 
-- employees who were born between Jan 1, 1965 and Dec 31, 1965.
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees AS e
	INNER JOIN dept_emp AS de
		ON (e.emp_no = de.emp_no)
	INNER JOIN titles AS ti
		ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;
-- Check table.
SELECT * FROM mentorship_eligibility;










