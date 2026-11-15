const db = require('../config/db');

class Transactions {

    // RESERVATIONS
    
    static async findAllReservations() {
        const [rows] = await db.execute(
            'SELECT * FROM Reservations ORDER BY reservation_id DESC'
        );
        return rows;
    }

    static async findReservationById(id) {
        const [rows] = await db.execute(
            'SELECT * FROM Reservations WHERE reservation_id = ?',
            [id]
        );
        return rows[0];
    }

    static async hasReservationConflict(
        spotId, startTime, endTime, excludeId = null
    ) {
        let sql = `
            SELECT reservation_id
            FROM Reservations
            WHERE spot_id = ?
            AND status IN ('Pending', 'Active')
            AND start_time < ?
            AND end_time > ?
        `;

        const params = [spotId, endTime, startTime];

        if (excludeId !== null) {
            sql += ' AND reservation_id <> ?';
            params.push(excludeId);
        }

        const [rows] = await db.execute(sql, params);

        return rows.length > 0;
    }

    static async createReservation(data) {
        const {
            user_id,
            spot_id,
            start_time,
            end_time,
            status
        } = data;

        const [result] = await db.execute(
            `INSERT INTO Reservations
            (user_id, spot_id, start_time, end_time, status)
            VALUES (?, ?, ?, ?, ?)`,
            [user_id, spot_id, start_time, end_time, status || 'Pending']
        );

        return result.insertId;
    }

    static async updateReservation(id, data) {
        const {
            user_id,
            spot_id,
            start_time,
            end_time,
            status
        } = data;

        const [result] = await db.execute(
            `UPDATE Reservations
            SET user_id = ?,
                spot_id = ?,
                start_time = ?,
                end_time = ?,
                status = ?
            WHERE reservation_id = ?`,
            [user_id, spot_id, start_time, end_time, status, id]
        );

        return result.affectedRows;
    }

    static async deleteReservation(id) {
        const [result] = await db.execute(
            'DELETE FROM Reservations WHERE reservation_id = ?',
            [id]
        );

        return result.affectedRows;
    }

    // PARKING SESSIONS
    
    static async findAllSessions() {
        const [rows] = await db.execute(
            'SELECT * FROM Parking_Sessions ORDER BY session_id DESC'
        );

        return rows;
    }

    // GET SESSION BY ID
    static async findSessionById(id) {
        const [rows] = await db.execute(
            'SELECT * FROM Parking_Sessions WHERE session_id = ?',
            [id]
        );

        return rows[0];
    }

    static async createSession(data) {
        const {
            vehicle_id,
            spot_id,
            entry_timestamp,
            exit_timestamp = null,
            status = 'Active'
        } = data;

        const [result] = await db.execute(
            `INSERT INTO Parking_Sessions
            (vehicle_id, spot_id, entry_timestamp,
            exit_timestamp, status)
            VALUES (?, ?, ?, ?, ?)`,
            [
                vehicle_id,
                spot_id,
                entry_timestamp,
                exit_timestamp,
                status
            ]
        );

        return result.insertId;
    }

    static async updateSession(id, data) {
        const {
            vehicle_id,
            spot_id,
            entry_timestamp,
            exit_timestamp,
            status
        } = data;

        const [result] = await db.execute(
            `UPDATE Parking_Sessions
            SET vehicle_id = ?,
                spot_id = ?,
                entry_timestamp = ?,
                exit_timestamp = ?,
                status = ?
            WHERE session_id = ?`,
            [
                vehicle_id,
                spot_id,
                entry_timestamp,
                exit_timestamp,
                status,
                id
            ]
        );

        return result.affectedRows;
    }

    static async recordExit(id) {
        const [result] = await db.execute(
            `UPDATE Parking_Sessions
            SET exit_timestamp = NOW(),
                status = 'Completed'
            WHERE session_id = ?
            AND status = 'Active'`,
            [id]
        );

        return result.affectedRows;
    }

    static async deleteSession(id) {
        const [result] = await db.execute(
            'DELETE FROM Parking_Sessions WHERE session_id = ?',
            [id]
        );

        return result.affectedRows;
    }

    // REQUIRED INNER JOIN REPORT

    static async getSessionsWithSpots() {
        const [rows] = await db.execute(`
            SELECT
                ps.session_id,
                ps.vehicle_id,
                ps.spot_id,
                ps.entry_timestamp,
                ps.exit_timestamp,
                ps.status,
                sp.spot_id AS matched_spot_id
            FROM Parking_Sessions ps
            INNER JOIN Parking_Spots sp
                ON ps.spot_id = sp.spot_id
            ORDER BY ps.session_id DESC
        `);

        return rows;
    }

}

module.exports = Transactions;