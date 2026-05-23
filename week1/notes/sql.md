# Week 1 – Relational Model → SQL Mapping

## Database Basics

```sql
-- Create a database
CREATE DATABASE university;

-- Select / switch to a database
USE university;

-- Show all databases
SHOW DATABASES;

-- Show all tables in current database
SHOW TABLES;

-- Describe a table's columns
DESCRIBE Instructor;
DESC Instructor;          -- shorthand

-- Drop a database (careful — deletes everything inside)
DROP DATABASE university;

-- Drop a table
DROP TABLE Instructor;

-- Remove all rows but keep the table structure
TRUNCATE TABLE Instructor;
```

Week 1 is pre-SQL theory, but every concept maps directly to SQL.

## Relational Model → SQL Correspondence

| Relational Model | SQL |
|-----------------|-----|
| Relation | Table |
| Relation schema R(A1,…,An) | `CREATE TABLE R (A1 ..., An ...)` |
| Tuple | Row |
| Attribute | Column |
| Domain | Data type (`INT`, `VARCHAR`, `DECIMAL`, …) |
| Primary key | `PRIMARY KEY (col)` |
| Foreign key | `FOREIGN KEY (col) REFERENCES T(col)` |

## Key Concepts in SQL Terms

```sql
-- A relation schema: Instructor(InstID, InstName, DeptName, Salary)
-- is declared in SQL as:
CREATE TABLE Instructor (
    InstID    INT          PRIMARY KEY,
    InstName  VARCHAR(50)  NOT NULL,
    DeptName  VARCHAR(30),
    Salary    DECIMAL(10,2)
);

-- A foreign key (referential integrity):
CREATE TABLE Teaches (
    InstID    INT,
    CourseID  VARCHAR(10),
    PRIMARY KEY (InstID, CourseID),
    FOREIGN KEY (InstID) REFERENCES Instructor(InstID)
);
```

## Notes

- **Superkey:** any set of columns that, combined, are unique across all rows
- **Candidate key:** a superkey with no redundant columns — could be any `UNIQUE NOT NULL` column set
- **Primary key:** the one candidate key you declare with `PRIMARY KEY`
- SQL tables allow NULL by default; relational model theoretically does not (NULLs are a SQL extension)
