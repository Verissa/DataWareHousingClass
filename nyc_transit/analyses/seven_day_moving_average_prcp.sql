.echo on
-- Calculate 7-day moving average of precipitation
SELECT 
    date,
    AVG(precipitation) OVER (
        ORDER BY date
--For each row, including 3 days before and 3 days after the current date.
        RANGE BETWEEN INTERVAL 3 DAYS PRECEDING AND INTERVAL 3 DAYS FOLLOWING
    ) AS prcp_7_day_moving_average
FROM "main"."staging"."stg__central_park_weather"
ORDER BY date;