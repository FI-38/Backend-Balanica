// app.js
const express = require('express');
const cors = require('cors');
require('dotenv').config();
const db = require('./db');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const app = express();

app.use(cors());
app.use(express.json());
// Middleware für JWT-Authentifizierung
function authMiddleware(req, res, next) {
  const authHeader = req.headers.authorization;

  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    return res.status(401).json({ error: "Nicht autorisiert" });
  }

  const token = authHeader.split(" ")[1];

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.userId = decoded.userId;
    next();
  } catch (err) {
    return res.status(401).json({ error: "Ungültiges Token" });
  }
}

// Health-Check
app.get('/api/health', (req, res) => {
  res.json({ status: 'ok', message: 'Backend läuft' });
});

// Produkte abrufen
app.get('/api/products', async (req, res) => {
  try {
    const rows = await db.query('SELECT * FROM product');
    res.json(rows);
  } catch (err) {
    console.error('Fehler /api/products:', err);
    res.status(500).json({ error: 'Interner Serverfehler' });
  }
});

// Registrierung
app.post('/api/register', async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res
        .status(400)
        .json({ error: 'E-Mail und Passwort sind erforderlich.' });
    }

    if (password.length < 8) {
      return res
        .status(400)
        .json({ error: 'Das Passwort muss mindestens 8 Zeichen lang sein.' });
    }

    // Prüfen, ob Benutzer schon existiert
    const existing = await db.query('SELECT * FROM user WHERE email = ?', [
      email,
    ]);
    if (existing.length > 0) {
      return res
        .status(409)
        .json({ error: 'Ein Benutzer mit dieser E-Mail existiert bereits.' });
    }

    // Passwort hashen
    const hash = await bcrypt.hash(password, 10);

    // Benutzer speichern
    const result = await db.query(
      'INSERT INTO user (email, password_hash) VALUES (?, ?)',
      [email, hash],
    );

    // insertId (BigInt) in Number oder String umwandeln
    const userId =
      typeof result.insertId === 'bigint'
        ? Number(result.insertId)
        : result.insertId;

    res.status(201).json({
      message: 'Benutzer erfolgreich registriert.',
      userId,
    });
  } catch (err) {
    console.error('Fehler /api/register:', err);
    res.status(500).json({ error: 'Interner Serverfehler' });
  }
});

// Login
app.post('/api/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res
        .status(400)
        .json({ error: 'E-Mail und Passwort sind erforderlich.' });
    }

    const rows = await db.query('SELECT * FROM user WHERE email = ?', [email]);

    if (rows.length === 0) {
      return res.status(401).json({ error: 'Ungültige Zugangsdaten.' });
    }

    const user = rows[0];

    const isMatch = await bcrypt.compare(password, user.password_hash);
    if (!isMatch) {
      return res.status(401).json({ error: 'Ungültige Zugangsdaten.' });
    }

    const token = jwt.sign(
      { userId: user.id, email: user.email },
      process.env.JWT_SECRET,
      { expiresIn: '1h' },
    );

    res.json({ message: 'Login erfolgreich.', token });
  } catch (err) {
    console.error('Fehler /api/login:', err);
    res.status(500).json({ error: 'Interner Serverfehler' });
  }
});
// Bestellung anlegen
app.post('/api/orders', authMiddleware, async (req, res) => {
  const { items } = req.body;

  if (!Array.isArray(items) || items.length === 0) {
    return res.status(400).json({ error: "Keine Artikel im Warenkorb." });
  }

  try {
    const resultOrder = await db.query(
      "INSERT INTO orders (user_id, created_at) VALUES (?, NOW())",
      [req.userId]
    );

    const orderId =
      typeof resultOrder.insertId === "bigint"
        ? Number(resultOrder.insertId)
        : resultOrder.insertId;

    for (const item of items) {
      await db.query(
        "INSERT INTO order_items (order_id, product_id, quantity) VALUES (?, ?, ?)",
        [orderId, item.productId, item.quantity ?? 1]
      );
    }

    return res.json({ orderId });
  } catch (err) {
    console.error("Fehler /api/orders:", err);
    return res.status(500).json({ error: "Interner Serverfehler" });
  }
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Server läuft auf Port ${port}`);
});

// Bestellung anlegen
app.post('/api/orders', authMiddleware, async (req, res) => {
  const { items } = req.body;

  if (!Array.isArray(items) || items.length === 0) {
    return res.status(400).json({ error: "Keine Artikel im Warenkorb." });
  }

  try {
    const resultOrder = await db.query(
      "INSERT INTO orders (user_id, created_at) VALUES (?, NOW())",
      [req.userId]
    );

    const orderId =
      typeof resultOrder.insertId === "bigint"
        ? Number(resultOrder.insertId)
        : resultOrder.insertId;

    for (const item of items) {
      await db.query(
        "INSERT INTO order_items (order_id, product_id, quantity) VALUES (?, ?, ?)",
        [orderId, item.productId, item.quantity ?? 1]
      );
    }

    return res.json({ orderId });
  } catch (err) {
    console.error("Fehler /api/orders:", err);
    return res.status(500).json({ error: "Interner Serverfehler" });
  }
});
