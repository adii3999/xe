import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  await prisma.user.create({
    data: {
      phone: '7777777777',
      name: 'Admin User',
      role: 'admin',
    },
  });

  const user = await prisma.user.create({
    data: {
      phone: '9999999999',
      name: 'Demo Seller',
      role: 'seller',
      seller: {
        create: {
          legalName: 'Demo Seller Pvt Ltd',
          kycStatus: 'verified',
          shops: {
            create: {
              name: 'Demo Shop',
              address1: 'Main Road',
              city: 'Delhi',
              state: 'Delhi',
              pincode: '110001',
              lat: 28.6139,
              lng: 77.209,
              products: {
                create: [
                  {
                    name: 'Fresh Milk',
                    category: 'Dairy',
                    price: 60,
                    inventory: { create: { quantity: 20, reserved: 0 } },
                  },
                  {
                    name: 'Bread',
                    category: 'Bakery',
                    price: 40,
                    inventory: { create: { quantity: 15, reserved: 0 } },
                  },
                ],
              },
            },
          },
        },
      },
    },
    include: { seller: true },
  });

  await prisma.user.create({
    data: {
      phone: '8888888888',
      name: 'Demo Buyer',
      role: 'buyer',
    },
  });

  console.log('Seeded:', user.id);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
