CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    role varchar(20) NOT NULL CHECK (role IN ('admin', 'customer')),
    name varchar(100) NOT NULL,
    email varchar(100) UNIQUE NOT NULL,
    password varchar(255) NOT NULL,
    phone varchar(20)
);

CREATE TABLE vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    vehicle_name varchar(100) NOT NULL,
    vehicle_type varchar(20) NOT NULL CHECK (
        vehicle_type IN ('car', 'bike', 'truck')
    ),
    model varchar(50),
    registration_number varchar(50) UNIQUE NOT NULL,
    rental_price_per_day decimal(10, 2) NOT NULL,
    availability_status varchar(20) NOT NULL CHECK (
        availability_status IN (
            'available',
            'rented',
            'maintenance'
        )
    )
);

CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id int NOT NULL,
    vehicle_id int NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    booking_status varchar(20) NOT NULL CHECK (
        booking_status IN (
            'pending',
            'confirmed',
            'completed',
            'cancelled'
        )
    ),
    total_cost decimal(10, 2) NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
    CONSTRAINT fk_vehicle FOREIGN KEY (vehicle_id) REFERENCES vehicles (vehicle_id) ON DELETE CASCADE
);

-- solutions
-- 1
SELECT b.booking_id, u.name AS customer_name, v.vehicle_name, b.start_date, b.end_date, b.booking_status
FROM
    bookings b
    INNER JOIN users u ON b.user_id = u.user_id
    INNER JOIN vehicles v ON b.vehicle_id = v.vehicle_id;

-- 2
SELECT
  v.vehicle_id,
  v.vehicle_name,
  v.vehicle_type,
  v.registration_number,
  v.model,
  v.availability_status,
  v.rental_price_per_day
FROM
  vehicles v
WHERE
  NOT EXISTS (
    SELECT
      1
    FROM
      bookings b
    WHERE
      b.vehicle_id = v.vehicle_id
  );

-- 3
SELECT
  vehicle_id,
  vehicle_name,
  model,
  vehicle_type,
  rental_price_per_day,
  availability_status
FROM
  vehicles
WHERE
  availability_status = 'available'
  AND vehicle_type = 'car';

-- 4
SELECT v.vehicle_name, COUNT(b.booking_id) AS total_bookings
FROM vehicles v
    INNER JOIN bookings b ON v.vehicle_id = b.vehicle_id
GROUP BY
    v.vehicle_id,
    v.vehicle_name
HAVING
    COUNT(b.booking_id) > 2;