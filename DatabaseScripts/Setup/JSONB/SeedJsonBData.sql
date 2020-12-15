CREATE TYPE jsonb_cars_type AS (
    brand VARCHAR(50),
    model VARCHAR(50),
    company_name VARCHAR(50),
    is_used BOOLEAN
);

-- Insert into jsonb_cars table all rows from cars table    
INSERT INTO jsonb_cars(data) 
SELECT row_to_json(cast(row(brand, model, company_name, is_used) 
  as jsonb_cars_type)) 
FROM cars;


CREATE TYPE jsonb_car_reservations_type AS (
  car_id INT,
  customer_id INT,
  start_date VARCHAR(50),
  end_date DATE,
  is_deleted BOOLEAN,
  created_at TIMESTAMP
);

-- Insert into jsonb_car_reservations table all rows from cars table    
INSERT INTO jsonb_car_reservations(data) 
SELECT row_to_json(cast(row(car_id, customer_id, start_date, end_date, is_deleted, created_at) 
  as jsonb_car_reservations_type)) 
FROM car_reservations;


-- Create customers Table
CREATE TYPE jsonb_customers_type AS (
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  customer_address VARCHAR(50),
  is_premium BOOLEAN
);

-- Insert into jsonb_customers table all rows from cars table    
INSERT INTO jsonb_customers(data) 
SELECT row_to_json(cast(row(first_name, last_name, customer_address, is_premium) 
  as jsonb_customers_type)) 
FROM customers;
