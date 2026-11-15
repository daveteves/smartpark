const Transactions = require('../models/Transactions');

  // RESERVATIONS CRUD

exports.getAllReservations = async (req, res) => {
    try {
    const data = await Transactions.findAllReservations();
    res.status(200).json({ success: true, data });
    } catch (error) {
    res.status(500).json({ success: false, message: 'Database error', error: error.message });
    }
};

exports.getReservationById = async (req, res) => {
    try {
    const data = await Transactions.findReservationById(req.params.id);
    if (!data) return res.status(404).json({ success: false, message: 'Reservation not found' });
    res.status(200).json({ success: true, data });
    } catch (error) {
    res.status(500).json({ success: false, message: 'Database error', error: error.message });
    }
};

exports.createReservation = async (req, res) => {
    try {
    const reservationId = await Transactions.createReservation(req.body);
    res.status(201).json({ success: true, reservationId });
    } catch (error) {
    res.status(400).json({ success: false, message: 'Invalid input', error: error.message });
    }
};

exports.updateReservation = async (req, res) => {
    try {
    const affectedRows = await Transactions.updateReservation(req.params.id, req.body);
    if (affectedRows === 0) return res.status(404).json({ success: false, message: 'Reservation not found' });
    res.status(200).json({ success: true, message: 'Reservation updated successfully' });
    } catch (error) {
    res.status(400).json({ success: false, message: 'Invalid input', error: error.message });
    }
};

exports.deleteReservation = async (req, res) => {
    try {
    const affectedRows = await Transactions.deleteReservation(req.params.id);
    if (affectedRows === 0) return res.status(404).json({ success: false, message: 'Reservation not found' });
    res.status(200).json({ success: true, message: 'Reservation deleted successfully' });
    } catch (error) {
    res.status(500).json({ success: false, message: 'Database error', error: error.message });
    }
};

  // PARKING_SESSIONS CRUD

exports.getAllSessions = async (req, res) => {
    try {
    const data = await Transactions.findAllSessions();
    res.status(200).json({ success: true, data });
    } catch (error) {
    res.status(500).json({ success: false, message: 'Database error', error: error.message });
    }
};

exports.getSessionById = async (req, res) => {
    try {
    const data = await Transactions.findSessionById(req.params.id);
    if (!data) return res.status(404).json({ success: false, message: 'Parking session not found' });
    res.status(200).json({ success: true, data });
    } catch (error) {
    res.status(500).json({ success: false, message: 'Database error', error: error.message });
    }
};

exports.createSession = async (req, res) => {
    try {
    const sessionId = await Transactions.createSession(req.body);
    res.status(201).json({ success: true, sessionId });
    } catch (error) {
    res.status(400).json({ success: false, message: 'Invalid input', error: error.message });
    }
};

exports.updateSession = async (req, res) => {
    try {
    const affectedRows = await Transactions.updateSession(req.params.id, req.body);
    if (affectedRows === 0) return res.status(404).json({ success: false, message: 'Parking session not found' });
    res.status(200).json({ success: true, message: 'Parking session updated successfully' });
    } catch (error) {
    res.status(400).json({ success: false, message: 'Invalid input', error: error.message });
    }
};

exports.deleteSession = async (req, res) => {
    try {
    const affectedRows = await Transactions.deleteSession(req.params.id);
    if (affectedRows === 0) return res.status(404).json({ success: false, message: 'Parking session not found' });
    res.status(200).json({ success: true, message: 'Parking session deleted successfully' });
    } catch (error) {
    res.status(500).json({ success: false, message: 'Database error', error: error.message });
    }
};

exports.recordExit = async (req, res) => {
    try {
    const affectedRows = await Transactions.recordExit(req.params.id);
    if (affectedRows === 0) return res.status(404).json({ success: false, message: 'Active parking session not found' });
    res.status(200).json({ success: true, message: 'Vehicle exit recorded successfully' });
    } catch (error) {
    res.status(500).json({ success: false, message: 'Database error', error: error.message });
    }
};

// INNER JOIN - Parking_Sessions + Parking_Spots

exports.getSessionsWithSpots = async (req, res) => {
    try {
    const data = await Transactions.getSessionsWithSpots();
    res.status(200).json({ success: true, data });
    } catch (error) {
    res.status(500).json({ success: false, message: 'Database error', error: error.message });
    }
};
