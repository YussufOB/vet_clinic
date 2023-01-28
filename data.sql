/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '2020-02-03', 0, TRUE, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-11-15', 2, TRUE, 8.00);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, FALSE, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-05-12', 5, TRUE, 11.00);

/* Querying data */

ALTER TABLE animals ADD COLUMN species varchar;
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
  VALUES ('Charmander', '2020-02-08', 0, false, -11.00), ('Plantmon', '2021-11-15', 2, true, -5.70), ('Squirtle', '1993-04-02', 3, false, -12.13),
    ('Angemon', '2005-06-12', 1, true, -45.00), ('Boarmon', '2005-06-07', 7, true, 20.40), ('Blossom', '1998-10-13', 3, true, 17.00),
    ('Ditto', '2022-05-14', 4, true, 22.00)
;

UPDATE animals SET species_id = (SELECT id FROM species WHERE species.name = 'Digimon') WHERE animals.name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE species.name = 'Pokemon') WHERE animals.name NOT LIKE '%mon';
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE owners.full_name = 'Sam Smith') WHERE animals.name = 'Agumon';
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE owners.full_name = 'Jennifer Orwell') WHERE animals.name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE owners.full_name = 'Bob') WHERE animals.name IN ('Plantmon', 'Devimon');
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE owners.full_name = 'Melody Pond') WHERE animals.name IN ('Charmander', 'Blossom', 'Squirtle');
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE owners.full_name = 'Dean Winchester') WHERE animals.name IN ('Angemon', 'Boarmon');

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT, ADD CONSTRAINT species_id FOREIGN KEY(species_id) REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owners_id INT, ADD CONSTRAINT owners_id FOREIGN KEY(owners_id) REFERENCES owners(id);
INSERT INTO owners(full_name, age) VALUES ('Sam Smith', 34),('Jeniffer Orwell', 19),('Bob', 45),('Melody Pond', 77),('Dean Winchester', 14),('Jodie Whittaker', 38);
INSERT INTO species(name) VALUES ('Pokemon'),('Digimon');