DROP DATABASE IF EXISTS LibraryDB;
CREATE DATABASE LibraryDB;
USE LibraryDB;

CREATE TABLE Library (
    lname VARCHAR(50) PRIMARY KEY,
    city  VARCHAR(50) NOT NULL
);

CREATE TABLE Member (
    mid   INT          PRIMARY KEY,
    mname VARCHAR(50)  NOT NULL,
    lname VARCHAR(50)
);

CREATE TABLE Book (
    bid    INT          PRIMARY KEY,
    btitle VARCHAR(100) NOT NULL,
    byear  INT          NOT NULL
);

CREATE TABLE Club (
    cname VARCHAR(50) PRIMARY KEY,
    lname VARCHAR(50)
);

CREATE TABLE borrows (
    mid INT,
    bid INT,
    PRIMARY KEY (mid, bid)
);

CREATE TABLE attends (
    cname VARCHAR(50),
    mid   INT,
    PRIMARY KEY (cname, mid)
);

-- -------------------------------------------------------
INSERT INTO Library VALUES
('CentralLib',     'Copenhagen'),
('NorthLib',       'Copenhagen'),
('AarhusLib',      'Aarhus'),
('OsloLib',        'Oslo');

INSERT INTO Member VALUES
(1, 'Anna',   'CentralLib'),
(2, 'Bo',     'CentralLib'),
(3, 'Carla',  'AarhusLib'),
(4, 'Daniel', 'NorthLib'),
(5, 'Eva',    'OsloLib'),
(6, 'Felix',  'NorthLib');   -- Danish library, never borrows

INSERT INTO Book VALUES
(101, 'Database Design',  2020),
(102, 'Algorithms',       2018),
(103, 'Clean Code',       2019),
(104, 'AI Fundamentals',  2022);

INSERT INTO borrows VALUES
(1, 101),
(1, 102),
(3, 101),
(3, 103),
(4, 102);
-- Note: Bo(2) and Felix(6) never borrowed anything

INSERT INTO Club VALUES
('ReadersCircle', 'CentralLib'),
('BookNerds',     'AarhusLib'),
('PageTurners',   'NorthLib');

INSERT INTO attends VALUES
('ReadersCircle', 1),
('ReadersCircle', 2),
('BookNerds',     3),
('PageTurners',   4),
('PageTurners',   6);
