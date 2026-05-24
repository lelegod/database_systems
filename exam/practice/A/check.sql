-- ============================================================
-- CHECK FILE — Exam A (LibraryDB)
-- Run each block to see the EXPECTED output.
-- Compare against your answers.sql output.
-- ============================================================

USE LibraryDB;

-- -----------------------------------------------------------------------------------------------------
-- EXPECTED Q1: members at Copenhagen libraries who never borrowed
-- Expected rows: Bo (CentralLib), Felix (NorthLib)
-- -----------------------------------------------------------------------------------------------------
SELECT 'Q1 EXPECTED' AS check_label;
SELECT mname, lname
FROM Member
WHERE lname IN (SELECT lname FROM Library WHERE city = 'Copenhagen')
  AND mid NOT IN (SELECT mid FROM borrows);

-- -----------------------------------------------------------------------------------------------------
-- EXPECTED Q2: books borrowed by 2+ members → bid, btitle, byear, numBorrowers
-- Expected rows: (101, Database Design, 2020, 2), (102, Algorithms, 2018, 2)
-- -----------------------------------------------------------------------------------------------------
SELECT 'Q2 EXPECTED' AS check_label;
SELECT bid, btitle, byear, COUNT(DISTINCT mid) AS numBorrowers
FROM Book NATURAL JOIN borrows
GROUP BY bid, btitle, byear
HAVING COUNT(DISTINCT mid) >= 2;

-- -----------------------------------------------------------------------------------------------------
-- EXPECTED Q3: for each club, distinct books borrowed by at least one attending member
-- Expected rows: ReadersCircle=2, BookNerds=2, PageTurners=1
-- -----------------------------------------------------------------------------------------------------
SELECT 'Q3 EXPECTED' AS check_label;
SELECT cname, COUNT(DISTINCT bid) AS numBooks
FROM Club
    LEFT JOIN attends  USING (cname)
    LEFT JOIN borrows  USING (mid)
GROUP BY cname;

-- -----------------------------------------------------------------------------------------------------
-- EXPECTED Q4: test the bookCount function after you create it
-- Expected: mid=1 → 2, mid=2 → 0, mid=3 → 2, mid=99 → 0
-- -----------------------------------------------------------------------------------------------------
SELECT 'Q4 EXPECTED' AS check_label;
SELECT mid, bookCount(mid) AS result FROM Member
UNION
SELECT 99, bookCount(99);
