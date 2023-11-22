create database HR;
use HR;
create table HR1 (
Age INT,
  Attrition VARCHAR(3),
  BusinessTravel VARCHAR(20),
  DailyRate INT,
  Department VARCHAR(40),
  DistanceFromHome INT,
  Education INT,
  EducationField VARCHAR(20),
  EmployeeCount INT,
  EmployeeNumber INT,
  EnvironmentSatisfaction INT,
  Gender VARCHAR(6),
  HourlyRate INT,
  JobInvolvement INT,
  JobLevel INT,
  JobRole VARCHAR(30),
  JobSatisfaction INT,
  MaritalStatus VARCHAR(10)
);
select * from hr1;
drop table hr1;
SHOW VARIABLES LIKE "secure_file_priv";
load data infile "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\HR_1.csv"
into table hr1 
fields terminated by ',' 
optionally enclosed by '"' 
lines terminated by '\n' 
ignore 1 rows;

create table hr2 (
EmployeeID INT,
   MonthlyIncome INT,
   MonthlyRate INT,
   NumCompaniesWorked INT,
   Over18 CHAR(3),
   OverTime CHAR(3),
   PercentSalaryHike INT,
   PerformanceRating INT,
   RelationshipSatisfaction INT,
   StandardHours INT,
   StockOptionLevel INT,
   TotalWorkingYears INT,
   TrainingTimesLastYear INT,
   WorkLifeBalance INT,
   YearsAtCompany INT,
   YearsInCurrentRole INT,
   YearsSinceLastPromotion INT,
   YearsWithCurrManager INT
);
select * from hr2;

load data infile "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\HR_2 (2).csv"
into table hr2 
fields terminated by ',' 
optionally enclosed by '"' 
lines terminated by '\n' 
ignore 1 rows;


# KP1
create table KPI1 (
select department, concat(round(avg(case when attrition = "Yes" then 1 else 0 end)*100,0), "%") 
as att_rate from hr1 
group by department order by att_rate desc);

select * from kpi2;
select * from hr2;
drop table kpi2;
#Kpi 2
create table kpi2 (
select round(avg(hourlyrate),0) as AvgHourlyRate from hr1 
where jobrole = "Research Scientist" and gender = "male" order by AvgHourlyRate desc) ;

# KPI 3
create table KPI3 (
select  case
when MonthlyIncome <= 20000 then "Low Income" 
when monthlyincome > 20000 and MonthlyIncome<= 40000 then " Medium Income"
else " High Income" end as IncomeGroup,
concat(round(avg(case
when attrition = "Yes" then 1 else 0 end)*100,0), "%") 
as att_rate from HR1 as A
inner join HR2 as B on A.EmployeeNumber=B.EmployeeId
group by incomegroup order by att_rate desc);

select * from KPI3;

# KPI 4
create table KPI4 (
select round(avg(B.totalworkingyears),0) as AvgWorkingYear, A.department as Department 
from hr1 as A inner join hr2 as B
on A.employeenumber = B.employeeid 
group by department order by AvgWorkingYear desc);
select * from KPI4;

#KPI5
select * from hr1;
select * from hr2;
select round(avg(worklifebalance),1) from hr2;

create table KPI5 (
select round(avg(B.worklifebalance),0) as AVG_WRK_BLNC, A.jobrole as ROLE 
from hr1 A inner join hr2 B on A.employeenumber = B.employeeid
group by jobrole order by AVG_WRK_BLNC desc);

select * from KPI5;

#KPI6 
create table KPI6 (
select B.YearsSinceLastPromotion as LastPromotion,
concat(round((count(case when A.attrition = "Yes" then 1 else 0 end))/50000*100,2),"%")
as att_rate from hr1 A inner join hr2 B on A.employeenumber = B.employeeid
group by LastPromotion order by LastPromotion) ;

select * from KPI6;



