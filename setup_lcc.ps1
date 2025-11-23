Write-Host '-----------------------------------------------'
Write-Host '   LCC NETWORK - FULL AUTO SETUP STARTED       '
Write-Host '-----------------------------------------------'

# Root folder
$root = "$env:USERPROFILE\lcc-network"
if (Test-Path $root) { Remove-Item $root -Recurse -Force }
New-Item -ItemType Directory -Path $root | Out-Null

# Folders
New-Item -ItemType Directory "$root\lcc-backend" | Out-Null
New-Item -ItemType Directory "$root\lcc-frontend" | Out-Null
New-Item -ItemType Directory "$root\lcc-admin"    | Out-Null

# -----------------------------
# BACKEND
# -----------------------------
@'
const express = require("express");
const app = express();
app.use(express.json());
app.get("/", (req,res)=>res.send("LCC Backend Running"));
app.listen(5000, ()=>console.log("Backend UP on 5000"));
'@ | Out-File "$root\lcc-backend\server.js" -Encoding utf8

@'
{
  "name": "lcc-backend",
  "version": "1.0.0",
  "scripts": { "start": "node server.js" },
  "dependencies": { "express": "4.18.2" }
}
'@ | Out-File "$root\lcc-backend\package.json" -Encoding utf8

# -----------------------------
# FRONTEND
# -----------------------------
@'
import React from "react";
export default function App(){ return <h1>LCC Network Mining App</h1> }
'@ | Out-File "$root\lcc-frontend\App.jsx" -Encoding utf8

@'
{
  "name": "lcc-frontend",
  "version": "1.0.0",
  "scripts": { "dev": "vite --port 3000" },
  "dependencies": { "react": "18.2.0", "react-dom": "18.2.0" },
  "devDependencies": { "vite": "4.4.9", "@vitejs/plugin-react": "3.1.0" }
}
'@ | Out-File "$root\lcc-frontend\package.json" -Encoding utf8

# -----------------------------
# ADMIN
# -----------------------------
@'
import React from "react";
export default function Admin(){ return <h1>LCC Admin Panel</h1> }
'@ | Out-File "$root\lcc-admin\Admin.jsx" -Encoding utf8

@'
{
  "name": "lcc-admin",
  "version": "1.0.0",
  "scripts": { "dev": "vite --port 3001" },
  "dependencies": { "react": "18.2.0", "react-dom": "18.2.0" },
  "devDependencies": { "vite": "4.4.9", "@vitejs/plugin-react": "3.1.0" }
}
'@ | Out-File "$root\lcc-admin\package.json" -Encoding utf8

# -----------------------------
# INSTALL DEPENDENCIES
# -----------------------------
Write-Host "Installing Backend dependencies..."
cd "$root\lcc-backend"
npm install

Write-Host "Installing Frontend dependencies..."
cd "$root\lcc-frontend"
npm install

Write-Host "Installing Admin dependencies..."
cd "$root\lcc-admin"
npm install

Write-Host '-----------------------------------------------'
Write-Host '   LCC NETWORK - AUTO SETUP COMPLETED          '
Write-Host '-----------------------------------------------'
