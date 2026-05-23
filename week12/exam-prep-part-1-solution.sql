USE PetShelters;

-- -----------------------------------------------------------------------------------------------------
-- q1: Answer to question 1 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
SELECT breed, AVG(age) FROM Pet p JOIN Shelter s ON p.shelterId=s.shelterId WHERE s.city='Lyngby' GROUP BY breed;

-- -----------------------------------------------------------------------------------------------------
-- q2: Answer to question 2 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
SELECT personName FROM Person p WHERE p.personName IN (SELECT DISTINCT petName FROM Pet);
-- Alternative solution
SELECT personName FROM Person INTERSECT SELECT petName FROM Pet;

-- -----------------------------------------------------------------------------------------------------
-- q3: Answer to question 3 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
SELECT p.petName, COUNT(r.petName) AS numReservations 
FROM Pet p LEFT OUTER JOIN reservedFor r 
	ON p.petName=r.petName 
GROUP BY p.petName 
ORDER BY numReservations DESC;

-- -----------------------------------------------------------------------------------------------------
-- q4: Answer to question 4 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
DELIMITER //
CREATE TRIGGER reservedFor_BeforeInsert BEFORE INSERT ON reservedFor
FOR EACH ROW
BEGIN
	IF NEW.reservedDate > NOW() THEN 
		SIGNAL SQLSTATE 'HY000'
        SET MYSQL_ERRNO=1525, MESSAGE_TEXT='Can not make a reservation in the future.';
    END IF;
END;
//
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------
-- q5: Answer to question 5 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
INSERT INTO reservedFor VALUES('Tim', 'Remy', '2027-02-14');