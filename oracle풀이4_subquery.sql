/*-----------------------------------------------------------
       문제
 -------------------------------------------------------------*/
--1) department_id가 60인 부서의 도시명을 알아내는 SELECT문장을 기술하시오
SELECT city
FROM locations
WHERE location_id = ( SELECT location_id
                      FROM departments
                      WHERE department_id=60);

    
--2)사번이 107인 사원과 부서가 같고,167번의 급여보다 많은 사원들의 사번,이름(first_name),급여를 출력하시오.
SELECT employee_id, first_name, salary
FROM employees
WHERE department_id = (SELECT  department_id
                       FROM employees
                       WHERE employee_id = 107)
 AND salary > (SELECT salary
              FROM employees
              WHERE employee_id = 167);
--WHERE department_id=60
-- AND salary > 6200;
                  
--3) 급여평균보다 급여를 적게받는 사원들중 커미션을 받는 사원들의 사번,이름(first_name),급여,커미션 퍼센트를 출력하시오.
SELECT employee_id, first_name, salary, commission_pct
FROM employees
WHERE salary < (SELECT avg(salary)
                FROM employees)
  AND  commission_pct IS NOT NULL;                

--4)각 부서의 최소급여가 20번 부서의 최소급여보다 많은 부서의 번호와 그 부서의 최소급여를 출력하시오.
SELECT department_id, min(salary)
FROM employees
GROUP BY department_id
HAVING min(salary) > (SELECT min(salary)
                      FROM employees
                      GROUP BY department_id
                      HAVING department_id = 20)
--HAVING min(salary) >ANY ( SELECT salary
--                          FROM employees
--                          WHERE department_id = 20)
ORDER BY  department_id;
 
  
--5) 사원번호가 177인 사원과 담당 업무가 같은 사원의 사원이름(first_name)과 담당업무(job_id)하시오.   
SELECT first_name, job_id
FROM employees
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE employee_id = 177);
 
--6) 최소 급여를 받는 사원의 이름(first_name), 담당 업무(job_id) 및 급여(salary)를 표시하시오(그룹함수 사용).
SELECT first_name, job_id, salary
FROM employees
WHERE salary = (SELECT min(salary)
                FROM employees);
				
--7)업무별 평균 급여가 가장 적은  업무(job_id)를 찾아 업무(job_id)와 평균 급여를 표시하시오.
SELECT job_id, avg(salary)
FROM employees
GROUP BY job_id
HAVING avg(salary) = (SELECT min(avg(salary))
                      FROM employees
                      GROUP BY job_id);

					  
--8) 각 부서의 최소 급여를 받는 사원의 이름(first_name), 급여(salary), 부서번호(department_id)를 표시하시오.
SELECT first_name, salary, department_id
FROM employees
WHERE (department_id, salary) IN (SELECT department_id, min(salary)
                                  FROM employees
                                  GROUP BY department_id)
ORDER BY department_id;


SELECT first_name, salary, department_id
FROM employees e1
WHERE  salary = (SELECT  min(salary)
                 FROM employees e2
                 WHERE e1.department_id=e2.department_id)
ORDER BY department_id;

--9)담당 업무가 프로그래머(IT_PROG)인 모든 사원보다 급여가 적으면서 
--업무가 프로그래머(IT_PROG)가 아닌  사원들의 사원번호(employee_id), 이름(first_name), 
--담당 업무(job_id), 급여(salary))를 출력하시오.
SELECT employee_id, first_name, job_id, salary
FROM employees
WHERE salary <ALL (SELECT salary
                   FROM employees
                   WHERE job_id = 'IT_PROG')
 AND job_id <> 'IT_PROG';                  

--10)부하직원이 없는 모든 사원의 이름을 표시하시오.
SELECT employee_id, first_name
FROM employees
WHERE employee_id NOT IN (SELECT e.employee_id
                          FROM employees e, employees m
                          WHERE e.employee_id=m.manager_id)
ORDER BY employee_id;


SELECT employee_id, first_name
FROM employees e
WHERE NOT EXISTS (SELECT employee_id
                  FROM employees m
                  WHERE m.manager_id = e.employee_id)
ORDER BY employee_id;
