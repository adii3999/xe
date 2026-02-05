import React, { useState } from 'react';

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000';

export default function Login({ onAuthed }) {
  const [phone, setPhone] = useState('');
  const [otp, setOtp] = useState('');
  const [status, setStatus] = useState('');

  const sendOtp = async () => {
    setStatus('Sending OTP...');
    const res = await fetch(`${API_URL}/api/v1/auth/otp/request`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ phone }),
    });
    if (!res.ok) {
      setStatus('Failed to send OTP');
      return;
    }
    setStatus('OTP sent. Use 123456 if mock.');
  };

  const submit = async (event) => {
    event.preventDefault();
    setStatus('Verifying...');
    const res = await fetch(`${API_URL}/api/v1/auth/otp/verify`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ phone, otp }),
    });
    if (!res.ok) {
      setStatus('OTP verify failed');
      return;
    }
    const json = await res.json();
    const token = json.token;
    const health = await fetch(`${API_URL}/api/v1/admin/health`, {
      headers: { Authorization: `Bearer ${token}` },
    });
    if (!health.ok) {
      setStatus('Not an admin user');
      return;
    }
    localStorage.setItem('admin_token', token);
    setStatus('Logged in');
    onAuthed?.();
  };

  return (
    <section>
      <h3>Admin Login</h3>
      <form onSubmit={submit} style={{ display: 'grid', gap: 12, maxWidth: 320 }}>
        <input
          placeholder="Phone"
          value={phone}
          onChange={(e) => setPhone(e.target.value)}
        />
        <input
          placeholder="OTP"
          value={otp}
          onChange={(e) => setOtp(e.target.value)}
        />
        <button type="button" onClick={sendOtp}>
          Send OTP
        </button>
        <button type="submit">Login</button>
      </form>
      {status && <p>{status}</p>}
    </section>
  );
}
