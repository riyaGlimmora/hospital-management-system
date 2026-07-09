const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
const authRoutes = require('./modules/auth');
const doctorRoutes = require('./modules/doctors');
const appointmentRoutes = require('./modules/appointments');
const billingRoutes = require('./modules/billing');
const patientRoutes = require('./modules/patient');
const dashboardRoutes = require('./modules/dashboard');
const errorHandler = require('./middleware/error.middleware');
const AppError = require('./utils/AppError');

const app = express();

app.use(express.json());
app.use(cors());
app.use(morgan(process.env.NODE_ENV === 'production' ? 'combined' : 'dev'));

app.get('/api/v1/health', (req, res) => {
  res.status(200).json({
    success: true,
    message: 'Service is healthy',
    data: {
      status: 'ok',
      timestamp: new Date().toISOString(),
    },
  });
});

app.use('/api/v1/auth', authRoutes);
app.use('/api/v1/doctors', doctorRoutes);
app.use('/api/v1/appointments', appointmentRoutes);
app.use('/api/v1/billing', billingRoutes);
app.use('/api/v1/dashboard', dashboardRoutes);
app.use('/api/v1/patient', patientRoutes);


app.use((req, res, next) => {
  next(new AppError(`Route ${req.originalUrl} not found`, 404));
});

app.use(errorHandler);

module.exports = app;