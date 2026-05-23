USE universityDB;

SELECT CourseID, SectionID, Count(StudID)
FROM Takes
WHERE Semester = 'Fall' AND StudyYear = 2009
GROUP BY CourseID, SectionID;

SELECT Title, SUM(Credits)
FROM Instructor
	NATURAL JOIN Teaches
	NATURAL JOIN Course
WHERE InstName = 'Brandt'
GROUP BY Title;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM Course
WHERE CourseID NOT IN
(Select CourseID FROM Section);
SET SQL_SAFE_UPDATES = 1;