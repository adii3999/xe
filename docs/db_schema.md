# Database Schema (Draft)

## Conventions
- IDs: `uuid`
- Timestamps: `created_at`, `updated_at`
- Soft delete: `deleted_at` where needed
- Money: integer in smallest currency unit (paise)

## Core Tables

### users
- id (uuid, pk)
- phone (text, unique)
- name (text)
- role (enum: buyer, seller, admin)
- is_active (bool)
- created_at, updated_at

### sellers
- id (uuid, pk)
- user_id (uuid, fk -> users.id)
- legal_name (text)
- gstin (text, nullable)
- kyc_status (enum: pending, verified, rejected)
- created_at, updated_at

### shops
- id (uuid, pk)
- seller_id (uuid, fk -> sellers.id)
- name (text)
- address_line1 (text)
- address_line2 (text, nullable)
- city (text)
- state (text)
- pincode (text)
- lat (numeric)
- lng (numeric)
- is_active (bool)
- created_at, updated_at

### products
- id (uuid, pk)
- shop_id (uuid, fk -> shops.id)
- name (text)
- description (text, nullable)
- category (text)
- price (int)
- is_active (bool)
- created_at, updated_at

### inventory
- id (uuid, pk)
- product_id (uuid, fk -> products.id)
- quantity (int)
- reserved (int)
- updated_at

### orders
- id (uuid, pk)
- buyer_id (uuid, fk -> users.id)
- shop_id (uuid, fk -> shops.id)
- status (enum: placed, accepted, packed, out_for_delivery, delivered, cancelled)
- subtotal (int)
- delivery_fee (int)
- total (int)
- payment_mode (enum: cod, online)
- created_at, updated_at

### order_items
- id (uuid, pk)
- order_id (uuid, fk -> orders.id)
- product_id (uuid, fk -> products.id)
- quantity (int)
- price (int)

### payments
- id (uuid, pk)
- order_id (uuid, fk -> orders.id)
- provider (text)
- status (enum: pending, success, failed)
- amount (int)
- created_at, updated_at

### cod_settlements
- id (uuid, pk)
- order_id (uuid, fk -> orders.id)
- status (enum: pending, settled)
- amount (int)
- settled_at (timestamp, nullable)

### commissions
- id (uuid, pk)
- order_id (uuid, fk -> orders.id)
- rate_bps (int)
- amount (int)
- created_at
