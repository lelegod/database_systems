DROP DATABASE IF EXISTS PetShelters;
CREATE DATABASE PetShelters;
USE PetShelters;

CREATE TABLE Shelter(
	shelterId INT PRIMARY KEY, 
    city VARCHAR(50) NOT NULL
);

CREATE TABLE Pet(
	petName VARCHAR(50) PRIMARY KEY,
    age INT NOT NULL,
    breed VARCHAR(50) NOT NULL,
    shelterId INT NOT NULL,
    FOREIGN KEY(shelterId) REFERENCES Shelter(shelterId)
);

CREATE TABLE Person(
	personName VARCHAR(50) PRIMARY KEY, 
    city VARCHAR(50) NOT NULL
);

CREATE TABLE reservedFor(
	personName VARCHAR(50),
    petName VARCHAR(50),
    reservedDate DATETIME NOT NULL,
    PRIMARY KEY(personName, petName),
    FOREIGN KEY (personName) REFERENCES Person(personName),
    FOREIGN KEY (petName) REFERENCES Pet(petName)
);

INSERT INTO Shelter VALUES(0, 'Lyngby');
INSERT INTO Shelter VALUES(1, 'Sorgenfri');
INSERT INTO Shelter VALUES(2, 'Virum');

INSERT INTO Pet VALUES('Gordon Moore', 10, 'British Shorthair', 0);
INSERT INTO Pet VALUES('Julius Caesar', 11, 'British Shorthair', 0);
INSERT INTO Pet VALUES('Mr. Fluffy', 2, 'Poodle', 0);
INSERT INTO Pet VALUES('Einstein', 5, 'Pug', 0);

INSERT INTO Pet VALUES('Jonathan', 193, 'Seychelles Giant Tortoise', 1);
INSERT INTO Pet VALUES('Gonzales', 1, 'Mouse', 1);

INSERT INTO Pet VALUES('Tim', 3, 'Golden Retriever', 2);
INSERT INTO Pet VALUES('Remy', 6, 'Rat', 2);
INSERT INTO Pet VALUES('Kaa', 21, 'Indian Python', 2);
INSERT INTO Pet VALUES('Usain Bolt', 4, 'Pug', 2);
INSERT INTO Pet VALUES('Dorit', 4, 'Parrot', 2);
INSERT INTO Pet VALUES('Harald Keramiker', 9, 'British Shorthair', 2);

INSERT INTO Person VALUES('Tim', 'Lyngby');
INSERT INTO Person VALUES('Eli', 'Gentofte');
INSERT INTO Person VALUES('Dorit', 'Sorgenfri');
INSERT INTO Person VALUES('Vanessa', 'Sorgenfri');

INSERT INTO reservedFor VALUES('Tim', 'Mr. Fluffy', '2026-03-17');
INSERT INTO reservedFor VALUES('Eli', 'Usain Bolt', '2026-03-27');
INSERT INTO reservedFor VALUES('Dorit', 'Harald Keramiker', '2026-01-13');
INSERT INTO reservedFor VALUES('Tim', 'Usain Bolt', '2026-03-14');
INSERT INTO reservedFor VALUES('Dorit', 'Julius Caesar', '2026-01-13');
INSERT INTO reservedFor VALUES('Dorit', 'Gordon Moore', '2026-01-13');
INSERT INTO reservedFor VALUES('Vanessa', 'Kaa', '2026-02-14');
INSERT INTO reservedFor VALUES('Vanessa', 'Remy', '2026-02-14');
