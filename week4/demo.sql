USE universityDB;

SELECT StudID, StudName, DeptName, Building
FROM Student NATURAL JOIN Department
ORDER BY StudID;

SELECT InstID, InstName, COUNT(SectionID) AS SectionTought
FROM Instructor NATURAL LEFT OUTER JOIN Teaches
GROUP BY InstID, InstName;

SELECT InstID, InstName, (SELECT COUNT(*) FROM Teaches WHERE Teaches.InstID = Instructor.InstID) AS SectionTought
FROM Instructor;

CREATE VIEW SeniorStudents AS
SELECT StudID, StudName FROM Student
WHERE TotCredits > 100;
SELECT * FROM SeniorStudents;

DROP VIEW IF EXISTS CreditView;
CREATE VIEW CreditView(StudyYear, SumCredits) AS
SELECT StudyYear, SUM(Credits)
FROM Takes NATURAL JOIN Course
GROUP BY StudyYear;
SELECT * FROM CreditView;


