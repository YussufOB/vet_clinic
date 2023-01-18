/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name like '%mon';
SELECT * FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-01-01';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-01-01';
SELECT (name, escape_attempts) FROM animals WHERE weight_kg > 10.5;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT * FROM animals  WHERE neutered = TRUE;
SELECT * FROM animals  WHERE name != 'Gabumon';
SELECT * FROM animals  WHERE weight_kg BETWEEN 10.4 AND 17.3;
