DROP DATABASE IF EXISTS MusicDB;
CREATE DATABASE MusicDB;
USE MusicDB;

CREATE TABLE Label (
    lname   VARCHAR(50) PRIMARY KEY,
    country VARCHAR(50) NOT NULL
);

CREATE TABLE Artist (
    aid   INT         PRIMARY KEY,
    aname VARCHAR(50) NOT NULL,
    lname VARCHAR(50)
);

CREATE TABLE Song (
    songid VARCHAR(5)   PRIMARY KEY,
    stitle VARCHAR(100) NOT NULL,
    syear  INT          NOT NULL
);

CREATE TABLE Playlist (
    pname VARCHAR(50) PRIMARY KEY,
    lname VARCHAR(50)
);

CREATE TABLE performs (
    aid    INT,
    songid VARCHAR(5),
    PRIMARY KEY (aid, songid)
);

CREATE TABLE includes (
    pname  VARCHAR(50),
    songid VARCHAR(5),
    PRIMARY KEY (pname, songid)
);

-- -------------------------------------------------------
INSERT INTO Label VALUES
('NordicSound',    'Denmark'),
('CopenhagenBeat', 'Denmark'),
('StockholmRec',   'Sweden'),
('GlobalTunes',    'USA');

INSERT INTO Artist VALUES
(1, 'MØ',       'NordicSound'),
(2, 'Lukas G.', 'NordicSound'),
(3, 'Robyn',    'StockholmRec'),
(4, 'Nephew',   'CopenhagenBeat'),
(5, 'Billie E.','GlobalTunes'),
(6, 'Jacob',    'CopenhagenBeat');  -- Danish label, never performs

INSERT INTO Song VALUES
('S1', 'Final Song',        2021),
('S2', 'Dancing On My Own', 2010),
('S3', 'Lean On',           2015),
('S4', 'Dark Horse',        2022);

INSERT INTO performs VALUES
(1, 'S1'),
(2, 'S1'),
(2, 'S3'),
(3, 'S2'),
(4, 'S4'),
(1, 'S3');
-- Note: Billie E.(5) and Jacob(6) never perform anything

INSERT INTO Playlist VALUES
('DanishHits',  'NordicSound'),
('NordicVibes', 'CopenhagenBeat'),
('GlobalTop',   'GlobalTunes');

INSERT INTO includes VALUES
('DanishHits',  'S1'),
('DanishHits',  'S3'),
('NordicVibes', 'S4'),
('GlobalTop',   'S1'),
('GlobalTop',   'S2');
