USE [master]
GO
/****** Object:  Database [AbonentFNE]    Script Date: 23.12.2021 10:21:27 ******/
CREATE DATABASE [AbonentFNE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AbonentFNE', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSERVER\MSSQL\DATA\AbonentFNE.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AbonentFNE_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSERVER\MSSQL\DATA\AbonentFNE_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [AbonentFNE] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AbonentFNE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AbonentFNE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AbonentFNE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AbonentFNE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AbonentFNE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AbonentFNE] SET ARITHABORT OFF 
GO
ALTER DATABASE [AbonentFNE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AbonentFNE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AbonentFNE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AbonentFNE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AbonentFNE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AbonentFNE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AbonentFNE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AbonentFNE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AbonentFNE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AbonentFNE] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AbonentFNE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AbonentFNE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AbonentFNE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AbonentFNE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AbonentFNE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AbonentFNE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AbonentFNE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AbonentFNE] SET RECOVERY FULL 
GO
ALTER DATABASE [AbonentFNE] SET  MULTI_USER 
GO
ALTER DATABASE [AbonentFNE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AbonentFNE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AbonentFNE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AbonentFNE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AbonentFNE] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'AbonentFNE', N'ON'
GO
ALTER DATABASE [AbonentFNE] SET QUERY_STORE = OFF
GO
USE [AbonentFNE]
GO
/****** Object:  Table [dbo].[Звонки]    Script Date: 23.12.2021 10:21:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Звонки](
	[IdЗвонков] [bigint] IDENTITY(1,1) NOT NULL,
	[IdТелеАбон] [bigint] NOT NULL,
	[Город] [nvarchar](50) NOT NULL,
	[ДатаРазг] [date] NOT NULL,
	[Продолжительноть(мин)] [int] NOT NULL,
	[Оплачен] [bit] NOT NULL,
	[IdТарифа] [bigint] NOT NULL,
 CONSTRAINT [PK_Звонки] PRIMARY KEY CLUSTERED 
(
	[IdЗвонков] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Телефоны абонентов]    Script Date: 23.12.2021 10:21:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Телефоны абонентов](
	[IdТелеАбон] [bigint] IDENTITY(1,1) NOT NULL,
	[IdАбонента] [bigint] NOT NULL,
	[НомерДоговора] [nvarchar](50) NOT NULL,
	[ДатаУстановки] [date] NOT NULL,
	[НомерТелефона] [bigint] NOT NULL,
 CONSTRAINT [PK_Телефоны абонентов] PRIMARY KEY CLUSTERED 
(
	[IdТелеАбон] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Абоненты]    Script Date: 23.12.2021 10:21:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Абоненты](
	[IdАбонента] [bigint] NOT NULL,
	[Фамилия] [nvarchar](50) NOT NULL,
	[Имя] [nvarchar](50) NOT NULL,
	[Отчество] [nvarchar](50) NOT NULL,
	[Адресс] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Абоненты] PRIMARY KEY CLUSTERED 
(
	[IdАбонента] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Статистика_Разговоров]    Script Date: 23.12.2021 10:21:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Статистика_Разговоров]
as
Select НомерТелефона, Фамилия + ' ' + Имя + ' ' + Отчество as [ФИО абонента], COUNT(Звонки.IdТелеАбон) as [Кол_во звонков]
From Абоненты inner join [Телефоны абонентов] On Абоненты.IdАбонента = [Телефоны абонентов].IdАбонента
inner join Звонки On Звонки.IdТелеАбон = [Телефоны абонентов].IdТелеАбон
Group By НомерТелефона, Фамилия + ' ' + Имя + ' ' + Отчество, Звонки.IdТелеАбон
GO
/****** Object:  Table [dbo].[Тарифы]    Script Date: 23.12.2021 10:21:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Тарифы](
	[IdТарифа] [bigint] IDENTITY(1,1) NOT NULL,
	[Город] [nvarchar](50) NOT NULL,
	[Тариф] [int] NOT NULL,
 CONSTRAINT [PK_Тарифы] PRIMARY KEY CLUSTERED 
(
	[IdТарифа] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Абоненты] ([IdАбонента], [Фамилия], [Имя], [Отчество], [Адресс]) VALUES (1, N'Орлов', N'Сергей', N'Борисович', N'г.Омск, ул Мира, 54, 4')
INSERT [dbo].[Абоненты] ([IdАбонента], [Фамилия], [Имя], [Отчество], [Адресс]) VALUES (3, N'Вавилов', N'Сергей', N'Борисович', N'г. Омск, пр.Маркса, 34, 23')
INSERT [dbo].[Абоненты] ([IdАбонента], [Фамилия], [Имя], [Отчество], [Адресс]) VALUES (4, N'Титова', N'Александра', N'Ивановна', N'г.Омск, ул Ленина, 5,24')
GO
SET IDENTITY_INSERT [dbo].[Звонки] ON 

INSERT [dbo].[Звонки] ([IdЗвонков], [IdТелеАбон], [Город], [ДатаРазг], [Продолжительноть(мин)], [Оплачен], [IdТарифа]) VALUES (1, 4, N'Омск', CAST(N'2021-03-02' AS Date), 12, 0, 2)
INSERT [dbo].[Звонки] ([IdЗвонков], [IdТелеАбон], [Город], [ДатаРазг], [Продолжительноть(мин)], [Оплачен], [IdТарифа]) VALUES (2, 2, N'Новосибирск', CAST(N'2021-03-02' AS Date), 2, 1, 3)
INSERT [dbo].[Звонки] ([IdЗвонков], [IdТелеАбон], [Город], [ДатаРазг], [Продолжительноть(мин)], [Оплачен], [IdТарифа]) VALUES (3, 3, N'Воронеж', CAST(N'2021-03-08' AS Date), 15, 1, 1)
INSERT [dbo].[Звонки] ([IdЗвонков], [IdТелеАбон], [Город], [ДатаРазг], [Продолжительноть(мин)], [Оплачен], [IdТарифа]) VALUES (4, 1, N'Воронеж', CAST(N'2021-03-08' AS Date), 5, 1, 1)
INSERT [dbo].[Звонки] ([IdЗвонков], [IdТелеАбон], [Город], [ДатаРазг], [Продолжительноть(мин)], [Оплачен], [IdТарифа]) VALUES (5, 4, N'Санкт-Петербург', CAST(N'2021-03-15' AS Date), 10, 1, 5)
INSERT [dbo].[Звонки] ([IdЗвонков], [IdТелеАбон], [Город], [ДатаРазг], [Продолжительноть(мин)], [Оплачен], [IdТарифа]) VALUES (6, 3, N'Омск', CAST(N'2021-03-15' AS Date), 1, 0, 2)
INSERT [dbo].[Звонки] ([IdЗвонков], [IdТелеАбон], [Город], [ДатаРазг], [Продолжительноть(мин)], [Оплачен], [IdТарифа]) VALUES (7, 1, N'Омск', CAST(N'2021-03-15' AS Date), 10, 0, 2)
INSERT [dbo].[Звонки] ([IdЗвонков], [IdТелеАбон], [Город], [ДатаРазг], [Продолжительноть(мин)], [Оплачен], [IdТарифа]) VALUES (8, 2, N'Москва', CAST(N'2021-03-15' AS Date), 1, 1, 4)
INSERT [dbo].[Звонки] ([IdЗвонков], [IdТелеАбон], [Город], [ДатаРазг], [Продолжительноть(мин)], [Оплачен], [IdТарифа]) VALUES (9, 5, N'Воронеж', CAST(N'2021-03-23' AS Date), 6, 1, 1)
INSERT [dbo].[Звонки] ([IdЗвонков], [IdТелеАбон], [Город], [ДатаРазг], [Продолжительноть(мин)], [Оплачен], [IdТарифа]) VALUES (10, 4, N'Воронеж', CAST(N'2021-04-01' AS Date), 3, 0, 1)
INSERT [dbo].[Звонки] ([IdЗвонков], [IdТелеАбон], [Город], [ДатаРазг], [Продолжительноть(мин)], [Оплачен], [IdТарифа]) VALUES (11, 2, N'Воронеж', CAST(N'2021-04-01' AS Date), 3, 1, 1)
SET IDENTITY_INSERT [dbo].[Звонки] OFF
GO
SET IDENTITY_INSERT [dbo].[Тарифы] ON 

INSERT [dbo].[Тарифы] ([IdТарифа], [Город], [Тариф]) VALUES (1, N'Воронеж', 20)
INSERT [dbo].[Тарифы] ([IdТарифа], [Город], [Тариф]) VALUES (2, N'Омск', 10)
INSERT [dbo].[Тарифы] ([IdТарифа], [Город], [Тариф]) VALUES (3, N'Новосибирск', 10)
INSERT [dbo].[Тарифы] ([IdТарифа], [Город], [Тариф]) VALUES (4, N'Москва', 30)
INSERT [dbo].[Тарифы] ([IdТарифа], [Город], [Тариф]) VALUES (5, N'Санкт-Петербург', 30)
SET IDENTITY_INSERT [dbo].[Тарифы] OFF
GO
SET IDENTITY_INSERT [dbo].[Телефоны абонентов] ON 

INSERT [dbo].[Телефоны абонентов] ([IdТелеАбон], [IdАбонента], [НомерДоговора], [ДатаУстановки], [НомерТелефона]) VALUES (1, 4, N'3465Ф', CAST(N'2012-10-09' AS Date), 3812333490)
INSERT [dbo].[Телефоны абонентов] ([IdТелеАбон], [IdАбонента], [НомерДоговора], [ДатаУстановки], [НомерТелефона]) VALUES (2, 4, N'3466Ф', CAST(N'2012-10-09' AS Date), 3812951211)
INSERT [dbo].[Телефоны абонентов] ([IdТелеАбон], [IdАбонента], [НомерДоговора], [ДатаУстановки], [НомерТелефона]) VALUES (3, 1, N'4523Ф', CAST(N'2004-08-04' AS Date), 3812531178)
INSERT [dbo].[Телефоны абонентов] ([IdТелеАбон], [IdАбонента], [НомерДоговора], [ДатаУстановки], [НомерТелефона]) VALUES (4, 1, N'2378Ф', CAST(N'1996-01-01' AS Date), 3812326789)
INSERT [dbo].[Телефоны абонентов] ([IdТелеАбон], [IdАбонента], [НомерДоговора], [ДатаУстановки], [НомерТелефона]) VALUES (5, 3, N'99345P', CAST(N'2013-01-01' AS Date), 3812953412)
SET IDENTITY_INSERT [dbo].[Телефоны абонентов] OFF
GO
ALTER TABLE [dbo].[Звонки]  WITH CHECK ADD  CONSTRAINT [FK_Звонки_Тарифы] FOREIGN KEY([IdТарифа])
REFERENCES [dbo].[Тарифы] ([IdТарифа])
GO
ALTER TABLE [dbo].[Звонки] CHECK CONSTRAINT [FK_Звонки_Тарифы]
GO
ALTER TABLE [dbo].[Звонки]  WITH CHECK ADD  CONSTRAINT [FK_Звонки_Телефоны абонентов] FOREIGN KEY([IdТелеАбон])
REFERENCES [dbo].[Телефоны абонентов] ([IdТелеАбон])
GO
ALTER TABLE [dbo].[Звонки] CHECK CONSTRAINT [FK_Звонки_Телефоны абонентов]
GO
ALTER TABLE [dbo].[Телефоны абонентов]  WITH CHECK ADD  CONSTRAINT [FK_Телефоны абонентов_Абоненты] FOREIGN KEY([IdАбонента])
REFERENCES [dbo].[Абоненты] ([IdАбонента])
GO
ALTER TABLE [dbo].[Телефоны абонентов] CHECK CONSTRAINT [FK_Телефоны абонентов_Абоненты]
GO
/****** Object:  StoredProcedure [dbo].[ДобавлениеАбонента]    Script Date: 23.12.2021 10:21:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ДобавлениеАбонента]
@IdАбонента bigint,
@Фамилия nvarchar(50),
@Имя nvarchar(50),
@Отчество nvarchar(50),
@Адресс nvarchar(50)
as
Begin
Insert into Абоненты(IdАбонента,Фамилия,Имя,Отчество,Адресс)
Values(@IdАбонента,@Фамилия,@Имя,@Отчество,@Адресс)
end
GO
/****** Object:  StoredProcedure [dbo].[УдалениеАбонентов]    Script Date: 23.12.2021 10:21:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[УдалениеАбонентов]
@IdАбонента bigint
as
Begin
select *
from Абоненты
delete from Абоненты
Where @IdАбонента = IdАбонента
end
GO
USE [master]
GO
ALTER DATABASE [AbonentFNE] SET  READ_WRITE 
GO
