-- In next line, insert your student ID after the colon.
-- Student ID: s252786

-- Below, you must at most make one SQL query for each question. If you make several, they will be ignored.
USE CompanyDatabase;
-- -----------------------------------------------------------------------------------------------------
-- q1: Answer to question 1 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
SELECT ename, dname
FROM Employee
WHERE (SELECT country FROM Department WHERE Department.dname = Employee.dname) = 'Denmark' AND
eid NOT IN (SELECT eid FROM authors);
-- -----------------------------------------------------------------------------------------------------
-- q2: Answer to question 2 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
SELECT rid, rname, ryear, COUNT(DISTINCT eid) AS numAuthors
FROM authors LEFT JOIN Report USING (rid)
GROUP BY rid, rname, ryear
HAVING COUNT(DISTINCT eid) >= 2;
-- -----------------------------------------------------------------------------------------------------
-- q3: Answer to question 3 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
SELECT pname, COUNT(DISTINCT rid) AS numReports
FROM Project LEFT JOIN participates USING (pname) LEFT JOIN authors USING (eid)
GROUP BY pname;
-- -----------------------------------------------------------------------------------------------------
-- q4: Answer to question 4 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
DELIMITER //
CREATE FUNCTION reports (veid INTEGER(3)) RETURNS INTEGER
BEGIN
	DECLARE vNumReports INT;
    SELECT COUNT(*) INTO vNumReports FROM authors
    WHERE eid = veid;
	RETURN vNumReports;
END //
DELIMITER ;