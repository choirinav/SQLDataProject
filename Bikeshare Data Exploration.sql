-- Bikeshare dataset exploration

-- Get min max average trip duration
SELECT COUNT(*) AS total_trips, AVG(duration_sec) AS avg_trip_duration, MIN(duration_sec) AS min_trip_duration, MAX(duration_sec) AS max_trip_duration
FROM `bigquery-public-data.san_francisco.bikeshare_trips`;

-- Find the most popular stations
SELECT start_station_name, COUNT(*) AS num_trips
FROM `bigquery-public-data.san_francisco.bikeshare_trips`
GROUP BY start_station_name
ORDER BY num_trips DESC
LIMIT 10;

-- Determine peak hours for bike usage
SELECT EXTRACT(HOUR FROM start_date) AS hour_of_day,COUNT(*) AS num_trips
FROM `bigquery-public-data.san_francisco.bikeshare_trips`
GROUP BY hour_of_day
ORDER BY num_trips DESC;

-- Analyze trip duration by user type
SELECT subscriber_type,
AVG(duration_sec) AS avg_duration
FROM `bigquery-public-data.san_francisco.bikeshare_trips`
GROUP BY subscriber_type;

-- Analyze trip duration by zip code
SELECT zip_code, AVG(duration_sec) AS avg_duration, COUNT(*) AS num_trips
FROM `bigquery-public-data.san_francisco.bikeshare_trips`
GROUP BY zip_code
ORDER BY avg_duration ASC;
