CREATE OR REPLACE FUNCTION create_indexes() 
    RETURNS void
	AS $func$
DECLARE
	DECLARE result TEXT;
BEGIN 
	-- Create Hash Index for cars table
    -- on brand column
	CREATE INDEX IF NOT EXISTS 
    cars_brand_index 
    ON cars USING HASH(brand);
    
    -- Create BTree partial Index for cars table
    -- on brand column and is_used
	CREATE INDEX IF NOT EXISTS 
    cars_brand_is_used_index 
    ON cars USING HASH(brand)
    WHERE is_used = true;

    -- Create BTree Expression Index for jsonb_cars table
    -- on brand column, and partial on condition
    -- column data
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
    -- column data
    CREATE INDEX IF NOT EXISTS 
    jsonb_cars_data_gin_index 
    ON jsonb_cars USING GIN(data);

    -- Create BTree cars table
    -- on model column
    CREATE INDEX IF NOT EXISTS 
    cars_model_index 
    ON cars USING BTREE(model);

    -- Create BTree/Partial index on cars table
    -- on model column, and partial on condition
    CREATE INDEX IF NOT EXISTS 
    cars_model_is_used_index 
    ON cars USING BTREE(model)
    WHERE is_used = true;

    -- Create BTree/Partial Index on cars table
    -- on model column and partial condition 
    -- is_used = true
    CREATE INDEX IF NOT EXISTS 
    jsonb_cars_model_is_used_index  
    ON jsonb_cars USING BTREE (((data -> 'model')::VARCHAR))
    WHERE is_used = true;

    -- Create BTree Expression Index for jsonb_cars table
    -- on model column, and partial on condition
    CREATE INDEX IF NOT EXISTS 
    cars_model_partial_index 
    ON jsonb_cars USING BTREE (((data -> 'model')::VARCHAR))
    WHERE is_used = true;

    -- Create BTree index on customers table
    -- on model column
    CREATE INDEX IF NOT EXISTS 
    customers_address_index 
    ON customers USING BTREE(customer_address);

    -- Create BTree/Partial index on customers table
    -- on model column, and partial on condition
    -- is premimum
    -- Create Index for customers table
    CREATE INDEX IF NOT EXISTS 
    customers_address_is_premium_index 
    ON customers USING BTREE(customer_address)
    WHERE is_premium = true;

    -- Create BTree/Expression index on jsonb_customers table
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
    WHERE is_premium = true;

    -- Create BTree/Partial index on car_reservations table
    -- on model column, and partial on condition
    -- is is_deleted = false
    CREATE INDEX IF NOT EXISTS 
    car_reservations_start_date_index 
    ON car_reservations USING BTREE(start_date)
    WHERE is_deleted = false;
     
    -- Create BTree/Expression/Partial index on jsonb_car_reservations table
    -- on start_date expression and partial on condition
    -- is is_deleted = false
    CREATE INDEX IF NOT EXISTS 
    jsonb_car_reservations_start_date_index 
    ON jsonb_car_reservations (((data -> 'start_date')::TEXT))
    WHERE is_deleted = false;
        
END;
$func$ LANGUAGE plpgsql;