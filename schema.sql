/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals 
(id SERIAL PRIMARY KEY, name VARCHAR(100), 
date_of_birth DATE, escape_attempts INT, 
neutered BOOLEAN, weight_kg DECIMAL(5, 2));

-- project 2
-- ALTER TABLE animals ADD COLUMN species VARCHAR(20) NULL;
ALTER TABLE animals ADD species varchar(100);
