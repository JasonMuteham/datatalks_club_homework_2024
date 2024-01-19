SELECT COUNT(*) as total_trips
FROM main.green_2019_09
WHERE lpep_pickup_datetime::date = '2019-09-18';

SELECT lpep_pickup_datetime::date as pickup_date, trip_distance 
FROM main.green_2019_09
WHERE pickup_date in ('2019-09-18','2019-09-16','2019-09-26','2019-09-21')
ORDER BY trip_distance DESC
LIMIT 3;

SELECT lpep_pickup_datetime::date as pickup_date, Borough as borough, SUM(total_amount)::DECIMAL as total
FROM main.green_2019_09
JOIN zone_lookup ON PULocationID = LocationID
WHERE pickup_date = '2019-09-18' and borough IN ('Brooklyn','Manhattan','Queens','Bronx','Staten Island')
GROUP BY ALL
HAVING total > 50000
ORDER BY total DESC;

SELECT pickup.zone as pickup_zone, dropoff.zone as dropoff_zone, tip_amount, pickup.LocationID, dropoff.LocationID
FROM main.green_2019_09 
JOIN zone_lookup pickup ON PULocationID = pickup.LocationID
JOIN zone_lookup dropoff ON DOLocationID = dropoff.LocationID
WHERE pickup.zone = 'Astoria'
ORDER BY tip_amount DESC
LIMIT 5;