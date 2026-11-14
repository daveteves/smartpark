--Schema
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    session_id INT NOT NULL,
    amount_due DECIMAL(10, 2) NOT NULL,
    amount_paid DECIMAL(10, 2) DEFAULT 0.00,
    method ENUM('Cash', 'Card', 'Digital Wallet') NOT NULL,
    status ENUM('Pending', 'Paid', 'Failed') DEFAULT 'Pending',
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (session_id) REFERENCES Parking_Sessions(session_id)
);

CREATE TABLE Violations (
    violation_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    session_id INT,
    violation_type VARCHAR(100) NOT NULL,
    fine_amount DECIMAL(10, 2) NOT NULL,
    status ENUM('Unpaid', 'Paid', 'Appealed') DEFAULT 'Unpaid',
    issued_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id) ON DELETE CASCADE,
    FOREIGN KEY (session_id) REFERENCES Parking_Sessions(session_id) ON DELETE SET NULL
);

CREATE TABLE Charging_Sessions (
    charging_id INT AUTO_INCREMENT PRIMARY KEY,
    session_id INT NOT NULL,
    charger_id INT NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME,
    energy_consumed_kwh DECIMAL(8, 2) DEFAULT 0.00,
    cost DECIMAL(10, 2) DEFAULT 0.00,
    FOREIGN KEY (session_id) REFERENCES Parking_Sessions(session_id) ON DELETE CASCADE,
    FOREIGN KEY (charger_id) REFERENCES EV_Chargers(charger_id) ON DELETE CASCADE
);

--Seed
INSERT INTO Payments (session_id, amount_due, amount_paid, method, status) VALUES
(1, 70.00, 0.00, 'Card', 'Pending');

INSERT INTO Violations (vehicle_id, session_id, violation_type, fine_amount, status) VALUES
(1, 1, 'Overstaying Grace Period', 100.00, 'Unpaid');

INSERT INTO Charging_Sessions (session_id, charger_id, start_time, end_time, energy_consumed_kwh, cost) VALUES
(2, 1, '2026-11-01 08:20:00', NULL, 15.50, 125.00);