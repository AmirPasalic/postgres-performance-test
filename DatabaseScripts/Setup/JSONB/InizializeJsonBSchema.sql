-- Initialuze the JSONB schema

\connect CarReservationsDb;

-- Create cars Table
CREATE TABLE jsonb_cars (
  id BIGSERIAL PRIMARY KEY,
  "data" JSONB
);

-- Create reservations Table
CREATE TABLE jsonb_car_reservations (
  id BIGSERIAL PRIMARY KEY,
  "data" JSONB
);

-- Create customers Table
CREATE TABLE jsonb_customers (
  id BIGSERIAL PRIMARY KEY,
  "data" JSONB
);