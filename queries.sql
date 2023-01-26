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

/* Querying data */

BEGIN;
UPDATE animals SET species = 'digmon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE name NOT LIKE '%mon';
COMMIT;

BEGIN;
DELETE FROM animals WHERE name != '';
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT delete_dob;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT delete_dob;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 1;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts < 1;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01' GROUP BY species;

CREATE TABLE owners(
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  age INT
);

CREATE TABLE
  CREATE TABLE species(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT, ADD CONSTRAINT species_id FOREIGN KEY(species_id) REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owners_id INT, ADD CONSTRAINT owners_id FOREIGN KEY(owners_id) REFERENCES owners(id);
SELECT name FROM animals WHERE animals.owners_id = (SELECT id FROM owners WHERE owners.full_name = 'Melody Pond');
INSERT INTO owners(full_name, age) VALUES ('Sam Smith', 34),('Jeniffer Orwell', 19),('Bob', 45),('Melody Pond', 77),('Dean Winchester', 14),('Jodie Whittaker', 38);
INSERT INTO species(name) VALUES ('Pokemon'),('Digimon');
SELECT name, full_name FROM animals INNER JOIN owners ON animals.owners_id = owners.id WHERE owners.full_name = 'Melody Pond';
SELECT animals.name, species.name FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON animals.owners_id = owners.id;
select species.name as species, count(animals.name) as nb_of_animals from animals join species on animals.species_id = species.id group by species;
SELECT animals.name, species.name, owners.full_name FROM animals JOIN species ON animals.species_id = species.id JOIN owners ON animals.owners_id = owners.id WHERE species.name = 'Digimon' AND owners.full_name = 'Jeniffer Orwell';
SELECT animals.escape_attempts, owners.full_name FROM animals JOIN owners ON animals.owners_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;