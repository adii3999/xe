import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import { prisma } from './prisma.js';
import { requestOtp, verifyOtp } from './auth.js';
import { requireAuth, requireRole } from './middleware/auth_middleware.js';

const app = express();
app.use(cors());
app.use(express.json());

app.get('/health', (_req, res) => {
  res.json({ status: 'ok' });
});

const fallbackProducts = [
  { id: 'p1', name: 'Fresh Milk', price: 60, shopName: 'Local Dairy' },
  { id: 'p2', name: 'Bread', price: 40, shopName: 'Bakery Corner' },
  { id: 'p3', name: 'Eggs (6)', price: 55, shopName: 'Daily Mart' },
  { id: 'p4', name: 'Tomatoes 1kg', price: 70, shopName: 'Veggie Hub' },
];

app.get('/api/v1/shops/nearby', async (_req, res) => {
  try {
    const products = await prisma.product.findMany({
      take: 20,
      include: { shop: true },
    });
    return res.json({
      items: products.map((p: any) => ({
        id: p.id,
        name: p.name,
        price: p.price,
        shopName: p.shop.name,
      })),
    });
  } catch (_err) {
    return res.json({ items: fallbackProducts });
  }
});

app.post('/api/v1/auth/otp/request', async (req, res) => {
  try {
    const payload = await requestOtp(req.body);
    res.json(payload);
  } catch (err) {
    res.status(400).json({ ok: false, error: String(err) });
  }
});

app.post('/api/v1/auth/otp/verify', async (req, res) => {
  try {
    const payload = await verifyOtp(req.body);
    if (!payload.ok) return res.status(401).json({ ok: false });
    return res.json({ token: payload.token });
  } catch (err) {
    return res.status(400).json({ ok: false, error: String(err) });
  }
});

app.get('/api/v1/products', async (_req, res) => {
  try {
    const products = await prisma.product.findMany({
      take: 20,
      include: { shop: true },
    });
    return res.json({
      items: products.map((p: any) => ({
        id: p.id,
        name: p.name,
        price: p.price,
        shopName: p.shop.name,
      })),
    });
  } catch (_err) {
    return res.json({ items: fallbackProducts });
  }
});

app.get('/api/v1/admin/health', requireAuth, requireRole('admin'), (_req, res) => {
  res.json({ ok: true });
});

app.get('/api/v1/buyer/profile', requireAuth, requireRole('buyer'), async (req, res) => {
  const userId = (req as typeof req & { user?: { userId?: string } }).user?.userId;
  if (!userId) return res.status(401).json({ ok: false });
  const user = await prisma.user.findUnique({ where: { id: userId } });
  return res.json({ user });
});

app.get('/api/v1/seller/profile', requireAuth, requireRole('seller'), async (req, res) => {
  const userId = (req as typeof req & { user?: { userId?: string } }).user?.userId;
  if (!userId) return res.status(401).json({ ok: false });
  const user = await prisma.user.findUnique({
    where: { id: userId },
    include: { seller: { include: { shops: true } } },
  });
  return res.json({ user });
});

app.get('/api/v1/admin/profile', requireAuth, requireRole('admin'), async (req, res) => {
  const userId = (req as typeof req & { user?: { userId?: string } }).user?.userId;
  if (!userId) return res.status(401).json({ ok: false });
  const user = await prisma.user.findUnique({ where: { id: userId } });
  return res.json({ user });
});

const port = Number(process.env.PORT || 3000);
app.listen(port, () => {
  // eslint-disable-next-line no-console
  console.log(`API listening on :${port}`);
});
