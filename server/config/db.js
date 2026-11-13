const path = require('path');
const mysql = require('mysql2/promise');

// Load .env
require('dotenv').config({ path: path.resolve(__dirname, '.env') });
if (!process.env.DB_USER) {
    require('dotenv').config({ path: path.resolve(__dirname, '../.env') });
}

const pool = mysql.createPool({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

// Test
(async () => {
    try {
        const connection = await pool.getConnection();
        console.log(`Connected to MySQL database: ${process.env.DB_NAME}`);
        connection.release();
    } catch (err) {
        console.error('Database connection failed:', err.message);
        console.error('Loaded DB_USER:', process.env.DB_USER); // Helps verify if .env was read
    }
})();

module.exports = pool;
