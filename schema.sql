/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals 
(id SERIAL PRIMARY KEY, name VARCHAR(100), 
date_of_birth DATE, escape_attempts INT, 
neutered BOOLEAN, weight_kg DECIMAL(5, 2));

-- project 2
-- ALTER TABLE animals ADD COLUMN species VARCHAR(20) NULL;
ALTER TABLE animals ADD species varchar(100);

-- project 3
CREATE TABLE owners ( id Int GENERATED ALWAYS AS IDENTITY, full_name varchar(200), age Int, PRIMARY KEY (id) );

CREATE TABLE species ( id Int GENERATED ALWAYS AS IDENTITY, name varchar(200), PRIMARY KEY (id));


--set primary key for animals table, 
ALTER TABLE animals DROP column species;

 --remove species column from animals table
ALTER TABLE animals ADD COLUMN species_id SMALLINT, ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species (id) ON DELETE CASCADE;

ALTER TABLE animals ADD COLUMN owner_id SMALLINT, ADD CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES owners (id) ON DELETE CASCADE;
