CREATE OR REPLACE FUNCTION remove_indexes() 
    RETURNS void
	AS $func$
DECLARE
	DECLARE result TEXT;
BEGIN 
    -- Drop Index for cars table
	DROP INDEX IF EXISTS
    cars_brand_hash_index;

    -- Drop Index for jsonb_cars table
    DROP INDEX IF EXISTS
    jsonb_cars_brand_index;

    -- Drop Index for jsonb_cars table
    DROP INDEX IF EXISTS
    jsonb_cars_brand_is_used_index;

    -- Drop Index for jsonb_cars table
    DROP INDEX IF EXISTS
    jsonb_cars_data_gin_index;
    
    -- Drop Index for cars table
    DROP INDEX IF EXISTS
    cars_model_index;

    -- Drop Index for cars table
    DROP INDEX IF EXISTS
    cars_model_is_used_index;
    
    -- Drop Index for jsonb_cars table
    DROP INDEX IF EXISTS
    jsonb_cars_model_index;

   -- Drop Index for jsonb_cars table
    DROP INDEX IF EXISTS
    jsonb_cars_model_is_used_index;

    -- Drop Index for customers table
    DROP INDEX IF EXISTS
    customers_address_index;
    
    -- Drop Index for customers table
    DROP INDEX IF EXISTS
    customers_address_is_premium_index;
    
    -- Drop Index for jsonb_customers table
    DROP INDEX IF EXISTS
    jsonb_customers_address_index;
    
    -- Drop Index for jsonb_customers table
    DROP INDEX IF EXISTS
    jsonb_customers_address_is_premium_index;

    -- Drop Index for car_reservations table
    DROP INDEX IF EXISTS
    car_reservations_start_date_index;
    
    -- Drop Index for jsonb_car_reservations table
    DROP INDEX IF EXISTS
    jsonb_car_reservations_start_date_index;

    -- Drop Index for car_reservations table
    DROP INDEX IF EXISTS
    car_reservations_car_id_index;

    -- Drop Index for car_reservations table
    DROP INDEX IF EXISTS
    car_reservations_customer_id_index;
        
END;
$func$ LANGUAGE plpgsql;