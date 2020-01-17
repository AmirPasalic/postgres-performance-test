------------------------------------------------------------
------------------------------------------------------------

-- Example 4.
-- Select customer names, cars brand and model and car_reservations start_date 
-- where a car_reservation for that car exists
-- JSONB

SELECT 
  (tmp_jsonb_car_reservations.id)::INTEGER AS car_reservations_id,
  (ca.data ->> 'brand')::VARCHAR AS car_brand, 
  (ca.data ->> 'model')::VARCHAR AS car_model, 
  (cus.data ->> 'first_name'):: VARCHAR AS customer_first_name, 
  (cus.data ->> 'last_name'):: VARCHAR AS customer_last_name,
  (tmp_jsonb_car_reservations.start_date):: DATE AS reservation_start_date
FROM (
  SELECT 
	  id,
	  (data ->> 'car_id')::INTEGER AS car_id,
  	(data ->> 'customer_id')::INTEGER AS customer_id,
	  (data ->> 'start_date')::DATE AS start_date
  FROM jsonb_car_reservations
) tmp_jsonb_car_reservations
INNER JOIN jsonb_cars AS ca
  ON (ca.id = tmp_jsonb_car_reservations.car_id)
INNER JOIN jsonb_customers AS cus
  ON (cus.id = tmp_jsonb_car_reservations.customer_id);
