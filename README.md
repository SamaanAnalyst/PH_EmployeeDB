# Pewlett_Hackard_Analysis
We intend to convert Pewlett Hackard employees' data from CSV files into a structured database using SQL.

## Project Overview
Pewlett Hackard is a large company boasting several thousand employees, and it has been around for a long time.<br>
As baby boomers begin to retire at a rapid rate, Pewlett Hackard is looking toward the future in two ways: <br>
1. Offering a retirement package for those who meet certain criteria.
2. Starting to think about which positions will open up soon. 

The number of upcoming retirements will leave thousands of job openings, which would require the company to have a robust employee database and a well-founded transition plan to fill these many vacancies.<br>

The HR department has requested an analysis of the company's current employees' information to identify the retirement-eligible employees, <br>
the number of positions that Pewlett Hackard will need to fill soon and the retiring titles and mentorship opportunities. <br>

This analysis will help future-proof Pewlett Hackard by upgrading the employees' information from CSV files to a relational database using SQL. <br>

## Objectives
The tasks in this project require transforming the employees' information from CSV files to a database first, then finding answers to the following questions:
1. Who will be retiring in the next few years? Furthermore, of those employees, who are eligible for a retirement package?
2. How many positions will Pewlett Hackard need to fill? 

### Challenge Overview
1. How many employees will be retiring per title?
2. Who are the eligible employees for a mentorship program?

## Resources
- Data sources: departments.csv, dept_emp.csv, dept_manager.csv, employees.csv, salaries.csv, titles.csv.
- Software: PostgreSQL (version 11), pgAdmin 4 (version 6.7).
- Libraries & Packages: Quick Database Diagrams (Quick DBD) online tool.

## Pewlett Hackard Focused Analysis Results
1. The first outcome of this project entailed upgrading the employees' information system in two steps:
    - First, by creating an Entity Relationship Diagram using the Quick DBD online tool, which represents the connections between the data<br>
      files based on primary or foreign keys, or a combination of both, and how they depend on each other to give a complete profile of<br>
      every employee at the Pewlett Hackard company.<br>
      
      ![PH_EmployeeDB_ERD](./Images/EmployeeDB_ERD.png)
    - Second, building a relational database based on the depicted schema in the ERD by importing all the data from the CSV files<br>
      mentioned in the Resources. Each CSV file is imported into one table in the database.
      - A detailed look at the database schema is available here: [PH_EmployeeDB_schema](https://github.com/Magzzie/Pewlett_Hackard_Analysis/blob/main/schema.sql)
      
2. The HR department defined the retirement-eligible employees' criteria to include all employees born between Jan 1, 1952, <br>and Dec 31, 1955, and hired between Jan 1, 1985, and Dec 31, 1988. 
3. According to the prementioned criteria, the number of eligible employees is (41,380) employees. 
    - The complete list of retirement-eligible employees based on birth and hiring dates can be found in the following CSV file:<br>
    
      [retirement_info.csv](https://github.com/Magzzie/Pewlett_Hackard_Analysis/blob/main/Data/retirement_info.csv)
4. The number of employees to retire in the next few years who were born and hired as stated in the eligibility criteria, but more accurately, are currently employed in the company, is (33,118) employees.
    - The list of currently employed and retirement-eligible employees can be found in the following CSV file:<br>
    
      [current_emp.csv](https://github.com/Magzzie/Pewlett_Hackard_Analysis/blob/main/Data/current_emp.csv)
5. We have created a list of possible vacancies for each department in the company to guide department managers in their transitioning efforts.<br>
    - It is worth noting that the sum of all departments count exceeds the true number of future retirees, probably due to duplicate entries<br>
      of some employees who are involved in more than one department.<br>
   ![Retirement-eligible employees' count per department](./Images/count_retiring_dept_name.png)


### Challenge Deliverables
1. When we looked at titles given to the retirement-eligible employees who were born between 1952 and 1955, we found <br>
   a list of (133,776) titles assigned to them over their employment life.<br>
      - Their records, including names, titles, and titles' dates, can be found in the following CSV file:<br> [retirement_titles.csv](https://github.com/Magzzie/Pewlett_Hackard_Analysis/blob/main/Data/retirement_titles.csv)
2. However, looking at the most recent title for each employee and excluding the ones who already left the job would better reflect the retiring titles in the company.<br> This narrowed list includes (72,458) titles, which exceeds the number of retiring employees, probably due to duplicate titles per certain employees.<br> 
      - These records can be found in the following CSV file:<br> [unique_titles.csv](https://github.com/Magzzie/Pewlett_Hackard_Analysis/blob/main/Data/unique_titles.csv)
3. Finally, we created a tailored table to show the number of future job openings for each title, and it seems that a ***Senior Engineer*** <br>
    position would be the most in-demand for this company. <br>
    ![Retiring Titles](./Images/retiring_titles.png)
4. Instead of having a large part of the workforce retiring, it would be wise to introduce a mentoring program for experienced and successful employees to step into a part-time role instead of retiring altogether. <br> Their new role in the company would be a mentor to the new hires.
   The company's management team defines the potential mentors as current employees born between Jan 1, 1965, and Dec 31, 1965. 
   - The number of potential mentors is (1,549) employees. 
   - Their records can be found in the following CSV file:<br> [mentorship_eligibility.csv](https://github.com/Magzzie/Pewlett_Hackard_Analysis/blob/main/Data/mentorship_eligibility.csv)<br>
   ![Mentorship_eligible employees](./Images/mentorship_eligibility.png)

## Summary
1. There will be an estimate of (33,118) positions to fill in Pewlett Hackard company over the next few years. 
2. There are only (1,549) qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees, averaging roughly 21 trainees per mentor, which is considered inadequate for quality training.  


---
