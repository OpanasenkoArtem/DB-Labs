# Лабораторна робота №6
## Тема: Міграції схем за допомогою Prisma ORM

## 1. Міграція `add-review-table`

Було створено нову таблицю `Review` для зберігання відгуків користувачів про товари. Також було налаштовано зв'язок один до багатьох між моделями `Product` та `Review`.

### До `model Product`

```prisma
model Product {
  id           Int            @id @default(autoincrement())
  name         String         @db.VarChar(200)
  price        Decimal        @db.Decimal(10, 2)
  description  String?
  categoryId   Int
  category     Category       @relation(fields: [categoryId], references: [id])
  orderDetails OrderDetails[]
  // поле reviews ще відсутнє
}
```

### Після `model Product` + `model Review`

```prisma
model Product {
  id           Int            @id @default(autoincrement())
  name         String         @db.VarChar(200)
  price        Decimal        @db.Decimal(10, 2)
  description  String?
  categoryId   Int
  category     Category       @relation(fields: [categoryId], references: [id])
  orderDetails OrderDetails[]
  reviews      Review[]       // ← додано зворотній зв'язок
}

model Review {
  id        Int     @id @default(autoincrement())
  rating    Int
  comment   String?
  productId Int
  product   Product @relation(fields: [productId], references: [id])
}
```

---

## 2. Міграція `add-product-field`

До існуючої таблиці `Product` було додано нове логічне поле `inStock`, яке за замовчуванням має значення `true`. Це дозволяє відстежувати наявність товару в магазині.

### До `model Product`

```prisma
model Product {
  id           Int            @id @default(autoincrement())
  name         String         @db.VarChar(200)
  price        Decimal        @db.Decimal(10, 2)
  description  String?
  categoryId   Int
  reviews      Review[]
}
```

### Після `model Product`

```prisma
model Product {
  id           Int            @id @default(autoincrement())
  name         String         @db.VarChar(200)
  price        Decimal        @db.Decimal(10, 2)
  description  String?
  inStock      Boolean        @default(true)  // нове поле
  categoryId   Int
  reviews      Review[]
}
```

## 3. Міграція `drop-old-column`

З моделі `Product` було видалено поле `description`, оскільки воно більше не використовується в бізнес-логіці застосунку.

### До `model Product`

```prisma
model Product {
  id           Int            @id @default(autoincrement())
  name         String         @db.VarChar(200)
  price        Decimal        @db.Decimal(10, 2)
  description  String?        // поле, що видаляється
  inStock      Boolean        @default(true)
  categoryId   Int
  reviews      Review[]
}
```

### Після `model Product`

```prisma
model Product {
  id           Int            @id @default(autoincrement())
  name         String         @db.VarChar(200)
  price        Decimal        @db.Decimal(10, 2)
  // поле description видалено
  inStock      Boolean        @default(true)
  categoryId   Int
  reviews      Review[]
}
```
