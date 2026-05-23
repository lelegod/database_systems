# Week 5 – Advanced SQL Cheat Sheet

## DELIMITER (required before multi-statement programs)

```sql
DELIMITER //
-- ... procedure/function/trigger body ...
DELIMITER ;
```

## Functions

```sql
-- Returns DECIMAL
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

-- Returns INT (SELECT ... INTO variable inside function)
DELIMITER //
CREATE FUNCTION BuildingCapacityFct(vBuilding VARCHAR(20))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE vMaxCapacity INT;
    SELECT SUM(Capacity) INTO vMaxCapacity
    FROM Classroom WHERE Building = vBuilding;
    RETURN vMaxCapacity;
END //
DELIMITER ;

-- Returns BOOLEAN, single-expression (no BEGIN/END needed)
DELIMITER //
CREATE FUNCTION IsExpensive(vSalary DECIMAL(10,2))
RETURNS BOOLEAN DETERMINISTIC
RETURN vSalary > 90000 //
DELIMITER ;

-- Call in a query / WHERE clause:
SELECT func_name(salary, name) FROM Instructor;
SELECT * FROM Classroom WHERE Capacity > BuildingCapacityFct('Watson');

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
-- Trigger that modifies NEW value
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

-- Trigger that REJECTS an invalid insert using SIGNAL
DELIMITER //
CREATE TRIGGER TimeSlot_Before_Insert
BEFORE INSERT ON TimeSlot
FOR EACH ROW
BEGIN
    IF NEW.EndTime <= NEW.StartTime THEN
        SIGNAL SQLSTATE 'HY000'
            SET MYSQL_ERRNO = 1525,
                MESSAGE_TEXT = 'EndTime is equal to or before StartTime';
    END IF;
END //
DELIMITER ;

-- Show triggers:
SHOW TRIGGERS;

-- Drop:
DROP TRIGGER check_salary;
```

### SIGNAL — raise an error inside any stored program

```sql
SIGNAL SQLSTATE 'HY000'
    SET MYSQL_ERRNO = 1525,
        MESSAGE_TEXT = 'Your custom error message here';
```
Use `SIGNAL` inside triggers, procedures, or functions to abort the operation and return an error to the caller.

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
-- Enable the event scheduler
SET GLOBAL event_scheduler = 1;

-- One-time cleanup
CREATE EVENT daily_cleanup
ON SCHEDULE EVERY 1 DAY
DO DELETE FROM Log WHERE created_at < NOW() - INTERVAL 30 DAY;

-- Random insert every 10 seconds
CREATE EVENT RollBall
ON SCHEDULE EVERY 10 SECOND
DO INSERT BallRolls (LuckyNo) VALUES (FLOOR(37 * RAND()));
```

## AUTO_INCREMENT

```sql
CREATE TABLE BallRolls (
    RollNo  INTEGER AUTO_INCREMENT PRIMARY KEY,
    LuckyNo INTEGER
);
-- RollNo is assigned automatically: 1, 2, 3, …
-- INSERT only needs to provide LuckyNo:
INSERT BallRolls (LuckyNo) VALUES (FLOOR(37 * RAND()));
```
