use projects;
select * from hr_employee_dataset_cleaned;

-- 1. Basic
-- Q1.Show the first 10 employees.

select * from hr_employee_dataset_cleaned limit 10;

-- Q2.Count the total number of employees.
select count(EmployeeNumber) from hr_employee_dataset_cleaned;

alter table hr_employee_dataset_cleaned drop column EmployeeCount;

-- Q3.List all unique Job Roles.
select * from hr_employee_dataset_cleaned;
select distinct(JobRole) from hr_employee_dataset_cleaned;

-- Q4.Find the minimum and maximum Monthly Income.
select min(MonthlyIncome) as Min_mounthly_income,max(MonthlyIncome) as Min_mounthly_income from hr_employee_dataset_cleaned;

-- Q5.Show details of employees older than 50 years.
select *from hr_employee_dataset_cleaned where age>=50;




-- 2. Demographics
-- Q6.Count employees by Gender.

select Gender,count(*) from hr_employee_dataset_cleaned group by Gender;

-- Q7.Find average Age per Department.
select * from hr_employee_dataset_cleaned;
select Department,Avg(Age) from hr_employee_dataset_cleaned group by Department;

-- Q8.Count employees by Marital Status.
select MaritalStatus,count(*) from hr_employee_dataset_cleaned group by MaritalStatus;

-- Q9.List departments with more than 100 employees.
select Department,EmployeeNumber from hr_employee_dataset_cleaned where EmployeeNumber>100;

-- Q10.Show the distribution of Education levels.
select Education,count(*) as Total_Employees from hr_employee_dataset_cleaned group by Education order by Total_Employees;




-- 3. Attrition
-- Q11.How many employees have left the company?
select * from hr_employee_dataset_cleaned;
select count(*) as Employees_Left from hr_employee_dataset_cleaned where Attrition='Yes';
select Attrition,count(*) as Employees_Left from hr_employee_dataset_cleaned group by Attrition;

-- Q12.Find attrition count by Department.
select Department,attrition,count(attrition) from hr_employee_dataset_cleaned group by Department,attrition;

-- Q13.Find attrition count by Gender.
select Gender,attrition,count(attrition) from hr_employee_dataset_cleaned group by Gender,attrition;

-- Q14.Compare average Monthly Income of employees who left vs stayed.
select * from hr_employee_dataset_cleaned;
select Attrition,Avg(MonthlyIncome) as Avg_Salary from hr_employee_dataset_cleaned group by Attrition;
SELECT 
    AVG(CASE WHEN Attrition = 'Yes' THEN MonthlyIncome END) AS avg_income_left,
    AVG(CASE WHEN Attrition = 'No' THEN MonthlyIncome END)  AS avg_income_stayed
FROM hr_employee_dataset_cleaned;

-- Q15.Find the top 5 Job Roles with highest attrition.
select JobRole,count(Attrition) as Attrition_count from hr_employee_dataset_cleaned where Attrition='No' group by JobRole order by Attrition_count desc limit 5;



-- 4. Salary & Performance
-- Q16.List the top 10 highest paid employees.
select * from hr_employee_dataset_cleaned;
SELECT EmployeeNumber, JobRole, MonthlyIncome FROM hr_employee_dataset_cleaned ORDER BY MonthlyIncome DESC LIMIT 10;
            -- Or
with Top10_cte as(
select EmployeeNumber,Department,JobRole,MonthlyIncome,row_number() over(partition by Department order by MonthlyIncome desc) as rnk from hr_employee_dataset_cleaned)
select * from  Top10_cte where rnk<=10;           

-- Q17.Show average PercentSalaryHike by Department.
select Department, avg(PercentSalaryHike) from hr_employee_dataset_cleaned group by Department;

-- Q18.Find employees with Performance Rating = 4.
select PerformanceRating from hr_employee_dataset_cleaned where PerformanceRating=4;

-- Q19.Find average Monthly Income by JobLevel.
select JobLevel,round(avg(MonthlyIncome),3) from hr_employee_dataset_cleaned group by JobLevel;

-- Q20.Show employees whose salary is above their department’s average.
select * from hr_employee_dataset_cleaned h where MonthlyIncome>(
select avg(MonthlyIncome) from hr_employee_dataset_cleaned where Department=h.Department);



-- 5. Work Experience & Promotions
-- Q21.Find average Total Working Years per Department.
select Department,avg(TotalWorkingYears) from hr_employee_dataset_cleaned group by Department;

-- Q22.Count employees not promoted in the last 5 years.
select * from hr_employee_dataset_cleaned;
select Department,count(*) as Employee_not_promoted from hr_employee_dataset_cleaned where YearsSinceLastPromotion>5 group by Department order by Employee_not_promoted desc;

-- Q23.Find employees with more than 10 YearsAtCompany but zero promotions.
select EmployeeNumber,Department,Age,YearsAtCompany,YearsSinceLastPromotion from hr_employee_dataset_cleaned where YearsAtCompany>10 and YearsSinceLastPromotion=0;

-- Q24.Show employees with more than 15 YearsWithCurrManager.
select EmployeeNumber,Department,Age,YearsWithCurrManager from hr_employee_dataset_cleaned where YearsWithCurrManager>15 order by YearsWithCurrManager desc;

-- Q25.Find average TrainingTimesLastYear by Department.
select * from hr_employee_dataset_cleaned;
select round(avg(TrainingTimesLastYear),3) from hr_employee_dataset_cleaned;


-- 6. Advanced Analytics
-- Q26.Show department-wise highest salary.
select * from hr_employee_dataset_cleaned;
with cte as(
select EmployeeNumber,Department,JobRole,MonthlyIncome,dense_rank() over(partition by Department order by MonthlyIncome desc) as Salary_rnk from  hr_employee_dataset_cleaned)
select * from cte where Salary_rnk=1;
           -- or
SELECT Department, EmployeeNumber, JobRole, MonthlyIncome
FROM (
    SELECT *,
           RANK() OVER (PARTITION BY Department ORDER BY MonthlyIncome DESC) AS salary_rank
    FROM hr_employee_dataset_cleaned
) t
WHERE salary_rank = 1;

-- Q27.Find employees whose Age is above department average.
select Department, EmployeeNumber, JobRole,Age from hr_employee_dataset_cleaned h where Age>(
select avg(Age) from hr_employee_dataset_cleaned where Department=h.Department order by Department,Age Asc);

-- Q28.Rank employees by Monthly Income within each Department.
select Department,MonthlyIncome,dense_rank() over(partition by Department order by MonthlyIncome desc) as rnk from hr_employee_dataset_cleaned;

-- Q29.Find JobRole with maximum average YearsAtCompany.
SELECT JobRole, AVG(YearsAtCompany) AS avg_years FROM hr_employee_dataset_cleaned GROUP BY JobRole ORDER BY avg_years DESC LIMIT 1;

-- Q30.Create a view for attrition summary by Department.
CREATE VIEW v_attrition_summary AS
SELECT 
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) AS employees_stayed,
    ROUND(
        (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2
    ) AS attrition_rate_percent
FROM hr_employee_dataset_cleaned
GROUP BY Department;
select * from v_attrition_summary;

