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
  vehicle_type varchar(20) NOT NULL CHECK (vehicle_type IN ('car', 'bike', 'truck')),
  model varchar(50),
  registration_number varchar(50) UNIQUE NOT NULL,
  rental_price_per_day decimal(10, 2) NOT NULL,
  availability_status varchar(20) NOT NULL CHECK (
    availability_status IN ('available', 'rented', 'maintenance')
  )
);


CREATE TABLE bookings (
  booking_id SERIAL PRIMARY KEY,
  user_id int NOT NULL,
  vehicle_id int NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  booking_status varchar(20) NOT NULL CHECK (
    booking_status IN ('pending', 'confirmed', 'completed', 'cancelled')
  ),
  total_cost decimal(10, 2) NOT NULL,
  CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
  CONSTRAINT fk_vehicle FOREIGN KEY (vehicle_id) REFERENCES vehicles (vehicle_id) ON DELETE CASCADE
);





