/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(250),
  date_of_birth DATE NOT NULL,
  escape_attempts INT NOT NULL,
  neutered BOOLEAN,
  weight_kg DECIMAL
);

CREATE TABLE owners(
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  age INT
);

CREATE TABLE species(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE specializations(
  specie_id INT,
  vet_id INT,
  PRIMARY KEY(vet_id, specie_id),
  CONSTRAINT spec_specie_id FOREIGN KEY(specie_id) REFERENCES species(id) ON DELETE CASCADE,
  CONSTRAINT spec_vet_id FOREIGN KEY(vet_id) REFERENCES vets(id) ON DELETE CASCADE
);

CREATE TABLE visits(
  animal_id INT,
  vet_id INT,
  date_of_visit DATE,
  PRIMARY KEY(animal_id, vet_id, date_of_visit),
  CONSTRAINT animal_visiting_id FOREIGN KEY(animal_id) REFERENCES animals(id) ON DELETE CASCADE,
  CONSTRAINT vet_visiting_id FOREIGN KEY(vet_id) REFERENCES vets(id) ON DELETE CASCADE
);

CREATE TABLE vets(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  age INT,
  date_of_graduation DATE
);

--Indexing would be better option for optimizing the query performance in this scenario cause provides a fast and efficient way to locate rows in visits and owners tables based on  specific  values (id and email columns). Denormalization may not be efficient since we are not to collect data from both tables.

CREATE INDEX animal_index ON visits(animal_id);
CREATE INDEX index_vet ON visits(vet_id);
CREATE INDEX index_email ON owners(email);