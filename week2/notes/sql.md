# Week 2 – DDL SQL Cheat Sheet

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

## DROP TABLE

```sql
DROP TABLE TableName;
```

## Common Data Types

```sql
INT                 -- integer
DECIMAL(10, 2)      -- 10 digits total, 2 after decimal
VARCHAR(50)         -- up to 50 characters
CHAR(5)             -- exactly 5 characters
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

-- Table-level (composite keys / FK)
PRIMARY KEY (col1, col2)
FOREIGN KEY (deptID) REFERENCES Department(deptID)
    ON DELETE SET NULL
    ON UPDATE CASCADE
```

## Full Example

```sql
CREATE TABLE Department (
    DeptName  VARCHAR(30)   PRIMARY KEY,
    Building  VARCHAR(20),
    Budget    DECIMAL(12,2) NOT NULL
);

CREATE TABLE Instructor (
    InstID    INT           PRIMARY KEY,
    InstName  VARCHAR(50)   NOT NULL,
    DeptName  VARCHAR(30),
    Salary    DECIMAL(10,2),
    FOREIGN KEY (DeptName) REFERENCES Department(DeptName)
        ON DELETE SET NULL
);
```

## Referential Action Summary

| Action | DELETE parent row | UPDATE parent PK |
|--------|------------------|-----------------|
| `CASCADE` | child rows deleted | child FK updated |
| `SET NULL` | child FK set to NULL | child FK set to NULL |
| `RESTRICT` | error, rejected | error, rejected |
