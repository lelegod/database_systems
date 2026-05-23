# Week 9 – Relational Algebra ↔ SQL Cheat Sheet

## Basic Operations

| RA | SQL |
|----|-----|
| σ_{P}(R) | `SELECT * FROM R WHERE P` |
| Π_{A,B}(R) | `SELECT A, B FROM R` |
| R ∪ S | `(SELECT * FROM R) UNION (SELECT * FROM S)` |
| R − S | `(SELECT * FROM R) EXCEPT (SELECT * FROM S)` |
| R × S | `SELECT * FROM R, S` |
| ρ_S(R) | `SELECT * FROM R AS S` |
| ρ_{S(B1,B2)}(R(A1,A2)) | `SELECT A1 AS B1, A2 AS B2 FROM R AS S` |

## Derived Operations

| RA | SQL |
|----|-----|
| R ⋈ S | `SELECT * FROM R NATURAL JOIN S` |
| R ⟕ S | `SELECT * FROM R NATURAL LEFT OUTER JOIN S` |
| R ⟖ S | `SELECT * FROM R NATURAL RIGHT OUTER JOIN S` |
| R ⟗ S | `SELECT * FROM R NATURAL FULL OUTER JOIN S` |
| R ⋈_θ S | `SELECT * FROM R JOIN S ON θ` |
| R ∩ S | `(SELECT * FROM R) INTERSECT (SELECT * FROM S)` |
| S ← R | `CREATE TABLE S SELECT * FROM R` |

## Extended Operations

| RA | SQL |
|----|-----|
| Π_{E1,E2,…}(R) | `SELECT E1, E2, … FROM R` |
| G_{AVG(Salary)}(Instructor) | `SELECT AVG(Salary) FROM Instructor` |
| DeptName G_{MAX(Salary)}(Instructor) | `SELECT DeptName, MAX(Salary) FROM Instructor GROUP BY DeptName` |

## Complete Query Translation Examples

```sql
-- RA: Π_{InstName, InstID}(Instructor)
SELECT InstName, InstID FROM Instructor;

-- RA: σ_{DeptName='Physics' ∧ Salary>90000}(Instructor)
SELECT * FROM Instructor
WHERE DeptName = 'Physics' AND Salary > 90000;

-- RA: Π_{InstName, InstID}(Instructor) ∪ Π_{StudName, StudID}(Student)
(SELECT InstName AS name, InstID AS id FROM Instructor)
UNION
(SELECT StudName AS name, StudID AS id FROM Student);

-- RA: Π_{InstID}(Instructor) − Π_{InstID}(Teaches)
(SELECT InstID FROM Instructor)
EXCEPT
(SELECT InstID FROM Teaches);

-- RA: Π_{InstName, CourseID}(Instructor ⋈ Teaches)
SELECT InstName, CourseID
FROM   Instructor NATURAL JOIN Teaches;

-- RA: Π_{StudName, InstID}(Student ⟕ Advisor)
SELECT StudName, InstID
FROM   Student NATURAL LEFT OUTER JOIN Advisor;

-- RA: DeptName G_{MAX(Salary), AVG(Salary)}(Instructor)
SELECT DeptName, MAX(Salary), AVG(Salary)
FROM   Instructor
GROUP BY DeptName;
```

## Full SQL Query Semantics

```
SELECT A1,…,An FROM R1,…,Rm WHERE P
≡  Π_{A1,…,An}( σ_P( R1 × … × Rm ) )
```
