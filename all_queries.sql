-- Get the count of observations during each season using a CTE.

/* with seasons as (
SELECT 
    observations.*,
    CASE
        WHEN
            (MONTH(observation_date) = 12
                AND DAY(observation_date) >= 21)
                OR (MONTH(observation_date) IN (1 , 2))
                OR (MONTH(observation_date) = 3
                AND DAY(observation_date) < 21)
        THEN
            'Winter'
        WHEN
            (MONTH(observation_date) = 3
                AND DAY(observation_date) >= 21)
                OR (MONTH(observation_date) IN (4 , 5))
                OR (MONTH(observation_date) = 6
                AND DAY(observation_date) < 21)
        THEN
            'Spring'
        WHEN
            (MONTH(observation_date) = 6
                AND DAY(observation_date) >= 21)
                OR (MONTH(observation_date) IN (7 , 8))
                OR (MONTH(observation_date) = 9
                AND DAY(observation_date) < 21)
        THEN
            'Summer'
        WHEN
            (MONTH(observation_date) = 9
                AND DAY(observation_date) >= 21)
                OR (MONTH(observation_date) IN (10 , 11))
                OR (MONTH(observation_date) = 12
                AND DAY(observation_date) < 21)
        THEN
            'Fall'
    END AS Season
FROM
    observations)
    
SELECT 
    season, COUNT(season) AS num_observations
FROM
    seasons
GROUP BY season
order by num_observations DESC;
*/

-- ----------------------------------Break-------------------------- --

-- Find the count of rose-breasted grobseaks (one of my favorites)

/* SELECT 
    s.name, SUM(o.species_count) AS total_observations
FROM
    observations o
        JOIN
    bird_species s ON o.bird_id = s.id
WHERE
    s.name LIKE 'rose-breast%'
GROUP BY s.name;
*/

-- ----------------------------Break----------------------------------- --

-- Find the number of some birds of prey. (Not all hawks have the name "hawk" so some will be left out).

/* SELECT 
    CASE
        WHEN s.name LIKE '%hawk%' THEN 'Hawk'
        WHEN s.name LIKE '%owl%' THEN 'Owl'
        WHEN s.name LIKE '%eagle%' THEN 'Eagle'
        WHEN
            (s.name LIKE '%falcon%')
                OR (s.name IN ('American Kestrel' , 'Merlin'))
        THEN
            'Falcon'
        ELSE 'No raptor'
    END AS raptor_category,
    SUM(o.species_count) AS num_observations
FROM
    observations o
        JOIN
    bird_species s ON o.bird_id = s.id
GROUP BY raptor_category
ORDER BY num_observations DESC;
*/

-- ------------------------------------Break------------------------------------------- --

-- Find the Top 5 states based upon observations (by distinct observation id).

/*
SELECT 
    a.state,
    COUNT(DISTINCT o.observation_id) AS num_observations
FROM
    areas a
        JOIN
    observations o ON a.id = o.area_id
GROUP BY a.state
ORDER BY num_observations DESC
LIMIT 5;
*/

-- ------------------------------- Break--------------------------------------------- ---

-- Find the number of endangered birds in the west (Only 41 states in dataset.)

/*SELECT 
    COUNT(DISTINCT s.id) AS num_species_endangered
FROM
    observations o
        JOIN
    bird_species s ON o.bird_id = s.id
        JOIN
    areas a ON o.area_id = a.id
WHERE
    a.state IN ('California' , 'Oregon',
        'Washington',
        'Nevada',
        'Utah',
        'Arizona',
        'New Mexico',
        'Montana',
        'Idaho',
        'Colorado',
        'Wyoming')
        AND s.endangered = 'TRUE';
*/

-- -------------------------------------- Break ------------------------------- --

-- Find the most popular bird for each state (based on the greatest bird count for a species in a state)

/*
with popular_birds_by_state as(
SELECT 
    s.name, a.state, SUM(o.species_count) AS num_spotted,
    Rank() over (partition by state order by SUM(o.species_count) Desc) as bird_rank
FROM
    observations o
        JOIN
    bird_species s ON o.bird_id = s.id
        JOIN
    areas a ON o.area_id = a.id
GROUP BY s.name, a.state)

SELECT 
    name, state, num_spotted
FROM
    popular_birds_by_state
WHERE
    bird_rank = 1
    order by state;
    
*/

-- --------------------------------------- Break --------------------------------------


-- Find the average flight speed and weight for birds that have European or Eurasian in their names
-- compared to all other birds.

/*
(SELECT 
    ROUND(AVG(flight_speed), 2) AS avg_flight_speed,
    ROUND(AVG(weight_ounces), 2) AS avg_weight,
    'European' AS nationality
FROM
    bird_species
WHERE
    name LIKE '%European%'
        OR name LIKE '%Eurasian%') UNION (SELECT 
    ROUND(AVG(flight_speed), 2) AS avg_flight_speed,
    ROUND(AVG(weight_ounces), 2) AS avg_weight,
    'American' AS nationality
FROM
    bird_species
WHERE
    name NOT LIKE '%European%'
        AND name NOT LIKE '%Eurasian%');
*/

-- ------------------------------------------Break--------------------------------------- --

-- Find the total number of birds that were heard but not photographed, photographed but not heard,
-- photographed and heard, and neither photographed or heard.

/*
SELECT 
    CASE
        WHEN made_sound = 'TRUE' AND camera = 'None' THEN 'Heard but no pic'
        WHEN
            made_sound = 'FALSE'
                AND camera <> 'None'
        THEN
            'Not heard but pic'
        WHEN made_sound = 'TRUE' AND camera <> 'None' THEN 'Heard and pic'
        WHEN made_sound = 'FALSE' AND camera = 'None' THEN 'Not heard and no pic'
    END AS observation_category,
    SUM(species_count) AS num_observed
FROM
    observations
GROUP BY observation_category
ORDER BY num_observed DESC;
*/

--  -----------------------------Break-------------------------------------

-- Find total number of birds photographed per camera.

/* 
SELECT 
    camera, SUM(species_count) num_photographed
FROM
    observations
group by camera
order by num_photographed DESC;
*/


-- -----------------------------------------Break------------------------------------ --

-- Find all one word bird names aka no spaces. (Technically, Cardinal should be Northen Cardinal.)

/*
SELECT 
    name
FROM
    bird_species
WHERE
    name NOT LIKE '% %'; 
*/

--   --------------------------------Break-------------------------------------

-- Show total bird observation counts per year in Maine.

/*
SELECT 
    YEAR(o.observation_date) AS observation_year,
    SUM(o.species_count) AS total_bird_numbers
FROM
    observations o
        JOIN
    bird_species s ON o.bird_id = s.id
        JOIN
    areas a ON o.area_id = a.id
WHERE
    a.state = 'Maine'
GROUP BY observation_year
ORDER BY observation_year;
*/

-- ----------------------------------Break---------------------------------------

-- Find all jay counts per year.

/*
SELECT 
    YEAR(o.observation_date) AS observed_year,
    s.name,
    SUM(o.species_count) AS number_jays
FROM
    observations o
        JOIN
    bird_species s ON o.bird_id = s.id
WHERE
    s.name LIKE '%jay%'
GROUP BY observed_year , s.name
ORDER BY observed_year , number_jays DESC;
*/


