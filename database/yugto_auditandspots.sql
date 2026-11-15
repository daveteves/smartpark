-- Schema
CREATE TABLE Memberships (
    membership_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    plan_type ENUM('Monthly', 'Quarterly', 'Annual') NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status ENUM('Active', 'Expired', 'Cancelled') DEFAULT 'Active',
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Audit_Logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action_type VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    ip_address VARCHAR(45),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE SET NULL
);

CREATE TABLE Parking_Spots (
    spot_id INT AUTO_INCREMENT PRIMARY KEY,
    zone_id INT NOT NULL,
    spot_number VARCHAR(10) NOT NULL,
    status ENUM('Available', 'Occupied', 'Maintenance') DEFAULT 'Available',
    FOREIGN KEY (zone_id) REFERENCES Parking_Zones(zone_id) ON DELETE CASCADE,
    UNIQUE(zone_id, spot_number)
);

-- Seed
INSERT INTO Memberships (user_id, plan_type, start_date, end_date, status) VALUES
(2, 'Monthly', '2026-11-01', '2026-12-01', 'Active');

INSERT INTO Audit_Logs (user_id, action_type, description, ip_address) VALUES
(1, 'SYSTEM_START', 'System initialized by admin', '192.168.1.100'),
(2, 'USER_LOGIN', 'Customer logged in', '10.0.0.50');

INSERT INTO Parking_Spots (zone_id, spot_number, status) VALUES
(1, 'A1', 'Available'),
(1, 'A2', 'Occupied'),
(2, 'EV1', 'Occupied'),
(2, 'EV2', 'Available');