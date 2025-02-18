USE [master]
GO
/****** Object:  Database [QuanLyThuVienUFM]    Script Date: 24-Apr-23 2:31:20 PM ******/
CREATE DATABASE [QuanLyThuVienUFM]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyThuVienUFM', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\DATA\QuanLyThuVienUFM.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QuanLyThuVienUFM_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\DATA\QuanLyThuVienUFM_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QuanLyThuVienUFM] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyThuVienUFM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyThuVienUFM] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyThuVienUFM] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QuanLyThuVienUFM] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [QuanLyThuVienUFM] SET QUERY_STORE = ON
GO
ALTER DATABASE [QuanLyThuVienUFM] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [QuanLyThuVienUFM]
GO
/****** Object:  User [ThuThu1]    Script Date: 24-Apr-23 2:31:20 PM ******/
CREATE USER [ThuThu1] FOR LOGIN [ThuThu1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Nhacungcap1]    Script Date: 24-Apr-23 2:31:20 PM ******/
CREATE USER [Nhacungcap1] FOR LOGIN [Nhacungcap1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [DocGia1]    Script Date: 24-Apr-23 2:31:20 PM ******/
CREATE USER [DocGia1] FOR LOGIN [DocGia1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Synonym [dbo].[DG]    Script Date: 24-Apr-23 2:31:20 PM ******/
CREATE SYNONYM [dbo].[DG] FOR [dbo].[DocGia]
GO
/****** Object:  Synonym [dbo].[s]    Script Date: 24-Apr-23 2:31:20 PM ******/
CREATE SYNONYM [dbo].[s] FOR [dbo].[Sach]
GO
/****** Object:  Synonym [dbo].[TH]    Script Date: 24-Apr-23 2:31:20 PM ******/
CREATE SYNONYM [dbo].[TH] FOR [dbo].[TreHan]
GO
/****** Object:  UserDefinedFunction [dbo].[f_TongSLDSachtheoISBN]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[f_TongSLDSachtheoISBN] (@ISBN nvarchar(5))
returns int as
begin
declare @TongSL int
select @TongSL = sum(SoLuong)
from Sach
where ISBN=@ISBN
return @TongSL
end
GO
/****** Object:  UserDefinedFunction [dbo].[f_TongSLSachtheoMaM]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[f_TongSLSachtheoMaM] (@MaM nvarchar(5))
returns int
as
begin
declare @TongSLS int
select @TongSLS = count(MaSach)
from CTPhieuMuon
where MaM=@MaM
return @TongSLS
end
GO
/****** Object:  Table [dbo].[TheLoai]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TheLoai](
	[MaLoai] [nvarchar](5) NOT NULL,
	[TenLoai] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_TheLoai_MaLoai] PRIMARY KEY CLUSTERED 
(
	[MaLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dausach]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dausach](
	[ISBN] [nvarchar](5) NOT NULL,
	[MaLoai] [nvarchar](5) NOT NULL,
	[TenSach] [nvarchar](100) NOT NULL,
	[Tacgia] [nvarchar](50) NOT NULL,
	[NXB] [nvarchar](50) NOT NULL,
	[Thongtinsach] [nvarchar](1024) NULL,
 CONSTRAINT [PK_DauSach_ISBN] PRIMARY KEY CLUSTERED 
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwLuanVanThacSi]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vwLuanVanThacSi] as
select ISBN, TenSach, TacGia, ThongTinSach
from Dausach join TheLoai on Dausach.MaLoai = TheLoai.MaLoai
where TenLoai like N'Luận văn Thạc sĩ'
GO
/****** Object:  Table [dbo].[Sach]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sach](
	[MaSach] [nvarchar](5) NOT NULL,
	[ISBN] [nvarchar](5) NOT NULL,
	[SoLuong] [int] NOT NULL,
	[Gia] [int] NULL,
	[NamXB] [int] NULL,
	[Ghichu] [nvarchar](10) NULL,
 CONSTRAINT [PK__Sach__B235742D44BBD231] PRIMARY KEY CLUSTERED 
(
	[MaSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwSoLuongSachtheoTL]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwSoLuongSachtheoTL] AS
SELECT Dausach.ISBN, TenLoai, MaSach, TenSach, SUM(Soluong) as N'Số lượng'
FROM TheLoai join Dausach on  Dausach.MaLoai = TheLoai.MaLoai
	 join Sach on Sach.ISBN = Dausach.ISBN
GROUP BY Dausach.ISBN, TenLoai, MaSach, TenSach
GO
/****** Object:  Table [dbo].[PhieuMuon]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuMuon](
	[MaM] [nvarchar](5) NOT NULL,
	[MaDG] [nvarchar](5) NOT NULL,
	[MaTT] [nvarchar](5) NOT NULL,
	[Ngaymuon] [datetime] NOT NULL,
	[Ngayhethan] [datetime] NOT NULL,
 CONSTRAINT [PK_PhieuMuon_MaM] PRIMARY KEY CLUSTERED 
(
	[MaM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwSLSachMuon]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwSLSachMuon] AS
SELECT MONTH(NgayMuon) AS Thang, YEAR(NgayMuon) AS Nam, COUNT(*) AS SoLuong
FROM PhieuMuon
GROUP BY MONTH(NgayMuon),YEAR(NgayMuon)
HAVING COUNT(*) > 3
GO
/****** Object:  Table [dbo].[CTPhieuNhap]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTPhieuNhap](
	[SoPN] [nvarchar](5) NOT NULL,
	[ISBN] [nvarchar](5) NOT NULL,
	[Soluong] [int] NULL,
	[Gianhap] [int] NULL,
 CONSTRAINT [FK_CTPhieuNhap] PRIMARY KEY CLUSTERED 
(
	[SoPN] ASC,
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThuThu]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThuThu](
	[MaTT] [nvarchar](5) NOT NULL,
	[HoTenTT] [nvarchar](20) NOT NULL,
	[NgaySinhTT] [datetime] NOT NULL,
	[GioiTinhTT] [nvarchar](6) NOT NULL,
	[DthoaiTT] [nvarchar](11) NOT NULL,
	[DiachiTT] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ThuThu_MaTT] PRIMARY KEY CLUSTERED 
(
	[MaTT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuNhap]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuNhap](
	[SoPN] [nvarchar](5) NOT NULL,
	[MaNCC] [nvarchar](5) NOT NULL,
	[MaTT] [nvarchar](5) NOT NULL,
 CONSTRAINT [PK_PhieuNhap_IDPN] PRIMARY KEY CLUSTERED 
(
	[SoPN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[f_TongSLSN]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[f_TongSLSN]()
returns table
as
return (select ctpn.SoPN, MaNCC, HoTenTT, sum(SoLuong) as TongSLSachNhap
		from PhieuNhap pn join CTPhieuNhap ctpn on pn.SoPN=ctpn.SoPN 
			 join ThuThu tt on tt.MaTT = pn.MaTT
		group by ctpn.SoPN, MaNCC, HoTenTT)
GO
/****** Object:  Table [dbo].[DocGia]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocGia](
	[MaDG] [nvarchar](5) NOT NULL,
	[HoTenDG] [nvarchar](20) NOT NULL,
	[NgaySinhDG] [datetime] NOT NULL,
	[GioiTinhDG] [nvarchar](6) NOT NULL,
	[DthoaiDG] [nvarchar](11) NOT NULL,
	[DiachiDG] [nvarchar](50) NOT NULL,
	[DoiTuong] [nvarchar](15) NOT NULL,
 CONSTRAINT [PK_DocGia_MaDG] PRIMARY KEY CLUSTERED 
(
	[MaDG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CTPhieuMuon]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTPhieuMuon](
	[MaM] [nvarchar](5) NOT NULL,
	[MaSach] [nvarchar](5) NOT NULL,
 CONSTRAINT [PK__CTPhieuMuon] PRIMARY KEY CLUSTERED 
(
	[MaM] ASC,
	[MaSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[f_SLPMDG]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[f_SLPMDG]()
returns table
as
return (select DocGia.MaDG, HoTenDG, count(MaSach) as SLSachMuon
from DocGia join PhieuMuon on DocGia.MaDG = PhieuMuon.MaDG
	 join CTPhieuMuon on CTPhieuMuon.MaM = PhieuMuon.MaM
group by DocGia.MaDG, HoTenDG)
GO
/****** Object:  Table [dbo].[TreHan]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TreHan](
	[IDTH] [int] IDENTITY(1,1) NOT NULL,
	[MaM] [nvarchar](5) NOT NULL,
	[MaT] [nvarchar](5) NULL,
	[MaSach] [nvarchar](5) NOT NULL,
	[Ngaymuon] [datetime] NOT NULL,
	[Ngayhethan] [datetime] NOT NULL,
	[Ngaytra] [datetime] NULL,
	[Songaytrehan] [int] NOT NULL,
	[Sotien]  AS ([Songaytrehan]*(1000)),
PRIMARY KEY CLUSTERED 
(
	[IDTH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwTreHanHonPM09]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[vwTreHanHonPM09] as 
Select *
from TreHan
where Songaytrehan > ALL (Select Songaytrehan
						   from TreHan
						   where MaM = 'PM009')
GO
/****** Object:  Table [dbo].[Nhacungcap]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nhacungcap](
	[MaNCC] [nvarchar](5) NOT NULL,
	[TenNCC] [nvarchar](100) NULL,
	[Diachi] [nvarchar](150) NULL,
	[Dienthoai] [nvarchar](12) NULL,
	[Website] [nvarchar](30) NULL,
 CONSTRAINT [PK_Nhacungcap_IDNCC] PRIMARY KEY CLUSTERED 
(
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuTra]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuTra](
	[MaT] [nvarchar](5) NOT NULL,
	[MaM] [nvarchar](5) NULL,
	[Ngaytra] [datetime] NOT NULL,
 CONSTRAINT [PK_PhieuTra_MaT] PRIMARY KEY CLUSTERED 
(
	[MaT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Report_SachMuonTheoDocGia]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report_SachMuonTheoDocGia](
	[MaDG] [nvarchar](5) NOT NULL,
	[HoTenDG] [nvarchar](20) NOT NULL,
	[SoSachMuon] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Report_SoLuongSMTheoNam]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report_SoLuongSMTheoNam](
	[Nam] [nvarchar](4000) NULL,
	[SoLuongSM] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Report_SoLuongSMTheoTT]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report_SoLuongSMTheoTT](
	[MaTT] [nvarchar](5) NOT NULL,
	[HoTenTT] [nvarchar](20) NOT NULL,
	[SoLuongSM] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TheThuVien]    Script Date: 24-Apr-23 2:31:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TheThuVien](
	[Mathe] [nchar](5) NOT NULL,
	[MaDG] [nvarchar](5) NOT NULL,
	[HanThe] [datetime] NOT NULL,
 CONSTRAINT [TheThuVien_Mathe] PRIMARY KEY CLUSTERED 
(
	[Mathe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM001', N'S0001')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM001', N'S0002')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM001', N'S0003')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM002', N'S0002')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM003', N'S0006')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM003', N'S0007')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM004', N'S0008')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM005', N'S0010')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM005', N'S0011')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM006', N'S0012')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM007', N'S0013')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM007', N'S0014')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM008', N'S0015')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM009', N'S0016')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM010', N'S0017')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM011', N'S0018')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM012', N'S0019')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM013', N'S0013')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM013', N'S0020')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM014', N'S0014')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM014', N'S0015')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM015', N'S0016')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM016', N'S0017')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM017', N'S0018')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM018', N'S0019')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM019', N'S0020')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM020', N'S0002')
INSERT [dbo].[CTPhieuMuon] ([MaM], [MaSach]) VALUES (N'PM020', N'S0003')
GO
INSERT [dbo].[CTPhieuNhap] ([SoPN], [ISBN], [Soluong], [Gianhap]) VALUES (N'PN001', N'25754', 2, 60000)
INSERT [dbo].[CTPhieuNhap] ([SoPN], [ISBN], [Soluong], [Gianhap]) VALUES (N'PN001', N'31782', 6, 240000)
INSERT [dbo].[CTPhieuNhap] ([SoPN], [ISBN], [Soluong], [Gianhap]) VALUES (N'PN002', N'08667', 15, 397000)
INSERT [dbo].[CTPhieuNhap] ([SoPN], [ISBN], [Soluong], [Gianhap]) VALUES (N'PN002', N'26762', 2, 60000)
INSERT [dbo].[CTPhieuNhap] ([SoPN], [ISBN], [Soluong], [Gianhap]) VALUES (N'PN002', N'32148', 15, 600000)
INSERT [dbo].[CTPhieuNhap] ([SoPN], [ISBN], [Soluong], [Gianhap]) VALUES (N'PN003', N'08683', 3, 75000)
INSERT [dbo].[CTPhieuNhap] ([SoPN], [ISBN], [Soluong], [Gianhap]) VALUES (N'PN003', N'32228', 2, 100000)
INSERT [dbo].[CTPhieuNhap] ([SoPN], [ISBN], [Soluong], [Gianhap]) VALUES (N'PN004', N'26761', 1, 30000)
INSERT [dbo].[CTPhieuNhap] ([SoPN], [ISBN], [Soluong], [Gianhap]) VALUES (N'PN004', N'26774', 2, 60000)
INSERT [dbo].[CTPhieuNhap] ([SoPN], [ISBN], [Soluong], [Gianhap]) VALUES (N'PN005', N'15142', 2, 90000)
INSERT [dbo].[CTPhieuNhap] ([SoPN], [ISBN], [Soluong], [Gianhap]) VALUES (N'PN005', N'32147', 10, 400000)
INSERT [dbo].[CTPhieuNhap] ([SoPN], [ISBN], [Soluong], [Gianhap]) VALUES (N'PN006', N'14980', 13, 199200)
INSERT [dbo].[CTPhieuNhap] ([SoPN], [ISBN], [Soluong], [Gianhap]) VALUES (N'PN007', N'30817', 1, 30000)
INSERT [dbo].[CTPhieuNhap] ([SoPN], [ISBN], [Soluong], [Gianhap]) VALUES (N'PN007', N'30821', 2, 60000)
INSERT [dbo].[CTPhieuNhap] ([SoPN], [ISBN], [Soluong], [Gianhap]) VALUES (N'PN007', N'30824', 1, 30000)
INSERT [dbo].[CTPhieuNhap] ([SoPN], [ISBN], [Soluong], [Gianhap]) VALUES (N'PN007', N'30827', 1, 30000)
INSERT [dbo].[CTPhieuNhap] ([SoPN], [ISBN], [Soluong], [Gianhap]) VALUES (N'PN007', N'31908', 20, 600000)
INSERT [dbo].[CTPhieuNhap] ([SoPN], [ISBN], [Soluong], [Gianhap]) VALUES (N'PN007', N'32206', 40, 1200000)
INSERT [dbo].[CTPhieuNhap] ([SoPN], [ISBN], [Soluong], [Gianhap]) VALUES (N'PN007', N'32208', 30, 900000)
GO
INSERT [dbo].[Dausach] ([ISBN], [MaLoai], [TenSach], [Tacgia], [NXB], [Thongtinsach]) VALUES (N'08667', N'APDK', N'Kinh tế và dự báo', N'Bộ Kế hoạch và đầu tư', N'Hà Nội', N'Tạp chí Kinh tế và Dự báo là Cơ quan của Bộ Kế hoạch và Đầu tư, phát hành số đầu tiên vào tháng 10 năm 1967 trên toàn quốc. Tạp chí Kinh tế và Dự báo hoạt động theo Giấy phép hoạt động báo chí in số 115/GP-BTTTT, ngày 14/5/2014 của Bộ trưởng Bộ Thông tin và Truyền thông, được xuất bản bằng tiếng Việt và tiếng Anh.')
INSERT [dbo].[Dausach] ([ISBN], [MaLoai], [TenSach], [Tacgia], [NXB], [Thongtinsach]) VALUES (N'08683', N'APDK', N'Thời báo Kinh tế Sài gòn', N'Sở Công thương Tp. HCM', N'Tp.HCM', N'Tạp chí Kinh tế Sài Gòn (Saigon Times Group) là tên gọi chung của một Tạp chí gồm ba tạp chí tiếng Việt (Tạp chí Kinh tế Sài Gòn; Tạp chí Kinh tế Sài Gòn Online; Sài Gòn Tiếp thị Online); hai tạp chí tiếng Anh (Saigon Times Weekly; The Saigon Times), phụ trương quảng cáo Thị trường Địa ốc; hai tổ chức phi lợi nhuận là Saigon Times Club và Saigon Times Foundation')
INSERT [dbo].[Dausach] ([ISBN], [MaLoai], [TenSach], [Tacgia], [NXB], [Thongtinsach]) VALUES (N'14980', N'BTC', N'Thế giới phụ nữ. 15 : Phụ nữ Việt Nam', N'Báo Phụ nữ Việt Nam', N'Hà Nội', N'Tạp chí Thế giới phụ nữ xuất bản hàng tuần từ Báo Phụ nữ Việt Nam')
INSERT [dbo].[Dausach] ([ISBN], [MaLoai], [TenSach], [Tacgia], [NXB], [Thongtinsach]) VALUES (N'15142', N'BTC', N'Những vấn đề kinh tế & chính trị thế giới', N'Viện Hàn lâm Khoa học Xã hội Việt Nam', N'Hà Nội', N'Những vấn đề kinh tế thế giới do Viện Hàn lâm Khoa học Xã hội Việt Nam. Viện Kinh tế và Chính trị thế giới viết')
INSERT [dbo].[Dausach] ([ISBN], [MaLoai], [TenSach], [Tacgia], [NXB], [Thongtinsach]) VALUES (N'25754', N'APDK', N'Phát triển kinh tế', N'Đại học Kinh tế Tp.HCM', N'Thành phố Hồ Chí Minh', N'Tạp chí khoa học kinh tế xuất bản hàng tháng')
INSERT [dbo].[Dausach] ([ISBN], [MaLoai], [TenSach], [Tacgia], [NXB], [Thongtinsach]) VALUES (N'26761', N'BT', N'Một số biện pháp phòng ngừa và hạn chế rủi ro tín dụng tại Ngân hàng', N'Đặng Thị Thu Thùy', N'Tp.HCM', N'Bậc cao đẳng C11')
INSERT [dbo].[Dausach] ([ISBN], [MaLoai], [TenSach], [Tacgia], [NXB], [Thongtinsach]) VALUES (N'26762', N'BT', N'Phát triển cho vay tiêu dùng tại Ngân hàng Thương mại Cổ phần Á Châu', N'Lê Thanh Thủy', N'Tp.HCM', N'Bậc cao đẳng C11')
INSERT [dbo].[Dausach] ([ISBN], [MaLoai], [TenSach], [Tacgia], [NXB], [Thongtinsach]) VALUES (N'26774', N'BT', N'Chiến lược phân phối sản phẩm của Công ty TNHH Gia Minh Hưng: Thực trạng và giải pháp', N'Nguyễn Thị Ngọc Trinh', N'Tp.HCM', N'Bậc Trung cấp K37')
INSERT [dbo].[Dausach] ([ISBN], [MaLoai], [TenSach], [Tacgia], [NXB], [Thongtinsach]) VALUES (N'30817', N'TLNC', N'Analysis of the profitability of Hiep Luc Co.LTD', N'Nguyễn Lê Thanh Hằng... [et al.]', N'Ho Chi Minh city', N'Scientific research includes bibliographical references and indexs')
INSERT [dbo].[Dausach] ([ISBN], [MaLoai], [TenSach], [Tacgia], [NXB], [Thongtinsach]) VALUES (N'30821', N'TLNC', N'Nghiên cứu các yếu tố ảnh hưởng đến quyết định lựa chọn HomeStay', N'Lê Nhật Khả Vy thực hiện', N'TP. Hồ Chí Minh', N'Báo cáo tổng kết đề tài nghiên cứu khoa học của sinh viên, Lĩnh vực nghiên cứu: Khoa học xã hội')
INSERT [dbo].[Dausach] ([ISBN], [MaLoai], [TenSach], [Tacgia], [NXB], [Thongtinsach]) VALUES (N'30824', N'TLNC', N'Tác động của social media và hallyu đến quyết định mua sản phẩm Hàn Quốc', N'Trương Thị Hồng thực hiện', N'TP. Hồ Chí Minh ', N'Báo cáo tổng kết đề tài nghiên cứu khoa học của sinh viên tham gia xét giải thưởng "Tài năng Kinh tế trẻ" - Lần 7, 2018')
INSERT [dbo].[Dausach] ([ISBN], [MaLoai], [TenSach], [Tacgia], [NXB], [Thongtinsach]) VALUES (N'30827', N'TLNC', N'Nghiên cứu các yếu tố ảnh hưởng đến ý định mua hàng Việt của người tiêu dùng Việt tại TPHCM', N'Nguyễn Hà Phương Trâm...[và nh.ng. khác] thực hiện', N'TP. Hồ Chí Minh', N'Báo cáo tổng kết đề tài nghiên cứu khoa học của sinh viên, Lĩnh vực nghiên cứu : marketing')
INSERT [dbo].[Dausach] ([ISBN], [MaLoai], [TenSach], [Tacgia], [NXB], [Thongtinsach]) VALUES (N'31782', N'LATS', N'Tác động của giá trị tiêu dùng và tính đổi mới của người tiêu dùng', N'Dư Thị Chung; Ngô Thị Thu', N'TP.HCM', N'Đề tài tìm hiểu tác động đồng thời của giá trị tiêu dùng, tính đổi bẩm sinh tính đổi mới theo sản phẩm đến ý định chấp nhận và hành vi chấp nhận sản phẩm mới. Phương pháp nghiên cứu được sử dụng trong đề tài gồm cả nghiên cứu định tính và định lượng. Dữ liệu trong nghiên cứu định tính được thu thập thông qua các cuộc thảo luận với 8 chuyên gia và 16 người tiêu dùng, dữ liệu trong nghiên cứu định lượng được thu thập qua việc khảo sát 915 người tiêu dùng các sản phẩm điện tử cá nhân, địa điểm tại Thành phố Hồ Chí Minh.')
INSERT [dbo].[Dausach] ([ISBN], [MaLoai], [TenSach], [Tacgia], [NXB], [Thongtinsach]) VALUES (N'31908', N'GTBG', N'Tài liệu học tập đào tạo nhân viên trong khách sạn - nhà hàng', N'Tổng cục du lịch', N'TP. Hồ Chí Minh : UFM', N'Dự án phát triển nguồn nhân lực Du lịch Việt Nam: Chương trình phát triển đào tạo viên - kỹ năng đào tạo.')
INSERT [dbo].[Dausach] ([ISBN], [MaLoai], [TenSach], [Tacgia], [NXB], [Thongtinsach]) VALUES (N'32147', N'LATS', N'Tác động của quản trị công ty đến thành quả công ty cổ phần Việt Nam', N'Phạm Đức Huy', N' Giáo dục Việt Nam', N'Luận án kiểm tra tác động của quản trị công ty đến thành quả công ty qua các giai đoạn của vòng đời doanh nghiệp. Dữ liệu được thu thập từ báo cáo tài chính, báo cáo quản trị, báo cáo thường niên của 415 công ty phi tài chính niêm yết trên HSX và HNX giai đoạn 2012-2019. Luận án kế thừa mô hình của Anthony và Ramesh (1992), Y. Li và Zhang (2018) nhằm phân loại dữ liệu thành 3 giai đoạn của vòng đời doanh nghiệp bao gồm: giai đoạn tăng trưởng, trưởng thành và suy thoái.')
INSERT [dbo].[Dausach] ([ISBN], [MaLoai], [TenSach], [Tacgia], [NXB], [Thongtinsach]) VALUES (N'32148', N'LATS', N'Thuế và đầu tư trực tiếp nước ngoài tại các quốc gia đang phát triển', N'Nguyễn Thị Kim Chi', N' Giáo dục Việt Nam', N'Đầu tư trực tiếp nước ngoài đã và đang tác động mạnh đến nền kinh tế thế giới trong nhiều năm qua và là một chủ đề quan trọng đối với các quốc gia đang phát triển. Để thu hút đầu tư trực tiếp nước ngoài một cách hiệu quả, hầu hết các nước phải điều chỉnh chính sách thuế và pháp luật thuế, nổi bật với xu hướng cạnh tranh về thuế với các nước láng giềng, hoặc các quốc gia cùng điều kiện phát triển về kinh tế, xã hội. Trong đó, so với các loại thuế khác, thuế thu nhập doanh nghiệp là loại thuế trực thu, có cơ sở tính thuế là thu nhập chịu thuế của các doanh nghiệp, nên có ý nghĩa điều tiết rất nhạy cảm, có tác động sâu rộng đến hoạt động sản xuất kinh doanh, kể cả doanh nghiệp nhận đầu tư trực tiếp từ nước ngoài.')
INSERT [dbo].[Dausach] ([ISBN], [MaLoai], [TenSach], [Tacgia], [NXB], [Thongtinsach]) VALUES (N'32206', N'GTBG', N'Giáo trình khai phá dữ liệu', N'Tôn Thất Hòa An (chủ biên); Cao Thị Nhạn', N'TP. HCM : Trường Đại học Tài chính - Marketing', N'Cuốn sách này có 9 chương được biên soạn nhằm cung cấp kiến thức cơ sở cho tiến trình khám phá tri thức từ dữ liệu.')
INSERT [dbo].[Dausach] ([ISBN], [MaLoai], [TenSach], [Tacgia], [NXB], [Thongtinsach]) VALUES (N'32208', N'GTBG', N'Toán cơ sở cho kinh tế', N'Nguyễn Huy Hoàng (chủ biên); Nguyễn Trung Đông', N'TP. HCM : Trường Đại học Tài chính - Marketing', N'Cuốn sách này có 4 chương và phụ lục tính toán ma trận bằng máy tính cá nhân, phụ lục một số thuật ngữ then chốt Anh - Việt, cùng một số đề tham khảo để sinh viên có thể rèn luyện')
INSERT [dbo].[Dausach] ([ISBN], [MaLoai], [TenSach], [Tacgia], [NXB], [Thongtinsach]) VALUES (N'32228', N'LVThS', N'Các yếu tố ảnh hưởng đến ý định của khách hàng sử dụng dịch vụ', N'Nguyễn Hoàng Bảo Ngọc', N'TP. Hồ Chí Minh', N'Luận văn phân tích, xác định các yếu tố ảnh hưởng đến ý định của khách hàng sử dụng dịch vụ khám chữa bệnh từ đó đề xuất hướng xây dựng chiến lược khuyến khích bệnh nhân chọn sử dụng dịch vụ khám chữa bệnh tại Bệnh viện Trưng Vương.')
INSERT [dbo].[Dausach] ([ISBN], [MaLoai], [TenSach], [Tacgia], [NXB], [Thongtinsach]) VALUES (N'32231', N'LVThS', N'Ảnh hưởng của các giá trị cảm nhận của khách hàng', N' La Thị Bích Hiền', N'TP. Hồ Chí Minh', N'Luận văn')
INSERT [dbo].[Dausach] ([ISBN], [MaLoai], [TenSach], [Tacgia], [NXB], [Thongtinsach]) VALUES (N'32283', N'Sa', N'Financial Management: Core Concepts', N'Brooks, Raymond', N'Harlow : Pearson', N'Includes bibliographical references and index')
INSERT [dbo].[Dausach] ([ISBN], [MaLoai], [TenSach], [Tacgia], [NXB], [Thongtinsach]) VALUES (N'32314', N'Sa', N'Đi bộ và sức khỏe', N'Nguyễn Ngọc Kim Anh', N'Hà Nội : Thể thao và Du lịch', N'Trình bày những kiến thức cơ bản về vai trò đi bộ trong rèn luyện sức khỏe, lợi ích , kỹ thuật đi bộ thể thao')
GO
INSERT [dbo].[DocGia] ([MaDG], [HoTenDG], [NgaySinhDG], [GioiTinhDG], [DthoaiDG], [DiachiDG], [DoiTuong]) VALUES (N'DG001', N'Nguyễn Thị Minh', CAST(N'2004-03-12T00:00:00.000' AS DateTime), N'Nữ', N'0915007408', N'Q1, Tp.HCM', N'Sinh viên')
INSERT [dbo].[DocGia] ([MaDG], [HoTenDG], [NgaySinhDG], [GioiTinhDG], [DthoaiDG], [DiachiDG], [DoiTuong]) VALUES (N'DG002', N'Nguyễn Thị Ngọc', CAST(N'2003-03-12T00:00:00.000' AS DateTime), N'Nữ', N'098123123', N'Phú Nhuận, Tp.HCM', N'Sinh viên')
INSERT [dbo].[DocGia] ([MaDG], [HoTenDG], [NgaySinhDG], [GioiTinhDG], [DthoaiDG], [DiachiDG], [DoiTuong]) VALUES (N'DG003', N'Trần Anh Tuấn', CAST(N'2002-05-20T00:00:00.000' AS DateTime), N'Nam', N'091321321', N'Q1, Tp.HCM', N'Sinh viên')
INSERT [dbo].[DocGia] ([MaDG], [HoTenDG], [NgaySinhDG], [GioiTinhDG], [DthoaiDG], [DiachiDG], [DoiTuong]) VALUES (N'DG004', N'Lê Nam Mạnh', CAST(N'2002-08-20T00:00:00.000' AS DateTime), N'Nam', N'090312312', N'Thanh Xuân, Hà Nội', N'Sinh viên')
INSERT [dbo].[DocGia] ([MaDG], [HoTenDG], [NgaySinhDG], [GioiTinhDG], [DthoaiDG], [DiachiDG], [DoiTuong]) VALUES (N'DG005', N'Nguyễn Quốc Khánh', CAST(N'2004-08-14T00:00:00.000' AS DateTime), N'Nam', N'0936868946', N'Bình Thạnh, Tp.HCM', N'Sinh viên')
INSERT [dbo].[DocGia] ([MaDG], [HoTenDG], [NgaySinhDG], [GioiTinhDG], [DthoaiDG], [DiachiDG], [DoiTuong]) VALUES (N'DG006', N'Nguyễn Duy', CAST(N'2001-06-14T00:00:00.000' AS DateTime), N'Nam', N'090812812', N'Củ Chi, Tp.HCM', N'Sinh viên')
INSERT [dbo].[DocGia] ([MaDG], [HoTenDG], [NgaySinhDG], [GioiTinhDG], [DthoaiDG], [DiachiDG], [DoiTuong]) VALUES (N'DG007', N'Nguyễn Xuân Hùng', CAST(N'2003-10-09T00:00:00.000' AS DateTime), N'Nam', N'0915007602', N'Hóc Môn, Tp.HCM', N'Sinh viên')
INSERT [dbo].[DocGia] ([MaDG], [HoTenDG], [NgaySinhDG], [GioiTinhDG], [DthoaiDG], [DiachiDG], [DoiTuong]) VALUES (N'DG008', N'Nguyễn Xuân Dũng', CAST(N'1978-07-09T00:00:00.000' AS DateTime), N'Nam', N'0915000233', N'Cam Ranh, Nha Trang', N'Giảng viên')
INSERT [dbo].[DocGia] ([MaDG], [HoTenDG], [NgaySinhDG], [GioiTinhDG], [DthoaiDG], [DiachiDG], [DoiTuong]) VALUES (N'DG009', N'Nguyễn Quốc Hùng', CAST(N'1982-07-07T00:00:00.000' AS DateTime), N'Nam', N'0915007802', N'Long Thành, Đồng Nai', N'Giảng viên')
INSERT [dbo].[DocGia] ([MaDG], [HoTenDG], [NgaySinhDG], [GioiTinhDG], [DthoaiDG], [DiachiDG], [DoiTuong]) VALUES (N'DG010', N'Nguyễn Mai Hồng', CAST(N'1986-11-09T00:00:00.000' AS DateTime), N'Nữ', N'0975017602', N'Củ Chi, Tp.HCM', N'Giảng viên')
INSERT [dbo].[DocGia] ([MaDG], [HoTenDG], [NgaySinhDG], [GioiTinhDG], [DthoaiDG], [DiachiDG], [DoiTuong]) VALUES (N'DG011', N'Phạm Minh Tâm', CAST(N'1991-02-25T00:00:00.000' AS DateTime), N'Nam', N'0321452167', N'Đức Huệ, Long An', N'Giảng viên')
INSERT [dbo].[DocGia] ([MaDG], [HoTenDG], [NgaySinhDG], [GioiTinhDG], [DthoaiDG], [DiachiDG], [DoiTuong]) VALUES (N'DG012', N'Trần Xuân Anh', CAST(N'1985-06-19T00:00:00.000' AS DateTime), N'Nam', N'0913007609', N'Bến Cát, Bình Dương', N'Giảng viên')
INSERT [dbo].[DocGia] ([MaDG], [HoTenDG], [NgaySinhDG], [GioiTinhDG], [DthoaiDG], [DiachiDG], [DoiTuong]) VALUES (N'DG013', N'Trần Quốc An', CAST(N'1984-08-19T00:00:00.000' AS DateTime), N'Nam', N'0923007609', N'Dĩ An, Bình Dương', N'Giảng viên')
INSERT [dbo].[DocGia] ([MaDG], [HoTenDG], [NgaySinhDG], [GioiTinhDG], [DthoaiDG], [DiachiDG], [DoiTuong]) VALUES (N'DG014', N'Nguyễn Trà Giang', CAST(N'1992-02-02T00:00:00.000' AS DateTime), N'Nữ', N'0907898867', N'Thuận An, Bình Dương', N'Giảng viên')
INSERT [dbo].[DocGia] ([MaDG], [HoTenDG], [NgaySinhDG], [GioiTinhDG], [DthoaiDG], [DiachiDG], [DoiTuong]) VALUES (N'DG015', N'Lê Văn Thịnh', CAST(N'1990-02-02T00:00:00.000' AS DateTime), N'Nam', N'09365428761', N'', N'Giảng viên')
INSERT [dbo].[DocGia] ([MaDG], [HoTenDG], [NgaySinhDG], [GioiTinhDG], [DthoaiDG], [DiachiDG], [DoiTuong]) VALUES (N'DG016', N'Lê Đức Minh', CAST(N'1989-02-02T00:00:00.000' AS DateTime), N'Nam', N'0934521896', N'Bến Lức, Long An', N'Nhân viên')
INSERT [dbo].[DocGia] ([MaDG], [HoTenDG], [NgaySinhDG], [GioiTinhDG], [DthoaiDG], [DiachiDG], [DoiTuong]) VALUES (N'DG017', N'Lê Văn Khương', CAST(N'1990-02-02T00:00:00.000' AS DateTime), N'Nam', N'0864123571', N'Châu Thành, Long An', N'Nhân viên')
INSERT [dbo].[DocGia] ([MaDG], [HoTenDG], [NgaySinhDG], [GioiTinhDG], [DthoaiDG], [DiachiDG], [DoiTuong]) VALUES (N'DG018', N'Mai Hoàng Đức', CAST(N'1992-02-02T00:00:00.000' AS DateTime), N'Nam', N'0987132468', N'Dầu Tiếng, Bình Dương', N'Nhân viên')
INSERT [dbo].[DocGia] ([MaDG], [HoTenDG], [NgaySinhDG], [GioiTinhDG], [DthoaiDG], [DiachiDG], [DoiTuong]) VALUES (N'DG019', N'Võ Cẩm Nhung', CAST(N'1997-02-02T00:00:00.000' AS DateTime), N'Nữ', N'0362122358', N'Quận 12,Tp.HCM', N'Nhân viên')
INSERT [dbo].[DocGia] ([MaDG], [HoTenDG], [NgaySinhDG], [GioiTinhDG], [DthoaiDG], [DiachiDG], [DoiTuong]) VALUES (N'DG020', N'Trần Việt Hưng', CAST(N'1991-02-02T00:00:00.000' AS DateTime), N'Nam', N'0245612879', N'Bình Thạnh, Tp.HCM', N'Nhân viên')
GO
INSERT [dbo].[Nhacungcap] ([MaNCC], [TenNCC], [Diachi], [Dienthoai], [Website]) VALUES (N'NCC01', N'Công Ty Cổ Phần Phát Hành Sách Tp. HCM', N'60-62 Lê Lợi, P. Bến Nghé, Q. 1, TPHCM', N'02838225798', N'www.nhasachtritue.com')
INSERT [dbo].[Nhacungcap] ([MaNCC], [TenNCC], [Diachi], [Dienthoai], [Website]) VALUES (N'NCC02', N'Trí Tuệ - Công Ty Cổ Phần Sách & Thiết Bị Giáo Dục Trí Tuệ', N'187 Giảng Võ, Q. Đống Đa, Hà Nội', N'02438515567', N'www.nhasachtritue.com')
INSERT [dbo].[Nhacungcap] ([MaNCC], [TenNCC], [Diachi], [Dienthoai], [Website]) VALUES (N'NCC03', N'Công Ty TNHH Văn Hóa Việt Long', N'14/35, Đào Duy Anh, P.9, Q. Phú Nhuận,Tp.HCM', N'02838452708', N'www.vietlongbook.com')
INSERT [dbo].[Nhacungcap] ([MaNCC], [TenNCC], [Diachi], [Dienthoai], [Website]) VALUES (N'NCC04', N'Công Ty TNHH Đăng Nguyên', N'Thôn Đức Mỹ, X. Suối Nghệ, H. Châu Đức, Bà Rịa-Vũng Tàu', N'02543716857', N'www.bachdangbook.com/')
INSERT [dbo].[Nhacungcap] ([MaNCC], [TenNCC], [Diachi], [Dienthoai], [Website]) VALUES (N'NCC05', N'Công Ty Cổ Phần Sách Giáo Dục Tại Thành Phố Hà Nội', N'Công Ty Cổ Phần Sách Giáo Dục Tại Tp.Hà Nội', N'02462534308', N'')
INSERT [dbo].[Nhacungcap] ([MaNCC], [TenNCC], [Diachi], [Dienthoai], [Website]) VALUES (N'NCC06', N'Công Ty Cổ Phần Dịch Vụ Xuất Bản Giáo Dục Hà Nội', N'Tầng 4 Tòa Nhà Diamond Flower Tower 48 Lê Văn Lương, P. Nhân Chính, Q. Thanh Xuân Hà Nội', N'02435121977', N'www.xbgdhn.vn')
INSERT [dbo].[Nhacungcap] ([MaNCC], [TenNCC], [Diachi], [Dienthoai], [Website]) VALUES (N'NCC07', N'Trường Đại học Tài chính - Marketing', N'778 Nguyễn Kiệm, P.4, Q. Phú Nhuận, TP Hồ Chí Minh', N'02839976462', N'thuvien.ufm.edu.vn')
GO
INSERT [dbo].[PhieuMuon] ([MaM], [MaDG], [MaTT], [Ngaymuon], [Ngayhethan]) VALUES (N'PM001', N'DG001', N'TT001', CAST(N'2022-01-09T00:00:00.000' AS DateTime), CAST(N'2022-01-19T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuMuon] ([MaM], [MaDG], [MaTT], [Ngaymuon], [Ngayhethan]) VALUES (N'PM002', N'DG005', N'TT002', CAST(N'2022-02-09T00:00:00.000' AS DateTime), CAST(N'2022-02-19T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuMuon] ([MaM], [MaDG], [MaTT], [Ngaymuon], [Ngayhethan]) VALUES (N'PM003', N'DG009', N'TT004', CAST(N'2022-02-10T00:00:00.000' AS DateTime), CAST(N'2022-02-20T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuMuon] ([MaM], [MaDG], [MaTT], [Ngaymuon], [Ngayhethan]) VALUES (N'PM004', N'DG011', N'TT012', CAST(N'2022-02-11T00:00:00.000' AS DateTime), CAST(N'2022-02-21T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuMuon] ([MaM], [MaDG], [MaTT], [Ngaymuon], [Ngayhethan]) VALUES (N'PM005', N'DG003', N'TT006', CAST(N'2022-03-01T00:00:00.000' AS DateTime), CAST(N'2022-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuMuon] ([MaM], [MaDG], [MaTT], [Ngaymuon], [Ngayhethan]) VALUES (N'PM006', N'DG002', N'TT011', CAST(N'2022-04-14T00:00:00.000' AS DateTime), CAST(N'2022-04-24T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuMuon] ([MaM], [MaDG], [MaTT], [Ngaymuon], [Ngayhethan]) VALUES (N'PM007', N'DG001', N'TT005', CAST(N'2022-08-06T00:00:00.000' AS DateTime), CAST(N'2022-08-16T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuMuon] ([MaM], [MaDG], [MaTT], [Ngaymuon], [Ngayhethan]) VALUES (N'PM008', N'DG002', N'TT001', CAST(N'2023-01-16T00:00:00.000' AS DateTime), CAST(N'2023-01-26T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuMuon] ([MaM], [MaDG], [MaTT], [Ngaymuon], [Ngayhethan]) VALUES (N'PM009', N'DG008', N'TT007', CAST(N'2023-02-03T00:00:00.000' AS DateTime), CAST(N'2023-02-13T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuMuon] ([MaM], [MaDG], [MaTT], [Ngaymuon], [Ngayhethan]) VALUES (N'PM010', N'DG011', N'TT001', CAST(N'2023-02-15T00:00:00.000' AS DateTime), CAST(N'2023-02-25T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuMuon] ([MaM], [MaDG], [MaTT], [Ngaymuon], [Ngayhethan]) VALUES (N'PM011', N'DG012', N'TT008', CAST(N'2023-02-17T00:00:00.000' AS DateTime), CAST(N'2023-02-27T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuMuon] ([MaM], [MaDG], [MaTT], [Ngaymuon], [Ngayhethan]) VALUES (N'PM012', N'DG017', N'TT010', CAST(N'2023-03-01T00:00:00.000' AS DateTime), CAST(N'2023-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuMuon] ([MaM], [MaDG], [MaTT], [Ngaymuon], [Ngayhethan]) VALUES (N'PM013', N'DG009', N'TT004', CAST(N'2023-03-09T00:00:00.000' AS DateTime), CAST(N'2023-03-19T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuMuon] ([MaM], [MaDG], [MaTT], [Ngaymuon], [Ngayhethan]) VALUES (N'PM014', N'DG018', N'TT012', CAST(N'2023-03-11T00:00:00.000' AS DateTime), CAST(N'2023-03-21T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuMuon] ([MaM], [MaDG], [MaTT], [Ngaymuon], [Ngayhethan]) VALUES (N'PM015', N'DG020', N'TT011', CAST(N'2023-03-12T00:00:00.000' AS DateTime), CAST(N'2023-03-22T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuMuon] ([MaM], [MaDG], [MaTT], [Ngaymuon], [Ngayhethan]) VALUES (N'PM016', N'DG005', N'TT019', CAST(N'2023-04-05T00:00:00.000' AS DateTime), CAST(N'2023-04-15T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuMuon] ([MaM], [MaDG], [MaTT], [Ngaymuon], [Ngayhethan]) VALUES (N'PM017', N'DG003', N'TT015', CAST(N'2023-04-10T00:00:00.000' AS DateTime), CAST(N'2023-04-20T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuMuon] ([MaM], [MaDG], [MaTT], [Ngaymuon], [Ngayhethan]) VALUES (N'PM018', N'DG008', N'TT017', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(N'2023-04-21T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuMuon] ([MaM], [MaDG], [MaTT], [Ngaymuon], [Ngayhethan]) VALUES (N'PM019', N'DG004', N'TT018', CAST(N'2023-04-15T00:00:00.000' AS DateTime), CAST(N'2023-04-25T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuMuon] ([MaM], [MaDG], [MaTT], [Ngaymuon], [Ngayhethan]) VALUES (N'PM020', N'DG006', N'TT004', CAST(N'2023-04-19T00:00:00.000' AS DateTime), CAST(N'2023-04-29T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuMuon] ([MaM], [MaDG], [MaTT], [Ngaymuon], [Ngayhethan]) VALUES (N'PM021', N'DG001', N'TT001', CAST(N'2022-01-09T00:00:00.000' AS DateTime), CAST(N'2022-01-19T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[PhieuNhap] ([SoPN], [MaNCC], [MaTT]) VALUES (N'PN001', N'NCC01', N'TT002')
INSERT [dbo].[PhieuNhap] ([SoPN], [MaNCC], [MaTT]) VALUES (N'PN002', N'NCC02', N'TT005')
INSERT [dbo].[PhieuNhap] ([SoPN], [MaNCC], [MaTT]) VALUES (N'PN003', N'NCC03', N'TT007')
INSERT [dbo].[PhieuNhap] ([SoPN], [MaNCC], [MaTT]) VALUES (N'PN004', N'NCC04', N'TT009')
INSERT [dbo].[PhieuNhap] ([SoPN], [MaNCC], [MaTT]) VALUES (N'PN005', N'NCC05', N'TT010')
INSERT [dbo].[PhieuNhap] ([SoPN], [MaNCC], [MaTT]) VALUES (N'PN006', N'NCC06', N'TT013')
INSERT [dbo].[PhieuNhap] ([SoPN], [MaNCC], [MaTT]) VALUES (N'PN007', N'NCC07', N'TT017')
GO
INSERT [dbo].[PhieuTra] ([MaT], [MaM], [Ngaytra]) VALUES (N'PT001', N'PM001', CAST(N'2022-07-19T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuTra] ([MaT], [MaM], [Ngaytra]) VALUES (N'PT002', N'PM002', CAST(N'2022-04-19T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuTra] ([MaT], [MaM], [Ngaytra]) VALUES (N'PT003', N'PM003', CAST(N'2023-02-21T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuTra] ([MaT], [MaM], [Ngaytra]) VALUES (N'PT004', N'PM004', CAST(N'2022-04-19T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuTra] ([MaT], [MaM], [Ngaytra]) VALUES (N'PT005', N'PM005', CAST(N'2022-03-14T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuTra] ([MaT], [MaM], [Ngaytra]) VALUES (N'PT006', N'PM006', CAST(N'2022-04-16T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuTra] ([MaT], [MaM], [Ngaytra]) VALUES (N'PT007', N'PM007', CAST(N'2022-08-26T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuTra] ([MaT], [MaM], [Ngaytra]) VALUES (N'PT008', N'PM008', CAST(N'2023-02-16T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuTra] ([MaT], [MaM], [Ngaytra]) VALUES (N'PT009', N'PM009', CAST(N'2023-03-14T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuTra] ([MaT], [MaM], [Ngaytra]) VALUES (N'PT010', N'PM010', CAST(N'2023-02-25T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuTra] ([MaT], [MaM], [Ngaytra]) VALUES (N'PT011', N'PM011', CAST(N'2023-03-01T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuTra] ([MaT], [MaM], [Ngaytra]) VALUES (N'PT012', N'PM012', CAST(N'2023-04-12T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuTra] ([MaT], [MaM], [Ngaytra]) VALUES (N'PT013', N'PM013', CAST(N'2023-03-28T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuTra] ([MaT], [MaM], [Ngaytra]) VALUES (N'PT014', N'PM014', CAST(N'2023-04-20T00:00:00.000' AS DateTime))
INSERT [dbo].[PhieuTra] ([MaT], [MaM], [Ngaytra]) VALUES (N'PT015', N'PM015', CAST(N'2023-04-14T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Report_SachMuonTheoDocGia] ([MaDG], [HoTenDG], [SoSachMuon]) VALUES (N'DG001', N'Nguyễn Thị Minh', 5)
INSERT [dbo].[Report_SachMuonTheoDocGia] ([MaDG], [HoTenDG], [SoSachMuon]) VALUES (N'DG002', N'Nguyễn Thị Ngọc', 2)
INSERT [dbo].[Report_SachMuonTheoDocGia] ([MaDG], [HoTenDG], [SoSachMuon]) VALUES (N'DG003', N'Trần Anh Tuấn', 3)
INSERT [dbo].[Report_SachMuonTheoDocGia] ([MaDG], [HoTenDG], [SoSachMuon]) VALUES (N'DG004', N'Lê Nam Mạnh', 1)
INSERT [dbo].[Report_SachMuonTheoDocGia] ([MaDG], [HoTenDG], [SoSachMuon]) VALUES (N'DG005', N'Nguyễn Quốc Khánh', 2)
INSERT [dbo].[Report_SachMuonTheoDocGia] ([MaDG], [HoTenDG], [SoSachMuon]) VALUES (N'DG006', N'Nguyễn Duy', 2)
INSERT [dbo].[Report_SachMuonTheoDocGia] ([MaDG], [HoTenDG], [SoSachMuon]) VALUES (N'DG008', N'Nguyễn Xuân Dũng', 2)
INSERT [dbo].[Report_SachMuonTheoDocGia] ([MaDG], [HoTenDG], [SoSachMuon]) VALUES (N'DG009', N'Nguyễn Quốc Hùng', 4)
INSERT [dbo].[Report_SachMuonTheoDocGia] ([MaDG], [HoTenDG], [SoSachMuon]) VALUES (N'DG011', N'Phạm Minh Tâm', 2)
INSERT [dbo].[Report_SachMuonTheoDocGia] ([MaDG], [HoTenDG], [SoSachMuon]) VALUES (N'DG012', N'Trần Xuân Anh', 1)
INSERT [dbo].[Report_SachMuonTheoDocGia] ([MaDG], [HoTenDG], [SoSachMuon]) VALUES (N'DG017', N'Lê Văn Khương', 1)
INSERT [dbo].[Report_SachMuonTheoDocGia] ([MaDG], [HoTenDG], [SoSachMuon]) VALUES (N'DG018', N'Mai Hoàng Đức', 2)
INSERT [dbo].[Report_SachMuonTheoDocGia] ([MaDG], [HoTenDG], [SoSachMuon]) VALUES (N'DG020', N'Trần Việt Hưng', 1)
GO
INSERT [dbo].[Report_SoLuongSMTheoNam] ([Nam], [SoLuongSM]) VALUES (N'2022', 11)
INSERT [dbo].[Report_SoLuongSMTheoNam] ([Nam], [SoLuongSM]) VALUES (N'2023', 10)
GO
INSERT [dbo].[Report_SoLuongSMTheoTT] ([MaTT], [HoTenTT], [SoLuongSM]) VALUES (N'TT001', N'Nguyễn Quang Khải', 4)
INSERT [dbo].[Report_SoLuongSMTheoTT] ([MaTT], [HoTenTT], [SoLuongSM]) VALUES (N'TT002', N'Trần Xuân Hương', 1)
INSERT [dbo].[Report_SoLuongSMTheoTT] ([MaTT], [HoTenTT], [SoLuongSM]) VALUES (N'TT003', N'Nguyễn Quốc Đạt', 0)
INSERT [dbo].[Report_SoLuongSMTheoTT] ([MaTT], [HoTenTT], [SoLuongSM]) VALUES (N'TT004', N'Nguyễn Mai Quyên', 3)
INSERT [dbo].[Report_SoLuongSMTheoTT] ([MaTT], [HoTenTT], [SoLuongSM]) VALUES (N'TT005', N'Trần Mai Thanh', 1)
INSERT [dbo].[Report_SoLuongSMTheoTT] ([MaTT], [HoTenTT], [SoLuongSM]) VALUES (N'TT006', N'Phạm Xuân Anh', 1)
INSERT [dbo].[Report_SoLuongSMTheoTT] ([MaTT], [HoTenTT], [SoLuongSM]) VALUES (N'TT007', N'Phạm Ngọc Anh', 1)
INSERT [dbo].[Report_SoLuongSMTheoTT] ([MaTT], [HoTenTT], [SoLuongSM]) VALUES (N'TT008', N'Đỗ Ngọc Linh', 1)
INSERT [dbo].[Report_SoLuongSMTheoTT] ([MaTT], [HoTenTT], [SoLuongSM]) VALUES (N'TT009', N'Hoàng Khánh Hưng ', 0)
INSERT [dbo].[Report_SoLuongSMTheoTT] ([MaTT], [HoTenTT], [SoLuongSM]) VALUES (N'TT010', N'Nguyễn Thế Duy', 1)
INSERT [dbo].[Report_SoLuongSMTheoTT] ([MaTT], [HoTenTT], [SoLuongSM]) VALUES (N'TT011', N'Lê Thị Cúc', 2)
INSERT [dbo].[Report_SoLuongSMTheoTT] ([MaTT], [HoTenTT], [SoLuongSM]) VALUES (N'TT012', N'Mai Minh Mẫn', 2)
INSERT [dbo].[Report_SoLuongSMTheoTT] ([MaTT], [HoTenTT], [SoLuongSM]) VALUES (N'TT013', N'Võ Tú Hoàng', 0)
INSERT [dbo].[Report_SoLuongSMTheoTT] ([MaTT], [HoTenTT], [SoLuongSM]) VALUES (N'TT014', N'Trần Hữu Thắng', 0)
INSERT [dbo].[Report_SoLuongSMTheoTT] ([MaTT], [HoTenTT], [SoLuongSM]) VALUES (N'TT015', N'Nguyễn Duy Hưng', 1)
INSERT [dbo].[Report_SoLuongSMTheoTT] ([MaTT], [HoTenTT], [SoLuongSM]) VALUES (N'TT016', N'Mai Thị Lựu', 0)
INSERT [dbo].[Report_SoLuongSMTheoTT] ([MaTT], [HoTenTT], [SoLuongSM]) VALUES (N'TT017', N'Đào Thị Hồng', 1)
INSERT [dbo].[Report_SoLuongSMTheoTT] ([MaTT], [HoTenTT], [SoLuongSM]) VALUES (N'TT018', N'Phan Thành Nhân', 1)
INSERT [dbo].[Report_SoLuongSMTheoTT] ([MaTT], [HoTenTT], [SoLuongSM]) VALUES (N'TT019', N'Phan Ánh Dương', 1)
INSERT [dbo].[Report_SoLuongSMTheoTT] ([MaTT], [HoTenTT], [SoLuongSM]) VALUES (N'TT020', N'Phan Ánh Nguyệt', 0)
GO
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0001', N'08667', 8, 26000, 2020, N'')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0002', N'08667', 7, 27000, 2023, N'')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0003', N'08683', 3, 25000, 2014, N'')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0004', N'25754', 2, 30000, 2019, N'')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0005', N'26774', 2, 30000, 2020, N'')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0006', N'26761', 1, 30000, 2014, N'')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0007', N'26762', 2, 30000, 2014, N'')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0008', N'15142', 0, 45000, 2023, N'')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0009', N'15142', 2, 45000, 2022, N'')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0010', N'14980', 4, 13800, 2015, N'')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0011', N'14980', 9, 16000, 2020, N'')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0012', N'32208', 30, 30000, 2022, N'')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0013', N'32206', 40, 30000, 2022, N'')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0014', N'31908', 20, 30000, 2022, N'')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0015', N'32148', 15, 40000, 2022, N'')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0016', N'32147', 10, 40000, 2022, N'')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0017', N'31782', 6, 40000, 2022, N'')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0018', N'32231', 5, 50000, 2022, N'')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0019', N'32228', 2, 50000, 2022, N'')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0020', N'32314', 5, 0, 2022, N'Được tặng')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0021', N'32283', 1, 0, 2016, N'Được tặng')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0022', N'30827', 1, 30000, 2018, N'')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0023', N'30824', 1, 30000, 2018, N'')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0024', N'30821', 2, 60000, 2018, N'')
INSERT [dbo].[Sach] ([MaSach], [ISBN], [SoLuong], [Gia], [NamXB], [Ghichu]) VALUES (N'S0025', N'30817', 1, 30000, 2020, N'')
GO
INSERT [dbo].[TheLoai] ([MaLoai], [TenLoai]) VALUES (N'APDK', N'Ấn phẩm định kỳ')
INSERT [dbo].[TheLoai] ([MaLoai], [TenLoai]) VALUES (N'BT', N'Bài trích')
INSERT [dbo].[TheLoai] ([MaLoai], [TenLoai]) VALUES (N'BTC', N'Báo - tạp chí')
INSERT [dbo].[TheLoai] ([MaLoai], [TenLoai]) VALUES (N'GTBG', N'Giáo trình, bài giảng')
INSERT [dbo].[TheLoai] ([MaLoai], [TenLoai]) VALUES (N'LATS', N'Luận án Tiến sĩ')
INSERT [dbo].[TheLoai] ([MaLoai], [TenLoai]) VALUES (N'LVThS', N'Luận văn Thạc sĩ')
INSERT [dbo].[TheLoai] ([MaLoai], [TenLoai]) VALUES (N'Sa', N'Sách')
INSERT [dbo].[TheLoai] ([MaLoai], [TenLoai]) VALUES (N'TLNC', N'Tài liệu nghiên cứu khoa học')
GO
INSERT [dbo].[TheThuVien] ([Mathe], [MaDG], [HanThe]) VALUES (N'TTV01', N'DG001', CAST(N'2027-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[TheThuVien] ([Mathe], [MaDG], [HanThe]) VALUES (N'TTV02', N'DG002', CAST(N'2025-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[TheThuVien] ([Mathe], [MaDG], [HanThe]) VALUES (N'TTV03', N'DG003', CAST(N'2025-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[TheThuVien] ([Mathe], [MaDG], [HanThe]) VALUES (N'TTV04', N'DG004', CAST(N'2024-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[TheThuVien] ([Mathe], [MaDG], [HanThe]) VALUES (N'TTV05', N'DG005', CAST(N'2026-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[TheThuVien] ([Mathe], [MaDG], [HanThe]) VALUES (N'TTV06', N'DG006', CAST(N'2023-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[TheThuVien] ([Mathe], [MaDG], [HanThe]) VALUES (N'TTV07', N'DG007', CAST(N'2026-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[TheThuVien] ([Mathe], [MaDG], [HanThe]) VALUES (N'TTV08', N'DG008', CAST(N'2028-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[TheThuVien] ([Mathe], [MaDG], [HanThe]) VALUES (N'TTV09', N'DG009', CAST(N'2026-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[TheThuVien] ([Mathe], [MaDG], [HanThe]) VALUES (N'TTV10', N'DG010', CAST(N'2030-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[TheThuVien] ([Mathe], [MaDG], [HanThe]) VALUES (N'TTV11', N'DG011', CAST(N'2030-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[TheThuVien] ([Mathe], [MaDG], [HanThe]) VALUES (N'TTV12', N'DG012', CAST(N'2027-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[TheThuVien] ([Mathe], [MaDG], [HanThe]) VALUES (N'TTV13', N'DG013', CAST(N'2028-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[TheThuVien] ([Mathe], [MaDG], [HanThe]) VALUES (N'TTV14', N'DG014', CAST(N'2030-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[TheThuVien] ([Mathe], [MaDG], [HanThe]) VALUES (N'TTV15', N'DG015', CAST(N'2030-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[TheThuVien] ([Mathe], [MaDG], [HanThe]) VALUES (N'TTV16', N'DG016', CAST(N'2029-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[TheThuVien] ([Mathe], [MaDG], [HanThe]) VALUES (N'TTV17', N'DG017', CAST(N'2030-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[TheThuVien] ([Mathe], [MaDG], [HanThe]) VALUES (N'TTV18', N'DG018', CAST(N'2030-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[TheThuVien] ([Mathe], [MaDG], [HanThe]) VALUES (N'TTV19', N'DG019', CAST(N'2030-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[TheThuVien] ([Mathe], [MaDG], [HanThe]) VALUES (N'TTV20', N'DG020', CAST(N'2030-12-31T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[ThuThu] ([MaTT], [HoTenTT], [NgaySinhTT], [GioiTinhTT], [DthoaiTT], [DiachiTT]) VALUES (N'TT001', N'Nguyễn Quang Khải', CAST(N'1980-10-12T00:00:00.000' AS DateTime), N'Nam', N'0975007632', N'Q1 , Tp.HCM')
INSERT [dbo].[ThuThu] ([MaTT], [HoTenTT], [NgaySinhTT], [GioiTinhTT], [DthoaiTT], [DiachiTT]) VALUES (N'TT002', N'Trần Xuân Hương', CAST(N'1979-07-09T00:00:00.000' AS DateTime), N'Nữ', N'0935000433', N'Phú Giáo, Bình Dương')
INSERT [dbo].[ThuThu] ([MaTT], [HoTenTT], [NgaySinhTT], [GioiTinhTT], [DthoaiTT], [DiachiTT]) VALUES (N'TT003', N'Nguyễn Quốc Đạt', CAST(N'1978-07-07T00:00:00.000' AS DateTime), N'Nam', N'0985007802', N'Diên Khánh, Nha Trang')
INSERT [dbo].[ThuThu] ([MaTT], [HoTenTT], [NgaySinhTT], [GioiTinhTT], [DthoaiTT], [DiachiTT]) VALUES (N'TT004', N'Nguyễn Mai Quyên', CAST(N'1981-11-09T00:00:00.000' AS DateTime), N'Nữ', N'0975017688', N'Trảng Bom, Đồng Nai')
INSERT [dbo].[ThuThu] ([MaTT], [HoTenTT], [NgaySinhTT], [GioiTinhTT], [DthoaiTT], [DiachiTT]) VALUES (N'TT005', N'Trần Mai Thanh', CAST(N'1985-12-09T00:00:00.000' AS DateTime), N'Nữ', N'0935666602', N'Tân Uyên, Bình Dương')
INSERT [dbo].[ThuThu] ([MaTT], [HoTenTT], [NgaySinhTT], [GioiTinhTT], [DthoaiTT], [DiachiTT]) VALUES (N'TT006', N'Phạm Xuân Anh', CAST(N'1984-06-19T00:00:00.000' AS DateTime), N'Nam', N'0913007677', N'Q2 , Tp.HCM')
INSERT [dbo].[ThuThu] ([MaTT], [HoTenTT], [NgaySinhTT], [GioiTinhTT], [DthoaiTT], [DiachiTT]) VALUES (N'TT007', N'Phạm Ngọc Anh', CAST(N'1984-06-15T00:00:00.000' AS DateTime), N'Nam', N'0913447677', N'Q3 , Tp.HCM')
INSERT [dbo].[ThuThu] ([MaTT], [HoTenTT], [NgaySinhTT], [GioiTinhTT], [DthoaiTT], [DiachiTT]) VALUES (N'TT008', N'Đỗ Ngọc Linh', CAST(N'1985-03-09T00:00:00.000' AS DateTime), N'Nữ', N'02116584443', N'Ninh Hòa, Nha Trang')
INSERT [dbo].[ThuThu] ([MaTT], [HoTenTT], [NgaySinhTT], [GioiTinhTT], [DthoaiTT], [DiachiTT]) VALUES (N'TT009', N'Hoàng Khánh Hưng ', CAST(N'1982-08-11T00:00:00.000' AS DateTime), N'Nam', N'02116584444', N'Q1 , Tp.HCM')
INSERT [dbo].[ThuThu] ([MaTT], [HoTenTT], [NgaySinhTT], [GioiTinhTT], [DthoaiTT], [DiachiTT]) VALUES (N'TT010', N'Nguyễn Thế Duy', CAST(N'1988-10-09T00:00:00.000' AS DateTime), N'Nam', N'0354879621', N'Cẩm Mỹ, Đồng Nai')
INSERT [dbo].[ThuThu] ([MaTT], [HoTenTT], [NgaySinhTT], [GioiTinhTT], [DthoaiTT], [DiachiTT]) VALUES (N'TT011', N'Lê Thị Cúc', CAST(N'1989-05-04T00:00:00.000' AS DateTime), N'Nữ', N'092987987', N'Củ Chi, Tp.HCM')
INSERT [dbo].[ThuThu] ([MaTT], [HoTenTT], [NgaySinhTT], [GioiTinhTT], [DthoaiTT], [DiachiTT]) VALUES (N'TT012', N'Mai Minh Mẫn', CAST(N'1990-03-07T00:00:00.000' AS DateTime), N'Nữ', N'098789789', N'Q9, Tp.HCM')
INSERT [dbo].[ThuThu] ([MaTT], [HoTenTT], [NgaySinhTT], [GioiTinhTT], [DthoaiTT], [DiachiTT]) VALUES (N'TT013', N'Võ Tú Hoàng', CAST(N'2000-09-08T00:00:00.000' AS DateTime), N'Nam', N'091234234', N'Phú Đông, Tiền Giang')
INSERT [dbo].[ThuThu] ([MaTT], [HoTenTT], [NgaySinhTT], [GioiTinhTT], [DthoaiTT], [DiachiTT]) VALUES (N'TT014', N'Trần Hữu Thắng', CAST(N'1985-05-12T00:00:00.000' AS DateTime), N'Nam', N'092678678', N'Tân Phú, Đồng Nai')
INSERT [dbo].[ThuThu] ([MaTT], [HoTenTT], [NgaySinhTT], [GioiTinhTT], [DthoaiTT], [DiachiTT]) VALUES (N'TT015', N'Nguyễn Duy Hưng', CAST(N'1987-03-05T00:00:00.000' AS DateTime), N'Nam', N'098456654', N'67 Kỳ Đồng')
INSERT [dbo].[ThuThu] ([MaTT], [HoTenTT], [NgaySinhTT], [GioiTinhTT], [DthoaiTT], [DiachiTT]) VALUES (N'TT016', N'Mai Thị Lựu', CAST(N'1992-03-17T00:00:00.000' AS DateTime), N'Nữ', N'09181831444', N'Tân Trụ, Long An')
INSERT [dbo].[ThuThu] ([MaTT], [HoTenTT], [NgaySinhTT], [GioiTinhTT], [DthoaiTT], [DiachiTT]) VALUES (N'TT017', N'Đào Thị Hồng', CAST(N'1989-03-07T00:00:00.000' AS DateTime), N'Nữ', N'09754322222', N'Phú Nhuận, Tp.HCM')
INSERT [dbo].[ThuThu] ([MaTT], [HoTenTT], [NgaySinhTT], [GioiTinhTT], [DthoaiTT], [DiachiTT]) VALUES (N'TT018', N'Phan Thành Nhân', CAST(N'1987-02-04T00:00:00.000' AS DateTime), N'Nữ', N'09135332332', N'Cai Lậy, Tiền Giang')
INSERT [dbo].[ThuThu] ([MaTT], [HoTenTT], [NgaySinhTT], [GioiTinhTT], [DthoaiTT], [DiachiTT]) VALUES (N'TT019', N'Phan Ánh Dương', CAST(N'1989-08-03T00:00:00.000' AS DateTime), N'Nữ', N'09812127678', N'Mộc Hóa, Long An')
INSERT [dbo].[ThuThu] ([MaTT], [HoTenTT], [NgaySinhTT], [GioiTinhTT], [DthoaiTT], [DiachiTT]) VALUES (N'TT020', N'Phan Ánh Nguyệt', CAST(N'1990-01-08T00:00:00.000' AS DateTime), N'Nữ', N'09812342356', N'Thuận AN, Bình Dương')
GO
SET IDENTITY_INSERT [dbo].[TreHan] ON 

INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (1, N'PM001', N'PT001', N'S0001', CAST(N'2022-01-09T00:00:00.000' AS DateTime), CAST(N'2022-01-19T00:00:00.000' AS DateTime), CAST(N'2022-07-19T00:00:00.000' AS DateTime), 181)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (2, N'PM001', N'PT001', N'S0002', CAST(N'2022-01-09T00:00:00.000' AS DateTime), CAST(N'2022-01-19T00:00:00.000' AS DateTime), CAST(N'2022-07-19T00:00:00.000' AS DateTime), 181)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (3, N'PM001', N'PT001', N'S0003', CAST(N'2022-01-09T00:00:00.000' AS DateTime), CAST(N'2022-01-19T00:00:00.000' AS DateTime), CAST(N'2022-07-19T00:00:00.000' AS DateTime), 181)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (4, N'PM002', N'PT002', N'S0002', CAST(N'2022-02-09T00:00:00.000' AS DateTime), CAST(N'2022-02-19T00:00:00.000' AS DateTime), CAST(N'2022-04-19T00:00:00.000' AS DateTime), 59)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (5, N'PM003', N'PT003', N'S0006', CAST(N'2022-02-10T00:00:00.000' AS DateTime), CAST(N'2022-02-20T00:00:00.000' AS DateTime), CAST(N'2023-02-21T00:00:00.000' AS DateTime), 366)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (6, N'PM003', N'PT003', N'S0007', CAST(N'2022-02-10T00:00:00.000' AS DateTime), CAST(N'2022-02-20T00:00:00.000' AS DateTime), CAST(N'2023-02-21T00:00:00.000' AS DateTime), 366)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (7, N'PM004', N'PT004', N'S0008', CAST(N'2022-02-11T00:00:00.000' AS DateTime), CAST(N'2022-02-21T00:00:00.000' AS DateTime), CAST(N'2022-04-19T00:00:00.000' AS DateTime), 57)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (8, N'PM005', N'PT005', N'S0010', CAST(N'2022-03-01T00:00:00.000' AS DateTime), CAST(N'2022-03-11T00:00:00.000' AS DateTime), CAST(N'2022-03-14T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (9, N'PM005', N'PT005', N'S0011', CAST(N'2022-03-01T00:00:00.000' AS DateTime), CAST(N'2022-03-11T00:00:00.000' AS DateTime), CAST(N'2022-03-14T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (10, N'PM006', N'PT006', N'S0012', CAST(N'2022-04-14T00:00:00.000' AS DateTime), CAST(N'2022-04-24T00:00:00.000' AS DateTime), CAST(N'2022-04-16T00:00:00.000' AS DateTime), 362)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (11, N'PM007', N'PT007', N'S0013', CAST(N'2022-08-06T00:00:00.000' AS DateTime), CAST(N'2022-08-16T00:00:00.000' AS DateTime), CAST(N'2022-08-26T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (12, N'PM007', N'PT007', N'S0014', CAST(N'2022-08-06T00:00:00.000' AS DateTime), CAST(N'2022-08-16T00:00:00.000' AS DateTime), CAST(N'2022-08-26T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (13, N'PM008', N'PT008', N'S0015', CAST(N'2023-01-16T00:00:00.000' AS DateTime), CAST(N'2023-01-26T00:00:00.000' AS DateTime), CAST(N'2023-02-16T00:00:00.000' AS DateTime), 21)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (14, N'PM009', N'PT009', N'S0016', CAST(N'2023-02-03T00:00:00.000' AS DateTime), CAST(N'2023-02-13T00:00:00.000' AS DateTime), CAST(N'2023-03-14T00:00:00.000' AS DateTime), 29)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (15, N'PM010', N'PT010', N'S0017', CAST(N'2023-02-15T00:00:00.000' AS DateTime), CAST(N'2023-02-25T00:00:00.000' AS DateTime), CAST(N'2023-02-25T00:00:00.000' AS DateTime), 55)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (16, N'PM011', N'PT011', N'S0018', CAST(N'2023-02-17T00:00:00.000' AS DateTime), CAST(N'2023-02-27T00:00:00.000' AS DateTime), CAST(N'2023-03-01T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (17, N'PM012', N'PT012', N'S0019', CAST(N'2023-03-01T00:00:00.000' AS DateTime), CAST(N'2023-03-11T00:00:00.000' AS DateTime), CAST(N'2023-04-12T00:00:00.000' AS DateTime), 32)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (18, N'PM013', N'PT013', N'S0013', CAST(N'2023-03-09T00:00:00.000' AS DateTime), CAST(N'2023-03-19T00:00:00.000' AS DateTime), CAST(N'2023-03-28T00:00:00.000' AS DateTime), 9)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (19, N'PM013', N'PT013', N'S0020', CAST(N'2023-03-09T00:00:00.000' AS DateTime), CAST(N'2023-03-19T00:00:00.000' AS DateTime), CAST(N'2023-03-28T00:00:00.000' AS DateTime), 9)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (20, N'PM014', N'PT014', N'S0014', CAST(N'2023-03-11T00:00:00.000' AS DateTime), CAST(N'2023-03-21T00:00:00.000' AS DateTime), CAST(N'2023-04-20T00:00:00.000' AS DateTime), 30)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (21, N'PM014', N'PT014', N'S0015', CAST(N'2023-03-11T00:00:00.000' AS DateTime), CAST(N'2023-03-21T00:00:00.000' AS DateTime), CAST(N'2023-04-20T00:00:00.000' AS DateTime), 30)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (22, N'PM015', N'PT015', N'S0016', CAST(N'2023-03-12T00:00:00.000' AS DateTime), CAST(N'2023-03-22T00:00:00.000' AS DateTime), CAST(N'2023-04-14T00:00:00.000' AS DateTime), 23)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (23, N'PM016', NULL, N'S0017', CAST(N'2023-04-05T00:00:00.000' AS DateTime), CAST(N'2023-04-15T00:00:00.000' AS DateTime), NULL, 6)
INSERT [dbo].[TreHan] ([IDTH], [MaM], [MaT], [MaSach], [Ngaymuon], [Ngayhethan], [Ngaytra], [Songaytrehan]) VALUES (24, N'PM017', NULL, N'S0018', CAST(N'2023-04-10T00:00:00.000' AS DateTime), CAST(N'2023-04-20T00:00:00.000' AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[TreHan] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [index_TSTG]    Script Date: 24-Apr-23 2:31:21 PM ******/
CREATE NONCLUSTERED INDEX [index_TSTG] ON [dbo].[Dausach]
(
	[TenSach] ASC,
	[Tacgia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [index_HoTenTT]    Script Date: 24-Apr-23 2:31:21 PM ******/
CREATE NONCLUSTERED INDEX [index_HoTenTT] ON [dbo].[ThuThu]
(
	[HoTenTT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CTPhieuMuon]  WITH CHECK ADD  CONSTRAINT [FK_CTPhieuMuon_MaM] FOREIGN KEY([MaM])
REFERENCES [dbo].[PhieuMuon] ([MaM])
GO
ALTER TABLE [dbo].[CTPhieuMuon] CHECK CONSTRAINT [FK_CTPhieuMuon_MaM]
GO
ALTER TABLE [dbo].[CTPhieuMuon]  WITH CHECK ADD  CONSTRAINT [FK_CTPhieuMuon_MaSach] FOREIGN KEY([MaSach])
REFERENCES [dbo].[Sach] ([MaSach])
GO
ALTER TABLE [dbo].[CTPhieuMuon] CHECK CONSTRAINT [FK_CTPhieuMuon_MaSach]
GO
ALTER TABLE [dbo].[CTPhieuNhap]  WITH CHECK ADD  CONSTRAINT [FK_CTPhieuNhap_SoPN] FOREIGN KEY([SoPN])
REFERENCES [dbo].[PhieuNhap] ([SoPN])
GO
ALTER TABLE [dbo].[CTPhieuNhap] CHECK CONSTRAINT [FK_CTPhieuNhap_SoPN]
GO
ALTER TABLE [dbo].[CTPhieuNhap]  WITH CHECK ADD  CONSTRAINT [FK_PhieuNhap_ISBN] FOREIGN KEY([ISBN])
REFERENCES [dbo].[Dausach] ([ISBN])
GO
ALTER TABLE [dbo].[CTPhieuNhap] CHECK CONSTRAINT [FK_PhieuNhap_ISBN]
GO
ALTER TABLE [dbo].[Dausach]  WITH CHECK ADD  CONSTRAINT [FK_Dausach_MaLoai] FOREIGN KEY([MaLoai])
REFERENCES [dbo].[TheLoai] ([MaLoai])
GO
ALTER TABLE [dbo].[Dausach] CHECK CONSTRAINT [FK_Dausach_MaLoai]
GO
ALTER TABLE [dbo].[PhieuMuon]  WITH CHECK ADD  CONSTRAINT [FK_PhieuMuon_MaDG] FOREIGN KEY([MaDG])
REFERENCES [dbo].[DocGia] ([MaDG])
GO
ALTER TABLE [dbo].[PhieuMuon] CHECK CONSTRAINT [FK_PhieuMuon_MaDG]
GO
ALTER TABLE [dbo].[PhieuMuon]  WITH CHECK ADD  CONSTRAINT [FK_PhieuMuon_MaTT] FOREIGN KEY([MaTT])
REFERENCES [dbo].[ThuThu] ([MaTT])
GO
ALTER TABLE [dbo].[PhieuMuon] CHECK CONSTRAINT [FK_PhieuMuon_MaTT]
GO
ALTER TABLE [dbo].[PhieuNhap]  WITH CHECK ADD  CONSTRAINT [FK_PhieuNhap_MaNCC] FOREIGN KEY([MaNCC])
REFERENCES [dbo].[Nhacungcap] ([MaNCC])
GO
ALTER TABLE [dbo].[PhieuNhap] CHECK CONSTRAINT [FK_PhieuNhap_MaNCC]
GO
ALTER TABLE [dbo].[PhieuNhap]  WITH CHECK ADD  CONSTRAINT [FK_PhieuNhap_MaTT] FOREIGN KEY([MaTT])
REFERENCES [dbo].[ThuThu] ([MaTT])
GO
ALTER TABLE [dbo].[PhieuNhap] CHECK CONSTRAINT [FK_PhieuNhap_MaTT]
GO
ALTER TABLE [dbo].[PhieuTra]  WITH CHECK ADD  CONSTRAINT [FK_PhieuTra_MaM] FOREIGN KEY([MaM])
REFERENCES [dbo].[PhieuMuon] ([MaM])
GO
ALTER TABLE [dbo].[PhieuTra] CHECK CONSTRAINT [FK_PhieuTra_MaM]
GO
ALTER TABLE [dbo].[Sach]  WITH CHECK ADD  CONSTRAINT [FK_Sach_ISBN] FOREIGN KEY([ISBN])
REFERENCES [dbo].[Dausach] ([ISBN])
GO
ALTER TABLE [dbo].[Sach] CHECK CONSTRAINT [FK_Sach_ISBN]
GO
ALTER TABLE [dbo].[TheThuVien]  WITH CHECK ADD  CONSTRAINT [FK_TheThuVien_MaDG] FOREIGN KEY([MaDG])
REFERENCES [dbo].[DocGia] ([MaDG])
GO
ALTER TABLE [dbo].[TheThuVien] CHECK CONSTRAINT [FK_TheThuVien_MaDG]
GO
ALTER TABLE [dbo].[TreHan]  WITH CHECK ADD  CONSTRAINT [FK_TreHan_MaM] FOREIGN KEY([MaM])
REFERENCES [dbo].[PhieuMuon] ([MaM])
GO
ALTER TABLE [dbo].[TreHan] CHECK CONSTRAINT [FK_TreHan_MaM]
GO
ALTER TABLE [dbo].[TreHan]  WITH CHECK ADD  CONSTRAINT [FK_TreHan_MaSach] FOREIGN KEY([MaSach])
REFERENCES [dbo].[Sach] ([MaSach])
GO
ALTER TABLE [dbo].[TreHan] CHECK CONSTRAINT [FK_TreHan_MaSach]
GO
ALTER TABLE [dbo].[TreHan]  WITH CHECK ADD  CONSTRAINT [FK_TreHan_MaT] FOREIGN KEY([MaT])
REFERENCES [dbo].[PhieuTra] ([MaT])
GO
ALTER TABLE [dbo].[TreHan] CHECK CONSTRAINT [FK_TreHan_MaT]
GO
ALTER TABLE [dbo].[DocGia]  WITH CHECK ADD  CONSTRAINT [CK_DocGia_DoiTuong] CHECK  (([DoiTuong]=N'Nhân viên' OR [DoiTuong]=N'Giảng viên' OR [DoiTuong]=N'Sinh viên'))
GO
ALTER TABLE [dbo].[DocGia] CHECK CONSTRAINT [CK_DocGia_DoiTuong]
GO
ALTER TABLE [dbo].[DocGia]  WITH CHECK ADD  CONSTRAINT [CK_DocGia_GioiTinhDG] CHECK  (([GioiTinhDG]=N'Khác' OR [GioiTinhDG]=N'Nữ' OR [GioiTinhDG]='Nam'))
GO
ALTER TABLE [dbo].[DocGia] CHECK CONSTRAINT [CK_DocGia_GioiTinhDG]
GO
ALTER TABLE [dbo].[ThuThu]  WITH CHECK ADD  CONSTRAINT [CK_ThuThu_GioiTinhTT] CHECK  (([GioiTinhTT]=N'Khác' OR [GioiTinhTT]=N'Nữ' OR [GioiTinhTT]='Nam'))
GO
ALTER TABLE [dbo].[ThuThu] CHECK CONSTRAINT [CK_ThuThu_GioiTinhTT]
GO
/****** Object:  StoredProcedure [dbo].[sp_DGGiangVien]    Script Date: 24-Apr-23 2:31:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_DGGiangVien] as
begin
select * 
from DocGia
where DoiTuong like N'Giảng viên'
end
GO
/****** Object:  StoredProcedure [dbo].[sp_SLDGtheoDoiTuong]    Script Date: 24-Apr-23 2:31:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_SLDGtheoDoiTuong] (@DoiTuong nvarchar(15)) AS
BEGIN
DECLARE @SODG INT
IF EXISTS (SELECT MaDG FROM DocGia WHERE DoiTuong=@DoiTuong)
		   BEGIN 
		   SET @SODG = (SELECT COUNT(MaDG) FROM DocGia where DoiTuong=@DoiTuong
		   GROUP BY DoiTuong)
		   END
		   PRINT N'Số độc giả là đối tượng ' + @DoiTuong + N' là ' + CAST(@SODG AS NCHAR(7))
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SLSach]    Script Date: 24-Apr-23 2:31:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_SLSach] @ISBN nvarchar(5) as
declare @SLSach int
select @SLSach = SUM(SoLuong) from Sach where ISBN = @ISBN
if @SLSach > 5
	begin
	print N'Còn sách'
	end
	else
	print N'Sắp hết sách'
	print N'Số lượng sách: '+cast(@SLSach as nvarchar(10))
GO
/****** Object:  StoredProcedure [dbo].[sp_Top3SM]    Script Date: 24-Apr-23 2:31:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_Top3SM] as
select top(3) with ties count(CTPhieuMuon.MaSach) as SoLanMuon, TenSach
from CTPhieuMuon join Sach on CTPhieuMuon.MaSach = Sach.MaSach
		join Dausach on Dausach.ISBN = Sach.ISBN
group by TenSach
order by count(CTPhieuMuon.MaSach) desc
GO
/****** Object:  StoredProcedure [dbo].[sp_TTDG]    Script Date: 24-Apr-23 2:31:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_TTDG] @MaDG nvarchar(5) as
select *
from DocGia
where MaDG = @MaDG 
GO
/****** Object:  StoredProcedure [dbo].[sp_TTinTreHan]    Script Date: 24-Apr-23 2:31:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_TTinTreHan] @Tu datetime, @Den datetime as
select *
from TreHan
where (NgayMuon between @Tu and @Den)
GO
USE [master]
GO
ALTER DATABASE [QuanLyThuVienUFM] SET  READ_WRITE 
GO
