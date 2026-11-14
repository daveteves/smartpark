--Schema
CREATE TABLE IoT_Devices (
    device_id INT AUTO_INCREMENT PRIMARY KEY,
    zone_id INT NOT NULL,
    device_type ENUM('Camera', 'Boom Barrier', 'Spot Sensor', 'Kiosk') NOT NULL,
    ip_address VARCHAR(45) UNIQUE,
    status ENUM('Online', 'Offline', 'Maintenance') DEFAULT 'Online',
    last_ping TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (zone_id) REFERENCES Parking_Zones(zone_id) ON DELETE CASCADE
);

CREATE TABLE RFID_Tags (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    rfid_code VARCHAR(100) UNIQUE NOT NULL,
    issue_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id) ON DELETE CASCADE
);

CREATE TABLE EV_Chargers (
    charger_id INT AUTO_INCREMENT PRIMARY KEY,
    spot_id INT UNIQUE NOT NULL,
    charger_type ENUM('Level 1', 'Level 2', 'DC Fast') NOT NULL,
    power_output_kw DECIMAL(5, 2) NOT NULL,
    status ENUM('Available', 'In Use', 'Out of Order') DEFAULT 'Available',
    FOREIGN KEY (spot_id) REFERENCES Parking_Spots(spot_id) ON DELETE CASCADE
);

--Seed
INSERT INTO IoT_Devices (zone_id, device_type, ip_address, status) VALUES
(1, 'Boom Barrier', '192.168.1.10', 'Online'),
(2, 'Camera', '192.168.1.11', 'Online');

INSERT INTO RFID_Tags (vehicle_id, rfid_code, issue_date) VALUES
(1, 'RFID-CAR-001', '2026-11-01'),
(2, 'RFID-EV-002', '2026-11-01');

INSERT INTO EV_Chargers (spot_id, charger_type, power_output_kw, status) VALUES
(3, 'Level 2', 7.20, 'In Use'),
(4, 'DC Fast', 50.00, 'Available');