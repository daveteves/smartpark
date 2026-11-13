const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();

app.use(cors());
app.use(express.json());

const requestLogger = require('./middleware/logger');

const coreRoutes = require('./routes/coreRoutes');

app.use(requestLogger);

app.use('/api/core', require('./routes/coreRoutes'));

app.get('/', (req, res) => {
  res.status(200).json({ success: true, message: 'Welcome to the SmartPark API' });
});

const PORT = process.env.PORT || 8000;
app.listen(PORT, () => console.log(`SmartPark Server running on port ${PORT}`));
