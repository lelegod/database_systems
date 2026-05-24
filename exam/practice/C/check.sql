-- ============================================================
-- CHECK FILE — Exam C (MusicDB)
-- Run each block to see the EXPECTED output.
-- Compare against your answers.sql output.
-- ============================================================

USE MusicDB;

-- -----------------------------------------------------------------------------------------------------
-- EXPECTED Q1: Danish artists who never performed any song
-- Expected rows: Jacob (CopenhagenBeat)
-- -----------------------------------------------------------------------------------------------------
SELECT 'Q1 EXPECTED' AS check_label;
SELECT aname, lname
FROM Artist
WHERE lname IN (SELECT lname FROM Label WHERE country = 'Denmark')
  AND aid NOT IN (SELECT aid FROM performs);

-- -----------------------------------------------------------------------------------------------------
-- EXPECTED Q2: songs performed by 2+ artists → songid, stitle, syear, numArtists
-- Expected rows: (S1, Final Song, 2021, 2), (S3, Lean On, 2015, 2)
-- -----------------------------------------------------------------------------------------------------
SELECT 'Q2 EXPECTED' AS check_label;
SELECT songid, stitle, syear, COUNT(DISTINCT aid) AS numArtists
FROM Song NATURAL JOIN performs
GROUP BY songid, stitle, syear
HAVING COUNT(DISTINCT aid) >= 2;

-- -----------------------------------------------------------------------------------------------------
-- EXPECTED Q3: for each playlist, distinct artists performing at least one song in that playlist
-- Expected rows: DanishHits=2, NordicVibes=1, GlobalTop=3
-- -----------------------------------------------------------------------------------------------------
SELECT 'Q3 EXPECTED' AS check_label;
SELECT pname, COUNT(DISTINCT aid) AS numArtists
FROM Playlist
    LEFT JOIN includes USING (pname)
    LEFT JOIN performs USING (songid)
GROUP BY pname;

-- -----------------------------------------------------------------------------------------------------
-- EXPECTED Q4: test songCount function after you create it
-- Expected: aid=1 → 2, aid=2 → 2, aid=6 → 0, aid=99 → 0
-- -----------------------------------------------------------------------------------------------------
SELECT 'Q4 EXPECTED' AS check_label;
SELECT aid, songCount(aid) AS result FROM Artist
UNION
SELECT 99, songCount(99);
