# HR Employee Attrition Analysis

## 📖 Overview  
This project aims to explore and analyze HR data of employees to uncover patterns related to attrition. The goal is to build insights into which factors influence employees leaving the company and provide actionable recommendations.

## 🗂 Repository Structure

| File / Folder | Description |
|----------------|-------------|
| `HR_Employee_dataset_cleaned.csv` | The cleaned HR dataset used for analysis. |
| `HR_dataset_cleaned.ipynb` | Jupyter notebook containing data cleaning, EDA, outlier handling, and visualizations. |
| `HR_Employee.sql` | SQL scripts with queries for HR analytics (attrition, salary, promotions, etc.). |
| `HR.pbix` | Power BI dashboard file for interactive visualization. |
| `HR_SQL_Taskes.pdf` | Document containing list of SQL tasks and their solutions. |
| `Hr_Dashbord_image.png` | Screenshot / preview of Power BI dashboard. |
| `Hr_Dashbord_Vedio.mp4` | Video walkthrough of the dashboard. |
| `EDA/` | (Optional) Folder for exploratory data analysis files or plots. |

## 🧰 Tools & Technologies
- Python (Pandas, Seaborn, NumPy) for data cleaning & EDA  
- SQL / MySQL for database queries  
- Power BI for dashboard & reporting  
- Git & GitHub for version control  

## 🔍 Key Analyses & Queries
Here are some of the analyses performed:
- Distribution of Education / Gender / Department  
- Attrition counts & rates by department, role, gender  
- Compare average salary between those who left vs stayed  
- Identify top paid employees & department-wise highest salary  
- Examine promotions, tenure, and years with current manager  
- Built views / subqueries for reusable summaries  

## 📊 Dashboard Insights
- Department-wise attrition rates  
- Top 10 highest paid employees  
- Gender and education distributions  
- Salary and tenure benchmarks  
- Interactive filters for deeper slicing  

## 🧭 How to Run / Use

1. Clone the repository:
   ```bash
   git clone https://github.com/saikumarpetluri/HR_Employee_Attrition_Project.git
Open and run HR_dataset_cleaned.ipynb for data cleaning & EDA.

Use HR_Employee.sql in your SQL environment to run the HR analytics queries.

Open HR.pbix in Power BI Desktop to explore dashboards.

(Optional) Export visualizations or publish dashboard to Power BI Service.
