-- Drop tables if they exist
IF OBJECT_ID('[Orders]', 'U') IS NOT NULL
    DROP TABLE [Orders];

IF OBJECT_ID('[Customers]', 'U') IS NOT NULL
    DROP TABLE [Customers];
-- Drop tables if they exist
IF OBJECT_ID('[Item]', 'U') IS NOT NULL
    DROP TABLE Item;

IF OBJECT_ID('[Ingredient]', 'U') IS NOT NULL
    DROP TABLE Ingredient;

IF OBJECT_ID(' [Inventory]', 'U') IS NOT NULL
    DROP TABLE Inventory;
IF OBJECT_ID(' [recipe]', 'U') IS NOT NULL
    DROP TABLE recipe;
IF OBJECT_ID('[Staff]', 'U') IS NOT NULL
    DROP TABLE Staff;
IF OBJECT_ID('[shift]', 'U') IS NOT NULL
    DROP TABLE [shift];
IF OBJECT_ID('[rota]', 'U') IS NOT NULL
    DROP TABLE [Rota];
 Create Orders table
drop table if exists [Orders]
CREATE TABLE [Orders] (
    [Row_Id] int NOT NULL CONSTRAINT [PK_Orders] PRIMARY KEY,
    [Order_ID] nvarchar(20) NOT NULL,
    [Order_Date] datetime NOT NULL unique,
    [Item_ID] int NOT NULL UNIQUE,
    [QTY] int NOT NULL,
    [Customer_id] int NOT NULL UNIQUE,
    CONSTRAINT [UK_Orders_CustomerID] UNIQUE ([Customer_id]) -- Unique constraint on Customer_id
);

-- Create Customers table
drop table if exists [Customers]
CREATE TABLE [Customers] (
    [row_id] int IDENTITY(1,1) CONSTRAINT [PK_Customer] PRIMARY KEY,
    [Customer_id] int NOT NULL,
    [Cust_FirstName] nvarchar(50) NOT NULL,
    [Cust_LastName] nvarchar(50) NOT NULL,
    [Cust_AddressLine1] nvarchar(max) NOT NULL,
    [Cust_AddressLine2] nvarchar(max) NULL,
    [Cust_City] nvarchar(20) NOT NULL,
    [Cust_PostalCode] nvarchar(20) NOT NULL,
    CONSTRAINT [FK_Customer_CustomerID] FOREIGN KEY ([Customer_id]) REFERENCES [Orders]([Customer_id])
);

drop table if exists [Item]
CREATE TABLE [Item] (
    [Item_Id] int  NOT NULL ,
    [SKU] nvarchar(50)  NOT NULL unique,
    [item_name] nvarchar(max)  NOT NULL ,
    [item_category] nvarchar(max)  NOT NULL ,
    [item_size] nvarchar(20)  NOT NULL ,
    [item_price] decimal(6,2)  NOT NULL ,
    CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED (
        [Item_Id] ASC
    )
)
drop table if exists [Ingredient]
CREATE TABLE [Ingredient] (
    [Ing_id] nvarchar(20)  NOT NULL ,
    [Ing_name] nvarchar(50)  NOT NULL ,
    [Ing_weight] int  NOT NULL ,
    [Ing_measure] varchar(20)  NOT NULL ,
    [Ing_price] decimal(5,2)  NOT NULL ,
    CONSTRAINT [PK_Ingredient] PRIMARY KEY CLUSTERED (
        [Ing_id] ASC
    )
)
drop table if exists [Recipe]
CREATE TABLE [Recipe] (
    [Row_id] int  NOT NULL ,
    [Recipe_id] nvarchar(50)  NOT NULL ,
    [Ing_id] nvarchar(20)  NOT NULL unique,
    [Qty] int  NOT NULL ,
    CONSTRAINT [PK_Recipe] PRIMARY KEY CLUSTERED (
        [Row_id] ASC
    )
)
drop table if exists [Inventory]
CREATE TABLE [Inventory] (
    [Inv_id] int  NOT NULL ,
    [item_id] nvarchar(20)  NOT NULL ,
    [Qty] int  NOT NULL ,
    CONSTRAINT [PK_Inventory] PRIMARY KEY CLUSTERED (
        [Inv_id] ASC
    )
)
drop table if exists [Staff]
CREATE TABLE [Staff] (
    [Staff_Id] nvarchar(20)  NOT NULL ,
    [First_name] nvarchar(50)  NOT NULL ,
    [Last_name] nvarchar(50)  NOT NULL ,
    [Position] nvarchar(max)  NOT NULL ,
    [hourly_rate] decimal(6,2)  NOT NULL ,
    CONSTRAINT [PK_Staff] PRIMARY KEY CLUSTERED (
        [Staff_Id] ASC
    )
)
drop table if exists [Shift]
CREATE TABLE [Shift] (
    [Shift_Id] nvarchar(20)  NOT NULL ,
    [day_of_Week] nvarchar(50)  NOT NULL ,
    [Start_Time] time  NOT NULL ,
    [End_Time] time  NOT NULL ,
    CONSTRAINT [PK_Shift] PRIMARY KEY CLUSTERED (
        [Shift_Id] ASC
    )
)
drop table if exists [Rota]
CREATE TABLE [Rota] (
    [Row_Id] int  NOT NULL ,
    [Rota_Id] nvarchar(20)  NOT NULL ,
    [date] datetime  NOT NULL ,
    [Shift_Id] nvarchar(20)  NOT NULL unique,
    [Staff_Id] nvarchar(20)  NOT NULL unique,
    CONSTRAINT [PK_Rota] PRIMARY KEY CLUSTERED (
        [Row_Id] ASC
    )
)

ALTER TABLE [Customers] WITH CHECK ADD CONSTRAINT [FK_Customers_Customer_Id] FOREIGN KEY([Customer_Id])
REFERENCES [Orders] ([Customer_id])

ALTER TABLE [Customers] CHECK CONSTRAINT [FK_Customers_Customer_Id]

ALTER TABLE [Item] WITH CHECK ADD CONSTRAINT [FK_Item_Item_Id] FOREIGN KEY([Item_Id])
REFERENCES [Orders] ([Item_ID])

ALTER TABLE [Item] CHECK CONSTRAINT [FK_Item_Item_Id]

ALTER TABLE [Ingredient] WITH CHECK ADD CONSTRAINT [FK_Ingredient_Ing_id] FOREIGN KEY([Ing_id])
REFERENCES [Recipe] ([Ing_id])

ALTER TABLE [Ingredient] CHECK CONSTRAINT [FK_Ingredient_Ing_id]

ALTER TABLE [Recipe] WITH CHECK ADD CONSTRAINT [FK_Recipe_Recipe_id] FOREIGN KEY([Recipe_id])
REFERENCES [Item] ([SKU])

ALTER TABLE [Recipe] CHECK CONSTRAINT [FK_Recipe_Recipe_id]

ALTER TABLE [Inventory] WITH CHECK ADD CONSTRAINT [FK_Inventory_item_id] FOREIGN KEY([item_id])
REFERENCES [Recipe] ([Ing_id])

ALTER TABLE [Inventory] CHECK CONSTRAINT [FK_Inventory_item_id]

ALTER TABLE [Shift] WITH CHECK ADD CONSTRAINT [FK_Shift_Shift_Id] FOREIGN KEY([Shift_Id])
REFERENCES [Rota] ([Shift_Id])

ALTER TABLE [Shift] CHECK CONSTRAINT [FK_Shift_Shift_Id]

ALTER TABLE [Rota] WITH CHECK ADD CONSTRAINT [FK_Rota_date] FOREIGN KEY([date])
REFERENCES [Orders] ([Order_Date])

ALTER TABLE [Rota] CHECK CONSTRAINT [FK_Rota_date]

ALTER TABLE [Rota] WITH CHECK ADD CONSTRAINT [FK_Rota_Staff_Id] FOREIGN KEY([Staff_Id])
REFERENCES [Staff] ([Staff_Id])

ALTER TABLE [Rota] CHECK CONSTRAINT [FK_Rota_Staff_Id]


