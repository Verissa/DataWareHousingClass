.echo on

-- Calculate 7 day moving min, max, avg, sum for precipitation and snowfall
SELECT 
    date,
    MIN(precipitation) OVER seven AS prcp_7_day_moving_min,
    MAX(precipitation) OVER seven AS prcp_7_day_moving_max,
    AVG(precipitation) OVER seven AS prcp_7_day_moving_avg,
    SUM(precipitation) OVER seven AS prcp_7_day_moving_sum,
    MIN(snowfall) OVER seven AS snow_7_day_moving_min,
    MAX(snowfall) OVER seven AS snow_7_day_moving_max,
    AVG(snowfall) OVER seven AS snow_7_day_moving_avg,
    SUM(snowfall) OVER seven AS snow_7_day_moving_sum
FROM "main"."staging"."stg__central_park_weather"
WINDOW seven AS (
    ORDER BY date ASC
--For each row, including 3 days before and 3 days after the current date.
    RANGE BETWEEN INTERVAL 3 DAYS PRECEDING AND INTERVAL 3 DAYS FOLLOWING
)
ORDER BY date;