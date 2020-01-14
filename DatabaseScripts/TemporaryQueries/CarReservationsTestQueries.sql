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

 ------

 CREATE OR REPLACE FUNCTION queryAmir() 
	RETURNS 
	TABLE(id BIGINT, car_brand VARCHAR, car_model VARCHAR) 
	AS $func$
DECLARE
	sevenDaysInTheFuture DATE := (SELECT (SELECT NOW() + INTERVAL '7 DAY')::DATE);
	tomorrow DATE := (SELECT 'tomorrow'::DATE tomorrow);
BEGIN 
	RETURN QUERY
	-- EXPLAIN ANALYSE
    SELECT cr.id, ca.brand, ca.model 
	FROM car_reservations AS cr
    INNER JOIN cars AS ca ON cr.car_id = ca.id
    INNER JOIN customers AS cus ON cr.customer_id = cus.id
    WHERE 
        (cr.start_date BETWEEN tomorrow AND sevenDaysInTheFuture) OR
        (ca.brand = 'VW' OR 
        ca.model = 'Touareg' OR
        cus.first_name = 'Max');
END;
$func$ LANGUAGE plpgsql;

SELECT * FROM queryAmir();

-- DROP FUNCTION queryAmir()

----------------------------------------------------------

CREATE OR REPLACE FUNCTION queryAmir() 
	RETURNS 
	TABLE(id BIGINT, car_brand VARCHAR, car_model VARCHAR) 
	AS $func$
DECLARE
	sevenDaysInTheFuture DATE := (SELECT (SELECT NOW() + INTERVAL '7 DAY')::DATE);
	tomorrow DATE := (SELECT 'tomorrow'::DATE tomorrow);
BEGIN 
	RETURN QUERY
	-- EXPLAIN ANALYSE
    SELECT cr.id, ca.brand, ca.model 
	FROM car_reservations AS cr
    INNER JOIN cars AS ca ON cr.car_id = ca.id
    INNER JOIN customers AS cus ON cr.customer_id = cus.id
    WHERE 
        (cr.start_date BETWEEN tomorrow AND sevenDaysInTheFuture) OR
        (ca.brand = 'VW' OR 
        ca.model = 'Touareg' OR
        cus.first_name = 'Max');
END;
$func$ LANGUAGE plpgsql;

SELECT * FROM queryAmir();

------

-- To return Explain analyze

CREATE OR REPLACE FUNCTION queryAmir() 
	RETURNS 
	TEXT
	AS $func$
DECLARE
	sevenDaysInTheFuture DATE := (SELECT (SELECT NOW() + INTERVAL '7 DAY')::DATE);
	tomorrow DATE := (SELECT 'tomorrow'::DATE tomorrow);
	DECLARE analyzeResult TEXT;
BEGIN 
	EXPLAIN ANALYSE INTO analyzeResult
    SELECT cr.id, ca.brand, ca.model 
	FROM car_reservations AS cr
    INNER JOIN cars AS ca ON cr.car_id = ca.id
    INNER JOIN customers AS cus ON cr.customer_id = cus.id
    WHERE 
        (cr.start_date BETWEEN tomorrow AND sevenDaysInTheFuture) OR
        (ca.brand = 'VW' OR 
        ca.model = 'Touareg' OR
        cus.first_name = 'Max');
		RETURN analyzeResult;
END;
$func$ LANGUAGE plpgsql;


