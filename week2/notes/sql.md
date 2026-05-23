# Week 2 – DDL + DML SQL Cheat Sheet

## CREATE TABLE

```sql
CREATE TABLE TableName (
    col1  DataType  [NOT NULL],
    col2  DataType  [DEFAULT value],
    ...
    PRIMARY KEY (col1),
    FOREIGN KEY (col2) REFERENCES OtherTable(col)
        [ON DELETE CASCADE | SET NULL | RESTRICT]
        [ON UPDATE CASCADE | SET NULL | RESTRICT]
);
```

## DROP / ALTER TABLE

```sql
DROP TABLE TableName;

-- Add a column
ALTER TABLE TableName ADD col DataType;

-- Remove a column
ALTER TABLE TableName DROP COLUMN col;

-- Modify a column's type
ALTER TABLE TableName MODIFY col NewDataType;

-- Rename a column
ALTER TABLE TableName CHANGE old_col new_col DataType;
```

## Common Data Types

```sql
INT                 -- integer
DECIMAL(10, 2)      -- 10 digits total, 2 after decimal point
VARCHAR(50)         -- variable string, up to 50 chars
CHAR(5)             -- fixed string, exactly 5 chars
DATE                -- YYYY-MM-DD
DATETIME            -- YYYY-MM-DD HH:MM:SS
```

## Constraints

```sql
-- Column-level
col INT NOT NULL
col VARCHAR(20) UNIQUE
col INT DEFAULT 0
col INT CHECK (col > 0)

-- Table-level (composite PK, FK)
PRIMARY KEY (col1, col2)
FOREIGN KEY (deptID) REFERENCES Department(deptID)
    ON DELETE SET NULL
    ON UPDATE CASCADE
```

## INSERT

```sql
-- Positional (values must match column order exactly)
INSERT INTO Person VALUES('31262549', 'Hans Hansen', 'Jernbane Alle 74');
INSERT Person VALUES('31262549', 'Hans Hansen', 'Jernbane Alle 74'); -- also valid

-- Named columns (safer, order doesn't matter)
INSERT INTO Course (CourseID, Title, DeptName, Credits)
VALUES ('CS-102', 'Weekly Seminar', 'Comp. Sci.', 0);

-- Insert NULL explicitly
INSERT INTO Section VALUES('CS-102', 1, 'Fall', 2009, NULL, NULL, NULL);

-- Multiple rows in one statement
INSERT INTO Course VALUES
    ('CS-102', 'Weekly Seminar', 'Comp. Sci.', 0),
    ('CS-103', 'Weekly Seminar', 'Comp. Sci.', 0);

-- Insert from a SELECT query (ex. 2.25)
INSERT INTO Takes
SELECT Student.StudID, Section.CourseID, Section.SectionID,
       Section.Semester, Section.StudyYear, NULL
FROM Student, Section
WHERE Student.DeptName = 'Comp. Sci.'
AND   Section.CourseID = 'CS-102';
```

## SELECT (basics — used in week 2 exercises)

```sql
-- All columns
SELECT * FROM Student;

-- Specific columns
SELECT StudName FROM Student;
SELECT StudName, TotCredits FROM Student;

-- With WHERE condition
SELECT StudName FROM Student
WHERE TotCredits > 100;

-- AND / OR  (AND has higher precedence than OR)
SELECT * FROM Student
WHERE DeptName = 'Comp. Sci.' AND TotCredits > 100;

SELECT * FROM Classroom
WHERE Capacity > 25 AND Capacity < 50
OR Building = 'Painter';

-- Not equal: != or <>
SELECT DeptName FROM Department
WHERE Building != 'Taylor';

-- Multi-table (implicit join via WHERE)
SELECT CourseId, StudyYear, Grade
FROM Student, Takes
WHERE Student.StudName = 'Shankar'
AND   Student.StudID = Takes.StudID;
```

## UPDATE

```sql
-- Update a single column
UPDATE Department
SET Building = 'Taylor'
WHERE DeptName = 'Finance';

-- Update multiple columns
UPDATE Instructor
SET Salary = Salary * 1.05,
    DeptName = 'Physics'
WHERE InstID = 10101;

-- Update all rows (no WHERE — be careful!)
UPDATE Instructor SET Salary = Salary * 1.10;
```

## DELETE

```sql
-- Delete specific rows
DELETE FROM Course
WHERE CourseID = 'CS-102' OR CourseID = 'CS-103';

-- Delete all rows (keeps table structure)
DELETE FROM Course;
```

## Full Example (WeekTwo schema)

```sql
CREATE DATABASE WeekTwo;
USE WeekTwo;

CREATE TABLE Person (
    DriverID   VARCHAR(10) PRIMARY KEY,
    DriverName VARCHAR(20),
    Address    VARCHAR(40)
);

CREATE TABLE Car (
    License  VARCHAR(10) PRIMARY KEY,
    Model    VARCHAR(30),
    ProdYear INT
);

CREATE TABLE Accident (
    ReportNumber VARCHAR(10) PRIMARY KEY,
    AccDate      VARCHAR(20),
    Location     VARCHAR(20)
);

CREATE TABLE Owns (
    DriverID VARCHAR(10),
    License  VARCHAR(10),
    PRIMARY KEY (DriverID, License),
    FOREIGN KEY (DriverID) REFERENCES Person(DriverID),
    FOREIGN KEY (License)  REFERENCES Car(License)
);

CREATE TABLE Participants (
    ReportNumber VARCHAR(10),
    License      VARCHAR(10),
    DriverID     VARCHAR(10),
    DamageAmount INT,
    PRIMARY KEY (ReportNumber, License),
    FOREIGN KEY (ReportNumber) REFERENCES Accident(ReportNumber),
    FOREIGN KEY (License)      REFERENCES Car(License),
    FOREIGN KEY (DriverID)     REFERENCES Person(DriverID)
);

-- Inserting data
INSERT Person VALUES('31262549', 'Hans Hansen', 'Jernbane Alle 74, 2720 Vanlose');
INSERT Car VALUES('JW46898', 'Honda Accord Aut. 2.0', 2001);
INSERT Accident VALUES('3004000121', '2015-06-18', '2605 Brondby');
INSERT Owns VALUES('31262549', 'JW46898');
INSERT Participants VALUES('3004000121', 'JW46898', '31262549', 6800);
```

## Referential Action Summary

| Action | DELETE parent row | UPDATE parent PK |
|--------|------------------|-----------------|
| `CASCADE` | child rows deleted | child FK updated |
| `SET NULL` | child FK set to NULL | child FK set to NULL |
| `RESTRICT` | error, rejected | error, rejected |
