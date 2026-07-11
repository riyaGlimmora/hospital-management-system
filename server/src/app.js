const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const authRoutes = require('./modules/auth');
const doctorRoutes = require('./modules/doctors');
const departmentRoutes = require('./modules/departments');
const appointmentRoutes = require('./modules/appointments');
const billingRoutes = require('./modules/billing');
const patientRoutes = require('./modules/patient');
const dashboardRoutes = require('./modules/dashboard');
const errorHandler = require('./middleware/error.middleware');
const AppError = require('./utils/AppError');

const app = express();

const allowedOrigins = (process.env.CLIENT_ORIGIN ?? '')
  .split(',')
  .map((origin) => origin.trim())
  .filter(Boolean);

// Vercel preview URL pattern: https://<project>-<hash>-<scope>.vercel.app
const VERCEL_PREVIEW_PATTERN = /^https:\/\/[\w-]+-[\w]+-[\w-]+\.vercel\.app$/;

const corsOptions = {
  origin(origin, callback) {
    // Allow non-browser requests (no Origin header, e.g. health checks/curl)
    if (!origin) {
      return callback(null, true);
    }
    // Allow any *.vercel.app origin (covers preview + production deployments)
    if (origin.endsWith('.vercel.app')) {
      return callback(null, true);
    }
    if (allowedOrigins.includes(origin)) {
      return callback(null, true);
    }
    return callback(new AppError(`Origin ${origin} is not allowed by CORS`, 403));
  },
};

app.use(cors(corsOptions));
app.use(helmet());
app.use(express.json());
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
app.use('/api/v1/departments', departmentRoutes);
app.use('/api/v1/appointments', appointmentRoutes);
app.use('/api/v1/billing', billingRoutes);
app.use('/api/v1/dashboard', dashboardRoutes);
app.use('/api/v1/patients', patientRoutes);


app.use((req, res, next) => {
  next(new AppError(`Route ${req.originalUrl} not found`, 404));
});

app.use(errorHandler);

module.exports = app;