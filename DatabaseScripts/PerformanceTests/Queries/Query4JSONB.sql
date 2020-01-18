------------------------------------------------------------
------------------------------------------------------------

-- Query 4
-- Select all Cars where a Reservation exists
-- JSONB

EXPLAIN ANALYSE  
SELECT * -- id, brand, model, company_name
FROM (
  SELECT 
    id,
    (data ->> 'car_id')::INTEGER AS car_id
  FROM jsonb_car_reservations
) tmp_jsonb_car_reservations
JOIN jsonb_cars AS cr
  ON (cr.id = tmp_jsonb_car_reservations.car_id);
