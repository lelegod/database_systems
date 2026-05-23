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

-- Filter rows first, then group
SELECT dept, COUNT(*) AS cnt
FROM   Instructor
WHERE  salary > 50000
GROUP BY dept
HAVING COUNT(*) > 2
ORDER BY cnt DESC;
```

## SELECT Clause Extras

```sql
SELECT DISTINCT dept FROM Instructor;         -- remove duplicates
SELECT InstID, salary * 1.1 AS new_sal        -- arithmetic expression
FROM   Instructor;
SELECT * FROM Instructor;                      -- all columns
```
