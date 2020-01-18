CREATE OR REPLACE FUNCTION seed_data(INT) RETURNS void AS $$
DECLARE
   entriesCount ALIAS FOR $1; -- change to 1000000
   trippleEntriesCount INT := entriesCount * 3;
   day1InTheFuture DATE := (SELECT 'tomorrow'::DATE tomorrow);
   days7InTheFuture DATE := (SELECT (SELECT NOW() + INTERVAL '7 DAY')::DATE);
   days14InTheFuture DATE := (SELECT (SELECT NOW() + INTERVAL '14 DAY')::DATE);
   days21InTheFuture DATE := (SELECT (SELECT NOW() + INTERVAL '14 DAY')::DATE);
   days28InTheFuture DATE := (SELECT (SELECT NOW() + INTERVAL '14 DAY')::DATE);
BEGIN 
	-- Insert into cars Table - BMWs
	INSERT INTO cars (brand, model, company_name)
		SELECT 'BMW',
			('{"120d", "X1", "X3", "X5", "X6"}'::TEXT[])
				[i % 5 + 1],
			'Bayerische Motoren Werke AG'
			FROM generate_series(1, entriesCount) as i;

	-- Insert into cars Table - VWs
	INSERT INTO cars (brand, model, company_name)
		SELECT 'VW',
			('{"Jetta", "Tiguan", "Touareg", "Passat", "Golf"}'::TEXT[])
				[i % 5 + 1],
			'Volkswagen AG'
			FROM generate_series(1, entriesCount) as i;

	-- Insert into cars Table - Mercedeses
	INSERT INTO cars (brand, model, company_name)
		SELECT 'Mercedes-Benz',
			('{"GLA", "B180", "CLS", "GLC", "GLE"}'::TEXT[])
				[i % 5 + 1],
			'Daimler AG'
			FROM generate_series(1, entriesCount) as i;

	-- Insert Customers
	INSERT INTO customers (first_name, last_name, customer_address)
		SELECT 
			('{"Adam", "John", "Max", "Joe", "Anthony"}'::TEXT[])
				[i % 5 + 1],
			('{"Miller", "Blake", "Doe", "Will", "Tommas"}'::TEXT[])
				[i % 5 + 1],
			('{"Berlin", "Munich", "Hamburg", "Stuttgart", "Frankfurt"}'::TEXT[])
				[i % 5 + 1]
			FROM generate_series(1, entriesCount) as i;

	-- Insert Car Reservations
	INSERT INTO car_reservations (car_id, customer_id, start_date, end_date)
		SELECT 
			(SELECT trunc(random() * 3000 + 1) WHERE i = i), -- carId
			-- randomly generate carId from 1 - 3000
			(SELECT trunc(random() * 1000 + 1) WHERE i = i), -- customerId
			-- the WHERE i = i is to fake a condition.
			-- PostgreSQL can treat such a scalar subquery, which doesn’t have any outer dependences as a stable one
			-- so it will be evaluated only once. And random would generate always the same number
			day1InTheFuture, -- startDate
			days7InTheFuture -- endDate
			FROM generate_series(1, trippleEntriesCount) as i;

	-- Insert 3 Milion Car Reservations
	INSERT INTO car_reservations (car_id, customer_id, start_date, end_date)
		SELECT 
			(SELECT trunc(random() * 3000 + 1) WHERE i = i), -- carId
			(SELECT trunc(random() * 1000 + 1) WHERE i = i), -- customerId
			days7InTheFuture, -- startDate
			days14InTheFuture -- endDate
			FROM generate_series(1, trippleEntriesCount) as i;

	-- Insert 3 Milion Car Reservations
	INSERT INTO car_reservations (car_id, customer_id, start_date, end_date)
		SELECT 
			(SELECT trunc(random() * 3000 + 1) WHERE i = i), -- carId
			(SELECT trunc(random() * 1000 + 1) WHERE i = i), -- customerId
			days14InTheFuture, -- startDate
			days21InTheFuture -- endDate
			FROM generate_series(1, trippleEntriesCount) as i;

	-- Insert 3 Milion Car Reservations
	INSERT INTO car_reservations (car_id, customer_id, start_date, end_date)
		SELECT 
			(SELECT trunc(random() * 3000 + 1) WHERE i = i), -- carId
			(SELECT trunc(random() * 1000 + 1) WHERE i = i), -- customerId
			days21InTheFuture, -- startDate
			days28InTheFuture -- endDate
			FROM generate_series(1, trippleEntriesCount) as i;

			-- select trunc(random() * 1000 + 1)
END;
$$ LANGUAGE plpgsql;
