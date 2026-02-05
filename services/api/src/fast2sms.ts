const FAST2SMS_URL = 'https://www.fast2sms.com/dev/bulkV2';

export type Fast2SmsConfig = {
  apiKey?: string;
  route?: string;
  senderId?: string;
  entityId?: string;
  templateId?: string;
  messageTemplate?: string;
};

export async function sendFast2SmsOtp(phone: string, otp: string, config: Fast2SmsConfig) {
  if (!config.apiKey) {
    return { ok: false, message: 'FAST2SMS_API_KEY missing' };
  }

  const route = config.route ?? 'q';
  const messageTemplate = config.messageTemplate ?? 'Your OTP is {otp}';
  const message = messageTemplate.replace('{otp}', otp);

  const payload: Record<string, string> = {
    route,
    numbers: phone,
    message,
  };

  if (route.startsWith('dlt')) {
    if (config.senderId) payload.sender_id = config.senderId;
    if (config.entityId) payload.entity_id = config.entityId;
    if (config.templateId) payload.template_id = config.templateId;
  } else {
    payload.language = 'english';
  }

  const response = await fetch(FAST2SMS_URL, {
    method: 'POST',
    headers: {
      authorization: config.apiKey,
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: new URLSearchParams(payload),
  });

  if (!response.ok) {
    return { ok: false, message: `HTTP ${response.status}` };
  }

  const data = await response.json();
  return { ok: true, data };
}
