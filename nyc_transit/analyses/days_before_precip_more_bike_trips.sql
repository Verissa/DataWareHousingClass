.echo on

--https://github.com/wearpants/cmu-95797-23m2/compare/week-5-start...week-5-end
-- CTE to determine if there was any precipitation on each day
WITH prcp_any_by_day AS (
    SELECT
        date,
        (precipitation + snowfall) > 0 AS prcp_any
    FROM "main"."staging"."stg__central_park_weather"
)
,
-- CTE to calculate reduction in bike trips on days with precipitation
final AS (
    SELECT
        p.date,
        prcp_any,
        LEAD(prcp_any) OVER (ORDER BY p.date) AS prcp_any_next,
        ttd.trips AS trips_today,
        ttd.trips - ttm.trips AS trips_delta
    FROM prcp_any_by_day p
    JOIN "main"."main"."mart__fact_all_trips_daily" ttd ON p.date = ttd.date AND ttd.type = 'bike'
    JOIN "main"."main"."mart__fact_all_trips_daily" ttm ON (p.date + 1) = ttm.date AND ttm.type = 'bike'
)

-- Calculate the average reduction in bike trips on days with precipitation compared to the previous day
SELECT AVG(trips_delta / trips_today) AS reduction_in_trips
FROM final
WHERE prcp_any_next AND NOT prcp_any;