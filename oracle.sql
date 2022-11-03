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