# ---------------------------------------------------------------------- #
# Target DBMS:           MySQL                                           #
# Project name:          Cardealership                                   #
# ---------------------------------------------------------------------- #

USE cardealership;

# ---------------------------------------------------------------------- #
# Tables                                                                 #
# ---------------------------------------------------------------------- #
# Add table "dealerships"                                                #
# ---------------------------------------------------------------------- #

CREATE TABLE dealerships (
  dealership_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  address VARCHAR(50),
  phone VARCHAR(12)
);

# ---------------------------------------------------------------------- #
# Add table "vehicles"                                 			         #
# ---------------------------------------------------------------------- #

CREATE TABLE vehicles (
  VIN VARCHAR(50)PRIMARY KEY,
  make VARCHAR(50),
  model VARCHAR(50),
  year INT,
  price DOUBLE
);

# ---------------------------------------------------------------------- #
# Add table "inventory"                                 		         #
# ---------------------------------------------------------------------- #

CREATE TABLE inventory (
  dealership_id INT,
  VIN VARCHAR(50),
  PRIMARY KEY (dealership_id, VIN),
  FOREIGN KEY (dealership_id) REFERENCES dealerships (dealership_id),
  FOREIGN KEY (VIN) REFERENCES vehicles (VIN)
);

# ---------------------------------------------------------------------- #
# Add table "sales_contracts"                          			         #
# ---------------------------------------------------------------------- #

CREATE TABLE sales_contracts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  contract_number VARCHAR(50),
  VIN VARCHAR(50),
  contract_date DATE,
  customer_name VARCHAR(50),
  total_amount DOUBLE,
  FOREIGN KEY (VIN) REFERENCES vehicles (VIN)
);

# ---------------------------------------------------------------------- #
# Add table "lease_contracts"                          			         #
# ---------------------------------------------------------------------- #

CREATE TABLE lease_contracts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  contract_number VARCHAR(50),
  VIN VARCHAR(50),
  contract_date DATE,
  customer_name VARCHAR(50),
  monthly_payment DOUBLE,
  lease_term INT,
  FOREIGN KEY (VIN) REFERENCES vehicles (VIN)
);


# ---------------------------------------------------------------------- #
# Add info into "dealerships"                                            #
# ---------------------------------------------------------------------- #

INSERT INTO dealerships (name, address, phone)
VALUES
  ('ABC Motors', '123 Main Street', '555-1234'),
  ('XYZ Auto', '456 Elm Avenue', '555-5678'),
  ('Auto World', '789 Oak Lane', '555-9012'),
  ('Sunset Motors', '321 Sunset Boulevard', '555-2468'),
  ('City Auto Sales', '789 Maple Avenue', '555-3691'),
  ('Top Gear Motors', '987 Pine Street', '555-4820');

# ---------------------------------------------------------------------- #
# Add info into "inventory"                                              #
# ---------------------------------------------------------------------- #

INSERT INTO inventory (dealership_id, VIN)
VALUES
  (1, '1HGBH41JXMN109186'),
  (2, '2GTEK13T451128943'),
  (1, '3GNCA53X19S610082'),
  (3, '1C6RR7MT4ES345678'),
  (2, 'JM1BL1L73D1806257'),
  (3, '5NPE24AF4FH555444');


# ---------------------------------------------------------------------- #
# Add info into "lease_contracts"                                        #
# ---------------------------------------------------------------------- #

INSERT INTO lease_contracts (contract_number, VIN, contract_date, customer_name, monthly_payment, lease_term)
VALUES
  ('LC001', '1HGBH41JXMN109186', '2023-06-01', 'John Doe', 500.00, 12),
  ('LC002', '2GTEK13T451128943', '2023-06-01', 'Jane Smith', 600.00, 24),
  ('LC003', '3GNCA53X19S610082', '2023-07-01', 'Michael Johnson', 450.00, 12),
  ('LC004', '1C6RR7MT4ES345678', '2023-06-15', 'Emily Davis', 550.00, 12),
  ('LC005', 'JM1BL1L73D1806257', '2023-06-01', 'David Wilson', 400.00, 12),
  ('LC006', '5NPE24AF4FH555444', '2023-06-01', 'Sarah Thompson', 550.00, 12);

# ---------------------------------------------------------------------- #
# Add info into "sales_contracts"                          			     #
# ---------------------------------------------------------------------- #

INSERT INTO sales_contracts (contract_number, VIN, contract_date, customer_name, total_amount)
VALUES
  ('SC001', '1HGBH41JXMN109186', '2023-06-01', 'John Smith', 20000.00),
  ('SC002', '2GTEK13T451128943', '2023-06-02', 'Emily Johnson', 30000.00),
  ('SC003', '3GNCA53X19S610082', '2023-06-03', 'Michael Williams', 25000.00),
  ('SC004', '1C6RR7MT4ES345678', '2023-06-04', 'Emma Brown', 35000.00),
  ('SC005', 'JM1BL1L73D1806257', '2023-06-05', 'Sophia Davis', 18000.00),
  ('SC006', '5NPE24AF4FH555444', '2023-06-06', 'Daniel Johnson', 22000.00);

# ---------------------------------------------------------------------- #
# Add info into "vehicles"                                               #
# ---------------------------------------------------------------------- #

INSERT INTO vehicles (VIN, make, model, year, price)
VALUES
  ('1HGBH41JXMN109186', 'Toyota', 'Corolla', 2021, 25000.00),
  ('2GTEK13T451128943', 'GMC', 'Sierra', 2020, 35000.00),
  ('3GNCA53X19S610082', 'Chevrolet', 'Equinox', 2019, 20000.00),
  ('1C6RR7MT4ES345678', 'Ram', '1500', 2022, 40000.00),
  ('JM1BL1L73D1806257', 'Mazda', '3', 2018, 18000.00),
  ('5NPE24AF4FH555444', 'Hyundai', 'Sonata', 2020, 22000.00);

-- SHOW TABLES;
-- SELECT * FROM dealerships;
-- SELECT * FROM inventory;
-- SELECT * FROM lease_contracts;
-- SELECT * FROM sales_contracts;
-- SELECT * FROM vehicles;

INSERT INTO inventory (dealership_id, VIN)
SELECT 'XYZ Motors', '1C6RR7MT4ES345678'
FROM vehicles
WHERE dealerships.dealership_id = dealership_id;

SELECT * FROM vehicles; 

SELECT * FROM dealerships;
INSERT INTO inventory (dealership_id, VIN)
SELECT d.dealership_id, v.VIN
FROM vehicles v
JOIN dealerships d ON d.name = 'XYZ AUTO'
WHERE v.VIN = '1C6RR7MT4ES345678';


-- 1. FINDING ALL VEHICLES WITH THEIR DEALERSHIPS --
select * FROM dealerships
JOIN vehicles ON dealerships.dealership_id = vehicles.VIN;


-- 2. FIND ALL Vehicles for a specific dealship --
SELECT * FROM dealerships 
JOIN vehicles ON dealerships.dealership_id = vehicles.VIN
WHERE name = 'ABC Motors';


-- 3. FIND A CAR BY VIN -- 
SELECT * FROM vehicles
WHERE VIN = '1HGBH41JXMN109186';


-- 4. FIND THE DEALERSHIP WHERE A CERTAIN CAR IS LOCATED, BY VIN -- 
SELECT * FROM dealerships 
JOIN vehicles ON dealerships.dealership_id = vehicles.VIN
WHERE vin = '1HGBH41JXMN109186';



-- 5 FIND ALL DEALERSHIPS THAT HAVE A CERTAIN CAR TYPE --
SELECT * FROM dealerships 
JOIN vehicles ON dealerships.dealership_id = vehicles.VIN
WHERE make = 'Toyota';


-- 6. GET ALL SALES INFORMATION FOR A SPECIFIC DEALER FOR A SPECIFIC DATE RANGE -- 
SELECT * FROM dealerships 
JOIN sales_contracts ON dealerships.dealership_id = sales_contracts.VIN
WHERE contract_date = '2023-06-01'; 


