DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS screenings;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS films;


CREATE TABLE customers(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  funds INT8
);

CREATE TABLE films(
  id SERIAL8 PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  price INT8 NOT NULL
);

CREATE TABLE tickets(
  id SERIAL8 PRIMARY KEY,
  customer_id INT8 NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT8 NOT NULL REFERENCES films(id) ON DELETE CASCADE
);

CREATE TABLE screenings(
  id SERIAL8 PRIMARY KEY,
  film_id INT8 REFERENCES films(id) ON DELETE CASCADE,
  showing VARCHAR(5),
  capacity INT4 NOT NULL,
  available INT4,
  CHECK (available <= capacity)
);
