USE [master]
GO
/****** Object:  Database [Hana_Shop]    Script Date: 03/04/2021 3:51:34 PM ******/
CREATE DATABASE [Hana_Shop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Hana_Shop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Hana_Shop.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Hana_Shop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Hana_Shop_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Hana_Shop] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Hana_Shop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Hana_Shop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Hana_Shop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Hana_Shop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Hana_Shop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Hana_Shop] SET ARITHABORT OFF 
GO
ALTER DATABASE [Hana_Shop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Hana_Shop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Hana_Shop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Hana_Shop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Hana_Shop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Hana_Shop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Hana_Shop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Hana_Shop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Hana_Shop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Hana_Shop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Hana_Shop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Hana_Shop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Hana_Shop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Hana_Shop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Hana_Shop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Hana_Shop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Hana_Shop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Hana_Shop] SET RECOVERY FULL 
GO
ALTER DATABASE [Hana_Shop] SET  MULTI_USER 
GO
ALTER DATABASE [Hana_Shop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Hana_Shop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Hana_Shop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Hana_Shop] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Hana_Shop] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Hana_Shop', N'ON'
GO
USE [Hana_Shop]
GO
/****** Object:  Table [dbo].[tblCategory]    Script Date: 03/04/2021 3:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCategory](
	[categoryId] [varchar](10) NOT NULL,
	[categoryName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_tblCategory] PRIMARY KEY CLUSTERED 
(
	[categoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblHistory]    Script Date: 03/04/2021 3:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblHistory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[productId] [int] NOT NULL,
	[date] [datetime] NOT NULL,
	[username] [varchar](50) NOT NULL,
	[type] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tblHistory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblOrder]    Script Date: 03/04/2021 3:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblOrder](
	[orderId] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[isOnlinePayment] [bit] NULL,
	[currentDate] [datetime] NOT NULL,
	[total] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_tblOrder] PRIMARY KEY CLUSTERED 
(
	[orderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblOrderDetail]    Script Date: 03/04/2021 3:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrderDetail](
	[orderDetailId] [int] IDENTITY(1,1) NOT NULL,
	[orderId] [int] NOT NULL,
	[productId] [int] NOT NULL,
	[price] [nchar](10) NULL,
	[quantity] [int] NOT NULL,
 CONSTRAINT [PK_tblOrderDetail] PRIMARY KEY CLUSTERED 
(
	[orderDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblProduct]    Script Date: 03/04/2021 3:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblProduct](
	[productId] [int] IDENTITY(24,1) NOT NULL,
	[productName] [nvarchar](50) NOT NULL,
	[image] [varchar](max) NOT NULL,
	[description] [nvarchar](500) NOT NULL,
	[price] [numeric](18, 3) NOT NULL,
	[createDate] [datetime] NOT NULL,
	[quantity] [numeric](18, 0) NOT NULL,
	[status] [bit] NOT NULL,
	[categoryId] [varchar](10) NOT NULL,
 CONSTRAINT [PK_tblProduct] PRIMARY KEY CLUSTERED 
(
	[productId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 03/04/2021 3:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUser](
	[username] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[fullname] [nvarchar](100) NOT NULL,
	[role] [varchar](10) NULL,
	[status] [bit] NULL,
 CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[tblCategory] ([categoryId], [categoryName]) VALUES (N'C1', N'FastFood')
INSERT [dbo].[tblCategory] ([categoryId], [categoryName]) VALUES (N'C2', N'Drink')
SET IDENTITY_INSERT [dbo].[tblHistory] ON 

INSERT [dbo].[tblHistory] ([id], [productId], [date], [username], [type]) VALUES (36, 48, CAST(N'2021-03-18 19:02:41.077' AS DateTime), N'se140814', N'Update')
INSERT [dbo].[tblHistory] ([id], [productId], [date], [username], [type]) VALUES (37, 49, CAST(N'2021-03-18 19:03:03.380' AS DateTime), N'se140814', N'Delete')
INSERT [dbo].[tblHistory] ([id], [productId], [date], [username], [type]) VALUES (38, 53, CAST(N'2021-03-18 19:22:23.287' AS DateTime), N'se140814', N'Delete')
INSERT [dbo].[tblHistory] ([id], [productId], [date], [username], [type]) VALUES (39, 53, CAST(N'2021-03-18 19:29:02.727' AS DateTime), N'se140814', N'Update')
INSERT [dbo].[tblHistory] ([id], [productId], [date], [username], [type]) VALUES (40, 53, CAST(N'2021-03-18 19:29:24.273' AS DateTime), N'se140814', N'Delete')
INSERT [dbo].[tblHistory] ([id], [productId], [date], [username], [type]) VALUES (41, 53, CAST(N'2021-03-18 19:29:30.337' AS DateTime), N'se140814', N'Update')
INSERT [dbo].[tblHistory] ([id], [productId], [date], [username], [type]) VALUES (42, 53, CAST(N'2021-03-19 08:56:48.990' AS DateTime), N'se140814', N'Update')
INSERT [dbo].[tblHistory] ([id], [productId], [date], [username], [type]) VALUES (43, 53, CAST(N'2021-03-19 08:57:11.247' AS DateTime), N'se140814', N'Update')
INSERT [dbo].[tblHistory] ([id], [productId], [date], [username], [type]) VALUES (44, 53, CAST(N'2021-03-19 08:57:21.657' AS DateTime), N'se140814', N'Update')
INSERT [dbo].[tblHistory] ([id], [productId], [date], [username], [type]) VALUES (45, 53, CAST(N'2021-03-19 09:00:26.880' AS DateTime), N'se140814', N'Update')
INSERT [dbo].[tblHistory] ([id], [productId], [date], [username], [type]) VALUES (47, 41, CAST(N'2021-03-19 18:38:05.303' AS DateTime), N'se140814', N'Update')
INSERT [dbo].[tblHistory] ([id], [productId], [date], [username], [type]) VALUES (48, 41, CAST(N'2021-03-19 18:38:15.387' AS DateTime), N'se140814', N'Update')
INSERT [dbo].[tblHistory] ([id], [productId], [date], [username], [type]) VALUES (49, 41, CAST(N'2021-03-19 18:38:24.210' AS DateTime), N'se140814', N'Delete')
INSERT [dbo].[tblHistory] ([id], [productId], [date], [username], [type]) VALUES (50, 41, CAST(N'2021-03-19 18:38:38.397' AS DateTime), N'se140814', N'Update')
INSERT [dbo].[tblHistory] ([id], [productId], [date], [username], [type]) VALUES (55, 53, CAST(N'2021-03-20 04:08:05.473' AS DateTime), N'se140814', N'Update')
SET IDENTITY_INSERT [dbo].[tblHistory] OFF
SET IDENTITY_INSERT [dbo].[tblOrder] ON 

INSERT [dbo].[tblOrder] ([orderId], [username], [isOnlinePayment], [currentDate], [total]) VALUES (1044, N'se140810', 0, CAST(N'2021-03-18 19:30:42.277' AS DateTime), CAST(50 AS Numeric(18, 0)))
INSERT [dbo].[tblOrder] ([orderId], [username], [isOnlinePayment], [currentDate], [total]) VALUES (1045, N'se140810', 0, CAST(N'2021-03-18 19:33:57.823' AS DateTime), CAST(40 AS Numeric(18, 0)))
INSERT [dbo].[tblOrder] ([orderId], [username], [isOnlinePayment], [currentDate], [total]) VALUES (1046, N'se140810', 0, CAST(N'2021-03-18 19:36:46.187' AS DateTime), CAST(510 AS Numeric(18, 0)))
INSERT [dbo].[tblOrder] ([orderId], [username], [isOnlinePayment], [currentDate], [total]) VALUES (1047, N'se140811', 0, CAST(N'2021-03-18 23:25:51.883' AS DateTime), CAST(30 AS Numeric(18, 0)))
INSERT [dbo].[tblOrder] ([orderId], [username], [isOnlinePayment], [currentDate], [total]) VALUES (1048, N'se140810', 0, CAST(N'2021-03-19 08:55:43.250' AS DateTime), CAST(120 AS Numeric(18, 0)))
INSERT [dbo].[tblOrder] ([orderId], [username], [isOnlinePayment], [currentDate], [total]) VALUES (1049, N'longnbpse140814@fpt.edu.vn', 0, CAST(N'2021-03-19 19:01:34.833' AS DateTime), CAST(41 AS Numeric(18, 0)))
INSERT [dbo].[tblOrder] ([orderId], [username], [isOnlinePayment], [currentDate], [total]) VALUES (1050, N'se140810', 0, CAST(N'2021-03-19 19:08:06.403' AS DateTime), CAST(41 AS Numeric(18, 0)))
INSERT [dbo].[tblOrder] ([orderId], [username], [isOnlinePayment], [currentDate], [total]) VALUES (1051, N'se140810', 0, CAST(N'2021-03-20 03:31:50.910' AS DateTime), CAST(120 AS Numeric(18, 0)))
INSERT [dbo].[tblOrder] ([orderId], [username], [isOnlinePayment], [currentDate], [total]) VALUES (1052, N'se140810', 0, CAST(N'2021-03-20 03:55:48.107' AS DateTime), CAST(60 AS Numeric(18, 0)))
INSERT [dbo].[tblOrder] ([orderId], [username], [isOnlinePayment], [currentDate], [total]) VALUES (1053, N'se140810', 0, CAST(N'2021-03-20 07:21:47.203' AS DateTime), CAST(180 AS Numeric(18, 0)))
INSERT [dbo].[tblOrder] ([orderId], [username], [isOnlinePayment], [currentDate], [total]) VALUES (1054, N'se140810', 0, CAST(N'2021-03-20 07:22:20.867' AS DateTime), CAST(30 AS Numeric(18, 0)))
SET IDENTITY_INSERT [dbo].[tblOrder] OFF
SET IDENTITY_INSERT [dbo].[tblOrderDetail] ON 

INSERT [dbo].[tblOrderDetail] ([orderDetailId], [orderId], [productId], [price], [quantity]) VALUES (20, 1044, 52, N'30        ', 1)
INSERT [dbo].[tblOrderDetail] ([orderDetailId], [orderId], [productId], [price], [quantity]) VALUES (21, 1044, 53, N'20        ', 1)
INSERT [dbo].[tblOrderDetail] ([orderDetailId], [orderId], [productId], [price], [quantity]) VALUES (22, 1045, 53, N'40        ', 2)
INSERT [dbo].[tblOrderDetail] ([orderDetailId], [orderId], [productId], [price], [quantity]) VALUES (23, 1046, 3, N'240       ', 2)
INSERT [dbo].[tblOrderDetail] ([orderDetailId], [orderId], [productId], [price], [quantity]) VALUES (24, 1046, 52, N'270       ', 9)
INSERT [dbo].[tblOrderDetail] ([orderDetailId], [orderId], [productId], [price], [quantity]) VALUES (25, 1047, 52, N'30        ', 1)
INSERT [dbo].[tblOrderDetail] ([orderDetailId], [orderId], [productId], [price], [quantity]) VALUES (26, 1048, 52, N'120       ', 4)
INSERT [dbo].[tblOrderDetail] ([orderDetailId], [orderId], [productId], [price], [quantity]) VALUES (27, 1049, 53, N'40.8      ', 2)
INSERT [dbo].[tblOrderDetail] ([orderDetailId], [orderId], [productId], [price], [quantity]) VALUES (28, 1050, 53, N'40.8      ', 2)
INSERT [dbo].[tblOrderDetail] ([orderDetailId], [orderId], [productId], [price], [quantity]) VALUES (29, 1051, 4, N'120       ', 2)
INSERT [dbo].[tblOrderDetail] ([orderDetailId], [orderId], [productId], [price], [quantity]) VALUES (30, 1052, 4, N'60        ', 1)
INSERT [dbo].[tblOrderDetail] ([orderDetailId], [orderId], [productId], [price], [quantity]) VALUES (31, 1053, 3, N'120       ', 1)
INSERT [dbo].[tblOrderDetail] ([orderDetailId], [orderId], [productId], [price], [quantity]) VALUES (32, 1053, 4, N'60        ', 1)
INSERT [dbo].[tblOrderDetail] ([orderDetailId], [orderId], [productId], [price], [quantity]) VALUES (33, 1054, 45, N'30        ', 2)
SET IDENTITY_INSERT [dbo].[tblOrderDetail] OFF
SET IDENTITY_INSERT [dbo].[tblProduct] ON 

INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (3, N'Sausage McMuffin with Egg', N'https://d1nqx6es26drid.cloudfront.net/app/uploads/2015/04/04033140/product-sausage-mcmuffin-w-egg-350x350.png', N'Sumptuous chicken sausage and an egg done sunny side-up served between perfectly toasted muffins.', CAST(120.000 AS Numeric(18, 3)), CAST(N'2021-03-14 00:00:00.000' AS DateTime), CAST(0 AS Numeric(18, 0)), 0, N'C1')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (4, N'MILO', N'https://d1nqx6es26drid.cloudfront.net/app/uploads/2015/04/04035541/product-hot-milo-350x350.png', N'For a quick energy boost, your favourite chocolate drink toasty in a cup.', CAST(60.000 AS Numeric(18, 3)), CAST(N'2021-03-10 00:00:00.000' AS DateTime), CAST(0 AS Numeric(18, 0)), 0, N'C2')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (5, N'Jasmine Green Tea', N'https://d1nqx6es26drid.cloudfront.net/app/uploads/2015/04/04040044/product-jasmine-green-tea-350x350.png', N'A soothing fusion of fragrant Jasmine and Green Tea calms your senses.', CAST(60.000 AS Numeric(18, 3)), CAST(N'2021-02-03 00:00:00.000' AS DateTime), CAST(6 AS Numeric(18, 0)), 1, N'C2')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (6, N'Strawberry Shake', N'https://d1nqx6es26drid.cloudfront.net/app/uploads/2015/04/04041717/product-strawberry-milkshake-350x350.png', N'Fall in love all over again with McDonald’s totally irresistible shake! Creamy rich and absolutely “Wow!” – millions around the world have fallen for their luscious lure. Your choice of vanilla, strawberry or chocolate.', CAST(70.000 AS Numeric(18, 3)), CAST(N'2020-10-22 00:00:00.000' AS DateTime), CAST(6 AS Numeric(18, 0)), 1, N'C2')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (7, N'PRIME BEEF', N'https://dominos.vn/Data/Sites/1/Product/577/prime-beef-full.png', N'Mozzarella cheese, Pizza Sauce, Onion, Tomato, Cheese Sauce, Meat ball, Mexico Beef', CAST(300.000 AS Numeric(18, 3)), CAST(N'2020-10-11 00:00:00.000' AS DateTime), CAST(3 AS Numeric(18, 0)), 1, N'C1')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (8, N'PIZZAMIN Extravaganza', N'https://img.dominos.vn/Extravaganza.jpg', N'Tomato Sauce, Mozzarella Cheese, Pepperoni Sausage, Ham, Italian Sausage, Beef Ball, Green Bell Pepper, Fat Mushroom, Onion, Olive 
Lưu bản dịch
', CAST(250.000 AS Numeric(18, 3)), CAST(N'2020-01-11 00:00:00.000' AS DateTime), CAST(6 AS Numeric(18, 0)), 1, N'C1')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (9, N'SURF & TURF', N'https://dominos.vn/Data/Sites/1/Product/582/surf-and-turf-min-360x240.png', N'Mozzarella cheese, Pizza Sauce, Onion, Shrimp, Tomato, Cheese Sauce, Mexico Beef', CAST(160.000 AS Numeric(18, 3)), CAST(N'2020-02-11 00:00:00.000' AS DateTime), CAST(8 AS Numeric(18, 0)), 1, N'C1')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (10, N'OCEAN MANIA', N'https://dominos.vn/Data/Sites/1/Product/580/ocean-mania-full.png', N'chocolate, suger', CAST(260.000 AS Numeric(18, 3)), CAST(N'2021-01-11 00:00:00.000' AS DateTime), CAST(4 AS Numeric(18, 0)), 1, N'C1')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (11, N'SPICY CHICKEN', N'https://popeyes.vn/media/catalog/category/menu_SPICY_alacarte_1.png', N'6 pc spicy chicken  ', CAST(230.000 AS Numeric(18, 3)), CAST(N'2020-12-12 00:00:00.000' AS DateTime), CAST(36 AS Numeric(18, 0)), 1, N'C1')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (12, N'PEACH JELLY TEA', N'https://www.highlandscoffee.com.vn/vnt_upload/product/03_2018/thumbs/270_crop_TRATHACHDAO.png', N'A bold tea base with juicy peaches and chewy peach jelly. Top it with milk if you prefer!', CAST(695.000 AS Numeric(18, 3)), CAST(N'2020-02-03 00:00:00.000' AS DateTime), CAST(10 AS Numeric(18, 0)), 1, N'C2')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (13, N'Latte ', N'https://d1nqx6es26drid.cloudfront.net/app/uploads/2015/04/16034540/product-himalayan-tea-frappe-mcc-350x350.png', N'The robust flavour of freshly brewed coffee meets the creamy, sweet scent of vanilla; topped with whipped cream for a sweet finish.', CAST(150.000 AS Numeric(18, 3)), CAST(N'2020-12-25 00:00:00.000' AS DateTime), CAST(2 AS Numeric(18, 0)), 1, N'C2')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (14, N'GOLDEN LOTUS TEA', N'https://www.highlandscoffee.com.vn/vnt_upload/product/03_2018/TRASENVANG.png', N'https://www.highlandscoffee.com.vn/en/golden-lotus-tea.html', CAST(70.000 AS Numeric(18, 3)), CAST(N'2020-12-10 00:00:00.000' AS DateTime), CAST(3 AS Numeric(18, 0)), 1, N'C2')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (15, N'PHINDI CHOCO
', N'https://www.highlandscoffee.com.vn/vnt_upload/product/11_2020/phindi_choco_new.png', N'The new generation of Phin coffee with smoother Phin, combined with the sweet melted Choco, brings a new taste, could not be more attractive!', CAST(40.000 AS Numeric(18, 3)), CAST(N'2020-10-11 00:00:00.000' AS DateTime), CAST(0 AS Numeric(18, 0)), 0, N'C2')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (16, N'AMERICANO', N'https://www.highlandscoffee.com.vn/vnt_upload/product/03_2018/thumbs/270_crop_AMERICANO.png', N'A shot of espresso topped with hot water. Also available was an Iced Americano.', CAST(39.000 AS Numeric(18, 3)), CAST(N'2020-06-05 00:00:00.000' AS DateTime), CAST(1 AS Numeric(18, 0)), 1, N'C2')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (17, N'Green Tea', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBC0WN6SuHbCIq7qqq0YeDjbAzo53ziJBELw&usqp=CAU', N'Tannins give green tea its astringent flavour. They have antioxidant and antibacterial properties, and also act as detoxicants.', CAST(100.000 AS Numeric(18, 3)), CAST(N'2020-06-16 00:00:00.000' AS DateTime), CAST(0 AS Numeric(18, 0)), 0, N'C1')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (18, N'Double Chocolate', N'https://d1nqx6es26drid.cloudfront.net/app/uploads/2015/04/16034420/product-double-chocolate-frappe-mcc-350x350.png', N'The only thing better than chocolate is more chocolate! A doubly delicious blend of chocolaty Oreo® goodness topped with whipped cream, chocolate drizzle and chocolate powder.', CAST(170.000 AS Numeric(18, 3)), CAST(N'2020-05-05 00:00:00.000' AS DateTime), CAST(5 AS Numeric(18, 0)), 1, N'C2')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (19, N'Latte Frappé', N'https://d1nqx6es26drid.cloudfront.net/app/uploads/2015/04/16113718/latte_frappe_v1.png', N'The robust flavour of freshly brewed coffee meets the creamy, sweet scent of vanilla; topped with whipped cream for a sweet finish', CAST(110.000 AS Numeric(18, 3)), CAST(N'2020-12-21 00:00:00.000' AS DateTime), CAST(3 AS Numeric(18, 0)), 1, N'C2')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (20, N'Buttermilk Crispy Chicken', N'data:image/jpeg;base64,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', N'Crispy whole-muscle chicken thigh flavoured with buttermilk packed in a glazed burger bun. Served with white cheddar cheese, romaine lettuce, black pepper mayo; and topped with grilled pineapple rings and crisp purple cabbage.
In short, perfection in every bite!', CAST(160.000 AS Numeric(18, 3)), CAST(N'2020-12-31 00:00:00.000' AS DateTime), CAST(5 AS Numeric(18, 0)), 1, N'C1')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (21, N'Original Angus Cheeseburger', N'https://d1nqx6es26drid.cloudfront.net/app/uploads/2019/07/05231454/the-originial-angus-350x350.png', N'Made from all the things you love – two slices of melty cheese, slivered onions and 100% Angus beef. All between aromatic glazed buns for an irresistible finish.', CAST(210.000 AS Numeric(18, 3)), CAST(N'2020-11-21 00:00:00.000' AS DateTime), CAST(6 AS Numeric(18, 0)), 1, N'C1')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (22, N'Angus BLT', N'https://d1nqx6es26drid.cloudfront.net/app/uploads/2019/07/05151250/Angus-BLT.png', N'A classic combo with a signature twist. Enjoy crispy chicken bacon, crisp romaine lettuce and juicy tomatoes, now paired with 100% Angus Beef, sliced onions and cheddar cheese for a taste like never before.', CAST(240.000 AS Numeric(18, 3)), CAST(N'2020-10-25 00:00:00.000' AS DateTime), CAST(0 AS Numeric(18, 0)), 0, N'C1')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (23, N'Hotcakes', N'https://d1nqx6es26drid.cloudfront.net/app/uploads/2015/04/04032614/product-hotcakes-350x350.png', N'Home » Asian » Hottokēki (Japanese Hot Cake)
HOTTOKĒKI (JAPANESE HOT CAKE)
26 March, 2014 by Tara 95 Comments

Recipe for Hottokēki, Japanese Hot Cakes', CAST(110.000 AS Numeric(18, 3)), CAST(N'2020-12-26 00:00:00.000' AS DateTime), CAST(5 AS Numeric(18, 0)), 1, N'C1')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (26, N'Cake', N'data:image/jpeg;base64,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', N'This recipe for the Best Birthday Cake with moist and fluffy cake paired with rich and creamy milk chocolate buttercream is perfect for celebrating!', CAST(695.000 AS Numeric(18, 3)), CAST(N'2021-03-16 20:00:59.557' AS DateTime), CAST(1 AS Numeric(18, 0)), 1, N'C1')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (36, N'Mussels Pesto Pizza', N'https://img.dominos.vn/Mussle-pesto-pizza.jpg', N'Pesto sauce, Chilean green mussel, Shrimps, Green bell peppers, Onions ', CAST(500000.000 AS Numeric(18, 3)), CAST(N'2020-03-20 00:00:00.000' AS DateTime), CAST(6 AS Numeric(18, 0)), 1, N'C1')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (39, N'Half-Half', N'https://img.dominos.vn/Haft-haft.jpg', N'Pizza is a topping combination of Ocean Mania pizza and Cheesy Chicken Bacon pizza ', CAST(300.000 AS Numeric(18, 3)), CAST(N'2021-03-06 00:00:00.000' AS DateTime), CAST(7 AS Numeric(18, 0)), 1, N'C1')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (40, N'Meat Lovers', N'https://img.dominos.vn/Meat-lover.jpg', N'Tomato Sauce, Mozzarella Cheese, Pepperoni Sausage, Ham, Italian Sausage, Beef Ball, Bacon ', CAST(250.000 AS Numeric(18, 3)), CAST(N'2020-04-23 00:00:00.000' AS DateTime), CAST(4 AS Numeric(18, 0)), 1, N'C1')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (41, N'Pepperoni Feast', N'https://img.dominos.vn/Pepperoni-feast-.jpg', N'Tomato Sauce, Mozzarella Cheese, Pepperoni Sausage', CAST(390.000 AS Numeric(18, 3)), CAST(N'2020-06-11 00:00:00.000' AS DateTime), CAST(6 AS Numeric(18, 0)), 0, N'C1')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (42, N'Coca zero', N'https://img.dominos.vn/coke-zero.jpg', N'Coca zero 330ml', CAST(20.000 AS Numeric(18, 3)), CAST(N'2020-10-10 00:00:00.000' AS DateTime), CAST(0 AS Numeric(18, 0)), 0, N'C2')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (43, N'Fanta bottle', N'https://img.dominos.vn/fanta-1.5.jpg', N'Fanta bottle 1.5L ', CAST(15.000 AS Numeric(18, 3)), CAST(N'2021-01-01 00:00:00.000' AS DateTime), CAST(20 AS Numeric(18, 0)), 1, N'C2')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (45, N'Sprite Bottle', N'https://img.dominos.vn/Sprite-1.5L.jpg', N'Sprite Bottle 1.5L', CAST(15.000 AS Numeric(18, 3)), CAST(N'2021-03-03 00:00:00.000' AS DateTime), CAST(18 AS Numeric(18, 0)), 1, N'C2')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (46, N'Milk ice coffe', N'https://tch-app.s3.ap-southeast-1.amazonaws.com/menufrontend/5b03966a1acd4d5bbd6723a3_cafe-sua-da.jpg', N'Combined coffee with condensed milk is a proud Vietnamese creation, seeing a Vietnamese brand-name drink. ', CAST(15.000 AS Numeric(18, 3)), CAST(N'2021-03-02 00:00:00.000' AS DateTime), CAST(20 AS Numeric(18, 0)), 1, N'C2')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (47, N'White Pearl Milk Tea ', N'https://tch-app.s3.ap-southeast-1.amazonaws.com/menufrontend/5e92fd7dc788bc0011abaa06_TS-Macca-tran-chau-trang.jpg', N' Crispy white pearl is added, giving you the feeling of "already" in every sip, satisfying cravings for milk tea immediately. ', CAST(30.000 AS Numeric(18, 3)), CAST(N'2021-02-06 00:00:00.000' AS DateTime), CAST(20 AS Numeric(18, 0)), 1, N'C2')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (48, N'Lotus Seed Oolong - Ice ', N'https://tch-app.s3.ap-southeast-1.amazonaws.com/menufrontend/5c3ff3c5acf0d338d22adbae_Tra-hat-sen.jpg', N'Oolong tea and lotus seeds are both healthy ingredients with a cleansing, cooling, and beauty effect.', CAST(25.000 AS Numeric(18, 3)), CAST(N'2020-05-05 00:00:00.000' AS DateTime), CAST(20 AS Numeric(18, 0)), 1, N'C2')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (49, N'Melon Tea', N'https://tch-app.s3.ap-southeast-1.amazonaws.com/menufrontend/5ffbb2671327f700184f54d3_TRA-DUA-LUOI.jpg', N'Each delicious sip from the refreshing melon blends with the delicious and mildly delicious Tra Lai background.', CAST(30.000 AS Numeric(18, 3)), CAST(N'2020-07-07 00:00:00.000' AS DateTime), CAST(25 AS Numeric(18, 0)), 0, N'C2')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (50, N'Melon Yogurt', N'https://tch-app.s3.ap-southeast-1.amazonaws.com/menufrontend/5ffbb2671327f700184f54d4_YOGURT-DUA-LUOI_ko-topping.jpg', N'Sweet and sour yogurt, cool, numb, mixed with aromatic melon, try to enjoy the New Year cool off healthy with Yogurt Melon yogurt', CAST(26.000 AS Numeric(18, 3)), CAST(N'2020-04-06 00:00:00.000' AS DateTime), CAST(30 AS Numeric(18, 0)), 1, N'C2')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (51, N'Cold Brew', N'https://tch-app.s3.ap-southeast-1.amazonaws.com/menufrontend/5ca47f92acf0d3492076b29a_Cold-Brew-Classic.jpg', N'Original and Fresh with pine tree notes, chestnut, signature chocolate notes, mild smoke aroma of Cau Dat Arabica seeds. ', CAST(27.000 AS Numeric(18, 3)), CAST(N'2021-03-08 00:00:00.000' AS DateTime), CAST(4 AS Numeric(18, 0)), 1, N'C2')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (52, N'Pudding', N'https://cdn.huongnghiepaau.com/wp-content/uploads/2019/01/pudding-tra-xanh.jpg', N'Pudding is a dessert cake that is not too strange to many people because of its delicious taste and eye-catching. ', CAST(30.000 AS Numeric(18, 3)), CAST(N'2021-03-18 19:01:02.303' AS DateTime), CAST(0 AS Numeric(18, 0)), 0, N'C1')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (53, N'yogurt', N'https://www.pcrm.org/sites/default/files/berries-nondairy-yogurt.jpg', N'Boost your brain health with berry-topped soy, almond, or coconut yogurt.', CAST(20.400 AS Numeric(18, 3)), CAST(N'2021-03-18 19:21:50.797' AS DateTime), CAST(1 AS Numeric(18, 0)), 0, N'C2')
INSERT [dbo].[tblProduct] ([productId], [productName], [image], [description], [price], [createDate], [quantity], [status], [categoryId]) VALUES (65, N'aaa', N'tao lao', N'aaa', CAST(1.000 AS Numeric(18, 3)), CAST(N'2021-03-20 07:28:52.380' AS DateTime), CAST(1 AS Numeric(18, 0)), 1, N'C1')
SET IDENTITY_INSERT [dbo].[tblProduct] OFF
INSERT [dbo].[tblUser] ([username], [password], [fullname], [role], [status]) VALUES (N'hsddung92long@gmail.com', N'12354', N'hsddung92long', N'U', 1)
INSERT [dbo].[tblUser] ([username], [password], [fullname], [role], [status]) VALUES (N'longnbpse140814@fpt.edu.vn', N'longnbpse140814@fpt.edu.vn', N'123', N'U', 1)
INSERT [dbo].[tblUser] ([username], [password], [fullname], [role], [status]) VALUES (N'se140809', N'123456', N'Dinh', N'AD', 0)
INSERT [dbo].[tblUser] ([username], [password], [fullname], [role], [status]) VALUES (N'se140810', N'123', N'Linh', N'U', 1)
INSERT [dbo].[tblUser] ([username], [password], [fullname], [role], [status]) VALUES (N'se140811', N'123456', N'Minh', N'U', 1)
INSERT [dbo].[tblUser] ([username], [password], [fullname], [role], [status]) VALUES (N'se140814', N'123', N'Long', N'AD', 1)
INSERT [dbo].[tblUser] ([username], [password], [fullname], [role], [status]) VALUES (N'songokuhanten1325@gmail.com', N'12354', N'songokuhanten1325', N'U', 1)
ALTER TABLE [dbo].[tblHistory]  WITH CHECK ADD  CONSTRAINT [FK_tblHistory_tblProduct] FOREIGN KEY([productId])
REFERENCES [dbo].[tblProduct] ([productId])
GO
ALTER TABLE [dbo].[tblHistory] CHECK CONSTRAINT [FK_tblHistory_tblProduct]
GO
ALTER TABLE [dbo].[tblHistory]  WITH CHECK ADD  CONSTRAINT [FK_tblHistory_tblUser] FOREIGN KEY([username])
REFERENCES [dbo].[tblUser] ([username])
GO
ALTER TABLE [dbo].[tblHistory] CHECK CONSTRAINT [FK_tblHistory_tblUser]
GO
ALTER TABLE [dbo].[tblOrder]  WITH CHECK ADD  CONSTRAINT [FK_tblOrder_tblUser] FOREIGN KEY([username])
REFERENCES [dbo].[tblUser] ([username])
GO
ALTER TABLE [dbo].[tblOrder] CHECK CONSTRAINT [FK_tblOrder_tblUser]
GO
ALTER TABLE [dbo].[tblOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_tblOrderDetail_tblOrder] FOREIGN KEY([orderId])
REFERENCES [dbo].[tblOrder] ([orderId])
GO
ALTER TABLE [dbo].[tblOrderDetail] CHECK CONSTRAINT [FK_tblOrderDetail_tblOrder]
GO
ALTER TABLE [dbo].[tblOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_tblOrderDetail_tblProduct] FOREIGN KEY([productId])
REFERENCES [dbo].[tblProduct] ([productId])
GO
ALTER TABLE [dbo].[tblOrderDetail] CHECK CONSTRAINT [FK_tblOrderDetail_tblProduct]
GO
ALTER TABLE [dbo].[tblProduct]  WITH CHECK ADD  CONSTRAINT [FK_tblProduct_tblCategory] FOREIGN KEY([categoryId])
REFERENCES [dbo].[tblCategory] ([categoryId])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_tblProduct_tblCategory]
GO
USE [master]
GO
ALTER DATABASE [Hana_Shop] SET  READ_WRITE 
GO
