# Week 4 – Intermediate SQL (Theory)

## JOIN Types

| JOIN | Returns |
|------|---------|
| **INNER JOIN** / **JOIN** | Only matching rows from both tables |
| **NATURAL JOIN** | INNER JOIN on all same-named columns; removes duplicate columns |
| **LEFT OUTER JOIN** | All left rows + matching right rows (unmatched right = NULL) |
| **RIGHT OUTER JOIN** | All right rows + matching left rows (unmatched left = NULL) |
| **FULL OUTER JOIN** | All rows from both; NULLs where no match *(not in MariaDB/MySQL)* |
| **CROSS JOIN** | Cartesian product (every row with every row) |

## JOIN Conditions

| Syntax | Meaning |
|--------|---------|
| `R NATURAL JOIN S` | Join on all common attribute names, merge duplicates |
| `R JOIN S USING (A1, ..., An)` | Join on specified common columns, merge duplicates |
| `R JOIN S ON predicate` | Join on explicit condition, keeps both copies of join cols |

## FULL OUTER JOIN workaround (MariaDB/MySQL)

```sql
-- FULL OUTER JOIN is NOT supported in MariaDB/MySQL
-- Use UNION of LEFT and RIGHT:
(SELECT * FROM R LEFT OUTER JOIN S ON R.id = S.id)
UNION
(SELECT * FROM R RIGHT OUTER JOIN S ON R.id = S.id);
```

## Views

- A **view** is a named query stored in the database; it behaves like a virtual table
- The underlying data is not copied — each access re-runs the query
- Updatable only if the view maps to a single base table without aggregates

## Authorization (GRANT / REVOKE)

| Privilege | Allows |
|----------|--------|
| `SELECT` | Query the table/view |
| `INSERT` | Insert new rows |
| `UPDATE` | Modify existing rows |
| `DELETE` | Delete rows |
| `ALL PRIVILEGES` | All of the above |

- `WITH GRANT OPTION` lets the grantee re-grant privileges
- `GRANT OPTION FOR` can be used to revoke only the ability to grant

## Integrity Constraints (additional)

| Constraint | Notes |
|-----------|-------|
| `NOT NULL` | Column cannot be NULL |
| `PRIMARY KEY` | Unique + NOT NULL, at most one per table |
| `FOREIGN KEY` | Referential integrity |
| `ENUM('v1','v2',...)` | Column value must be one of the listed strings |
| `CHECK(cond)` | Row-level condition |
