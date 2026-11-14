--Schema
CREATE TABLE Reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    spot_id INT NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    status ENUM('Pending', 'Active', 'Completed', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (spot_id) REFERENCES Parking_Spots(spot_id) ON DELETE CASCADE
    );

    CREATE TABLE Parking_Sessions (
        session_id INT AUTO_INCREMENT PRIMARY KEY,
        vehicle_id INT NOT NULL,
        spot_id INT NOT NULL,
        entry_timestamp DATETIME NOT NULL,
        exit_timestamp DATETIME,
        status ENUM('Active', 'Completed') DEFAULT 'Active',
        FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id),
        FOREIGN KEY (spot_id) REFERENCES Parking_Spots(spot_id)
    );

--Seed
INSERT INTO Reservations (user_id, spot_id, start_time, end_time, status) VALUES
(2, 1, '2026-11-02 08:00:00', '2026-11-02 12:00:00', 'Pending');

INSERT INTO Parking_Sessions (vehicle_id, spot_id, entry_timestamp, exit_timestamp, status) VALUES
(1, 2, '2026-11-01 07:30:00', NULL, 'Active'),
(2, 3, '2026-11-01 08:15:00', NULL, 'Active');
