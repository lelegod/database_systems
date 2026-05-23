# Week 5 – Advanced SQL / Programming (Theory)

## Procedural Extensions

SQL (MariaDB/MySQL) adds procedural constructs inside stored programs (functions, procedures, triggers).

## Control Flow

| Statement | Syntax sketch |
|-----------|--------------|
| IF | `IF cond THEN ... ELSEIF cond THEN ... ELSE ... END IF;` |
| CASE | `CASE WHEN cond THEN ... ELSE ... END CASE;` |
| LOOP | `label: LOOP ... LEAVE label; END LOOP label;` |
| WHILE | `WHILE cond DO ... END WHILE;` |
| REPEAT | `REPEAT ... UNTIL cond END REPEAT;` |
| LEAVE | Break out of a loop |
| ITERATE | Continue to next iteration (like `continue`) |

## Variables

```sql
DECLARE var_name datatype [DEFAULT value];
SET var_name = expression;
```

## Functions vs Procedures

| Feature | FUNCTION | PROCEDURE |
|---------|---------|-----------|
| Returns | A single value (`RETURNS type`) | Nothing (uses OUT params) |
| Called in | SELECT, expressions | `CALL` statement |
| Parameters | IN only (typically) | `IN`, `OUT`, `INOUT` |

## Triggers

- Automatically executed (fired) when a specified DML event occurs on a table
- `BEFORE` triggers can validate/modify data before it is written
- `AFTER` triggers act on data after it has been committed to the table
- `OLD.col` = the old value (available in UPDATE, DELETE)
- `NEW.col` = the new value (available in INSERT, UPDATE)

## Transactions

- A **transaction** is a sequence of SQL statements treated as a single unit
- Properties: **ACID** (Atomicity, Consistency, Isolation, Durability)
- Either all statements commit or all are rolled back
- `START TRANSACTION` / `COMMIT` / `ROLLBACK`

## DELIMITER

- MariaDB uses `;` as statement terminator — conflicts with procedure bodies
- Change the delimiter for multi-statement programs:
  ```sql
  DELIMITER //
  CREATE PROCEDURE ... BEGIN ... END //
  DELIMITER ;
  ```

## Database Access APIs

| API | Language | Notes |
|-----|---------|-------|
| **JDBC** | Java | `DriverManager.getConnection(...)`, `Statement`, `ResultSet` |
| **ODBC** | C/C++ (and others) | Platform-independent SQL API |
| **Embedded SQL** | C, COBOL | SQL mixed into host language, preprocessed |
