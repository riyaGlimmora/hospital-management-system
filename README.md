# Hospital Management System (MVP)

A full-stack Hospital Management System covering authentication, patient
management, doctor management, appointment scheduling, billing, and a
dashboard — built as a one-week MVP sprint.

## Tech Stack

**Frontend:** React (Vite), Tailwind CSS, React Router, Axios
**Backend:** Node.js, Express, PostgreSQL, JWT, Joi
**Deployment:** Vercel (frontend), Render (backend)

## Prerequisites

- Node.js 18+ and npm
- PostgreSQL 14+ (local install, or a hosted instance such as Render's
  managed Postgres)

## Project Structure

```
hospital-management-system/
├── server/    # Express API
└── client/    # React (Vite) frontend
```

## Backend Setup (`/server`)

1. Install dependencies:
   ```
   cd server
   npm install
   ```

2. Copy the example environment file and fill in real values:
   ```
   cp .env.example .env
   ```

   | Variable        | Description                                                        |
   |-----------------|---------------------------------------------------------------------|
   | `PORT`          | Port the API listens on (default `5000`)                           |
   | `DATABASE_URL`  | PostgreSQL connection string                                       |
   | `JWT_SECRET`    | Long random secret used to sign JWTs — never reuse the dev default |
   | `NODE_ENV`      | `development` or `production`                                      |
   | `CLIENT_ORIGIN` | The deployed frontend origin (used to restrict CORS)                |

3. Create the database referenced by `DATABASE_URL` if it doesn't exist yet.

4. Run migrations (creates all tables):
   ```
   npm run migrate
   ```

5. Seed realistic sample data (departments, doctors, patients, a week of
   appointments, and bills):
   ```
   npm run seed
   ```

6. Start the API:
   ```
   npm run dev      # with auto-reload (nodemon)
   npm start        # production-style start
   ```

   The API will be available at `http://localhost:5000/api/v1`.

### Default seeded login credentials

| Role         | Email                        | Password        |
|--------------|-------------------------------|------------------|
| Admin        | `admin@hospital.test`         | `Admin@123`      |
| Receptionist | `receptionist@hospital.test`  | `Reception@123`  |

Change or remove these before any real deployment — they exist for local
development and demos only.

## Frontend Setup (`/client`)

1. Install dependencies:
   ```
   cd client
   npm install
   ```

2. Copy the example environment file:
   ```
   cp .env.example .env
   ```

   | Variable            | Description                                  |
   |---------------------|-----------------------------------------------|
   | `VITE_API_BASE_URL` | Base URL of the backend API, including `/api/v1` |

3. Start the dev server:
   ```
   npm run dev
   ```

   The app will be available at `http://localhost:5173`.

## Running Both Together (Local Development)

Start the backend first (`npm run dev` in `/server`), then the frontend
(`npm run dev` in `/client`). The frontend's `VITE_API_BASE_URL` should
point at the running backend, e.g. `http://localhost:5000/api/v1`.

## Resetting the Database

Migrations and seeds are safe to re-run — they use `IF NOT EXISTS` /
`ON CONFLICT` / existence checks where relevant, so running `npm run migrate`
and `npm run seed` again on an already-set-up database will not create
duplicates.

To start completely fresh, drop and recreate the database, then re-run:
```
npm run migrate
npm run seed
```

## Deployment

- **Backend (Render):** deploy `/server` as a Web Service, provision a
  managed PostgreSQL instance, set the environment variables listed above
  (with `CLIENT_ORIGIN` pointing at the deployed Vercel URL), then run
  `npm run migrate` and `npm run seed` as one-off jobs against the
  production database.
- **Frontend (Vercel):** set the project root to `/client`, set
  `VITE_API_BASE_URL` to the deployed Render backend URL, and deploy.

## API Overview

All endpoints are prefixed with `/api/v1` and (except `/auth/login`)
require an `Authorization: Bearer <token>` header. Responses follow a
consistent envelope: `{ success, message, data, errors }`.

| Module       | Base path          |
|--------------|---------------------|
| Auth         | `/auth`             |
| Patients     | `/patients`         |
| Doctors      | `/doctors`          |
| Departments  | `/departments`      |
| Appointments | `/appointments`     |
| Billing      | `/billing`          |
| Dashboard    | `/dashboard`        |

## Roles

- **admin** — full access, including deleting/deactivating records.
- **receptionist** — day-to-day operations: patients, appointments, billing.
- **doctor** — read-only access to their own relevant data (dashboard,
  appointments).
