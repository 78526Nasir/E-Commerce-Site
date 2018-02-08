CREATE DATABASE E_Commerce

USE E_Commerce

select * from cart
-- User TABLE --

CREATE TABLE [User](
	 [user_id]		int identity,	
     username		varchar(50) not null,
     fullname		varchar(100) not null,
     email			varchar(100) not null,
     dob			datetime not null,
     age			int not null,
     [image]		varchar(max),
     religion		varchar(20) not null,
     [password]		varchar(100) not null,
     gender			varchar(10) not null,
     salt			varchar(max),
     [Hash]			varchar(max),
     
     constraint pk_U_id primary key ([user_id])
)

alter table [user] alter column [image] varchar(max)

drop table [User]

select * from admin
select * from [user]



select product.product_id from Product 
join Cart on Product.Product_ID=Cart.Product_ID


delete from cart

DBCC CHECKIDENT(RESEED,Cart)
select * from Product
select * from cart

select * from category
select * from company
-- STORE PROCEDURE for INSERT data into USER TABLE--

create proc sp_addNewUser
@username		varchar(50),
@fullname		varchar(100),
@email			varchar(100),
@dob			datetime,
@age			int,
@image			varchar(max),
@religion		varchar(20),
@password		varchar(100),
@gender			varchar(10),
@salt			varchar(max),
@hash			varchar(max)

as
begin 
	insert into [User](username,fullname,email,dob,age,[image],religion,[password],gender,salt,[hash]) values
				(@username,@fullname,@email,@dob,@age,@image,@religion,@password,@gender,@salt,@hash)
end

drop proc sp_addNewUser
select * from [User]


-- STORE PROCEDURE for SELECT USER --

create proc sp_selectUser 
@username varchar(50),
@hash varchar(100)
as 
begin
	select * from [User] where username=@username and [Hash]=@hash
end



-- STORE PROCEDURE for SELECT USER by Username--

create proc sp_retriveSaltAgainstUser
@username varchar(50)
as 
begin
	select salt from [User] where username=@username
end

drop proc sp_retriveSaltAgainstUser

select * from [user]

drop table [user]

select *  from CATEGORY

-- Product TABLE --

create table Product
(
	Product_ID			int primary key identity,
	ProductCode			varchar(50) NOT NULL,
	Product_Name		varchar(50) NOT NULL,
	[Description]		varchar(500) NOT NULL,
	Price				varchar(20) NOT NULL,
	Category_ID			INT NOT NULL,
	Company_ID			int NOT NULL,
	ImageUrl			varchar(500),
	Quantity			INT,
	
	CONSTRAINT FK_P_CAID FOREIGN KEY(Category_ID)
	REFERENCES Category(Category_ID) ON DELETE CASCADE,
	
	CONSTRAINT FK_P_COID FOREIGN KEY(Company_ID)
	REFERENCES Company(Company_ID) ON DELETE CASCADE
)


DROP TABLE Product

ALTER table PRODUCT alter column GUID UNIQUEIDENTIFIER NOT NULL;

select * from Cart

select * from [user]
-- STORE PROCEDURE for add new product --
create proc sp_addNewProduct
@productCode		varchar(50),
@productName		varchar(50),
@description		varchar(500),
@price				varchar(20),
@categoryID			int,
@companyID			int,
@imageUrl			varchar(500),
@quantity			int
as 
begin
	insert into Product values(@productCode,@productName,@description,@price,@categoryID,@companyID,@imageUrl,@quantity,NEWID())
end

select * from product
drop proc sp_addNewProduct

-- Category TABLE --
select * from product
create table Category
(
	Category_ID				int primary key identity,
	Category_Name			varchar(50),
	Category_Description	varchar(500)
)



select * from Category

select LEN(category_description) as Characters from category where category_id=3

-- STORE PROCEDURE for insert data into Category TABLE --

create proc sp_addNewCategory
@categoryName varchar(50),
@categoryDesc varchar(500)

as
begin
	insert into Category values(@categoryName,@categoryDesc)
end

-- STORE PROCEDURE for select all Category Name --

create proc sp_getAllCategory
as
begin
	select * from category
end

drop sp_getAllCategory


-- Company TABLE --

create table Company
(
	Company_ID			int primary key identity,
	Company_Name		varchar(50) not null,
	Company_Desc		varchar(500) not null,
	Partnership_date	datetime not null,
)

drop table company

select * from company
-- STORE PROCEDURE for select all Company --
create proc sp_getAllCompanies
as 
begin
	select * from Company
end


-- STORE PROCEDURE for insert data into Company TABLE ---

create proc sp_addNewCompany
@CompanyName		varchar(50),
@CompanyDesc		varchar(500),
@PartnershipDate	datetime

as
begin
	insert into Company values(@CompanyName,@CompanyDesc,@PartnershipDate)
end




-- CREATE admin TABLE --

create table [admin]
(
	Admin_ID	int primary key identity,
	username	varchar(50) not null,
	FullName	varchar(50),
	[Password]	varchar(50) not null,
	ImageUrl	varchar(max)
)

drop table admin


-- STORE PROCEDURE FOR Admin TABLE --

select * from product

-- STORE PROCEDURE FOR SELECT ADMIN --

create proc sp_selectAdmin 
@username varchar(50),
@password varchar(50)
as
begin
	select * from [admin] where username=@username and [Password]=@password
end


drop table admin

insert into [admin] values
('sujan','Nasir Islam Sujan','78526','../images/admin.jpg'),
('Nasir','Islam Nasir Sujan','12345','../images/admin2.jpg');


select * from admin

drop proc sp_selectAdmin
select * from category
select * from company


-- CART TABLE --

CREATE TABLE Cart(
	CartID		INT IDENTITY,
	Product_ID	INT NOT NULL,
	UserID		INT	NOT NULL,
	
	CONSTRAINT COMP_PU_ID PRIMARY KEY(Product_ID,UserID),
	CONSTRAINT FK_C_PID FOREIGN KEY(Product_ID) REFERENCES Product(Product_ID) ON DELETE CASCADE,
	CONSTRAINT FK_C_UID FOREIGN KEY(UserID) REFERENCES [User]([user_id]) ON DELETE CASCADE
)

select * from cart
insert into Cart values(1,2)




-- ORDER TABLE --

CREATE TABLE [Order](
	Order_ID			INT PRIMARY KEY IDENTITY,
	[User_ID]			INT NOT NULL,
	Product_ID			INT NOT NULL,
	Order_Date			DATETIME NOT NULL,
		
	CONSTRAINT FK_O_CID FOREIGN KEY([User_ID]) 
	REFERENCES [User]([User_ID]) ON DELETE CASCADE,
	
	CONSTRAINT FK_P_OID FOREIGN KEY(Product_ID) 
	REFERENCES Product(Product_ID) ON DELETE CASCADE,
);

DROP TABLE [Order] 

CREATE TABLE ProductOrderDetails(
	POD_ID			INT PRIMARY KEY IDENTITY,
	Product_ID		INT NOT NULL,
	Customer_ID		INT NOT NULL,
	[Address]		VARCHAR(MAX) NOT NULL,
	PhoneNumber		VARCHAR(15) NOT NULL,
	Quantity		INT NOT NULL,
	TotalPrice		FLOAT NOT NULL,
	
	CONSTRAINT FK_POD_CID FOREIGN KEY(Customer_ID) 
	REFERENCES [User]([User_id]) ON DELETE CASCADE,
	
	CONSTRAINT FK_POD_PID FOREIGN KEY(Product_ID) 
	REFERENCES Product(Product_ID) ON DELETE CASCADE

)

select * from ProductOrderDetails

drop table ProductOrderDetails 
drop table cart
drop table product

delete from CATEGORY where CATegory_ID=5
Select * from product


-- ResetPasswordRequest TABLE FOR RESETTING PASSWORD --

CREATE TABLE ResetPasswordRequest(
	ID			UNIQUEIDENTIFIER PRIMARY KEY,
	[User_ID]	INT NOT NULL,
	[DateTime]	DATETIME,
	
	CONSTRAINT FK_RPR_UID FOREIGN KEY ([User_ID]) 
	REFERENCES [User]([User_ID]) ON DELETE CASCADE  
)

-- DROP USER NEEEDS TO DROP --
drop table [user]
drop table [order]
drop table ProductOrderDetails
drop table ResetPasswordRequest 


---

select * from [product]


delete from ResetPasswordRequest

select * from category
select *from product
drop table CATEGORY

insert into CATEGORY values('Computer','All types of computer')
delete from CATEGORY where CATegory_ID=4

select * from [user]

-- STORE PROCEDURE FOR RESETTING PASSWORD PROCESS --

CREATE PROC SP_RESET_PASSWORD 
@email varchar(100)
AS
BEGIN
	DECLARE @User_ID INT
	DECLARE @R_Email VARCHAR(100)
	DECLARE @Username VARCHAR(50)
	SELECT @User_ID=[user_id], @R_Email= email, @Username=username
	FROM [User]
	WHERE email=@email
	
	
	IF(@User_ID IS NOT NULL)
		BEGIN
			DECLARE @GUID UNIQUEIDENTIFIER
			SET @GUID=NEWID()
			
			INSERT INTO ResetPasswordRequest VALUES
			(@GUID,@User_ID,GETDATE())
			
			SELECT 1 AS ReturnCode, @GUID AS UniqueID, @R_Email AS Email, @Username as Username
		END
	ELSE 
		BEGIN
			SELECT 0 AS ReturnCode, NULL AS UniqueID, NULL AS Email, @Username as Username
		END
	
END

DROP PROC SP_RESET_PASSWORD

select * from admin

-- STORE PROCEDURE FOR CHECKING LINK VALIDATION --
-- RESET LINK IS VALID FOR ONLY ONE TIME --

select * from ResetPasswordRequest

CREATE PROC SP_IS_PASSWORD_RESET_LINK_VALID 
@GUID UNIQUEIDENTIFIER
AS
BEGIN
	IF(EXISTS(SELECT [USER_ID] FROM ResetPasswordRequest WHERE ID=@GUID))
		BEGIN
			SELECT 1 AS returnCode
		END
	ELSE
		BEGIN
			SELECT 0 AS returnCode
		END
END


SELECT * FROM ResetPasswordRequest



CREATE PROC SP_CHANGE_PASSWORD
@GUID UNIQUEIDENTIFIER,
@password VARCHAR(100),
@salt VARCHAR(MAX),
@hash VARCHAR(MAX)
AS
BEGIN
	DECLARE @UserID INT
	
	SELECT @UserID = [User_ID] 
	FROM ResetPasswordRequest
	WHERE ID=@GUID
	
	IF(@UserID IS NULL)
		BEGIN
			-- IF USER DOES NOT EXISTS
			SELECT 0 AS returnCode	
		END
	ELSE
		BEGIN
			-- IF USER EXISTS, UPDATE WITH NEW PASSWORD,SALT AND HASH
			
			UPDATE [User] SET 
			[password]=@password, salt=@salt, [hash]=@hash
			WHERE [user_id] = @UserID
			
			-- DELETE THE RESET_PASSWORD_REQUEST RECORD 
			DELETE FROM ResetPasswordRequest
			WHERE ID=@GUID
			
			SELECT 1 AS returnCode
		END
END


select * from [user]

SELECT * FROM PRODUCT

delete from ResetPasswordRequest

-- STORE PROCEDURE FOR SEARCH USER --
CREATE PROC SP_SELECT_ALL_USER
AS
BEGIN
	SELECT [user_id],[username],fullname,email,age,religion,gender
	FROM [User]
END


-- STORE PROCEDURE FOR SELECT ALL COMPANY --

select * from company
CREATE PROC SP_SELECT_ALL_PARTNER
AS
BEGIN
	SELECT * FROM Company
END

select * from [user]

-- STORE PROCEDURE FOR SELECT ALL COMPANY --
select * from product
CREATE PROC SP_SELECT_ALL_PRODUCT
AS
BEGIN
	SELECT Product_ID, ProductCode, Product_Name, Company_ID, [Description], Price FROM Product
END




-- STORE PROCEDURE FOR DELETE USER --

CREATE PROC SP_DELETE_USER
@userid int
AS
BEGIN
	DELETE FROM [User] WHERE [user_id] =@userid
END

-- STORE PROCEDURE FOR DELETE PARTNER --

CREATE PROC SP_DELETE_PARTNER
@partnerid int
AS
BEGIN
	DELETE FROM Company WHERE Company_ID = @partnerid
END




-- STORE PROCEDURE FOR DELETE PRODUCT --

CREATE PROC SP_DELETE_PRODUCT
@productid int
AS
BEGIN
	DELETE FROM Product WHERE Product_ID = @productid
END


-- STORE PROCEDURE FOR GET PRODUCTS BY CATEGORY --

CREATE PROC SP_GET_PRODUCT_BY_CATEGORY 'laptop'
@categoryname VARCHAR(50)
AS
BEGIN
	select product_id, ProductCode, Product_Name, [Description],Price, ImageUrl, [GUID]
	from product join CATEGORY
	on product.CATEGORY_ID= CATEGORY.category_ID
	where CATEGORY_Name =@categoryname
END

DROP PROC SP_GET_PRODUCT_BY_CATEGORY



-- CREATE STORE PROCEDURE FOR GET ALL PRODUCTS --
CREATE PROC SP_GET_ALL_PRODUCT
AS
BEGIN
	select * from Product
END



-- RESEED the TO START IDENTITY FROM 0
DBCC CHECKIDENT(Cart,RESEED,0)
DBCC CHECKIDENT(product,RESEED,0)
DBCC CHECKIDENT([User],RESEED,0)
DBCC CHECKIDENT(Cart,RESEED,0)

select * from cart

select * from Product 
	

select * from [user]


update product set product_Name='Apple Macbook Air 3' where product_ID=6

-- STORE PROCEDURE FOR ADDING PRODUCT TO CART --
CREATE PROC SP_ADD_TO_CART
@productid		INT,
@userid			INT			
AS
BEGIN
	INSERT INTO Cart VALUES(@productid,@userid)
END

-- STORE PROCEDURE FOR GET PRODUCTS BY ProductID --

CREATE PROC SP_GET_PRODUCT_BY_PRODUCT_GUID 'bd50e6c3-d727-4f95-bc2d-2a8d689ac8cd465'
@productGUID	VARCHAR(MAX)
AS
BEGIN
	SELECT * FROM product 
	WHERE [GUID] = @productGUID AND LEN(@productGUID) = LEN(NEWID())
END

drop  proc SP_GET_PRODUCT_BY_PRODUCT_GUID
select len(GUID) as length  from product

select * from product

-- STORE PROCEDURE FOR GET DEFAULT ONE PRODUCTS  -- 

CREATE PROC SP_SELECT_DEFAULT_PRODUCT
AS
BEGIN
	select TOP(1) * from product 
END


-- STORE PROCEDURE FOR CHECK WHETHER A GIVEN USERNAME WAS ALREADY EXISTS OR NOT --

CREATE PROC SP_IS_USERNAME_EXISTS 
@username VARCHAR(100)
AS
BEGIN
	DECLARE @COUNT INT
	
	SELECT @COUNT = COUNT([user_id]) FROM [User] 
	WHERE username=@username
	
	IF(@COUNT>0)
		SELECT 1 AS UserNameExists
	ELSE 
		SELECT 0 AS UserNameExists
END


-- STORE PROCEDURE FOR CHECK WHETHER A GIVEN EMAIL WAS ALREADY EXISTS OR NOT
CREATE PROC SP_IS_EMAIL_EXISTS
@email VARCHAR(100)
AS
BEGIN
	DECLARE @COUNT INT
	
	SELECT @COUNT= COUNT(email)
	FROM [User] 
	WHERE email=@email
	
	IF(@COUNT>0)
		SELECT 1 AS EmailExists
	ELSE
		SELECT 0 AS EmailExists
END



-- STORE PROCEDURE FOR SELECT ALL CART --
CREATE PROC SP_SELECT_ALL_CART
@userid int
AS
BEGIN
	SELECT Product_ID FROM Cart WHERE UserID = @userid
END

DROP PROC SP_SELECT_ALL_CART 

-- STORE PROCEDURE FOR DELETE CARTED PRODUCT --
CREATE PROC SP_DELETE_CARTED_PRODUCT 
@productid int,
@userid int
AS
BEGIN
	DELETE FROM Cart WHERE [userID]=@userid AND Product_ID=@productid
END


select * from product 
join cart on product.product_id=cart.product_id

select * from product
select distinct(product_ID) from cart where UserID =2


select * from [user]

select * from [order]

select * from cart

update [User] set image='../images/admin2.jpg' where [USER_ID]=2

DBCC CHECKIDENT([USER],RESEED,0)

drop table cart

select * from [user]

-- STORE PROCEDURE FOR GET ALL CARTED PRODUCTS --
CREATE PROC SP_GET_ALL_CARTED_PRODUCTS
@userid int
AS
BEGIN
	SELECT Product.Product_ID, ProductCode, Product_Name, [Description], Price, ImageUrl, [GUID]
	FROM Product JOIN Cart on Product.Product_ID=Cart.Product_ID 
	WHERE UserID = @userid
END

drop proc SP_GET_ALL_CARTED_PRODUCTS

select * from product
DBCC CHECKIDENT (CART,RESEED,0)

select * from [user]

-- STORE PROCEDURE FOR INSERT DATA INTO ProductOrderDetails --

CREATE PROC SP_ADD_NEW_POD
@productid		INT,
@customerid		INT, 
@address		VARCHAR(MAX),
@phonenumber	VARCHAR(15),
@quantity		INT,
@totalprice		float
AS
BEGIN
	INSERT INTO ProductOrderDetails VALUES
	(@productid, @customerid, @address, @phonenumber, @quantity, @totalprice)
END

select * from ProductOrderDetails

 USE E_Commerce
CREATE TABLE ExceptionLog
(
	ID				INT PRIMARY KEY IDENTITY,
	[DATE]			DATETIME,
	[DESCRIPTION]	VARCHAR(MAX)
	
);

select * from ExceptionLog

CREATE PROC SP_INSERT_LOG
@description VARCHAR(MAX)
AS
BEGIN
	INSERT INTO ExceptionLog VALUES 
	(GETDATE(),@description)
END


select * from [User]
delete from [user]

select * from [order]
delete From [order]

CREATE PROC SP_TRIGGER_CART_TO_ORDER
@productid	INT,
@userid		INT
AS
BEGIN
	DELETE FROM CART WHERE PRODUCT_ID = @productid AND USERID = @userid
	INSERT INTO [ORDER] VALUES (@userid, @productid, GETDATE())
END

CREATE PROC SP_CANCEL_ORDER
@productid	INT,
@userid		INT
AS
BEGIN
	DELETE FROM [Order] WHERE PRODUCT_ID = @productid AND [USER_ID] = @userid
END