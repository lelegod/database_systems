-- ============================================================
-- CHECK FILE — Exam B (HospitalDB)
-- Run each block to see the EXPECTED output.
-- Compare against your answers.sql output.
-- ============================================================

USE HospitalDB;

-- -----------------------------------------------------------------------------------------------------
-- EXPECTED Q1: Danish doctors who never conducted any study
-- Expected rows: Astrid (OUH)
-- -----------------------------------------------------------------------------------------------------
SELECT 'Q1 EXPECTED' AS check_label;
SELECT dname, hname
FROM Doctor
WHERE hname IN (SELECT hname FROM Hospital WHERE country = 'Denmark')
  AND did NOT IN (SELECT did FROM conducts);

-- -----------------------------------------------------------------------------------------------------
-- EXPECTED Q2: studies conducted by 2+ doctors → sid, stitle, syear, numDoctors
-- Expected rows: (1, Cancer Research, 2023, 2), (2, Heart Study, 2022, 2)
-- -----------------------------------------------------------------------------------------------------
SELECT 'Q2 EXPECTED' AS check_label;
SELECT sid, stitle, syear, COUNT(DISTINCT did) AS numDoctors
FROM Study NATURAL JOIN conducts
GROUP BY sid, stitle, syear
HAVING COUNT(DISTINCT did) >= 2;

-- -----------------------------------------------------------------------------------------------------
-- EXPECTED Q3: for each research group, distinct studies by at least one member
-- Expected rows: CardioGroup=2, NeuroGroup=1, OncologyTeam=1
-- -----------------------------------------------------------------------------------------------------
SELECT 'Q3 EXPECTED' AS check_label;
SELECT gname, COUNT(DISTINCT sid) AS numStudies
FROM ResearchGroup
    LEFT JOIN member_of USING (gname)
    LEFT JOIN conducts  USING (did)
GROUP BY gname;

-- -----------------------------------------------------------------------------------------------------
-- EXPECTED Q4: test studyCount function after you create it
-- Expected: did=10 → 1, did=20 → 2, did=60 → 0, did=99 → 0
-- -----------------------------------------------------------------------------------------------------
SELECT 'Q4 EXPECTED' AS check_label;
SELECT did, studyCount(did) AS result FROM Doctor
UNION
SELECT 99, studyCount(99);
