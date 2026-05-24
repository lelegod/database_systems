USE universityDB;

DELIMITER //
CREATE FUNCTION BuildingCapacityFct (vBuilding VARCHAR(20)) RETURNS INT
BEGIN
	DECLARE vMaxCapacity INT;
    SELECT SUM(Capacity) INTO vMaxCapacity FROM Classroom
    WHERE vBuilding = Building;
    RETURN vMaxCapacity;
END //
DELIMITER ;
SELECT BuildingCapacityFct('Watson');
SELECT * FROM Classroom
WHERE Capacity > BuildingCapacityFct('Watson');
DROP FUNCTION BuildingCapacityFct;

CREATE FUNCTION timeoverlap
(vDayCode1 ENUM('M','T','W','R','F','S','U'),
vStartTime1 TIME,
vEndTime1 TIME,
vDayCode2 ENUM('M','T','W','R','F','S','U'),
vStartTime2 TIME,
vEndTime2 TIME
)
RETURNS BOOLEAN
RETURN vDayCode1 = vDayCode2 AND 
((vStartTime1 <= vStartTime2 AND vStartTime2 <= vEndTime1) OR
(vStartTime2 <= vStartTime1 AND vStartTime1 <= vEndTime2)
);
#testing timeoverlap function:
#different start
SELECT timeoverlap('M', '08:00:00', '08:50:00',
'T', '08:00:00', '08:50:00'); #should return 0
SELECT timeoverlap('M', '08:00:00', '08:50:00',
'M', '09:00:00', '09:50:00'); #should return 0
#same start
SELECT timeoverlap('M', '08:00:00', '08:50:00',
'M', '08:00:00', '08:40:00'); #should return 1
SELECT timeoverlap('M', '08:00:00', '08:50:00',
'M', '08:00:00', '08:40:00'); #should return 1
#first starts before second on the same day
SELECT timeoverlap('M', '08:00:00', '08:50:00',
'M', '08:10:00', '08:40:00'); #should return 1
SELECT timeoverlap('M', '08:00:00', '08:50:00',
'M', '08:10:00', '08:50:00'); #should return 1
SELECT timeoverlap('M', '08:00:00', '08:50:00',
'M', '08:10:00', '09:00:00'); #should return 1
#second starts before first on the same day
SELECT timeoverlap('M', '08:10:00', '08:40:00',
'M', '08:00:00', '08:50:00'); #should return 1
SELECT timeoverlap('M', '08:10:00', '08:50:00',
'M', '08:00:00', '08:50:00'); #should return 1
SELECT timeoverlap('M', '08:10:00', '09:00:00',
'M', '08:00:00', '08:50:00'); #should return 1

CREATE FUNCTION timeoverlapWithTable
(vTimeSlotID VARCHAR(4),
vDayCode ENUM('M','T','W','R','F','S','U'),
vStartTime TIME,
vEndTime TIME)
RETURNS BOOLEAN
RETURN EXISTS
(SELECT * FROM TimeSlot
WHERE TimeSlotID = vTimeSlotID AND 
timeoverlap(vDayCode, vStartTime, vEndTime, DayCode, StartTime, EndTime)
);
#testing timeoverlapWithTable function:
SELECT timeoverlapWithTable('A', 'M',
'08:10:00', '08:40:00'); #should return 1
SELECT timeoverlapWithTable('A', 'M',
'09:00:00', '09:50:00'); #should return 0
SELECT timeoverlapWithTable('A', 'T', '08:00:00',
'08:50:00'); #should return 0

DELIMITER //
CREATE PROCEDURE InsertTimeSlot
(IN vTimeSlotID VARCHAR(4),
IN vDayCode ENUM('M','T','W','R','F','S','U'),
IN vStartTime TIME,
IN vEndTime TIME)
BEGIN
	IF vEndTime <= vStartTime
    THEN SIGNAL SQLSTATE 'HY000'
		SET MYSQL_ERRNO = 1525,
		MESSAGE_TEXT = 'EndTime is equal to or before StartTime';
	END IF;
    IF timeoverlapWithTable(vTimeSlotID, vDayCode, vStartTime, vEndTime)
    THEN SIGNAL SQLSTATE 'HY000'
		SET MYSQL_ERRNO = 1525,
        MESSAGE_TEXT = 'time interval overlaps with existing timeinterval for the same TimeSlotID';
	END IF;
    INSERT TimeSlot VALUES (vTimeSlotID, vDayCode, vStartTime, vEndTime);
END //
DELIMITER ;
#testing procedure
SELECT * FROM TimeSlot; #
CALL InsertTimeSlot('A', 'T', '08:50:00',
'08:00:00'); # should give error message 'EndTime is equal to or before StartTime'
CALL InsertTimeSlot('A', 'M', '08:50:00',
'08:00:00'); # should give error message 'EndTime is equal to or before StartTime'
CALL InsertTimeSlot('A', 'M', '08:10:00',
'08:40:00'); # should give error message 'time interval overlaps with existing timeinterval for the same TimeSlotID'
SELECT * FROM TimeSlot; #no changes in TimeSlot
CALL InsertTimeSlot('A', 'T', '08:00:00',
'08:50:00'); # is succesfull
SELECT * FROM TimeSlot; #new timeslot is inserted

DELIMITER //
CREATE TRIGGER TimeSlot_Before_Insert
BEFORE INSERT ON TimeSlot FOR EACH ROW
BEGIN
	IF NEW.EndTime <= NEW.StartTime 
	THEN SIGNAL SQLSTATE 'HY000'
		SET MYSQL_ERRNO = 1525,
        MESSAGE_TEXT = 'EndTime is equal to or before StartTime';
	END IF;
    IF timeoverlapWithTable(NEW.TimeSlotID, NEW.DayCode, NEW.StartTime, NEW.EndTime)
	THEN SIGNAL SQLSTATE 'HY000'
		SET MYSQL_ERRNO = 1525,
        MESSAGE_TEXT = 'time interval overlaps with existing timeinterval for the same TimeSlotID';
	END IF;
END //
DELIMITER ;

INSERT TimeSlot VALUES ('A', 'R', '08:00:00',
'08:50:00'); #ok
INSERT TimeSlot VALUES ('A', 'T', '08:50:00',
'08:00:00'); # should give error message 'EndTime is equal to or before StartTime'
INSERT TimeSlot VALUES ('A', 'M', '08:50:00',
'08:00:00'); # should give error message 'EndTime is equal to or before StartTime'
INSERT TimeSlot VALUES ('A', 'M', '08:10:00',
'08:40:00'); #should give error message 'time interval overlaps with existing timeinterval for the same TimeSlotID'

CREATE TABLE IF NOT EXISTS BallRolls(
	RollNo INTEGER AUTO_INCREMENT PRIMARY KEY,
    LuckyNo INTEGER
);
SET GLOBAL event_scheduler = 1;
CREATE EVENT RollBall
ON SCHEDULE EVERY 10 SECOND
DO
INSERT BallRolls (LuckyNo) VALUES (FLOOR(36 * RAND()));
SET GLOBAL event_scheduler = 0;