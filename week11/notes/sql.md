# Week 11 – Indexing & Hashing SQL Cheat Sheet

## Create an Index

```sql
-- Basic syntax
CREATE [UNIQUE] INDEX index_name ON table_name (col1, col2, ...);

-- Examples
CREATE INDEX NameIndex ON Instructor(InstName);
CREATE UNIQUE INDEX EmailIndex ON Student(email);

-- Multi-column index
CREATE INDEX DeptSalary ON Instructor(DeptName, Salary);
```

## Specify Index Type

```sql
-- B+ Tree index (default in MariaDB/MySQL InnoDB)
CREATE INDEX NameIndex ON Instructor(InstName) USING BTREE;

-- Hash index (only in MEMORY storage engine in MariaDB)
CREATE INDEX NameIndex ON Instructor(InstName) USING HASH;
```

**MariaDB/MySQL default:** BTREE when no type is specified.  
**Auto-created:** Primary index on PRIMARY KEY + secondary indexes on all FOREIGN KEY columns.

## Drop an Index

```sql
DROP INDEX index_name ON table_name;

-- Example
DROP INDEX NameIndex ON Instructor;
```

## Show Indexes on a Table

```sql
SHOW INDEX FROM table_name;

-- Example
SHOW INDEX FROM Instructor;
```

## Practical Notes

| Scenario | Recommendation |
|---------|---------------|
| Primary key lookups | Automatic — no action needed |
| Frequent WHERE on a column | Add an index on that column |
| Frequent range queries (BETWEEN, >, <) | BTREE index |
| Frequent exact-match queries (=) | HASH index (if supported) |
| Composite WHERE conditions | Multi-column index matching the WHERE order |
| INSERT/UPDATE/DELETE heavy | Fewer indexes = faster writes |

## Examples

```sql
-- Index to speed up: SELECT * FROM Instructor WHERE DeptName = 'Physics'
CREATE INDEX DeptIndex ON Instructor(DeptName);

-- Unique index to enforce unique email
CREATE UNIQUE INDEX EmailIdx ON Student(email);

-- Show what indexes exist
SHOW INDEX FROM Instructor;

-- Remove an index no longer needed
DROP INDEX DeptIndex ON Instructor;
```

## Hash Function in SQL

```sql
-- Compute which bucket a key would go into (h(K) = K % 4)
SELECT StudID, StudID % 4 AS bucket FROM Student;
SELECT StudID, MOD(StudID, 4) AS bucket FROM Student;   -- same thing

-- Find all records that hash to bucket 1
SELECT * FROM Student WHERE StudID % 4 = 1;
```

## Index Types Summary

| Type | Dense/Sparse | Primary/Secondary |
|------|-------------|------------------|
| Dense on PK | Dense | Primary |
| Sparse on PK | Sparse | Primary |
| Dense on non-key attr | Dense | Primary or Secondary |
| Secondary on any attr | Dense | Secondary |
| B+ tree | Dense (leaves) | Both |
| Hash | Dense | Both |
