# Лабораторна робота 5: Нормалізація бази даних

## 1. Аналіз функціональних залежностей (Functional Dependencies)

### Таблиця: Address (вихідна схема)

- **PK:** `address_id`
- **FD1:** $address\_id \to street, city, country, client\_id$
- **Проблема:** $city \to country$ — місто визначає країну, але `city` не є первинним ключем.

---

## 2. Перевірка нормальних форм та Нормалізація

### Крок 1: 1NF

**Вимога:** Усі атрибути атомарні, немає повторюваних груп.

- **Аналіз:** Усі таблиці (`Client`, `Product`, `Order` тощо) мають скалярні значення. Масивів або вкладених структур немає.
- **Висновок:** Схема вже відповідає **1NF**.

---

### Крок 2: 2NF

**Вимога:** Таблиця в 1NF і всі неключові атрибути залежать від *повного* первинного ключа.

- **Аналіз:** Усі таблиці використовують сурогатні ключі (`SERIAL PRIMARY KEY`). Складених первинних ключів, де атрибут міг би залежати лише від частини ключа, немає.
- **Висновок:** Схема автоматично відповідає **2NF**.

---

### Крок 3: 3NF

**Вимога:** Таблиця в 2NF і немає транзитивних залежностей (неключовий атрибут не повинен залежати від іншого неключового атрибута).

#### Проблема: Транзитивна залежність у таблиці `Address`

У вихідній таблиці `Address` присутні поля `city` і `country` в одному рядку:

```sql
-- Вихідна схема
CREATE TABLE Address (
    id       SERIAL PRIMARY KEY,
    street   VARCHAR(200) NOT NULL,
    city     VARCHAR(100) NOT NULL,
    country  VARCHAR(100) NOT NULL,
    client_id INT NOT NULL,
    ...
);
```

Тут існує транзитивна залежність:

$$address\_id \to city \to country$$

Поле `country` залежить не від первинного ключа напряму, а від `city` — це порушення **3NF**.

- **Рішення:** Виділити `city` і `country` в окрему таблицю `City` та замінити їх на зовнішній ключ `city_id` у таблиці `Address`.

---

## 3. SQL Changes

### Нова таблиця: City (Виділення довідника міст)

```sql
CREATE TABLE City (
    id      SERIAL PRIMARY KEY,
    city    VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    UNIQUE (city, country)
);
```

### Модифікація таблиці Address

```sql
ALTER TABLE Address ADD COLUMN city_id INT;

INSERT INTO City (city, country)
SELECT DISTINCT city, country FROM Address;

UPDATE Address a
SET city_id = c.id
FROM City c
WHERE a.city = c.city AND a.country = c.country;

ALTER TABLE Address ALTER COLUMN city_id SET NOT NULL;

ALTER TABLE Address
    ADD CONSTRAINT fk_address_city
    FOREIGN KEY (city_id) REFERENCES City(id);

ALTER TABLE Address DROP COLUMN city;
ALTER TABLE Address DROP COLUMN country;
```

---

