# Week 4 – Intermediate SQL Cheat Sheet

## JOIN Syntax

```sql
-- INNER JOIN (explicit)
SELECT * FROM R INNER JOIN S ON R.id = S.id;
SELECT * FROM R JOIN S ON R.id = S.id;          -- INNER is default

-- NATURAL JOIN (joins on all same-named columns)
SELECT * FROM R NATURAL JOIN S;

-- USING (join on specified columns, no duplicate col in result)
SELECT * FROM R JOIN S USING (dept, year);

-- LEFT OUTER JOIN (all R rows, NULLs for unmatched S)
SELECT * FROM R LEFT OUTER JOIN S ON R.id = S.id;

-- RIGHT OUTER JOIN (all S rows, NULLs for unmatched R)
SELECT * FROM R RIGHT OUTER JOIN S ON R.id = S.id;

-- FULL OUTER JOIN workaround for MariaDB/MySQL
(SELECT * FROM R LEFT  OUTER JOIN S ON R.id = S.id)
UNION
(SELECT * FROM R RIGHT OUTER JOIN S ON R.id = S.id);

-- CROSS JOIN (cartesian product)
SELECT * FROM R CROSS JOIN S;
SELECT * FROM R, S;                              -- same thing
```

## Multi-table JOIN chain

```sql
SELECT i.InstName, c.Title
FROM   Instructor i
JOIN   Teaches t ON i.InstID = t.InstID
JOIN   Course c  ON t.CourseID = c.CourseID
WHERE  i.DeptName = 'Physics';
```

## Views

```sql
-- Create a view
CREATE VIEW PhysicsInstructors AS
    SELECT InstID, InstName, Salary
    FROM   Instructor
    WHERE  DeptName = 'Physics';

-- Query a view (same as a table)
SELECT * FROM PhysicsInstructors WHERE Salary > 80000;

-- Drop a view
DROP VIEW PhysicsInstructors;
```

## Authorization

```sql
-- Grant privileges
GRANT SELECT, INSERT ON Instructor TO 'alice'@'localhost';
GRANT ALL PRIVILEGES ON mydb.* TO 'admin'@'%' WITH GRANT OPTION;

-- Revoke privileges
REVOKE INSERT ON Instructor FROM 'alice'@'localhost';
REVOKE GRANT OPTION FOR SELECT ON Instructor FROM 'alice'@'localhost';
```

## ENUM Constraint

```sql
CREATE TABLE Section (
    semester ENUM('Fall', 'Spring', 'Summer') NOT NULL
);
```
