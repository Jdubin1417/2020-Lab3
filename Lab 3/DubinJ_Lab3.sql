/* 
Programmer's Name: Justin Dubin
Course: CSCI 2020 Section Number: 940 
Creation Date: 02/03/2022 Date of Last Modification: 02/09/2022
E-mail Address: dubinj@etsu.edu 
Purpose - 
Lab 2 - Introduction to SQL 
Identifier dictionary - 
Not Applicable 
 
Notes and Assumptions ? 
*/
-----------------------------------------------------------------
-- B1. Employees from 515 Area Code
SELECT * 
FROM HR.employees
WHERE phone_number LIKE '515%';

-- B2. Employees with 121 in the phone number
SELECT * 
FROM HR.employees
WHERE phone_number LIKE '%121%';

-- B3. Employees with 34 at the end of the phone number
SELECT * 
FROM HR.employees
WHERE phone_number LIKE '%34';

-- B4. Employees phone number in the format ###.###.###
SELECT * 
FROM HR.employees
WHERE phone_number LIKE '___.___.____';

-- B5. Employees phone number in the format ###.###.####
SELECT * 
FROM HR.Employees
WHERE REGEXP_LIKE(phone_number,
'^[0-9]{3}\.[0-9]{3}\.[0-9]{4}$');

-- B6. Employees phone number in the format ###.##.####.######
SELECT * 
FROM HR.Employees
WHERE REGEXP_LIKE(phone_number,
'^[0-9]{3}\.[0-9]{2}\.[0-9]{4}\.[0-9]{6}$');

-- C1. Employees Last and first names
SELECT last_name || ',' || first_name AS "Last, First"
FROM HR.Employees;

-- C2. Special Employee IDs in the format ZZ-###
SELECT SUBSTR(last_name, 1, 1) || SUBSTR(first_name, 1, 1) || '-' || employee_id AS "Customer Initials"
FROM HR.Employees;

-- C3. City names surrounded by asterisks
SELECT RPAD(LPAD(city, LENGTH(city)+5, '*'), LENGTH(city)+10, '*')
FROM HR.Locations
ORDER BY length(city) ASC;

-- C4. Formatted Location Addresses
SELECT street_address, CHR (13) || '     ' || city, state_province, postal_code, country_id 
FROM HR.Locations;

-- C5. Formatted Dates
SELECT TO_CHAR(SYSDATE, 'MMYYYY') , 
TO_CHAR(SYSDATE, 'MON-YYYY') , 
TO_CHAR(SYSDATE, 'YYYY/MM/DD') , 
TO_CHAR(SYSDATE, 'Month DD, YYYY') , 
TO_CHAR(SYSDATE, 'DL, Month DD, YYYY') ,
TO_CHAR(SYSDATE, 'Month DD, YYYY HH:MI:SS PM')
FROM DUAL;

-- D1. Simple Join of Employees and Departments
SELECT  Employee_ID, Last_Name, First_Name, Phone_Number, Department_Name
FROM HR.departments
INNER JOIN HR.employees
ON HR.departments.department_ID = HR.employees.department_ID;

-- D2. Select with two joins, including a self-join
SELECT e.employee_ID, e.last_name "Employee Last Name", e.first_name "Employee First Name", m.last_name "Manager Last Name", m.first_name "Manager First Name", d.department_name "Department"
FROM HR.employees e
INNER JOIN HR.departments d
ON d.department_id = e.department_id
INNER JOIN HR.employees m
ON m.employee_id = e.manager_id;

-- D3. Cross Join Example 
SELECT COUNT (*)
FROM HR.employees; --107

SELECT COUNT (*)
FROM HR.Departments; --27

SELECT 107*27 
FROM Dual; --2889

SELECT COUNT (*)
FROM HR.Employees
CROSS JOIN Hr.Departments; --2889

-- D4. Cross Join as Inner Join Example 
SELECT COUNT (*)
FROM HR.Employees
CROSS JOIN Hr.Departments
WHERE HR.departments.department_id =  HR.employees.department_id; --106