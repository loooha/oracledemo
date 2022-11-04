SELECT * FROM departments 
WHERE department_name LIKE '%IT%'
ORDER BY department_id;

-- 테이블 생성
CREATE TABLE mem(
 num number constraint mem_num_pk primary key,
 name varchar2(100),
 age number(3),
 loc varchar2(50)
);

-- 시퀀스 생성
CREATE SEQUENCE mem_num_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
-- 삽입
INSERT INTO mem(num, name, age, loc)
VALUES(mem_num_seq.nextval, '홍길동', 30, '서울');

SELECT * FROM mem;

commit;



-----------------------------------------------------------------------------
-- join

SELECT e.employee_id, e.first_name, e.job_id, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;


SELECT d.department_id, d.department_name, e.employee_id, e.first_name, e.job_id
FROM departments d, employees e
WHERE d.department_id = e.department_id;


SELECT e.employee_id, e.first_name, d.department_name, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id;
