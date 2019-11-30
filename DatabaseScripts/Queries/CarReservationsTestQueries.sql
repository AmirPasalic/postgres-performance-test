\connect CarReservationsDb;

SELECT cr.id, cars.id, cars.brand, cars.model, cars.companyname
	FROM car_reservations as cr
	INNER JOIN cars on cr.carid = cars.id
	WHERE cars.model = 'X5';

SELECT COUNT(cr.id)
	FROM car_reservations as cr
	INNER JOIN cars on cr.carid = cars.id
	WHERE cars.model = 'X5';
