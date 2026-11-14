-- Schema
CREATE TABLE Tariff_Rules (
    tariff_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_type ENUM('Car', 'Motorcycle', 'EV') NOT NULL,
    base_rate DECIMAL(10, 2) NOT NULL,
    hourly_rate DECIMAL(10, 2) NOT NULL,
    daily_max DECIMAL(10, 2) NOT NULL,
    grace_period INT NOT NULL
);

CREATE TABLE Promo_Codes (
    promo_id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(20) UNIQUE NOT NULL,
    discount_percentage DECIMAL(5, 2),
    discount_amount DECIMAL(10, 2),
    valid_from DATE NOT NULL,
    valid_until DATE NOT NULL,
    usage_limit INT DEFAULT 1,
    times_used INT DEFAULT 0
);

CREATE TABLE Vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    license_plate VARCHAR(20) UNIQUE NOT NULL,
    vehicle_type ENUM('Car', 'Motorcycle', 'EV') NOT NULL,
    color VARCHAR(30),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

