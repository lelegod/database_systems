USE universityDB;

SELECT MAX(Salary) FROM Instructor;

SELECT InstID, InstName FROM Instructor
WHERE Salary = (SELECT MAX(Salary) FROM Instructor);

DELETE FROM Takes
WHERE CourseID IN ('BIO-101', 'BIO-301');

SELECT StudID FROM Student
WHERE StudID NOT IN (SELECT StudID FROM Takes);

SELECT DeptName FROM Department
WHERE Budget >= ALL (SELECT Budget FROM Department);

SELECT StudName FROM Student
WHERE StudName = SOME (SELECT InstName FROM Instructor);

SELECT StudName
FROM Student, Instructor
WHERE StudName = InstName;

CREATE TABLE GradePoints (
Grade VARCHAR(2),
Points DECIMAL(3,1),
PRIMARY KEY (Grade)
);

INSERT GradePoints VALUES
('A', 4.0), ('A-', 3.7), ('B+', 3.3), ('B', 3.0), ('B-', 2.7),
('C+', 2.3), ('C', 2.0), ('C-', 1.7), ('D+', 1.3), ('D', 1.0),
('D-', 0.7), ('F', 0.0);

SELECT StudID, SUM(Credits * Points)
FROM (Takes NATURAL JOIN Course)
NATURAL JOIN GradePoints
GROUP BY StudID;

SELECT StudID, SUM(Credits * Points) / SUM(Credits) AS GPA
FROM (Takes NATURAL JOIN Course)
NATURAL JOIN GradePoints
GROUP BY StudID
ORDER BY GPA DESC;

(SELECT StudID, SUM(Credits * Points)
FROM (Takes NATURAL JOIN Course)
NATURAL JOIN GradePoints
GROUP BY StudID
)
UNION 
(SELECT StudID, 0 AS GPA
FROM Student
WHERE StudID NOT IN (SELECT StudID FROM Takes)
);

(SELECT StudID, SUM(Credits * Points) / SUM(Credits) AS GPA
FROM (Takes NATURAL JOIN Course)
NATURAL JOIN GradePoints
GROUP BY StudID
ORDER BY GPA DESC)
UNION
(SELECT StudID, 0 AS GPA
FROM Student
WHERE StudID NOT IN (SELECT StudID FROM Takes)
);

DROP TABLE IF EXISTS Testscores;
CREATE TABLE Testscores(
Student VARCHAR(20) NOT NULL,
Test VARCHAR(20) NOT NULL,
Score INT,
PRIMARY KEY (Student, test) 
);
INSERT Testscores values
('Brandt', 'A', 47), ('Brandt', 'B', 50),
('Brandt', 'C', NULL), ('Brandt', 'D', NULL),
('Chavez', 'A', 52), ('Chavez', 'B', 45),
('Chavez', 'C', 53), ('Chavez', 'D', NULL);
SELECT * FROM Testscores;
SELECT Student, MAX(Score) FROM Testscores
GROUP BY Student
HAVING AVG(Score) > 49;

SELECT DISTINCT Student FROM Testscores
WHERE Score IS NULL;
