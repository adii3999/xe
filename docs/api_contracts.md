1# API Contracts (Draft)

Base URL: `/api/v1`

## Auth
- `POST /auth/otp/request` — request OTP
- `POST /auth/otp/verify` — verify OTP, returns JWT

## Buyer
- `GET /shops/nearby?lat=&lng=&radius=`
- `GET /shops/{shopId}/products`
- `POST /cart`
- `POST /orders` — create order
- `GET /orders/{orderId}`
- `GET /orders/{orderId}/track`

## Seller
- `POST /seller/products`
- `PATCH /seller/products/{productId}`
- `PATCH /seller/inventory/{productId}`
- `POST /seller/orders/{orderId}/accept`
- `POST /seller/orders/{orderId}/reject`
- `GET /seller/earnings`

## Admin
- `POST /admin/sellers/{sellerId}/approve`
- `GET /admin/orders?status=`
- `PATCH /admin/commission`
- `POST /admin/orders/{orderId}/override`

## Payments
- `POST /payments/create`
- `POST /payments/webhook`

## Delivery
- `POST /delivery/assign`
- `PATCH /delivery/{orderId}/status`
