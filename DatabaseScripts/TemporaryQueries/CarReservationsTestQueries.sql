\connect CarReservationsDb;

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