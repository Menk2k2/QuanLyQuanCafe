CREATE DATABASE QuanLyQuanCafe
GO

USE QuanLyQuanCafe
GO 

-- Food
-- Table
-- FoodCategory
-- Account
-- Bill
-- BillInfo

CREATE TABLE TableFood
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Bàn chưa có tên',
	status NVARCHAR(100) NOT NULL DEFAULT N'Trống'  --Trống || Có người
)
GO

CREATE TABLE Account
(
	UserName NVARCHAR(100) PRIMARY KEY,
	DisplayName NVARCHAR(100) NOT NULL DEFAULT N'TTCN2',
	PassWord NVARCHAR(1000) NOT NULL DEFAULT 0,
	Type INT NOT NULL DEFAULT 0 --1:admin || 0:nhân viên
)
GO

CREATE TABLE FoodCategory
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên'
)
GO

CREATE TABLE Food
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên',
	idCategory INT NOT NULL,
	price FLOAT NOT NULL DEFAULT 0

	FOREIGN KEY (idCategory) REFERENCES dbo.FoodCategory(id)
)
GO

CREATE TABLE Bill
(
	id INT IDENTITY PRIMARY KEY,
	DateCheckIn DATE NOT NULL DEFAULT GETDATE(), 
	DateCheckOut DATE,
	idTable INT NOT NULL,
	status INT NOT NULL DEFAULT 0	-- 1: Đã thanh toán || 0: Chưa thanh toán
	
	FOREIGN KEY (idTable) REFERENCES dbo.TableFood(id)
)
GO

CREATE TABLE BillInfo
(
	id INT IDENTITY PRIMARY KEY,
	idBill INT NOT NULL,
	idFood INT NOT NULL,
	count INT NOT NULL DEFAULT 0

	FOREIGN KEY (idBill) REFERENCES dbo.Bill(id),
	FOREIGN KEY (idFood) REFERENCES dbo.Food(id)
)
GO

INSERT INTO dbo.Account
		( UserName,
		  DisplayName,
		  PassWord,
		  Type
		)
VALUES	(	N'Manh',	-- UserName - nvarchar(100)
			N'Admin',	-- DisplayName - nvarchar(100)
			N'1',	-- PassWord - nvarchar(100)
			1	-- Type - int
		)

INSERT INTO dbo.Account
		( UserName,
		  DisplayName,
		  PassWord,
		  Type
		)
VALUES	(	N'staff',	-- UserName - nvarchar(100)
			N'staff',	-- DisplayName - nvarchar(100)
			N'1',	-- PassWord - nvarchar(100)
			0	-- Type - int
		)
GO

CREATE PROC USP_GetAccountByUserName
 @userName nvarchar(100)
 AS
 BEGIN
	SELECT *FROM dbo.Account WHERE UserName = @userName
 END
 GO

 EXEC dbo.USP_GetAccountByUserName @userName = N'Manh' --nvarchar(100)

 GO

 CREATE PROC USP_Login
 @userName nvarchar(100), @passWord nvarchar(100)
 AS
 BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName AND PassWord = @passWord
 END
 GO

 --Thêm bàn--
 DECLARE @i INT = 0

 WHILE @i <=10
 BEGIN
	INSERT dbo.TableFood ( name) VALUES	( N'Bàn ' + CAST(@i AS nvarchar(100)))
	SET @i = @i +1
 END
 GO

 CREATE PROC USP_GetTableList
 AS SELECT * FROM dbo.TableFood
 GO

 UPDATE dbo.TableFood SET STATUS = N'Có người' WHERE id = 9

 EXEC dbo.USP_GetTableList
 GO

 --Thêm category--
 INSERT dbo.FoodCategory
		(name)
 VALUES	( N' Cà Phê ' -- name - nvarchar(100)
			)
INSERT dbo.FoodCategory
		(name)
 VALUES	( N' Đồ ăn ')
INSERT dbo.FoodCategory
		(name)
 VALUES	( N' Sinh tố ')
INSERT dbo.FoodCategory
		(name)
 VALUES	( N' Trà Sữa ')
 INSERT dbo.FoodCategory
		(name)
 VALUES	( N' Trà ')

--Thêm món ăn
INSERT dbo.Food
		(name, idCategory, price)
VALUES	( N' Cappuccino ', -- name - nvarchar(100)
		  1, -- idCategory - int
		  50000 -- price - float
			)
INSERT dbo.Food
		(name, idCategory, price)
VALUES	( N' Đen đá ',1,30000)
INSERT dbo.Food
		(name, idCategory, price)
VALUES	( N' Bánh chuối ',2,15000)
INSERT dbo.Food
		(name, idCategory, price)
VALUES	( N' Sữa chua trân châu nha đam ',3,20000)
INSERT dbo.Food
		(name, idCategory, price)
VALUES	( N' Trân châu đường đen ',4,35000)
INSERT dbo.Food
		(name, idCategory, price)
VALUES	( N' Trà sen vàng ',5,40000)
INSERT dbo.Food
		(name, idCategory, price)
VALUES	( N' Trà thạch vải ',5,40000)

--thêm Bill
INSERT dbo.Bill
	  ( DateCheckIn , 
		DateCheckOut ,
		idTable ,
		status
	  )
VALUES ( GETDATE() , --DateCheckIn - date
		 NULL , --DateCheckOut - date
		 1, --idTable - int
		 0 --status - int
		)

INSERT dbo.Bill
	  ( DateCheckIn , 
		DateCheckOut ,
		idTable ,
		status
	  )
VALUES ( GETDATE() , --DateCheckIn - date
		 NULL , --DateCheckOut - date
		 2, --idTable - int
		 0 --status - int
		)

INSERT dbo.Bill
	  ( DateCheckIn , 
		DateCheckOut ,
		idTable ,
		status
	  )
VALUES ( GETDATE() , --DateCheckIn - date
		 GETDATE() , --DateCheckOut - date
		 2, --idTable - int
		 1 --status - int
		)

--thêm BillInfo
INSERT dbo.BillInfo
	  ( idBill, idFood, count )
VALUES ( 1 , --idBill - int
		 1, --idFood - int
		 2 --count - int
		)

INSERT dbo.BillInfo
	  ( idBill, idFood, count )
VALUES ( 1 , --idBill - int
		 5, --idFood - int
		 1 --count - int
		)

INSERT dbo.BillInfo
	  ( idBill, idFood, count )
VALUES ( 2 , --idBill - int
		 1, --idFood - int
		 2 --count - int
		)

INSERT dbo.BillInfo
	  ( idBill, idFood, count )
VALUES ( 2 , --idBill - int
		 6, --idFood - int
		 2 --count - int
		)

INSERT dbo.BillInfo
	  ( idBill, idFood, count )
VALUES ( 3 , --idBill - int
		 5, --idFood - int
		 2 --count - int
		)

GO

SELECT f.name, bi.count, f.price, f.price * bi.count AS totalPrice FROM dbo.BillInfo AS bi, dbo.Bill AS b, dbo.Food AS f 
WHERE bi.idBill = b.id AND bi.idFood = f.id AND b.idTable = 1

 SELECT * FROM dbo.Bill
 SELECT * FROM dbo.BillInfo
 SELECT * FROM dbo.Food
 SELECT * FROM dbo.FoodCategory

 CREATE PROC USP_InsertBill
 @idTable INT
 AS
 BEGIN
	INSERT dbo.Bill
	  ( DateCheckIn , 
		DateCheckOut ,
		idTable ,
		status ,
		discount
	  )
VALUES ( GETDATE() , --DateCheckIn - date
		 NULL , --DateCheckOut - date
		 @idTable, --idTable - int
		 0, --status - int
		 0
		)

 END
 GO

 CREATE PROC USP_InsertBillInfo
 @idBill INT, @idFood INT, @count INT
 AS
 BEGIN
	
	DECLARE @isExitBillInfo INT
	DECLARE @foodCount INT = 1

	SELECT @isExitBillInfo = id, @foodCount = b.count FROM dbo.BillInfo AS b WHERE idBill = @idBill AND idFood = @idFood

	IF(@isExitBillInfo >0)
	BEGIN
		DECLARE @newCount INT = @foodCount + @count
		IF (@newCount >0)
			UPDATE dbo.BillInfo SET count = @foodCount + @count WHERE idFood = @idFood
		ELSE
			DELETE dbo.BillInfo WHERE idBill = @idBill AND idFood = @idFood
	END
	ELSE
	BEGIN
		INSERT dbo.BillInfo
			( idBill, idFood, count )
		VALUES ( @idBill, --idBill - int
			 @idFood, --idFood - int
			 @count --count - int
		)
	END
 END
 GO

 DELETE dbo.BillInfo

 DELETE dbo.Bill


CREATE TRIGGER UTG_UpdateBillInfo
ON dbo.BillInfo FOR INSERT, UPDATE 
AS
BEGIN
	DECLARE @idBill INT

	SELECT @idBill = idBill FROM Inserted

	DECLARE @idTable INT

	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill AND status = 0

	UPDATE dbo.TableFood SET status = N'Có người'  WHERE id = @idTable
END
GO

CREATE TRIGGER UTG_UpdateBill
ON dbo.Bill FOR UPDATE
AS
BEGIN
	DECLARE @idBill INT

	SELECT @idBill = id FROM Inserted

	DECLARE @idTable INT

	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill 

	DECLARE @count int = 0

	SELECT @count = COUNT(*) FROM dbo.Bill WHERE idTable = @idTable AND status = 0

	IF (@count = 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable
END
GO

ALTER TABLE dbo.Bill
ADD discount INT

UPDATE dbo.Bill SET discount = 0

SELECT* FROM dbo.Bill