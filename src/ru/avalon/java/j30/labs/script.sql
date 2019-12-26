/*
 * TODO(Студент): Опишите процесс создания базы данных
 * 1. Создайте все таблицы, согласно предложенной диаграмме.
 * 2. Опишите все необходимые отношения между таблицами.
 * 3. Добавьте в каждую таблицу минимум три записи.
 */
 
CREATE TABLE Roles
(
    id INT UNIQUE
        GENERATED always AS
        IDENTITY(start with 1,increment by 1) ,
    "name" VARCHAR(255) PRIMARY KEY
);

CREATE TABLE UserInfo
(
    id INT GENERATED always AS
           IDENTITY(start with 1,increment by 1)
           PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL
);

CREATE TABLE "User"
(
    id INT UNIQUE
        GENERATED always AS
        IDENTITY(start with 1,increment by 1),
    email VARCHAR(255) PRIMARY KEY,
    password VARCHAR(255),
    info INT UNIQUE,
    "role" INT,

    CONSTRAINT FK_UserInfo FOREIGN KEY(info) REFERENCES  Roles(id)
                           ON UPDATE RESTRICT 
                           ON DELETE CASCADE,
    CONSTRAINT FK_UserRole FOREIGN KEY("role") REFERENCES UserInfo
                           ON UPDATE RESTRICT 
                           ON DELETE CASCADE
);

CREATE TABLE "Order"
(
    id INT GENERATED always AS
           IDENTITY(start with 1,increment by 1)
           PRIMARY KEY,
    "user" INT,
    created TIMESTAMP,

    CONSTRAINT FK_OrderUser FOREIGN KEY("user") REFERENCES "User"(id)
                            ON UPDATE RESTRICT 
                            ON DELETE CASCADE
);

CREATE TABLE Supplier
(
    id INT UNIQUE GENERATED always AS
           IDENTITY(start with 1,increment by 1),
    "name" VARCHAR(255) PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(255),
    representative VARCHAR(255) NOT NULL
);

CREATE TABLE Product
(
id INT UNIQUE GENERATED always AS
       IDENTITY(start with 1,increment by 1),
code VARCHAR(255) PRIMARY KEY,
title VARCHAR(255),
supplier INT,
initial_price DOUBLE,
retail_price DOUBLE,

CONSTRAINT FK_ProduktSupplier FOREIGN KEY(supplier) REFERENCES Supplier(id)
                              ON UPDATE RESTRICT 
                              ON DELETE CASCADE
);

CREATE TABLE Order2Product
(
"order" INT,
product INT,

CONSTRAINT PK_OrderProduct PRIMARY KEY("order",product),
CONSTRAINT FK_OrderProductOrder FOREIGN KEY("order")
                        REFERENCES "Order"
                              ON UPDATE RESTRICT 
                              ON DELETE CASCADE,
CONSTRAINT FK_OrderProductProduct FOREIGN KEY(product)
                        REFERENCES Product(id)
                              ON UPDATE RESTRICT 
                              ON DELETE CASCADE
);

--заполняем таблички
INSERT INTO Roles("name")
            VALUES ('Повар'),('Клоун'),('Студент');

INSERT INTO UserInfo("name",surname)
            VALUES ('Николай','Петрович'),('Анна','Иванна'),('Генрих','Зюзикавич');

INSERT INTO Supplier("name",address,phone,representative)
            VALUES ('АО Инком','СПб ул. Красная д. 1','332-12-02','Медведев Д.А.'),
                   ('ПАО Помидорка','СПб ул. Синяя д. 1','332-13-02','Кудрин С.Н.'),
                   ('ИП Тарахтелка','СПб ул. Белая д. 1','332-11-02','Путин В.В.');

INSERT INTO Product (CODE,TITLE,SUPPLIER,INITIAL_PRICE,RETAIL_PRICE)
            VALUES ('AA','Помидор',2,4.4,56.5),
                   ('AB','Доставка',3,611.2,216.5),
                   ('AC','Бух. учёт',1,34.4,67.5);

INSERT INTO "User" (EMAIL,PASSWORD,INFO,"role")
            VALUES ('a@a.ru','aa',1,1),
                   ('b@b.ru','bb',2,2),
                   ('c@c.ru','cc',3,3);

INSERT INTO "Order" ("user",CREATED)
            VALUES (1,'2019-12-26 11:11:11'),
                   (2,'2019-12-26 11:11:12'),
                   (3,'2019-12-26 11:11:13');

INSERT INTO ORDER2PRODUCT ("order",PRODUCT)
            VALUES (1,1),(2,2),(3,3);
