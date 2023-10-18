use employee;
#task 3
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
FROM emp_record_table;

#task 4
##PART1
SELECT EMP_ID ,FIRST_NAME ,LAST_NAME ,GENDER ,DEPT ,EMP_RATING
FROM employee.emp_record_table
WHERE EMP_RATING<2; 

##PART2
SELECT EMP_ID ,FIRST_NAME ,LAST_NAME ,GENDER ,DEPT ,EMP_RATING
FROM employee.emp_record_table
WHERE EMP_RATING>4; 

##PART3
SELECT EMP_ID ,FIRST_NAME ,LAST_NAME ,GENDER ,DEPT ,EMP_RATING
FROM employee.emp_record_table
WHERE EMP_RATING BETWEEN 2 AND 4;

#task 5
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME
FROM emp_record_table
WHERE DEPT = 'Finance';

#task 6
SELECT 
    E.EMP_ID,
    E.FIRST_NAME,
    E.LAST_NAME,
    COUNT(DISTINCT R.EMP_ID) AS NUMBER_OF_REPORTERS
FROM emp_record_table E
JOIN emp_record_table R ON E.EMP_ID = R.MANAGER_ID
GROUP BY E.EMP_ID, E.FIRST_NAME, E.LAST_NAME
HAVING COUNT(DISTINCT R.EMP_ID) > 0;

#task 7
-- Employees from the Healthcare department
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
FROM emp_record_table
WHERE DEPT = 'Healthcare'

UNION

-- Employees from the Finance department
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
FROM emp_record_table
WHERE DEPT = 'Finance';

#task 8
SELECT DEPT, EMP_ID, FIRST_NAME, LAST_NAME, ROLE, MAX(EMP_RATING) AS MAX_EMP_RATING
FROM emp_record_table
GROUP BY DEPT, EMP_ID, FIRST_NAME, LAST_NAME, ROLE;

#task 9
SELECT
    ROLE,
    MIN(SALARY) AS MINIMUM_SALARY,
    MAX(SALARY) AS MAXIMUM_SALARY
FROM emp_record_table
GROUP BY ROLE;

#task 10
SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP,
  CASE
    WHEN EXP <= 2 THEN 'JUNIOR DATA SCIENTIST'
    WHEN EXP <= 5 THEN 'ASSOCIATE DATA SCIENTIST'
    WHEN EXP <= 10 THEN 'SENIOR DATA SCIENTIST'
    WHEN EXP <= 12 THEN 'LEAD DATA SCIENTIST'
    ELSE 'MANAGER'
  END AS JOB_RANK
FROM emp_record_table;

#task 11
CREATE VIEW HighSalaryEmployees AS
SELECT
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    COUNTRY,
    SALARY
FROM emp_record_table
WHERE SALARY > 6000;

select * from highsalaryemployees;

#task 12
SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP
FROM emp_record_table
WHERE EXP > (SELECT MAX(EXP) FROM emp_record_table WHERE EXP <= 10);

#task 13
DELIMITER //
CREATE PROCEDURE GetEmployeesWithExperienceGreaterThanThreeYears()
BEGIN
    SELECT
        EMP_ID,
        FIRST_NAME,
        LAST_NAME,
        EXP
    FROM emp_record_table
    WHERE EXP > 3;
END //
DELIMITER ;

CALL GetEmployeesWithExperienceGreaterThanThreeYears();

#task 14
DELIMITER //
CREATE FUNCTION AssignJobProfile(EXP INT)
RETURNS VARCHAR(50) DETERMINISTIC
BEGIN
    DECLARE JobProfile VARCHAR(50);

    IF EXP <= 2 THEN
        SET JobProfile = 'JUNIOR DATA SCIENTIST';
    ELSEIF EXP <= 5 THEN
        SET JobProfile = 'ASSOCIATE DATA SCIENTIST';
    ELSEIF EXP <= 10 THEN
        SET JobProfile = 'SENIOR DATA SCIENTIST';
    ELSEIF EXP <= 12 THEN
        SET JobProfile = 'LEAD DATA SCIENTIST';
    ELSE
        SET JobProfile = 'MANAGER';
    END IF;

    RETURN JobProfile;
END //
DELIMITER ;

SELECT AssignJobProfile(EXP)
FROM emp_record_table;

#task 15
CREATE INDEX idx_employee_firstname ON emp_record_table (FIRST_NAME(255)); 
EXPLAIN SELECT * FROM emp_record_table WHERE FIRST_NAME = 'Eric';

#task 16
SELECT
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    SALARY,
    EMP_RATING,
    (SALARY * 0.05 * EMP_RATING) AS BONUS
FROM emp_record_table;

#task 17
 SELECT
    CONTINENT,
    COUNTRY,
    AVG(SALARY) AS AVERAGE_SALARY
FROM emp_record_table
GROUP BY CONTINENT, COUNTRY;
