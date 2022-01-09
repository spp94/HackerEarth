-- Q-1. Write An SQL Query To Fetch “FIRST_NAME” From Worker Table Using The Alias Name As <WORKER_NAME>. 

SELECT FIRST_NAME AS WORKER_NAME FROM WORKER

-- Q-2. Write An SQL Query To Fetch “FIRST_NAME” From Worker Table In Upper Case.

SELECT UPPER(FIRST_NAME) FROM WORKER


-- Q-3. Write An SQL Query To Fetch Unique Values Of DEPARTMENT From Worker Table.

SELECT DISTINCT DEPARTMENT FROM WORKER


-- Q-4. Write An SQL Query To Print The First Three Characters Of  FIRST_NAME From Worker Table.

SELECT SUBSTRING(FIRST_NAME, 1, 3) FROM WORKER


-- Q-5. Write An SQL Query To Find The Position Of The Alphabet (‘A’) In The First Name Column ‘Amitabh’
--      From Worker Table.


SELECT CHARINDEX('A',FIRST_NAME) AS [INDEX], FIRST_NAME FROM WORKER WHERE FIRST_NAME = 'AMITABH'


-- Q-6. Write An SQL Query To Print The FIRST_NAME From Worker Table After Removing White Spaces From The Right Side.

SELECT RTRIM(FIRST_NAME) FROM WORKER



-- Q-7. Write An SQL Query To Print The DEPARTMENT From Worker Table After Removing White Spaces From The Left Side.

SELECT LTRIM(FIRST_NAME) FROM WORKER


-- Q-8. Write An SQL Query That Fetches The Unique Values Of DEPARTMENT From Worker Table And Prints Its Length.

SELECT DISTINCT(DEPARTMENT) AS DEPARTMENT, LEN(DEPARTMENT) AS DEPARTMENTLENGHT FROM WORKER


-- Q-9. Write An SQL Query To Print The FIRST_NAME From Worker Table After Replacing ‘A’ With ‘A’.

SELECT REPLACE(FIRST_NAME,'a','A') FROM WORKER


-- Q-10. Write An SQL Query To Print The FIRST_NAME And LAST_NAME From Worker Table Into A Single Column COMPLETE_NAME.
-- A Space Char Should Separate Them.


SELECT (RTRIM(FIRST_NAME) + ' ' + LTRIM(LAST_NAME)) AS COMPLETE_NAME FROM WORKER


-- Q-11. Write An SQL Query To Print All Worker Details From The Worker Table Order By FIRST_NAME Ascending.

SELECT * FROM WORKER ORDER BY FIRST_NAME ASC


-- Q-12. Write An SQL Query To Print All Worker Details From The Worker Table Order By FIRST_NAME Ascending
-- And DEPARTMENT Descending.


SELECT * FROM WORKER ORDER BY FIRST_NAME ASC, DEPARTMENT DESC


-- Q-13. Write An SQL Query To Print Details For Workers With The First Name As “Vipul” And “Satish” From Worker Table.

SELECT * FROM WORKER WHERE FIRST_NAME IN ('VIPUL','SATISH')


-- Q-14. Write An SQL Query To Print Details Of Workers Excluding First Names, “Vipul” And “Satish” From Worker Table.

SELECT * FROM WORKER WHERE FIRST_NAME NOT IN('VIPUL','SATISH')


-- Q-15. Write An SQL Query To Print Details Of Workers With DEPARTMENT Name As “Admin”.

SELECT * FROM WORKER WHERE DEPARTMENT = 'ADMIN'



-- Q-16. Write An SQL Query To Print Details Of The Workers Whose FIRST_NAME Contains ‘A’.

SELECT * FROM WORKER WHERE FIRST_NAME LIKE '%A%'


-- Q-17. Write An SQL Query To Print Details Of The Workers Whose FIRST_NAME Ends With ‘A’.

SELECT * FROM WORKER WHERE FIRST_NAME LIKE '%A'


-- Q-18. Write An SQL Query To Print Details Of The Workers Whose FIRST_NAME Ends With ‘H’ And Contains Six Alphabets.


SELECT * FROM WORKER WHERE FIRST_NAME LIKE '%H' AND LEN(FIRST_NAME) = 6



-- Q-19. Write An SQL Query To Print Details Of The Workers Whose SALARY Lies Between 100000 And 500000.

SELECT * FROM WORKER WHERE SALARY BETWEEN 100000 AND 500000


-- Q-20. Write An SQL Query To Print Details Of The Workers Who Have Joined In MARCH’2019.

SELECT * FROM WORKER WHERE YEAR(JOINING_DATE) = 2019 AND MONTH(JOINING_DATE) = 3


-- Q-21. Write An SQL Query To Fetch The Count Of Employees Working In The Department ‘Admin’.

select count(worker_id) from worker where department='admin';


-- Q-22. Write An SQL Query To Fetch Worker Names With Salaries >= 50000 And <= 100000.

select ltrim(rtrim(first_name))+' '+ rtrim(LTRIM(last_name)) from worker where salary between 50000 and 100000;


-- Q-23. Write An SQL Query To Fetch The No. Of Workers For Each Department In The Descending Order.

select Department,count(*) from worker group by department order by count(*) desc;



-- Q-24. Write An SQL Query To Print Details Of The Workers Who Are Also Managers.

select w.* from worker w
join title t 
on 
w.worker_id=t.worker_ref_id
where t.worker_title='manager';


-- Q-25. Write An SQL Query To Fetch Duplicate Records Having Matching Data In Some Fields Of A Table.

select * from worker;

with at as
(
SELECT *, 
ROW_NUMBER() OVER(PARTITION BY first_name,last_name,salary,joining_date,department 
ORDER BY first_name,last_name,salary,joining_date,department) AS ROWNUM
FROM WORKER
)

SELECT * FROM AT where rownum > 1


-- Ques 26 Write An SQL Query To Show Only Odd Rows From A Table.

select * from worker;
select * from (select *,row_number() over(order by worker_id) e from worker)r where r.e % 2=1; 



-- Q-27. Write An SQL Query To Clone A New Table From Another Table.


select * into new_table from worker;
select * from new_table;


-- Q-29. Write An SQL Query To Fetch Intersecting Records Of Two Tables.


(SELECT * FROM Worker)
INTERSECT
(SELECT * FROM WorkerClone);


-- Q-30. Write An SQL Query To Show Records From One Table That Another Table Does Not Have.


SELECT * FROM Worker
MINUS
SELECT * FROM Title;


-- Q-32. Write An SQL Query To Show The Top N (Say 10) Records Of A Table.

SELECT TOP 3 * FROM WORKER ORDER BY SALARY DESC


-- Q-33. Write An SQL Query To Determine The Nth (Say N=5) Highest Salary From A Table.

WITH #TEMP AS
(
SELECT *, ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS ROWNUM FROM WORKER
)
SELECT * FROM #TEMP WHERE ROWNUM = 5



-- Q-35. Write An SQL Query To Fetch The List Of Employees With The Same Salary.

SELECT w1.*, W2.* FROM WORKER W1
JOIN WORKER W2
ON W1.SALARY = W2.SALARY
WHERE W1.WORKER_ID <> W2.WORKER_ID



-- Q-36. Write An SQL Query To Show The Second Highest Salary From A Table.

SELECT MAX(SALARY) FROM WORKER
WHERE SALARY NOT IN (SELECT MAX(SALARY) FROM WORKER)


-- Q-37. Write An SQL Query To Show One Row Twice In Results From A Table.

SELECT * FROM WORKER
UNION ALL
SELECT * FROM WORKER


-- Q-38. Write An SQL Query To Fetch Intersecting Records Of Two Tables.

SELECT * FROM WORKER
INTERSECT
SELECT * FROM WORKERCLONE


-- Q-39. Write An SQL Query To Fetch The First 50% Records From A Table.

WITH #TEMP AS(
SELECT *, ROW_NUMBER() OVER(ORDER BY JOINING_DATE) AS ROWNUM FROM WORKER)

SELECT * FROM #TEMP WHERE ROWNUM <= (SELECT MAX(ROWNUM)/2 FROM #TEMP)



-- Q-40. Write An SQL Query To Fetch The Departments That Have Less Than Five People In It.


SELECT department, COUNT(DEPARTMENT)
FROM WORKER
GROUP BY department 
HAVING COUNT(DEPARTMENT) < 5



-- Q-41. Write An SQL Query To Show All Departments Along With The Number Of People In There.

SELECT DEPARTMENT, COUNT(DEPARTMENT) AS [TOTAL EMPLOYEES] FROM WORKER
GROUP BY DEPARTMENT


-- Q-42. Write An SQL Query To Show The Last Record From A Table.

WITH #TEMP AS
(
SELECT *, ROW_NUMBER() OVER(ORDER BY JOINING_DATE) AS ROWNUM FROM WORKER
)
SELECT * FROM #TEMP WHERE ROWNUM= (SELECT MAX(ROWNUM) FROM #TEMP) 



-- Q-45. Write An SQL Query To Print The Name Of Employees Having The Highest Salary In Each Department

SELECT DEPARTMENT, MAX(SALARY) FROM WORKER GROUP BY DEPARTMENT



-- Q-46. TO PRINT N RANDOM ROWS FROM A TABLE

SELECT TOP 5 *
FROM EMP ORDER BY NEWID()







