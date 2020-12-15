CREATE OR REPLACE FUNCTION create_indexes() 
    RETURNS void
	AS $func$
DECLARE
	DECLARE result TEXT;
BEGIN 
	-- Create Hash Index for cars table
    -- on brand column
	CREATE INDEX IF NOT EXISTS 
    cars_brand_hash_index 
    ON cars USING HASH(brand);
    
    -- Create BTree Expression Index for jsonb_cars table
    -- on brand column
    CREATE INDEX IF NOT EXISTS 
    jsonb_cars_brand_index 
    ON jsonb_cars USING BTREE (((data -> 'brand')::VARCHAR));

    -- Create BTree Expression/Partial Index for jsonb_cars table
    -- on brand column, and partial on condition
    -- is_used = true 
    CREATE INDEX IF NOT EXISTS 
    jsonb_cars_brand_is_used_index
    ON jsonb_cars USING BTREE (((data -> 'brand')::VARCHAR))
    WHERE (((data -> 'is_used')::BOOLEAN)) = true;

    -- Create GIN Index for jsonb_cars table
    -- on data JSONB column
    CREATE INDEX IF NOT EXISTS 
    jsonb_cars_data_gin_index 
    ON jsonb_cars USING GIN(data);

    -- Create BTree Index for cars table
    -- on model column
    CREATE INDEX IF NOT EXISTS 
    cars_model_index 
    ON cars USING BTREE(model);

    -- Create BTree/Partial Index for cars table
    -- on model column, and partial on condition
    -- is_used
    CREATE INDEX IF NOT EXISTS 
    cars_model_is_used_index 
    ON cars USING BTREE(model)
    WHERE is_used = true;

    -- Create BTree Expression Index on cars table
    -- on model column
    CREATE INDEX IF NOT EXISTS 
    jsonb_cars_model_index  
    ON jsonb_cars USING BTREE (((data -> 'model')::VARCHAR));

    -- Create BTree Expression Index for jsonb_cars table
    -- on model column, and partial on condition
    CREATE INDEX IF NOT EXISTS 
    jsonb_cars_model_is_used_index 
    ON jsonb_cars USING BTREE (((data -> 'model')::VARCHAR))
    WHERE (((data -> 'is_used')::BOOLEAN)) = true;

    -- Create BTree Index on customers table
    -- on customer_address column
    CREATE INDEX IF NOT EXISTS 
    customers_address_index 
    ON customers USING BTREE(customer_address);

    -- Create BTree Partial Index on customers table
    -- on customer_address column, and partial on condition
    -- is premimum
    CREATE INDEX IF NOT EXISTS 
    customers_address_is_premium_index 
    ON customers USING BTREE(customer_address)
    WHERE is_premium = true;

    -- Create BTree/Expression Index on jsonb_customers table
    -- on customer_address expression
    CREATE INDEX IF NOT EXISTS 
    jsonb_customers_address_index 
    ON jsonb_customers USING BTREE(((data -> 'customer_address')::VARCHAR)); 

    -- Create BTree/Expression/Partial index on jsonb_customers table
    -- on customer_address expression and partial on condition
    -- is premimum
    CREATE INDEX IF NOT EXISTS 
    jsonb_customers_address_is_premium_index 
    ON jsonb_customers USING BTREE(((data -> 'customer_address')::VARCHAR))
    WHERE (((data -> 'is_premium')::BOOLEAN)) = true;

    -- Create BTree Partial Index on car_reservations table
    -- on start_date column, and partial on condition
    -- is is_deleted = false
    CREATE INDEX IF NOT EXISTS 
    car_reservations_start_date_index 
    ON car_reservations USING BTREE(start_date)
    WHERE is_deleted = false;
     
    -- Create BTree Expression/Partial index on jsonb_car_reservations table
    -- on start_date expression and partial on condition
    -- is is_deleted = false
    CREATE INDEX IF NOT EXISTS 
    jsonb_car_reservations_start_date_index 
    ON jsonb_car_reservations (((data -> 'start_date')::TEXT))
    WHERE (((data -> 'is_deleted')::BOOLEAN)) = false;
        
    -- Create BTree Index on car_reservations table
    -- on car_id column
    CREATE INDEX IF NOT EXISTS 
    car_reservations_car_id_index 
    ON car_reservations USING BTREE(car_id); --car_id and customer_id

    -- Create BTree Index on car_reservations table
    -- on customer_id column
    CREATE INDEX IF NOT EXISTS 
    car_reservations_customer_id_index
    ON car_reservations USING BTREE(customer_id);

END;
$func$ LANGUAGE plpgsql;