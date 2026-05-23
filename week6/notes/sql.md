# Week 6 – ER to SQL Conversion Cheat Sheet

## ER → SQL Mapping Rules

### 1. Strong Entity Set → Table

```sql
-- ER: Student(StudID, name, email)
CREATE TABLE Student (
    StudID  INT          PRIMARY KEY,
    name    VARCHAR(50)  NOT NULL,
    email   VARCHAR(100)
);
```

### 2. Many-to-Many Relationship → New Table

```sql
-- ER: Student —Enrolls— Course  (many-to-many)
-- Relationship may have its own attribute: grade
CREATE TABLE Enrolls (
    StudID    INT,
    CourseID  VARCHAR(10),
    grade     CHAR(2),
    PRIMARY KEY (StudID, CourseID),
    FOREIGN KEY (StudID)   REFERENCES Student(StudID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
```

### 3. Many-to-One Relationship → FK in the "many" table

```sql
-- ER: Instructor →(works_in)— Department  (many-to-one)
-- Add DeptName FK to Instructor, no separate table
CREATE TABLE Instructor (
    InstID    INT          PRIMARY KEY,
    InstName  VARCHAR(50),
    DeptName  VARCHAR(30),
    FOREIGN KEY (DeptName) REFERENCES Department(DeptName)
        ON DELETE SET NULL
);
```

### 4. One-to-One Relationship → FK on either side

```sql
-- ER: Employee →(manages)→ Department  (one-to-one)
CREATE TABLE Department (
    DeptName  VARCHAR(30) PRIMARY KEY,
    ManagerID INT UNIQUE,
    FOREIGN KEY (ManagerID) REFERENCES Employee(EmpID)
        ON DELETE SET NULL
);
```

### 5. Multivalued Attribute → Separate Table

```sql
-- ER: Instructor has multivalued attribute {phone}
CREATE TABLE InstructorPhone (
    InstID  INT,
    phone   VARCHAR(20),
    PRIMARY KEY (InstID, phone),
    FOREIGN KEY (InstID) REFERENCES Instructor(InstID)
        ON DELETE CASCADE
);
```

### 6. Weak Entity Set → Table with owner's PK

```sql
-- ER: Section (weak) identified by Course (owner)
--     discriminator = (sec_id, semester, year)
CREATE TABLE Section (
    CourseID  VARCHAR(10),
    sec_id    INT,
    semester  ENUM('Fall','Spring','Summer'),
    year      INT,
    room      VARCHAR(10),
    PRIMARY KEY (CourseID, sec_id, semester, year),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
        ON DELETE CASCADE
);
```

## Relation Schema Text Notation (exam style)

On exams you often write schemas in shorthand, not SQL. Underline the primary key attributes.

```
Clients(CID, Firstname, Lastname, Street, SNo, Birth)
         ---

Cars(Plate, Model, Color, PYear, CID, StartDate)
     -----                        ^^^-- FK to Clients

Transaction(TransactionNo, ATM_ID, Amount)
            ------------------------------ composite PK
            ATM_ID is also FK to ATM(ATM_ID)
```

**Rule:** If a many-to-one relationship has its own attribute (e.g., StartDate), put that attribute AND the FK in the "many" table — no separate relationship table needed.

```
-- ER: Client —[Owns (StartDate)]→ Car  (many-to-one)
-- Result: StartDate and CID (FK) go in the Cars table
Cars(Plate, Model, Color, PYear, CID, StartDate)
```

## Quick Reference: Which table gets the FK?

| Relationship | FK placement |
|-------------|-------------|
| Many-to-many | New table (both PKs as composite PK + FK) |
| Many-to-one | FK in the "many" entity's table |
| One-to-one | FK in either table (choose the optional side) |
| Weak entity | FK to owner's PK + include in PK |
| Multivalued attr | New table: (entity PK, attribute value) |
