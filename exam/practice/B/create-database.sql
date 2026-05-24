DROP DATABASE IF EXISTS HospitalDB;
CREATE DATABASE HospitalDB;
USE HospitalDB;

CREATE TABLE Hospital (
    hname   VARCHAR(50) PRIMARY KEY,
    country VARCHAR(50) NOT NULL
);

CREATE TABLE Doctor (
    did   INT         PRIMARY KEY,
    dname VARCHAR(50) NOT NULL,
    hname VARCHAR(50)
);

CREATE TABLE Study (
    sid    INT          PRIMARY KEY,
    stitle VARCHAR(100) NOT NULL,
    syear  INT          NOT NULL
);

CREATE TABLE ResearchGroup (
    gname VARCHAR(50) PRIMARY KEY,
    hname VARCHAR(50)
);

CREATE TABLE conducts (
    did INT,
    sid INT,
    PRIMARY KEY (did, sid)
);

CREATE TABLE member_of (
    gname VARCHAR(50),
    did   INT,
    PRIMARY KEY (gname, did)
);

-- -------------------------------------------------------
INSERT INTO Hospital VALUES
('Rigshospitalet', 'Denmark'),
('OUH',            'Denmark'),
('Karolinska',     'Sweden'),
('Oslo Univ',      'Norway');

INSERT INTO Doctor VALUES
(10, 'Mette',  'Rigshospitalet'),
(20, 'Lars',   'Rigshospitalet'),
(30, 'Sofia',  'Karolinska'),
(40, 'Jonas',  'OUH'),
(50, 'Nina',   'Oslo Univ'),
(60, 'Astrid', 'OUH');     -- Danish hospital, never conducts

INSERT INTO Study VALUES
(1, 'Cancer Research',    2023),
(2, 'Heart Study',        2022),
(3, 'Brain Connectivity', 2024);

INSERT INTO conducts VALUES
(10, 1),
(20, 1),
(20, 2),
(30, 2),
(40, 3);
-- Note: Astrid(60) and Nina(50) never conduct anything

INSERT INTO ResearchGroup VALUES
('CardioGroup',  'Rigshospitalet'),
('NeuroGroup',   'Karolinska'),
('OncologyTeam', 'OUH');

INSERT INTO member_of VALUES
('CardioGroup',  10),
('CardioGroup',  20),
('NeuroGroup',   30),
('OncologyTeam', 40);
