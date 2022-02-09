-- DELIVERABLE 1
-- Step 1) Retrieve the emp_no, first_name, and last_name columns from the Employees table.
SELECT e.emp_no,
    e.first_name,
    e.last_name,
--Step 2) Retrieve the title, from_date, and to_date columns from the Titles table.
	ti.title,
	ti.from_date,
	ti.to_date
-- Step 3) Create a new table using the INTO clause.
INTO retirement_titles
-- Step 4) Join both tables on the primary key
FROM employees AS e
LEFT JOIN titles AS ti
ON e.emp_no = ti.emp_no
-- Step 5) Filter the data on the birth_date column to retrieve 
-- the employees who were born between 1952 and 1955. Then, order by the employee number.
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Distinct with Orderby to remove duplicate rows
SELECT DISTINCT ON(emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

-- Step 16) Write another query in the Employee_Database_challenge.sql file 
-- to retrieve the number of employees by their most recent job title who are about to retire.
SELECT COUNT(title),
	title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

-- DELIVERABLE 2
SELECT DISTINCT ON(e.emp_no)
	e.emp_no,
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
ON (de.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no, emp_no DESC;