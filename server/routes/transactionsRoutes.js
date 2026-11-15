const express = require('express');
const router = express.Router();
const transactionsController = require('../controllers/transactionsController');

// Test Route
router.get('/', (req, res) => res.status(200).json({ message: 'Transactions API is running' }));

// Reservations Routes
router.get('/reservations', transactionsController.getAllReservations);
router.get('/reservations/:id', transactionsController.getReservationById);
router.post('/reservations', transactionsController.createReservation);
router.put('/reservations/:id', transactionsController.updateReservation);
router.delete('/reservations/:id', transactionsController.deleteReservation);

// INNER JOIN Route 
router.get('/sessions/spots', transactionsController.getSessionsWithSpots);

// Parking_Sessions Routes
router.get('/sessions', transactionsController.getAllSessions);
router.get('/sessions/:id', transactionsController.getSessionById);
router.post('/sessions', transactionsController.createSession);
router.put('/sessions/:id', transactionsController.updateSession);
router.delete('/sessions/:id', transactionsController.deleteSession);

// Vehicle Exit Route
router.patch('/sessions/:id/exit', transactionsController.recordExit);

module.exports = router;
