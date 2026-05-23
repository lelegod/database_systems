USE universityDB;

SELECT DeptName, COUNT(InstID)
FROM Department NATURAL LEFT JOIN Instructor
GROUP BY DeptName;

SELECT DISTINCT Title
FROM Course JOIN PreReq ON PreReq.PreReqID = Course.CourseID;

SELECT Course.CourseID, COUNT(PreReqID) AS Number
FROM Course LEFT JOIN PreReq ON PreReq.PreReqID = Course.CourseID
GROUP BY CourseID;

SELECT StudName, Title
FROM (Takes NATURAL JOIN Student) JOIN Course USING (CourseID)
ORDER BY StudName;

CREATE VIEW SeniorInstructors(InstID, InstName, DeptName) AS
SELECT InstID, InstName, DeptName FROM Instructor
WHERE Salary > 80000;
SELECT * FROM SeniorInstructors;


DROP USER 'Karen'@'localhost';
DROP USER 'Linda'@'localhost';
DROP USER 'Susan'@'localhost';
CREATE USER 'Karen'@'%'
IDENTIFIED BY 'SetPassword';
CREATE USER 'Linda'@'%'
IDENTIFIED BY 'SetPassword';
CREATE USER 'Susan'@'%'
IDENTIFIED BY 'SetPassword';
SELECT user FROM mysql.user;

GRANT SELECT ON universityDB.* TO 'Karen'@'%';
GRANT ALL ON University.* TO 'Linda'@'%';
GRANT ALL ON University.* TO 'Susan'@'%';
SHOW GRANTS FOR 'Karen'@'%';
SHOW GRANTS FOR 'Linda'@'%';
SHOW GRANTS FOR 'Susan'@'%';

DROP USER 'Karen'@'%';
DROP USER 'Linda'@'%';
DROP USER 'Susan'@'%';

SELECT user FROM mysql.user;

