\connect CarReservationsDb;
-- Create cars Table
CREATE TABLE cars (
  id BIGSERIAL PRIMARY KEY,
  brand VARCHAR(50),
  model VARCHAR(50),
  company_name VARCHAR(50)
);

-- Create reservations Table
CREATE TABLE car_reservations (
  id BIGSERIAL PRIMARY KEY,
  car_id INT,
  customer_id INT,
  start_date DATE,
  end_date DATE
);

-- Create customers Table
CREATE TABLE customers (
  id BIGSERIAL PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  customer_address VARCHAR(50)
);