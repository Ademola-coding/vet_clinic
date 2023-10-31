-- Project 1
/*Queries that provide answers to the questions from all projects.*/
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


-- project 2
--Update species column with RollBack
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Update Species with commit
BEGIN;
UPDATE animals SET species='digimon' WHERE name LIKE '%mon';
UPDATE animals SET species='pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

-- Delete rows with rollback
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Delete with savepoint
BEGIN;
DELETE FROM animals WHERE date_of_birth>'2022-01-01';
SELECT * FROM animals;
SAVEPOINT save_point;
UPDATE animals SET weight_kg=weight_kg*-1;
SELECT * FROM animals;
ROLLBACK TO save_point;
UPDATE animals SET weight_kg=weight_kg*-1 WHERE weight_kg<0;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

-- Query Data from Animals table
SELECT count(*) FROM animals;
SELECT count(*) FROM animals WHERE escape_attempts = 0;
SELECT Avg(weight_kg) as Average_Weight_KG FROM animals; 

--avg escape attempt
SELECT neutered, MAX(escape_attempts) 
AS max_escape_attempts 
FROM animals GROUP BY neutered;

--min and max weight with species
SELECT species, MIN(weight_kg) 
as min_weight, MAX(weight_kg) 
as max_weight 
FROM animals GROUP BY species;

--avg no of escape in date
SELECT species, AVG(escape_attempts) 
as avg_escape_attempts 
FROM animals 
WHERE date_of_birth 
BETWEEN '1990-01-01' 
AND '2000-12-31' 
GROUP BY species;

-- Project 3
--Join Query by owner name
SELECT
    animals.name AS animals_owned_by_melody_pond
FROM
    animals
    JOIN owners ON owners.id = animals.owner_id
WHERE
    owners.full_name = 'Melody Pond';

--  List of all animals that are pokemon (their type is Pokemon).
SELECT
    animals.name AS pokemons
FROM
    animals
    JOIN species ON species.id = animals.species_id
WHERE
    species.name = 'Pokemon';

--Full Join Query by owner
select * from animals Full JOIN owners on animals.owner_id = owners.id;

--Join three tables and filter by owner and species
select * from animals JOIN owners on animals.owner_id=owners.id JOIN species on animals.species_id=species.id where species.name='Digimon' and owners.full_name='Jennifer Orwell';

--Join animal and owner table and filter by owner name and zero escape attempt
select * from animals JOIN owners on animals.owner_id=owners.id WHERE owners.full_name='Dean Winchester' AND escape_attempts=0;

-- Who owns the most animals;
select full_name as owner_name, count(full_name)no_of_animals from owners JOIN animals on animals.owner_id=owners.id GROUP BY owners.full_name;


-- Project 4 
-- Who was the last animal seen by William Tatcher?
SELECT
    animals.name AS last_animal_seen_by_dr_tatcher,
    visits.date_of_visit AS date_of_visit
FROM
    animals
    JOIN visits ON visits.animal_id = animals.id
    JOIN vets ON vets.id = visits.vet_id
WHERE
    vets.name = 'William Tatcher'
ORDER BY
    visits.date_of_visit DESC
LIMIT
    1;

-- How many different animals did Stephanie Mendez see?
SELECT DISTINCT
    COUNT(animals.name) AS diff_animals
FROM
    animals
    JOIN visits ON visits.animal_id = animals.id
    JOIN vets ON vets.id = visits.vet_id
WHERE
    vets.name = 'Stephanie Mendez';

-- List all vets and their specializations,
-- including vets with no specialization.
SELECT
    vets.name AS vet_name,
    species.name AS species_name
FROM
    vets
    FULL JOIN specializations ON specializations.vet_id = vets.id
    FULL JOIN species ON species.id = specializations.species_id;

-- List all animals that visited Stephanie Mendez between
-- April 1st and August 30th, 2020.
SELECT
    animals.name AS animal_name,
    visits.date_of_visit AS date_of_visit
FROM
    animals
    JOIN visits ON visits.animal_id = animals.id
    JOIN vets ON vets.id = visits.vet_id
WHERE
    vets.name = 'Stephanie Mendez'
    AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT
    animals.name AS animal_with_most_visits_to_the_vet
FROM
    animals
    JOIN visits ON visits.animal_id = animals.id
GROUP BY
    animals.name
ORDER BY
    COUNT(visits.animal_id) DESC
LIMIT
    1;

-- Who was Maisy Smith's first visit?
SELECT
    animals.name AS animal_name
FROM
    animals
    JOIN visits ON visits.animal_id = animals.id
    JOIN vets ON vets.id = visits.vet_id
WHERE
    vets.name = 'Maisy Smith'
ORDER BY
    visits.date_of_visit
LIMIT
    1;

-- Details for most recent visit: animal information,
-- vet information, and date of visit.
SELECT
    animals.*,
    vets.*,
    visits.date_of_visit AS date_of_visit
FROM
    animals
    JOIN visits ON visits.animal_id = animals.id
    JOIN vets ON vets.id = visits.vet_id
ORDER BY
    date_of_visit DESC
LIMIT
    1;

--What animal has the most visits to vets?
SELECT a.name AS animal_name, COUNT(*) as visit_count
FROM visits vi
JOIN animals a ON a.id = vi.animal_id
GROUP BY a.name
ORDER BY visit_count DESC;

--  What specialty should Maisy Smith consider getting?
--  Look for the species she gets the most.
SELECT
    species.name AS species_name,
    COUNT(visits.date_of_visit) AS visit_count
FROM
    species
    JOIN animals ON animals.species_id = species.id
    JOIN visits ON visits.animal_id = animals.id
    JOIN vets ON vets.id = visits.vet_id
WHERE
    vets.name = 'Maisy Smith'
GROUP BY
    species_name
ORDER BY
    visit_count DESC
LIMIT
    1;

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits WHERE animals_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits WHERE vets_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners WHERE email = 'owner_18327@mail.com';
