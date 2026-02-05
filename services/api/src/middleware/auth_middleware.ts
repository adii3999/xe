import jwt from 'jsonwebtoken';
import { Request, Response, NextFunction } from 'express';

export type AuthPayload = {
  phone: string;
  role?: string;
  userId?: string;
};

export function requireAuth(req: Request, res: Response, next: NextFunction) {
  const header = req.headers.authorization;
  if (!header) return res.status(401).json({ ok: false, error: 'Missing token' });
  const token = header.replace('Bearer ', '');
  try {
    const secret = process.env.JWT_SECRET || 'dev-secret';
    const payload = jwt.verify(token, secret) as AuthPayload;
    (req as Request & { user?: AuthPayload }).user = payload;
    return next();
  } catch (_err) {
    return res.status(401).json({ ok: false, error: 'Invalid token' });
  }
}

export function requireRole(role: string) {
  return (req: Request, res: Response, next: NextFunction) => {
    const user = (req as Request & { user?: AuthPayload }).user;
    if (!user || user.role != role) {
      return res.status(403).json({ ok: false, error: 'Forbidden' });
    }
    return next();
  };
}
