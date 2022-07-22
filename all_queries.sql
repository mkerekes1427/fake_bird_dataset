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



