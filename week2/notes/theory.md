# Week 2 – Introductory SQL: DDL (Theory)

## DDL vs DML vs DQL

| Category | Purpose | Key Statements |
|----------|---------|---------------|
| **DDL** (Data Definition Language) | Define/modify structure | `CREATE`, `DROP`, `ALTER` |
| **DML** (Data Manipulation Language) | Modify data | `INSERT`, `UPDATE`, `DELETE` |
| **DQL** (Data Query Language) | Query data | `SELECT` |

## Data Types (MariaDB/MySQL)

| Type | Usage |
|------|-------|
| `INT` | Integer numbers |
| `DECIMAL(p, d)` | Exact fixed-point; p = total digits, d = decimal places |
| `FLOAT` / `DOUBLE` | Approximate floating-point |
| `VARCHAR(n)` | Variable-length string, max n characters |
| `CHAR(n)` | Fixed-length string, exactly n characters |
| `DATE` | Date (YYYY-MM-DD) |
| `DATETIME` | Date + time |

## Integrity Constraints

| Constraint | Effect |
|-----------|--------|
| `NOT NULL` | Column cannot hold NULL |
| `PRIMARY KEY` | Unique + NOT NULL; at most one per table |
| `FOREIGN KEY ... REFERENCES` | Referential integrity |
| `UNIQUE` | All values must be distinct (NULLs are allowed) |
| `CHECK(predicate)` | Value must satisfy the predicate |

## Referential Actions (ON DELETE / ON UPDATE)

| Action | Behaviour |
|--------|-----------|
| `RESTRICT` / `NO ACTION` | Reject the delete/update if dependent rows exist |
| `CASCADE` | Propagate delete/update to dependent rows |
| `SET NULL` | Set FK to NULL in dependent rows |
| `SET DEFAULT` | Set FK to its default value in dependent rows |

## Schema Design Rules (from Week 1)

- Choose one **candidate key** as the **primary key**
- Foreign keys reference primary keys in other tables
- All attribute values should be **atomic** (1NF)
