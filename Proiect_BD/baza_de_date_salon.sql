USE [master]
GO
/****** Object:  Database [salon01]    Script Date: 24.05.2023 18:41:08 ******/
CREATE DATABASE [salon01]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'salon01', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\salon01.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'salon01_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\salon01_log.ldf' , SIZE = 1072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [salon01] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [salon01].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [salon01] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [salon01] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [salon01] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [salon01] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [salon01] SET ARITHABORT OFF 
GO
ALTER DATABASE [salon01] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [salon01] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [salon01] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [salon01] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [salon01] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [salon01] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [salon01] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [salon01] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [salon01] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [salon01] SET  ENABLE_BROKER 
GO
ALTER DATABASE [salon01] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [salon01] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [salon01] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [salon01] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [salon01] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [salon01] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [salon01] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [salon01] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [salon01] SET  MULTI_USER 
GO
ALTER DATABASE [salon01] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [salon01] SET DB_CHAINING OFF 
GO
ALTER DATABASE [salon01] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [salon01] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [salon01] SET DELAYED_DURABILITY = DISABLED 
GO
USE [salon01]
GO
/****** Object:  Table [dbo].[angajati]    Script Date: 24.05.2023 18:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[angajati](
	[id_angajat] [int] NOT NULL,
	[nume_angajat] [nvarchar](50) NULL,
	[specializare] [int] NULL,
	[telefon] [varchar](10) NULL,
	[email] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_angajat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[categorii_servicii]    Script Date: 24.05.2023 18:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categorii_servicii](
	[id_cat] [int] NOT NULL,
	[nume_cat] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_cat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[clienti]    Script Date: 24.05.2023 18:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[clienti](
	[id_client] [int] NOT NULL,
	[nume_client] [nvarchar](50) NULL,
	[telefon] [varchar](10) NULL,
	[email] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_client] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[programari_servicii]    Script Date: 24.05.2023 18:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[programari_servicii](
	[id_programare] [int] NOT NULL,
	[id_client] [int] NULL,
	[id_angajat] [int] NULL,
	[cod_serviciu] [int] NULL,
	[data_inceput] [datetime] NULL,
	[data_sfarsit] [datetime] NULL,
	[pret] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_programare] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[servicii]    Script Date: 24.05.2023 18:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[servicii](
	[id_serviciu] [int] NOT NULL,
	[nume_serviciu] [varchar](20) NULL,
	[categorie] [int] NULL,
	[durata_min] [int] NULL,
	[pret] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_serviciu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[vedere_programari]    Script Date: 24.05.2023 18:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vedere_programari] as
select * from programari_servicii
GO
INSERT [dbo].[angajati] ([id_angajat], [nume_angajat], [specializare], [telefon], [email]) VALUES (1, N'Angajat1', 1, N'0711111111', N'angajat1@yahoo.com')
INSERT [dbo].[angajati] ([id_angajat], [nume_angajat], [specializare], [telefon], [email]) VALUES (2, N'Angajat2', 2, N'0789234324', N'angajat2@yahoo.com')
INSERT [dbo].[angajati] ([id_angajat], [nume_angajat], [specializare], [telefon], [email]) VALUES (3, N'Angajat3', 3, N'0771771777', N'angajat3@yahoo.com')
INSERT [dbo].[categorii_servicii] ([id_cat], [nume_cat]) VALUES (1, N'Coafura')
INSERT [dbo].[categorii_servicii] ([id_cat], [nume_cat]) VALUES (2, N'Cosmetica')
INSERT [dbo].[categorii_servicii] ([id_cat], [nume_cat]) VALUES (3, N'Manichiura')
INSERT [dbo].[clienti] ([id_client], [nume_client], [telefon], [email]) VALUES (1, N'Irina', N'0777777777', N'irina@yahoo.com')
INSERT [dbo].[clienti] ([id_client], [nume_client], [telefon], [email]) VALUES (2, N'Cristina', N'0788888888', N'cristina@yahoo.com')
INSERT [dbo].[clienti] ([id_client], [nume_client], [telefon], [email]) VALUES (3, N'Maria', N'0766666666', N'maria@yahoo.com')
INSERT [dbo].[servicii] ([id_serviciu], [nume_serviciu], [categorie], [durata_min], [pret]) VALUES (1, N'tuns', 1, 30, 40)
INSERT [dbo].[servicii] ([id_serviciu], [nume_serviciu], [categorie], [durata_min], [pret]) VALUES (2, N'vopsit', 1, 90, 100)
INSERT [dbo].[servicii] ([id_serviciu], [nume_serviciu], [categorie], [durata_min], [pret]) VALUES (3, N'pensat sprancene', 2, 20, 15)
INSERT [dbo].[servicii] ([id_serviciu], [nume_serviciu], [categorie], [durata_min], [pret]) VALUES (4, N'vopsit sprancene', 2, 20, 25)
INSERT [dbo].[servicii] ([id_serviciu], [nume_serviciu], [categorie], [durata_min], [pret]) VALUES (5, N'manichiura lac', 3, 40, 40)
INSERT [dbo].[servicii] ([id_serviciu], [nume_serviciu], [categorie], [durata_min], [pret]) VALUES (6, N'manichiura gel', 3, 120, 100)
ALTER TABLE [dbo].[angajati]  WITH CHECK ADD FOREIGN KEY([specializare])
REFERENCES [dbo].[categorii_servicii] ([id_cat])
GO
ALTER TABLE [dbo].[programari_servicii]  WITH CHECK ADD FOREIGN KEY([cod_serviciu])
REFERENCES [dbo].[servicii] ([id_serviciu])
GO
ALTER TABLE [dbo].[programari_servicii]  WITH CHECK ADD FOREIGN KEY([id_angajat])
REFERENCES [dbo].[angajati] ([id_angajat])
GO
ALTER TABLE [dbo].[programari_servicii]  WITH CHECK ADD FOREIGN KEY([id_client])
REFERENCES [dbo].[clienti] ([id_client])
GO
ALTER TABLE [dbo].[servicii]  WITH CHECK ADD FOREIGN KEY([categorie])
REFERENCES [dbo].[categorii_servicii] ([id_cat])
GO
/****** Object:  StoredProcedure [dbo].[rezervare1234]    Script Date: 24.05.2023 18:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[rezervare1234](@id int ,@client nvarchar(50), @serviciu nvarchar(50), @data_ora datetime)
as
declare @id_client int = (select id_client from clienti where nume_client = @client)
declare @cod_serviciu int = (select id_serviciu from servicii where nume_serviciu = @serviciu)
insert programari_servicii(id_programare, id_client, cod_serviciu, data_inceput) values (@id, @id_client, @cod_serviciu, @data_ora)
GO
/****** Object:  StoredProcedure [dbo].[StergereProgramare]    Script Date: 24.05.2023 18:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[StergereProgramare]
	@IDProgramare int
as
begin
	delete from programari_servicii
	where id_programare = @IDProgramare
end
GO
USE [master]
GO
ALTER DATABASE [salon01] SET  READ_WRITE 
GO
