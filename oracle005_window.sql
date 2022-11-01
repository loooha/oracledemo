
/*-------------------------------------
ROLLUP( ) 함수, CUBE( )함수
--------------------------------------*/
SELECT department_id, job_id, count(*)
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id, job_id;


/*-------------------------------------
ROLLUP(column1, column2)
(column1, column2)
(column1)
()

ROLLUP(department_id, job_id)
 20	MK_MAN 1   --그룹
 20	MK_REP 1   --그룹
 20        2   --그룹
          107  --총계
--------------------------------------*/
SELECT department_id, count(*)
FROM employees
GROUP BY rollup(department_id)
ORDER BY department_id;


SELECT department_id, job_id, count(*)
FROM employees
GROUP BY rollup(department_id, job_id)
ORDER BY department_id, job_id;


/*-------------------------------------
CUBE( )함수
CUBE(column1, column2)
    (column1, column2)
    (column1)
    (column2)
    ()
    
CUBE(department_id, job_id)
 20	MK_MAN 1   --그룹
 20	MK_REP 1   --그룹
 20        2   --소계
    MK_MAN 1   --소계
    MK_REP 1   --소계
          107  --총계
--------------------------------------*/
SELECT department_id, count(*)
FROM employees
GROUP BY CUBE(department_id)
ORDER BY department_id;


SELECT department_id, job_id, count(*)
FROM employees
GROUP BY CUBE(department_id, job_id)
ORDER BY department_id, job_id;

SELECT department_id, job_id, count(*)
FROM employees
GROUP BY CUBE((department_id, job_id))
ORDER BY department_id, job_id;


/*-------------------------------------
GROUPING SETS(  ) 함수
--------------------------------------*/
SELECT department_id, job_id, count(*)
FROM employees
GROUP BY GROUPING SETS(department_id, job_id)
ORDER BY department_id, job_id;

SELECT department_id, job_id, count(*)
FROM employees
GROUP BY GROUPING SETS(department_id), GROUPING SETS(job_id)
ORDER BY department_id, job_id;


--
SELECT CASE department_id
            WHEN 10 THEN 'A'
            WHEN 20 THEN 'B'
            ELSE 'C'
        END AS "alias"
FROM employees;


SELECT CASE GROUPING(d.department_name)
            WHEN 1 THEN 'ALL Departments'
            ELSE d.department_name
        END AS "DNAME",
        CASE GROUPING(e.job_id)
            WHEN 1 THEN 'ALL Jobs'
            ELSE e.job_id
        END AS "JOB",
        count(*) AS "Total Sal",
        sum(e.salary) AS "Total Sal"
FROM employees e, departments d
WHERE e.department_id = d.department_id
GROUP BY d.department_name, rollup(job_id);


SELECT /*CASE GROUPING(d.department_name)
            WHEN 1 THEN 'ALL Departments'
            ELSE d.department_name
        END AS "DNAME",
        CASE GROUPING(e.job_id)
            WHEN 1 THEN 'ALL Jobs'
            ELSE e.job_id
        END AS "JOB",*/
        department_name, job_id,
        count(*) AS "Total Sal",
        sum(e.salary) AS "Total Sal"
FROM employees e, departments d
WHERE e.department_id = d.department_id
GROUP BY d.department_name, rollup(job_id);


SELECT CASE GROUPING(d.department_name)
            WHEN 1 THEN 'ALL Departments'
            ELSE d.department_name
        END AS "DNAME",
        CASE GROUPING(e.job_id)
            WHEN 1 THEN 'ALL Jobs'
            ELSE e.job_id
        END AS "JOB",
        count(*) AS "Total Sal",
        sum(e.salary) AS "Total Sal"
FROM employees e, departments d
WHERE e.department_id = d.department_id
GROUP BY rollup(d.department_name, job_id);


/*-------------------------------------
그룹내 순위관련함수
RANK(  ) OVER( ) : 특정 컬럼에 대한 순위를 구하는 함수로 동일한 값에 대해서는 동일한 순위를 준다.
DENSE( ) OVER( ) : 동일한 순위를 하나의 건수로 취급한다.
ROW( ) OVER( ) : 동일한 값이라도 고유한 순위를 부여한다.
--------------------------------------*/