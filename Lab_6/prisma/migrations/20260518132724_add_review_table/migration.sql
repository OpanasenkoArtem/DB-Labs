/*
  Warnings:

  - You are about to drop the column `address_id` on the `order` table. All the data in the column will be lost.
  - You are about to drop the column `client_id` on the `order` table. All the data in the column will be lost.
  - You are about to drop the column `order_date` on the `order` table. All the data in the column will be lost.
  - You are about to drop the column `order_id` on the `order_details` table. All the data in the column will be lost.
  - You are about to drop the column `product_id` on the `order_details` table. All the data in the column will be lost.
  - You are about to drop the `address` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `category` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `city` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `client` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `payment` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `product` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `addressId` to the `order` table without a default value. This is not possible if the table is not empty.
  - Added the required column `clientId` to the `order` table without a default value. This is not possible if the table is not empty.
  - Added the required column `orderDate` to the `order` table without a default value. This is not possible if the table is not empty.
  - Added the required column `orderId` to the `order_details` table without a default value. This is not possible if the table is not empty.
  - Added the required column `productId` to the `order_details` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "address" DROP CONSTRAINT "fk_address_city";

-- DropForeignKey
ALTER TABLE "address" DROP CONSTRAINT "fk_address_client";

-- DropForeignKey
ALTER TABLE "order" DROP CONSTRAINT "fk_order_address";

-- DropForeignKey
ALTER TABLE "order" DROP CONSTRAINT "fk_order_client";

-- DropForeignKey
ALTER TABLE "order_details" DROP CONSTRAINT "fk_orderdetails_order";

-- DropForeignKey
ALTER TABLE "order_details" DROP CONSTRAINT "fk_orderdetails_product";

-- DropForeignKey
ALTER TABLE "payment" DROP CONSTRAINT "fk_payment_order";

-- DropForeignKey
ALTER TABLE "product" DROP CONSTRAINT "fk_product_category";

-- AlterTable
ALTER TABLE "order" DROP COLUMN "address_id",
DROP COLUMN "client_id",
DROP COLUMN "order_date",
ADD COLUMN     "addressId" INTEGER NOT NULL,
ADD COLUMN     "clientId" INTEGER NOT NULL,
ADD COLUMN     "orderDate" DATE NOT NULL;

-- AlterTable
ALTER TABLE "order_details" DROP COLUMN "order_id",
DROP COLUMN "product_id",
ADD COLUMN     "orderId" INTEGER NOT NULL,
ADD COLUMN     "productId" INTEGER NOT NULL;

-- DropTable
DROP TABLE "address";

-- DropTable
DROP TABLE "category";

-- DropTable
DROP TABLE "city";

-- DropTable
DROP TABLE "client";

-- DropTable
DROP TABLE "payment";

-- DropTable
DROP TABLE "product";

-- CreateTable
CREATE TABLE "Category" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Client" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "phone" VARCHAR(20),
    "email" VARCHAR(100),

    CONSTRAINT "Client_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "City" (
    "id" SERIAL NOT NULL,
    "city" VARCHAR(100) NOT NULL,
    "country" VARCHAR(100) NOT NULL,

    CONSTRAINT "City_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Address" (
    "id" SERIAL NOT NULL,
    "street" VARCHAR(200) NOT NULL,
    "cityId" INTEGER NOT NULL,
    "clientId" INTEGER NOT NULL,

    CONSTRAINT "Address_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Product" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(200) NOT NULL,
    "price" DECIMAL(10,2) NOT NULL,
    "description" TEXT,
    "categoryId" INTEGER NOT NULL,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Review" (
    "id" SERIAL NOT NULL,
    "rating" INTEGER NOT NULL,
    "comment" TEXT,
    "productId" INTEGER NOT NULL,

    CONSTRAINT "Review_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Payment" (
    "id" SERIAL NOT NULL,
    "amount" DECIMAL(10,2) NOT NULL,
    "method" VARCHAR(50) NOT NULL,
    "status" VARCHAR(50) NOT NULL,
    "date" DATE NOT NULL,
    "orderId" INTEGER NOT NULL,

    CONSTRAINT "Payment_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Category_name_key" ON "Category"("name");

-- CreateIndex
CREATE UNIQUE INDEX "City_city_country_key" ON "City"("city", "country");

-- CreateIndex
CREATE UNIQUE INDEX "Payment_orderId_key" ON "Payment"("orderId");

-- AddForeignKey
ALTER TABLE "Address" ADD CONSTRAINT "Address_cityId_fkey" FOREIGN KEY ("cityId") REFERENCES "City"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Address" ADD CONSTRAINT "Address_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "Client"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order" ADD CONSTRAINT "order_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "Address"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order" ADD CONSTRAINT "order_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "Client"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payment" ADD CONSTRAINT "Payment_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_details" ADD CONSTRAINT "order_details_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_details" ADD CONSTRAINT "order_details_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
