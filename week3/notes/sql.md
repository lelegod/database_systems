# Week 3 – DQL SQL Cheat Sheet

## Basic SELECT

```sql
SELECT [DISTINCT] col1, col2, ...
FROM   table1, table2, ...
WHERE  condition
ORDER BY col [ASC|DESC];
```

## Filtering

```sql
-- Comparison
WHERE salary > 90000
WHERE dept = 'Physics' AND salary > 70000
WHERE dept = 'Math' OR dept = 'CS'
WHERE NOT (salary > 100000)

-- NULL checks
WHERE salary IS NULL
WHERE salary IS NOT NULL

-- Range
WHERE salary BETWEEN 50000 AND 80000

-- Pattern matching
WHERE name LIKE 'A%'         -- starts with A
WHERE name LIKE '__hn'       -- any 2 chars then 'hn'
WHERE name NOT LIKE '%son'   -- does not end with 'son'

-- Set membership
WHERE dept IN ('Physics', 'Math')
WHERE dept NOT IN ('History')
WHERE StudID IN (SELECT StudID FROM Takes)         -- subquery
WHERE StudID NOT IN (SELECT StudID FROM Takes)     -- subquery
```

## Subqueries

```sql
-- Scalar subquery (single value)
SELECT InstID, InstName FROM Instructor
WHERE Salary = (SELECT MAX(Salary) FROM Instructor);

-- IN / NOT IN with subquery
SELECT StudID FROM Student
WHERE StudID NOT IN (SELECT StudID FROM Takes);

-- ALL: condition must hold for every value
SELECT DeptName FROM Department
WHERE Budget >= ALL (SELECT Budget FROM Department);

-- SOME: condition holds for at least one value
SELECT DISTINCT StudName FROM Student
WHERE StudName = SOME (SELECT InstName FROM Instructor);
-- equivalent using implicit join:
SELECT DISTINCT StudName FROM Student, Instructor
WHERE StudName = InstName;
```

## String Functions

```sql
CONCAT(col1, ' ', col2)     -- concatenate strings
UPPER(col)
LOWER(col)
LENGTH(col)
```

## Aggregates

```sql
SELECT COUNT(*)              FROM Instructor;
SELECT COUNT(salary)         FROM Instructor;   -- ignores NULLs
SELECT AVG(salary)           FROM Instructor;
SELECT SUM(salary)           FROM Instructor;
SELECT MIN(salary), MAX(salary) FROM Instructor;
SELECT COUNT(DISTINCT dept)  FROM Instructor;
```

## GROUP BY + HAVING

```sql
-- Average salary per department
SELECT dept, AVG(salary) AS avg_sal
FROM   Instructor
GROUP BY dept;

-- Only departments with avg salary > 70000
SELECT dept, AVG(salary) AS avg_sal
FROM   Instructor
GROUP BY dept
HAVING AVG(salary) > 70000;

-- Filter rows first, then group, then filter groups
SELECT dept, COUNT(*) AS cnt
FROM   Instructor
WHERE  salary > 50000
GROUP BY dept
HAVING COUNT(*) > 2
ORDER BY cnt DESC;

-- HAVING with AVG on a different column
SELECT Student, MAX(Score)
FROM   Testscores
GROUP BY Student
HAVING AVG(Score) > 49;
```

## Chained NATURAL JOIN (three tables)

```sql
-- Join three tables in one step (chained NATURAL JOIN)
SELECT StudID, SUM(Credits * Points) AS total
FROM (Takes NATURAL JOIN Course) NATURAL JOIN GradePoints
GROUP BY StudID;

-- Computed column + ORDER BY alias
SELECT StudID, SUM(Credits * Points) / SUM(Credits) AS GPA
FROM (Takes NATURAL JOIN Course) NATURAL JOIN GradePoints
GROUP BY StudID
ORDER BY GPA DESC;
```

## UNION with literal values (include non-matching rows)

```sql
-- Students who have taken courses (with GPA) UNION students who haven't (NULL GPA)
(SELECT StudID, SUM(Credits * Points) / SUM(Credits) AS GPA
 FROM (Takes NATURAL JOIN Course) NATURAL JOIN GradePoints
 GROUP BY StudID)
UNION
(SELECT StudID, NULL AS GPA
 FROM Student
 WHERE StudID NOT IN (SELECT StudID FROM Takes))
ORDER BY GPA DESC;
```

## SELECT Clause Extras

```sql
SELECT DISTINCT dept FROM Instructor;         -- remove duplicates
SELECT InstID, salary * 1.1 AS new_sal        -- arithmetic expression
FROM   Instructor;
SELECT * FROM Instructor;                      -- all columns
```

## DELETE / DDL Patterns from Exercises

```sql
-- DELETE with IN subquery
DELETE FROM Takes WHERE CourseID IN ('BIO-101', 'BIO-301');

-- Create table with composite PK
DROP TABLE IF EXISTS Testscores;
CREATE TABLE Testscores (
    Student VARCHAR(20) NOT NULL,
    Test    VARCHAR(20) NOT NULL,
    Score   INT,
    PRIMARY KEY (Student, Test)
);

-- Multi-row INSERT
INSERT INTO Testscores VALUES
    ('Brandt', 'A', 47),
    ('Brandt', 'B', 50),
    ('Brandt', 'C', NULL),
    ('Brandt', 'D', NULL);
```
