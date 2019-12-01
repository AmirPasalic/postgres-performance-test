\connect CarReservationsDb;

------------------------------------------------
-- Example 1.
-- Select all from Cars table where the model is 'X5'.

-- Standard SQL

SELECT *
FROM cars
WHERE model = 'X5';
ANALYZE;


-- JSONB

SELECT *
FROM jsonb_cars
WHERE (data ->> 'model')::VARCHAR AS model = 'X5';
ANALYZE;


------------------------------------------------
-- Example 2.
-- Select all from Cars table where the model is 'X1'
-- or model is X3 or model is X5.

-- Standard SQL

SELECT *
FROM cars
WHERE model = 'X1' OR model = 'X3' OR model = 'X5';
ANALYZE;


-- JSONB

SELECT *
FROM jsonb_cars
WHERE 
	(data ->> 'model')::VARCHAR AS model = 'X1' OR
	(data ->> 'model')::VARCHAR AS model = 'X3' OR
	(data ->> 'model')::VARCHAR AS model = 'X5';
ANALYZE;


------------------------------------------------
-- Example 3.
-- Select all Cars where a Reservation exists

-- Standard SQL

SELECT *
FROM cars 
INNER JOIN car_reservations AS cr on car.id = cr.car_id


-- JSONB

SELECT * -- id, brand, model, company_name
FROM (
  SELECT 
	id,
	(data ->> 'car_id')::INTEGER AS car_id
  FROM jsonb_car_reservations
) tmp_jsonb_car_reservations
JOIN jsonb_cars AS cr
  ON (cr.id = tmp_jsonb_car_reservations.car_id);
  
 ANALYZE;


------------------------------------------------
------------------------------------------------
------------------------------------------------


-- Example ....

-- Standard SQL

SELECT COUNT(cr.id)
	FROM car_reservations as cr
	INNER JOIN cars on cr.car_id = cars.id
	WHERE cars.model = 'X5';

ANALYZE;

-- JSONB

SELECT COUNT(*) -- id, brand, model, company_name
FROM (
  SELECT 
	id,
	(data ->> 'brand')::VARCHAR AS brand,
	(data ->> 'model')::VARCHAR AS model,
	(data ->> 'company_name')::VARCHAR AS company_name
  FROM jsonb_cars
  WHERE
    (data ->> 'model')::VARCHAR = 'X5'
) tmp_jsonb_cars
JOIN jsonb_car_reservations AS cr
  ON (cr.id = tmp_jsonb_cars.id); --here should be cr.car_id = tmp_jsonb_cars.id but the cr.car_id is 
  -- in JSONB so this is not relevan query
  
 ANALYZE;