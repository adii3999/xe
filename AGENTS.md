# AGENTS Instructions

This workspace follows the high-level rollout plan outlined by the stakeholder. Treat this document as the single source of truth for phases, responsibilities, and deliverables.

## Phase 1: Foundation (Days 1–5)
1. **Idea Lock (Day 1)**
   - Confirm the hyperlocal + global marketplace concept with fast delivery from local shops and supporting platforms (buyer app, seller panel, automated shop websites).
   - This document is proprietary and is for internal use only.
2. **Brand Setup (Days 1–2)**
   - Finalize brand name.
   - Purchase `.com` and `.in` domains.
   - Reserve relevant social handles.
   - After completion, treat the brand as locked/established.
3. **Company Registration (Days 3–5)**
   - Register an LLP in India (recommended).
   - Open a current account.
   - GST registration can wait but should be planned.
   - Budget ~₹10k–15k.

## Phase 2: System Design (Days 6–10)
4. **Architecture Design**
   - Define modules for Buyer App, Seller App, Admin Panel, Backend APIs, and Delivery Logic.
5. **Database Design (Critical)**
   - Core tables: Users, Sellers, Shops, Products, Inventory (real-time), Orders, Payments, COD settlements, Commission.
6. **MVP Feature Freeze**
   - Avoid non-revenue features.
   - MVP must include location-based products, buy-now flows, seller notifications, delivery assignment, COD + online payments.

## Phase 3: Development (Days 11–30)
7. **Backend Build**
   - Implement Auth (OTP/JWT), Product APIs, Order APIs, Location logic, Settlement cron jobs.
8. **Buyer App**
   - Location detection, nearby product listing, cart, order tracking.
9. **Seller App**
   - Product management, stock updates, order accept/reject, earnings dashboard.
10. **Admin Panel**
   - Seller approval, order monitoring, commission controls, manual overrides.

## Phase 4: Operations Setup (Days 25–35)
11. **Delivery System**
   - Start with local bike riders or manual assignments and define COD rules.
12. **Seller Onboarding**
   - Onboard 20–30 local shops with 0–2% commission, free listing, and a simple agreement.

## Phase 5: Soft Launch (Days 35–45)
13. **Pilot Launch**
   - Run in one area with real users/orders, fix bugs, improve UX, and optimize speed.
14. **Trust Building**
   - Track ratings, provide support number, establish refund policy, add WhatsApp support.

## Phase 6: Money Mode (Day 45+)
15. **Revenue Activation**
   - Charge 3–5% commission, delivery fees, and offer featured product placements.
16. **City-wise Scaling**
   - Expand from area to city to state, adding more sellers and riders.

## Phase 7: Global Move (Later)
17. **Dubai/UAE Expansion**
   - Obtain trade license, enable Stripe payments, ship internationally, and craft a global brand image.
