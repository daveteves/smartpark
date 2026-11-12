--Schema
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'Operator', 'Customer') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Parking_Zones (
    zone_id INT AUTO_INCREMENT PRIMARY KEY,
    zone_name VARCHAR(50) NOT NULL,
    floor_level INT NOT NULL,
    capacity INT NOT NULL,
    zone_type ENUM('Standard', 'VIP', 'EV', 'Disabled') NOT NULL
);

--Seed
INSERT INTO Users (first_name, last_name, email, password_hash, role) VALUES
('Admin', 'User', 'admin@smartpark.com', 'hash_admin_123', 'Admin'),
('Dave', 'Teves', 'dave@email.com', 'hash_dave_456', 'Customer'),
('Rudylyn', 'Tero', 'rudylyn.t@email.com', 'hash_rudy_789', 'Customer');

INSERT INTO Parking_Zones (zone_name, floor_level, capacity, zone_type) VALUES
('Level 1 North', 1, 50, 'Standard'),
('Level 1 South', 1, 20, 'EV'),
('Level 2 VIP', 2, 30, 'VIP');