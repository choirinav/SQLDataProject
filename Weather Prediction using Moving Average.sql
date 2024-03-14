-- This project using weather data from https://power.larc.nasa.gov/beta/data-access-viewer/

-- Predicting future temperature using moving avarage
SELECT date, temperature,
  AVG(temperature) OVER (
    ORDER BY date 
    ROWS BETWEEN 7 PRECEDING AND CURRENT ROW
  ) AS moving_avg_temperature
FROM `authentic-idea-414103.mydataset.weather_data`
ORDER BY date;

-- Daily averages
SELECT 
  DATE(date) AS day,
  AVG(temperature) AS avg_temp,
  AVG(humidity) AS avg_humidity,
  AVG(wind_speed) AS avg_wind_speed
FROM `authentic-idea-414103.mydataset.weather_data`
GROUP BY day
ORDER BY day;

-- Monthly averages
SELECT 
  EXTRACT(MONTH FROM date) AS month,
  AVG(temperature) AS avg_temp,
  AVG(humidity) AS avg_humidity,
  AVG(wind_speed) AS avg_wind_speed
FROM `authentic-idea-414103.mydataset.weather_data`
GROUP BY month
ORDER BY month;

-- Seasonal trends
SELECT 
  CASE 
    WHEN EXTRACT(MONTH FROM date) IN (10, 11, 12, 1, 2, 3) THEN 'Rainy'
    ELSE 'Summer'
  END AS season,
  AVG(temperature) AS avg_temp,
  AVG(humidity) AS avg_humidity
FROM `authentic-idea-414103.mydataset.weather_data`
GROUP BY season
ORDER BY season;

-- Data correlation
SELECT
  CORR(temperature, humidity) AS temp_humidity_correlation,
  CORR(temperature, wind_speed) AS temp_wind_speed_correlation
FROM `authentic-idea-414103.mydataset.weather_data`;
