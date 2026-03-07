# Server Setup Guide – Contact Manager API

## 1. Prerequisites

- **Node.js** (v18 or newer) – [Download](https://nodejs.org/)
- **MongoDB** – choose one option below.

---

## 2. MongoDB Setup

Your `.env` uses: `mongodb://localhost:27017/contact-manager`

### Option A: MongoDB locally (Windows)

1. **Download MongoDB Community Server**  
   https://www.mongodb.com/try/download/community  
   - Choose: **Windows** → **msi** → **x86_64** (or ARM if needed).

2. **Run the installer**
   - Choose **Complete**.
   - Optionally install **MongoDB Compass** (GUI).
   - Install as a **Windows Service** so it starts with Windows (recommended).

3. **Confirm MongoDB is running**
   - Open **Services** (Win + R → `services.msc`) and check **MongoDB Server** is **Running**.
   - Or in a new terminal:
     ```bash
     mongod --version
     ```
   - If you installed as a service, it should already be listening on `localhost:27017`.

### Option B: MongoDB Atlas (cloud, no local install)

1. Go to https://www.mongodb.com/cloud/atlas and create a free account.
2. Create a **free cluster** (e.g. M0).
3. **Database Access** → Add user (username + password).
4. **Network Access** → Add IP: `0.0.0.0` (or your IP) so your app can connect.
5. **Connect** → **Connect your application** → copy the connection string (e.g. `mongodb+srv://user:pass@cluster.mongodb.net/`).
6. In your project `.env`, set:
   ```env
   MONGO_URI=mongodb+srv://YOUR_USER:YOUR_PASSWORD@YOUR_CLUSTER.mongodb.net/contact-manager?retryWrites=true&w=majority
   ```
   Replace `YOUR_USER`, `YOUR_PASSWORD`, `YOUR_CLUSTER` with your values.

---

## 3. Project setup

1. **Open a terminal** in the project folder:
   ```bash
   cd "c:\Users\kodesh\Downloads\server-20260306T044118Z-1-001\server"
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Environment**
   - `.env` is already present with:
     - `MONGO_URI` – MongoDB connection (local or Atlas).
     - `JWT_SECRET` – change in production.
     - `PORT=5000`, `NODE_ENV=development`.
   - If you use Atlas, only `MONGO_URI` needs to be updated (see step 2B).

---

## 4. Run the server

```bash
npm start
```

- Server runs with **nodemon** on **http://localhost:5000**.
- Health check: **http://localhost:5000/api/health**
- API base: `/api/auth`, `/api/contacts`.

---

## 5. Quick checklist

| Step                         | Action                                      |
|-----------------------------|---------------------------------------------|
| Node.js installed           | `node -v` and `npm -v` in terminal          |
| MongoDB running (local/Atlas) | Service running or Atlas cluster reachable |
| Dependencies installed      | `npm install` in project folder             |
| `.env` correct              | `MONGO_URI` points to your MongoDB          |
| Start server                | `npm start`                                 |

If the server fails with a MongoDB connection error, check that MongoDB is running and `MONGO_URI` in `.env` is correct.
