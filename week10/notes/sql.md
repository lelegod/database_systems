# Week 10 – Normalization SQL Cheat Sheet

Normalization is a design process, not a set of SQL keywords. The result is reflected in how you write `CREATE TABLE` statements.

## Identifying a Violation and Fixing It

### The Problem: Combined table (not normalized)

```sql
-- Bad design: InstructorDept combines Instructor + Department info
-- DeptBuilding and DeptBudget repeat for every instructor in the same dept
CREATE TABLE InstructorDept (
    InstID       INT          PRIMARY KEY,
    InstName     VARCHAR(50),
    DeptName     VARCHAR(30),
    DeptBuilding VARCHAR(30),  -- redundant
    DeptBudget   DECIMAL(12,2) -- redundant
);
-- FD: DeptName → DeptBuilding, DeptBudget  (violates 3NF: transitive dependency)
```

### The Fix: Decompose into two tables

```sql
CREATE TABLE Instructor (
    InstID    INT          PRIMARY KEY,
    InstName  VARCHAR(50)  NOT NULL,
    DeptName  VARCHAR(30),
    FOREIGN KEY (DeptName) REFERENCES Department(DeptName)
        ON DELETE SET NULL
);

CREATE TABLE Department (
    DeptName  VARCHAR(30)   PRIMARY KEY,
    Building  VARCHAR(30),
    Budget    DECIMAL(12,2) NOT NULL
);
-- Join them back with:
-- SELECT i.InstID, i.InstName, d.Building, d.Budget
-- FROM Instructor i JOIN Department d ON i.DeptName = d.DeptName;
```

---

## 2NF Violation Example (partial dependency)

```sql
-- Bad: OrderItem has {OrderNo, ItemNo} as PK
-- ItemPrice depends only on ItemNo (partial dependency → violates 2NF)
CREATE TABLE OrderItem_BAD (
    OrderNo   INT,
    ItemNo    INT,
    Qty       INT,
    ItemPrice DECIMAL(10,2),  -- depends only on ItemNo, not whole PK
    PRIMARY KEY (OrderNo, ItemNo)
);

-- Fix: separate Item pricing
CREATE TABLE Item (
    ItemNo    INT          PRIMARY KEY,
    ItemPrice DECIMAL(10,2) NOT NULL
);

CREATE TABLE OrderItem (
    OrderNo INT,
    ItemNo  INT,
    Qty     INT,
    PRIMARY KEY (OrderNo, ItemNo),
    FOREIGN KEY (ItemNo) REFERENCES Item(ItemNo)
);
```

---

## 4NF Violation Example (multivalued dependency)

```sql
-- Bad: TeachesPhone stores independent multivalued facts in one table
-- Instructor can teach many courses AND have many phones — these are independent
CREATE TABLE TeachesPhone_BAD (
    InstID   INT,
    CourseID VARCHAR(10),
    Phone    VARCHAR(20),
    PRIMARY KEY (InstID, CourseID, Phone)
);

-- Fix: separate the two independent facts
CREATE TABLE Teaches (
    InstID   INT,
    CourseID VARCHAR(10),
    PRIMARY KEY (InstID, CourseID),
    FOREIGN KEY (InstID)   REFERENCES Instructor(InstID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE InstructorPhone (
    InstID INT,
    Phone  VARCHAR(20),
    PRIMARY KEY (InstID, Phone),
    FOREIGN KEY (InstID) REFERENCES Instructor(InstID)
);
```

---

## Quick Checklist Before Writing CREATE TABLE

| Check | Question |
|-------|---------|
| 1NF | Are all columns atomic? No lists or composites in one column? |
| 2NF | Does every non-key column depend on the *whole* primary key? |
| 3NF | Does every non-key column depend *directly* on the PK (not via another non-key)? |
| BCNF | Is every FD's left side a superkey? |
| FK | Is every decomposition linked back with a foreign key? |
