Perfecto, Lorena. Esto cambia totalmente lo que necesitamos poner en el README, porque tu backend **es mucho más simple** (y no tiene rutas, controladores, ni carpetas extra).
Y no pasa nada: lo hacemos EXACTO para tu proyecto real, en alemán y profesional.

### 📌 **Tu backend REAL tiene:**

* `app.js` → tu servidor Express
* `db.js` → conexión MariaDB
* `.env`
* `package.json`
* `node_modules`

**Y nada más**.

Así que te escribo un README **adaptado exactamente a esta estructura**, correcto para entregar al profesor.

---

# 📝 **README – FI38 Online Shop Backend (DEUTSCH, adaptado a tu Backend real)**

```markdown
# FI38 Online Shop – Backend

Dies ist das Backend des Online-Shop-Projekts im Modul M4-DWG (Comhard / FI-38).  
Die Anwendung stellt einen einfachen Express-Server bereit, der mit einer MariaDB-Datenbank verbunden ist.  
Der Fokus liegt auf einer funktionierenden Server-Struktur, Datenbankverbindung und API-Basis.

---

## 🚀 Verwendete Technologien

- **Node.js**
- **Express.js**
- **MariaDB**
- **dotenv**

---

## 📁 Projektstruktur

```

backend/
├─ node_modules/
├─ .env                # Umgebungsvariablen (nicht hochladen)
├─ app.js              # Hauptserver
├─ db.js               # Datenbankverbindung
├─ package.json
└─ package-lock.json

```

---

## 🔧 Konfiguration (.env)

Im Hauptordner eine `.env` Datei erstellen mit folgenden Inhalten:

```

DB_HOST=localhost
DB_USER=root
DB_PASSWORD=DEIN_PASSWORT
DB_NAME=fi38_shop
PORT=3000

```

⚠️ Hinweis:  
`.env` darf **nicht** ins Repository hochgeladen werden.  
Für die Abgabe wird stattdessen eine `.env.example` empfohlen.

---

## 🗂 Datenbank

Das Projekt verwendet **MariaDB**.  
Für die Verbindung werden folgende Werte benötigt:

- Datenbankname: `fi38_shop`
- Nutzer: `root` (oder eigener User)
- Tabellen werden über SQL-Export bereitgestellt.

Bitte den beigefügten SQL-Dump (`.sql`) importieren.

---

## ▶️ Server starten

1. Dependencies installieren:

```

npm install

```

2. Server starten:

```

npm start

```

Der Server läuft anschließend unter:

👉 **http://localhost:3000**

---

## 🔌 API-Endpunkte

Da das Backend in dieser Version minimal aufgebaut ist, können hier folgende Routen vorhanden sein (abhängig von `app.js`):

- `/` – Basistest („Server läuft“)
- Weitere Routen können im Unterricht oder als Erweiterung ergänzt werden.

---

## 🧑‍🏫 Hinweise zur Abgabe

- Backend funktionsfähig (Express + DB)
- .env-Konfiguration korrekt integriert
- MariaDB-Verbindung erfolgreich getestet
- Projektstruktur übersichtlich und vollständig hochgeladen

---

## 👩‍💻 Autorin

**Lorena Balanica – FI38 (DWG)**  
Comhard Bildungszentrum, 2025
```