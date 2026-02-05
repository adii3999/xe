import jwt from 'jsonwebtoken';
import { z } from 'zod';
import { sendFast2SmsOtp } from './fast2sms.js';
import { prisma } from './prisma.js';

const otpSchema = z.object({
  phone: z.string().min(8),
});

const verifySchema = z.object({
  phone: z.string().min(8),
  otp: z.string().min(4),
});

const otpStore = new Map<string, { otp: string; expiresAt: number }>();

export async function requestOtp(body: unknown) {
  const { phone } = otpSchema.parse(body);
  const otp = process.env.FAST2SMS_API_KEY
    ? String(Math.floor(100000 + Math.random() * 900000))
    : '123456';
  const expiresAt = Date.now() + 5 * 60 * 1000;
  otpStore.set(phone, { otp, expiresAt });
  if (process.env.FAST2SMS_API_KEY) {
    const result = await sendFast2SmsOtp(phone, otp, {
      apiKey: process.env.FAST2SMS_API_KEY,
      route: process.env.FAST2SMS_ROUTE,
      senderId: process.env.FAST2SMS_SENDER_ID,
      entityId: process.env.FAST2SMS_ENTITY_ID,
      templateId: process.env.FAST2SMS_TEMPLATE_ID,
      messageTemplate: process.env.FAST2SMS_MESSAGE_TEMPLATE,
    });
    return { ok: result.ok, message: result.ok ? 'OTP sent.' : result.message };
  }
  return { ok: true, message: 'OTP sent (mock). Use 123456.' };
}

export async function verifyOtp(body: unknown) {
  const { phone, otp } = verifySchema.parse(body);
  const record = otpStore.get(phone);
  if (!record || record.expiresAt < Date.now() || record.otp != otp) {
    return { ok: false };
  }
  const secret = process.env.JWT_SECRET || 'dev-secret';
  const user = await prisma.user.upsert({
    where: { phone },
    update: {},
    create: { phone, role: 'buyer' },
  });
  const token = jwt.sign({ phone, role: user.role, userId: user.id }, secret, { expiresIn: '7d' });
  return { ok: true, token };
}
