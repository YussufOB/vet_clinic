/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE
  name like '%mon'
;

SELECT * FROM animals WHERE
  date_of_birth >= '2016-01-01'
  AND date_of_birth <= '2019-01-01'
;

SELECT name FROM animals WHERE
  neutered = TRUE AND escape_attempts < 3
;

SELECT name FROM animals WHERE
  date_of_birth >= '2016-01-01'
  AND date_of_birth <= '2019-01-01'
;

SELECT name, escape_attempts FROM animals WHERE
  weight_kg > 10.5
;

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

SELECT anmals.name as animal_name, vets.name AS doc_name, visits.date_of_visit AS visit_date FROM visits JOIN vets ON vet_id = vets.id JOIN animals ON animal_id = animals.id WHERE vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher') ORDER BY date_of_visit DESC LIMIT 1;
SELECT COUNT(name) AS animal_count FROM visits JOIN vets ON visits.vet_id = vets.id WHERE visits.vet_id = (SELECT id FROM vets WHERE name = 'Stephaine Mendez');
SELECT vets.name AS doc_name, species.name AS doc_spec FROM vets LEFT JOIN specializationS ON vets.id = specializations.vet_id LEFT JOIN species ON specializations.specie_id = species.id;
SELECT animals.name AS animal_name FROM visits JOIN vets ON visits.vet_id = vets.id JOIN animals ON visits.animal_id = animals.id WHERE visits.vet_id = (SELECT id FROM vets WHERE name = 'Stephaine Mendez') AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';
SELECT animals.name, COUNT(*) as count_visit FROM visits JOIN animals ON visits.animal_id = animals.id GROUP BY animals.name ORDER BY count_visit DESC LIMIT 1;
SELECT animals.name AS animal_name, vets.name AS doc_name, visits.date_of_visit AS visit_date FROM visits JOIN vets ON vet_id = vets.id JOIN animals ON animal_id = animals.id WHERE vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith') ORDER BY date_of_visit ASC LIMIT 1;
SELECT animals.name AS animal_name, animals.weight_kg AS weight, animals.date_of_birth AS animal_dob, animals.escape_attempts, animals.neutered, species.name AS animal_specie, owners.full_name AS owners_name, vets. name AS doc_name, vets.age AS doc_age, vets.date_of_graduation AS doc_graduation_date, visits.date_of_visit FROM visits JOIN animals ON animals.id = visits.animal_id JOIN owners ON owners.id = animals.owners_id JOIN species ON species.id = animals.species_id JOIN vets ON vets.id = visits.vet_id ORDER BY date_of_visit DESC LIMIT 1;
SELECT COUNT(*) AS count_visit FROM visits JOIN vets ON vets.id = visits.vet_id JOIN animals ON visits.animal_id = animals.id JOIN specializations ON visits.vet_id = specializations.vet_id JOIN species ON species.id = animals.species_id WHERE animals.species_id != specializations.specie_id;
SELECT visits.animal_id AS visiting_animal_id, COUNT(visits.animal_id) AS count_visit, animals.name AS animal_ame, species.name AS specie_name, vets.name AS doc_name FROM visits JOIN vets ON visits.vet_id = vets.id JOIN  animals ON visits.animal_id = animals.id JOIN species ON animals.species_id = species.id WHERE visits.vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith') GROUP BY visits.animal_id, animals.name, vets.name, species.name ORDER BY count_visit DESC LIMIT 1;

EXPLAIN ANALYSE SELECT * FROM visits WHERE animal_id = 4;
EXPLAIN ANALYSE SELECT * FROM visits WHERE vet_id = 2;
EXPLAIN ANALYSE SELECT * FROM owners WHERE  email = 'owner_18327@mail.com';
