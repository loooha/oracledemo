/*--------------------------------------
join(조인)
1. 여러개의 테이블에서 원하는 데이터를 추출해주는 쿼리문이다.
2. join은 oracle제품에서 사용되는 oracle용 join이 있고,
    모든 제품에서 공통적으로 사용되는 표준(ANSI) join이 있다.
--------------------------------------*/

/*--------------------------------------
1. equi join
    가장 많이 사용되는 조인방법으로 조인 대상이 되는 두 테이블에서 공통적으로 존재하는 컴럼의 값이
    일치되는 행을 연결하여 결과를 생성하는 방법이다.
--------------------------------------*/
-- (1) oracle용 equi join
SELECT  dept.department_id, emp.first_name, job_id, department_name
FROM employees emp, departments dept
WHERE emp.department_id=dept.department_id;

-- (2) ansi용 inner join
SELECT  dept.department_id, emp.first_name, job_id, department_name
FROM employees emp inner join departments dept
    ON emp.department_id=dept.department_id;


-- employees와 department테이블에서 사원번호(employee_id), 부서번호(department_id), 부서명(department_name)을 검색하세요.
SELECT emp.employee_id, dept.department_id, dept.department_name
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id
ORDER BY emp.employee_id;

SELECT emp.employee_id, dept.department_id, dept.department_name
FROM employees emp inner join departments dept
  ON emp.department_id = dept.department_id
ORDER BY emp.employee_id;

-- employee와 jobs 테이블에서 사원번호(employee_id), 업무번호(job_id), 업무명(job_title)을 검색하세요
SELECT e.employee_id, j.job_id, j.job_title
FROM employees e, jobs j
WHERE e.job_id = j.job_id
ORDER BY e.employee_id;

SELECT e.employee_id, j.job_id, j.job_title
FROM employees e inner join jobs j
ON e.job_id = j.job_id
ORDER BY e.employee_id;

-- job_id가 'FI_MGR'인 사원이 속한
-- 급여(salary)의 최소값(min_salary), 최대값(max_salary)을 출력
SELECT e.first_name, e.job_id, j.min_salary, j.max_salary
FROM employees e, jobs j
WHERE e.job_id = j.job_id
AND e.job_id = 'FI_MGR';

/*--------------------------------------
선행테이블(Driving) - 후행테이블(Driven)
--------------------------------------*/

SELECT e.first_name, e.job_id, j.min_salary, j.max_salary
FROM employees e inner join jobs j
ON e.job_id = j.job_id
WHERE e.job_id = 'FI_MGR';

-- 부서가 'Seattle'에 있는 부서에서 근무하는
-- 직원들의 first_name, hire_date, department_name, city
-- 출력하는 SELECT 작성
SELECT e.first_name, e.hire_date, d.department_name, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND l.city = 'Seattle';

SELECT e.first_name, e.hire_date, d.department_name, l.city
FROM employees e inner join departments d
ON e.department_id = d.department_id
inner join locations l
ON d.location_id = l.location_id
WHERE l.city = 'Seattle';


-- 20번 부서의 이름과 그 부서에 근무하는 사원의 이름(first_name)을 출력
SELECT d.department_name, d.department_id, e.first_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND d.department_id = 20;

SELECT d.department_name, d.department_id, e.first_name
FROM employees e inner join departments d
ON e.department_id = d.department_id
WHERE d.department_id = 20;


-- 1400, 1500번 위치의 도시이름과 그 곳에 있는 부서의 이름을 출력
SELECT l.location_id, l.city, d.department_name
FROM departments d, locations l
WHERE l.location_id = d.location_id
AND l.location_id IN (1400,1500);

SELECT l.location_id, l.city, d.department_name
FROM departments d inner join locations l
ON l.location_id = d.location_id
WHERE l.location_id IN (1400,1500);


/*--------------------------------------
2. carteian product (카디션 곱) 조인:
    테이블 행의 갯수만큼 출력해주는 조인이다.
--------------------------------------*/
-- 1) oracle용 carteian product
SELECT e.department_id , e.first_name, e.job_id, j.job_title
FROM employees e, jobs j;

SELECT count(*) FROM employees; --107
SELECT count(*) FROM jobs; --19

-- 2) ANSI용 cross join
SELECT e.department_id , e.first_name, e.job_id, j.job_title
FROM employees e cross join jobs j;


/*--------------------------------------
3. NATURAL JOIN
    NATURAL JOIN은 두 테이블 간의 동일한 이름을 갖는 모든 컬럼들에 대해 EQUI(=) JOIN을 수행한다.
    그리고, SQL SERVER에서는 지원하지 않는 기능이다.
--------------------------------------*/
SELECT first_name, salary, department_id, department_name
FROM employees NATURAL JOIN departments;
/*
SELECT first_name, salary, d.department_id, department_name
FROM employees e inner join departments d
ON e.department_id = d.department_id;
*/


/*--------------------------------------
4. non-equi join
    (=)동등비교연산자를 제외한 >=, <=, >, < 등의 연산자를 이용해서 조건을 지정하는 방법이다.
--------------------------------------*/
-- 1) oracle용 non-equi join
SELECT e.first_name, e.salary, j.min_salary, j.max_salary, j.job_title
FROM employees e, jobs j
WHERE e.job_id = j.job_id
AND e.salary >= j.min_salary
AND e.salary <= j.max_salary;

SELECT e.first_name, e.salary, j.min_salary, j.max_salary, j.job_title
FROM employees e join jobs j
ON e.job_id = j.job_id
WHERE e.salary >= j.min_salary
AND e.salary <= j.max_salary;


/*--------------------------------------
5. OUTER JOIN
    한 테이블은 데이터가 있고 다른 반대쪽에는 데이터가 없는 경우에
    데이터가 있는 테이블의 내용을 모두 가져오는 조건이다.
--------------------------------------*/
-- 1) oracle용 OUTER JOIN
SELECT e.first_name, e.employee_id, e.department_id, d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+); /* LEFT OUTER JOIN */

SELECT e.first_name, e.employee_id, e.department_id, d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id(+) = d.department_id; /* RIGHT OUTER JOIN */

-- 2) ANSI  OUTER JOIN
SELECT e.first_name, e.employee_id, e.department_id, d.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON e.department_id = d.department_id; /* LEFT OUTER JOIN */

SELECT e.first_name, e.employee_id, e.department_id, d.department_id, d.department_name
FROM employees e RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id; /* RIGHT OUTER JOIN */


/*--------------------------------------
6. SELF JOIN
    하나의 테이블을 두 개의 테이블로 설정해서 사용하는 조인방법이다.
    하나의 테이블에 같은 데이터가 두개의 컬럼에 다른 목적으로 저장되어 있는 경우
    employees, employee_id, manager_id
--------------------------------------*/
SELECT employee_id, first_name, manager_id
FROM employees;

-- 1) oracle SELF JOIN
SELECT w.employee_id AS "사원번호",
        w.first_name AS "사원이름",
        w.manager_id AS "매니저번호",
        m.first_name AS "매니저이름"
FROM employees w, employees m
WHERE w.manager_id = m.employee_id
ORDER BY w.employee_id;

-- 2) ansi SELF JOIN
SELECT w.employee_id AS "사원번호",
        w.first_name AS "사원이름",
        w.manager_id AS "매니저번호",
        m.first_name AS "매니저이름"
FROM employees w join employees m
ON w.manager_id = m.employee_id
ORDER BY w.employee_id;



/*--------------------------------------
USING
--------------------------------------*/    
SELECT  department_id,first_name, job_id, department_name
FROM employees inner join departments USING(department_id)
-- ON emp.department_id = dept.department_id
WHERE department_id=30;

