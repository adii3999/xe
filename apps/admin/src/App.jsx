import React, { useEffect, useState } from 'react';
import { Link, Route, Routes, useNavigate } from 'react-router-dom';

import Dashboard from './pages/Dashboard.jsx';
import Sellers from './pages/Sellers.jsx';
import Orders from './pages/Orders.jsx';
import Commission from './pages/Commission.jsx';
import Login from './pages/Login.jsx';

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000';

export default function App() {
  const navigate = useNavigate();
  const [authed, setAuthed] = useState(false);

  useEffect(() => {
    const token = localStorage.getItem('admin_token');
    if (!token) {
      setAuthed(false);
      return;
    }
    fetch(`${API_URL}/api/v1/admin/health`, {
      headers: { Authorization: `Bearer ${token}` },
    })
      .then((res) => {
        if (!res.ok) throw new Error('unauthorized');
        setAuthed(true);
      })
      .catch(() => {
        localStorage.removeItem('admin_token');
        setAuthed(false);
      });
  }, []);

  useEffect(() => {
    if (!authed) navigate('/login');
  }, [authed, navigate]);

  return (
    <div style={{ fontFamily: 'sans-serif', padding: 24 }}>
      <header style={{ marginBottom: 24 }}>
        <h2>Admin Panel</h2>
        <nav style={{ display: 'flex', gap: 12 }}>
          <Link to="/">Dashboard</Link>
          <Link to="/sellers">Sellers</Link>
          <Link to="/orders">Orders</Link>
          <Link to="/commission">Commission</Link>
          <button
            type="button"
            onClick={() => {
              localStorage.removeItem('admin_token');
              setAuthed(false);
            }}
          >
            Logout
          </button>
        </nav>
      </header>
      <Routes>
        <Route path="/login" element={<Login onAuthed={() => setAuthed(true)} />} />
        <Route path="/" element={<Dashboard />} />
        <Route path="/sellers" element={<Sellers />} />
        <Route path="/orders" element={<Orders />} />
        <Route path="/commission" element={<Commission />} />
      </Routes>
    </div>
  );
}
