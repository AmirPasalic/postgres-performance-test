\connect CarReservationsDb;

DO $$ 
DECLARE
   milionEntries INT := 1000000;
   tree_milionEntries INT := milionEntries * 3;
BEGIN 
	-- Insert into cars Table - 1 Milion BMWs
	INSERT INTO cars (brand, model, company_name)
		SELECT 'BMW',
			('{"120d", "X1", "X3", "X5", "X6"}'::TEXT[])
				[i % 5 + 1],
			'Bayerische Motoren Werke AG'
			FROM generate_series(1, milionEntries) as i;

	-- Insert into cars Table - 1 Milion VWs
	INSERT INTO cars (brand, model, company_name)
		SELECT 'VW',
			('{"Jetta", "Tiguan", "Touareg", "Passat", "Golf"}'::TEXT[])
				[i % 5 + 1],
			'Volkswagen AG'
			FROM generate_series(1, milionEntries) as i;

	-- Insert into cars Table - 1 Milion Mercedeses
	INSERT INTO cars (brand, model, company_name)
		SELECT 'Mercedes-Benz',
			('{"GLA", "B180", "CLS", "GLC", "GLE"}'::TEXT[])
				[i % 5 + 1],
			'Daimler AG'
			FROM generate_series(1, milionEntries) as i;

	-- Insert 1 Milion Customers
	INSERT INTO customers (first_name, last_name, customer_address)
		SELECT 
			('{"Adam", "John", "Max", "Joe", "Anthony"}'::TEXT[])
				[i % 5 + 1],
			('{"Miller", "Blake", "Doe", "Will", "Tommas"}'::TEXT[])
				[i % 5 + 1],
			('{"Berlin", "Munich", "Hamburg", "Stuttgart", "Frankfurt"}'::TEXT[])
				[i % 5 + 1]
			FROM generate_series(1, milionEntries) as i;

	-- Insert 3 Milion Car Reservations
	INSERT INTO car_reservations (car_id, customer_id, start_date, end_date)
		SELECT 
			i, -- carId
			3000000 - i, -- customerId
			'2020-01-21', -- startDate
			'2020-01-28' -- endDate
			FROM generate_series(1, tree_milionEntries) as i;

	-- Insert 3 Milion Car Reservations
	INSERT INTO car_reservations (car_id, customer_id, start_date, end_date)
		SELECT 
			i, -- carId
			3000000 - i, -- customerId
			'2020-02-01', -- startDate
			'2020-02-10' -- endDate
			FROM generate_series(1, tree_milionEntries) as i;

	-- Insert 3 Milion Car Reservations
	INSERT INTO car_reservations (car_id, customer_id, start_date, end_date)
		SELECT 
			i, -- carId
			3000000 - i, -- customerId
			'2020-02-10', -- startDate
			'2020-02-17' -- endDate
			FROM generate_series(1, tree_milionEntries) as i;

	-- Insert 3 Milion Car Reservations
	INSERT INTO car_reservations (car_id, customer_id, start_date, end_date)
		SELECT 
			i, -- carId
			3000000 - i, -- customerId
			'2020-02-18', -- startDate
			'2020-02-25' -- endDate
			FROM generate_series(1, tree_milionEntries) as i;

END $$;


