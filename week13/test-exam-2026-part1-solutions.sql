-- In next line, insert your student ID after the colon.
-- Student ID: 

-- Below, you must at most make one SQL query for each question. If you make several, they will be ignored.

-- -----------------------------------------------------------------------------------------------------
-- q1: Answer to question 1 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
SELECT ename, dname
FROM Employee NATURAL JOIN Department
WHERE country = 'Denmark' AND eid NOT IN (SELECT eid FROM authors);
	
-- -----------------------------------------------------------------------------------------------------
-- q2: Answer to question 2 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
SELECT rid, rname, ryear, COUNT(*) as numAuthors
FROM Report NATURAL JOIN authors
GROUP BY rid, rname, ryear
HAVING count(*) >= 2;

-- -----------------------------------------------------------------------------------------------------
-- q3: Answer to question 3 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
SELECT pname, COUNT(DISTINCT rid) as numReports
FROM Project NATURAL LEFT JOIN participates NATURAL LEFT JOIN authors
GROUP BY pname;

-- -----------------------------------------------------------------------------------------------------
-- q4: Answer to question 4 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------

-- DROP FUNCTION IF EXISTS reports;
CREATE FUNCTION reports(v_eid INT) RETURNS INT
RETURN (SELECT COUNT(*)
	FROM authors
	WHERE eid = v_eid);

-- SELECT eid, reports(eid) AS numReports FROM Employee; 
-- SELECT reports(60); -- non existing should give 0. 
