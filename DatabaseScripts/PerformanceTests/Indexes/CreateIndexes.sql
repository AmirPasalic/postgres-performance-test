CREATE OR REPLACE FUNCTION create_indexes() 
    RETURNS void
	AS $func$
DECLARE
	DECLARE result TEXT;
BEGIN 
	-- Create Index for cars table
	CREATE INDEX IF NOT EXISTS 
    cars_brand_index 
    ON cars (brand);
    
    CREATE INDEX IF NOT EXISTS 
    cars_model_index 
    ON cars (model);

    -- Create Index for customers table
    CREATE INDEX IF NOT EXISTS 
    customers_address_index 
    ON customers (customer_address);

    -- Create Index for car_reservations table
    CREATE INDEX IF NOT EXISTS 
    car_reservations_start_date_index 
    ON car_reservations (start_date);

    -- Create Index for jsonb_cars table
    CREATE INDEX IF NOT EXISTS 
    jsonb_cars_brand_index 
    ON jsonb_cars (((data ->> 'brand')::VARCHAR)); 
    --This or GIN index??
    
    CREATE INDEX IF NOT EXISTS 
    jsonb_cars_model_index 
    ON jsonb_cars (((data ->> 'model')::VARCHAR)); 
    --This or GIN index??

    -- Create Index for jsonb_customers table
    CREATE INDEX IF NOT EXISTS 
    jsonb_customers_address_index 
    ON jsonb_customers (((data ->> 'customer_address')::VARCHAR)); 
    --This or GIN index??

    -- Create Index for jsonb_car_reservations table
    CREATE INDEX IF NOT EXISTS 
    jsonb_car_reservations_start_date_index 
    ON jsonb_car_reservations (((data ->> 'start_date')::TEXT)); 
    --This or GIN index??
        
END;
$func$ LANGUAGE plpgsql;