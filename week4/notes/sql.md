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
-- Three tables joined in sequence
SELECT i.InstName, c.Title
FROM   Instructor i
JOIN   Teaches t ON i.InstID = t.InstID
JOIN   Course c  ON t.CourseID = c.CourseID
WHERE  i.DeptName = 'Physics';

-- Mix NATURAL JOIN and USING
SELECT StudName, Title
FROM (Student NATURAL JOIN Takes) JOIN Course USING (CourseID)
ORDER BY StudName;

-- LEFT OUTER JOIN + GROUP BY + COUNT (count per group, including zero)
SELECT DeptName, COUNT(InstID)
FROM Department NATURAL LEFT OUTER JOIN Instructor
GROUP BY DeptName;

-- Self-join (same table aliased twice)
SELECT DISTINCT Title
FROM prereq JOIN Course ON prereq.PreReqID = Course.CourseID;

-- Left join on same table to count prerequisites per course
SELECT Course.CourseID, Title, COUNT(prereq.CourseID) AS Number
FROM Course LEFT JOIN prereq ON prereq.PreReqID = Course.CourseID
GROUP BY Course.CourseID;
```

## ON DELETE Decision Rule

```sql
-- If the FK is part of the child's PRIMARY KEY → use CASCADE
-- (deleting parent must delete child, because child can't exist without its PK)
CREATE TABLE Takes (
    StudID   VARCHAR(5),
    CourseID VARCHAR(8),
    PRIMARY KEY (StudID, CourseID),
    FOREIGN KEY (StudID) REFERENCES Student(StudID) ON DELETE CASCADE
);

-- If the FK is NOT part of the PK → use SET NULL
-- (child can still exist, just without the reference)
CREATE TABLE Instructor (
    InstID   INT PRIMARY KEY,
    DeptName VARCHAR(30),
    FOREIGN KEY (DeptName) REFERENCES Department(DeptName) ON DELETE SET NULL
);
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

## User Management

```sql
-- Create a user
CREATE USER 'Karen'@'localhost' IDENTIFIED BY 'SetPassword';

-- Change password
SET PASSWORD = PASSWORD('KarenSecret');

-- Show grants for a user
SHOW GRANTS FOR 'Karen'@'localhost';

-- Drop a user
DROP USER 'Karen'@'localhost';
```

## Authorization (GRANT / REVOKE)

```sql
-- Grant on a specific table
GRANT SELECT, INSERT ON Instructor TO 'alice'@'localhost';

-- Grant on an entire database (database.*)
GRANT ALL ON University.* TO 'Linda'@'localhost';
GRANT SELECT ON University.* TO 'Karen'@'localhost';

-- Grant with ability to re-grant
GRANT ALL PRIVILEGES ON mydb.* TO 'admin'@'%' WITH GRANT OPTION;

-- Revoke a privilege
REVOKE INSERT ON Instructor FROM 'alice'@'localhost';

-- Revoke only the grant option (keep the privilege itself)
REVOKE GRANT OPTION FOR SELECT ON Instructor FROM 'alice'@'localhost';
```

## ENUM Constraint

```sql
CREATE TABLE Section (
    semester ENUM('Fall', 'Spring', 'Summer') NOT NULL
);
```
