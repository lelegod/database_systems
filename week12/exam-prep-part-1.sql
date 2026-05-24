-- In next line, insert your student ID after the colon.
-- Student ID: s252786

-- Below, you must at most make one SQL query for each question. If you make several, they will be ignored.

USE PetShelters;

-- -----------------------------------------------------------------------------------------------------
-- q1: Answer to question 1 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
SELECT breed, AVG(age)
FROM Pet LEFT JOIN Shelter USING (ShelterID)
WHERE City = 'Lyngby'
GROUP BY breed;
-- -----------------------------------------------------------------------------------------------------
-- q2: Answer to question 2 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
SELECT personName
FROM Pet JOIN Person ON Person.personName = Pet.petName;
-- -----------------------------------------------------------------------------------------------------
-- q3: Answer to question 3 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
SELECT petName, COUNT(personname) AS numReservations
FROM Pet NATURAL LEFT JOIN reservedFor
GROUP BY petName
ORDER BY numReservations DESC;
-- -----------------------------------------------------------------------------------------------------
-- q4: Answer to question 4 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
DELIMITER //
CREATE TRIGGER reservedFor_Before_Insert
BEFORE INSERT ON reservedFor FOR EACH ROW
BEGIN
	IF NEW.reservedDate > NOW()
	THEN SIGNAL SQLSTATE 'HY000'
		SET MYSQL_ERRNO = 1525,
        MESSAGE_TEXT = 'reservedDate is in the future';
	END IF;
END //
DELIMITER ; 
-- -----------------------------------------------------------------------------------------------------
-- q5: Answer to question 5 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------
INSERT reservedFor VALUES ('Dorit', 'Dorit', '2027-01-13 00:00:00')