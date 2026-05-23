-- create-database.sql file for creating and populating the CompanyDatabase database.
-- Referential integrity constraints are deliberately omitted from the file 
-- and they must be added to keep the database consistent, but you are not supposed to do so in this exam.
 
CREATE DATABASE IF NOT EXISTS CompanyDatabase;
USE CompanyDatabase;

DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS participates;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Report;
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS Department;
    
CREATE TABLE Department (
    dname VARCHAR(30), 
    country VARCHAR(30),
    PRIMARY KEY (dname)
    ); 
 
CREATE TABLE Employee (
    eid INT(3), 
    ename VARCHAR(30), 
    dname VARCHAR(30),
    PRIMARY KEY (eid)
    );
    
CREATE TABLE Report (
    rid INT(3), 
    rname VARCHAR(30), 
    ryear YEAR,
    PRIMARY KEY (rid)
    ); 
    
CREATE TABLE authors (
    rid INT(3), 
    eid INT(3),
    PRIMARY KEY (rid, eid)
    );
     
 CREATE TABLE Project (
    pname VARCHAR(30), 
    dname  VARCHAR(30),
    PRIMARY KEY (pname)
    ); 
    
 CREATE TABLE participates (
    pname VARCHAR(30), 
    eid INT(3),
    PRIMARY KEY (pname, eid)
    );
      
INSERT Department VALUES 
  ('FormalSys', 'Denmark'), ('Nobody', 'Utopia'),  ('SmartDB', 'Italy'), ('SmartSys', 'Germany'), ('Administration', 'Denmark');

INSERT Employee VALUES 
  (10,'Anne', 'FormalSys'), (20,'Giovanni', 'SmartDB'), (30,'Ida', 'FormalSys'), (40, 'Jan', 'SmartSys'), (50, 'Signe', 'Administration');
   
INSERT Report VALUES 
  (1,'Modern Database Systems', 2025), (2,'Formal Methods in Practice', 2024), (3,'Tools of the Future', 2025);
  
INSERT authors VALUES (1,10), (2,20), (2,10), (3,10), (3,30);
  
INSERT Project VALUES
  ('AIfuture', 'SmartSys'), ('FM', 'FormalSys'), ('RAISE', 'FormalSys');
    
INSERT participates VALUES
  ('AIfuture', 10), ('AIfuture', 20), ('RAISE', 20), ('RAISE', 30) ; 
