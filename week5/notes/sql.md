# Week 5 – Advanced SQL Cheat Sheet

## DELIMITER (required before multi-statement programs)

```sql
DELIMITER //
-- ... procedure/function/trigger body ...
DELIMITER ;
```

## Functions

```sql
DELIMITER //
CREATE FUNCTION func_name(param1 INT, param2 VARCHAR(50))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE result DECIMAL(10,2);
    SET result = param1 * 1.1;
    RETURN result;
END //
DELIMITER ;

-- Call in a query:
SELECT func_name(salary, name) FROM Instructor;

-- Drop:
DROP FUNCTION func_name;
```

## Procedures

```sql
DELIMITER //
CREATE PROCEDURE proc_name(IN dept VARCHAR(30), OUT avg_sal DECIMAL(10,2))
BEGIN
    SELECT AVG(salary) INTO avg_sal
    FROM   Instructor
    WHERE  DeptName = dept;
END //
DELIMITER ;

-- Call:
CALL proc_name('Physics', @result);
SELECT @result;

-- Drop:
DROP PROCEDURE proc_name;
```

## Triggers

```sql
DELIMITER //
CREATE TRIGGER check_salary
BEFORE INSERT ON Instructor
FOR EACH ROW
BEGIN
    IF NEW.Salary < 0 THEN
        SET NEW.Salary = 0;
    END IF;
END //
DELIMITER ;

-- Show triggers:
SHOW TRIGGERS;

-- Drop:
DROP TRIGGER check_salary;
```

## Control Flow (inside BEGIN...END)

```sql
-- IF
IF salary > 100000 THEN
    SET bonus = salary * 0.10;
ELSEIF salary > 50000 THEN
    SET bonus = salary * 0.05;
ELSE
    SET bonus = 0;
END IF;

-- CASE
CASE grade
    WHEN 'A' THEN SET points = 4;
    WHEN 'B' THEN SET points = 3;
    ELSE           SET points = 0;
END CASE;

-- WHILE
WHILE i <= 10 DO
    SET total = total + i;
    SET i = i + 1;
END WHILE;

-- REPEAT ... UNTIL
REPEAT
    SET i = i + 1;
UNTIL i > 10 END REPEAT;

-- LOOP with LEAVE
my_loop: LOOP
    SET i = i + 1;
    IF i > 10 THEN LEAVE my_loop; END IF;
END LOOP my_loop;
```

## Transactions

```sql
START TRANSACTION;
    UPDATE Account SET balance = balance - 500 WHERE id = 1;
    UPDATE Account SET balance = balance + 500 WHERE id = 2;
COMMIT;

-- Undo all changes:
ROLLBACK;
```

## Events (scheduled SQL)

```sql
CREATE EVENT daily_cleanup
ON SCHEDULE EVERY 1 DAY
DO DELETE FROM Log WHERE created_at < NOW() - INTERVAL 30 DAY;
```
