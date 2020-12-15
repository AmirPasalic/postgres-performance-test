-- Returns table

CREATE OR REPLACE FUNCTION testFunction() 
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

-- run it

SELECT * FROM testFunction();

-- DROP FUNCTION testFunction()

------------------------------------------------
------------------------------------------------

-- To return Explain Analyze

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


------------------------

SELECT * FROM pg_class

select name, setting from pg_settings where name = 'autovacuum';

SELECT relname, relkind, reltuples, relpages
FROM pg_class
--ERE relname LIKE 'tenk1%';