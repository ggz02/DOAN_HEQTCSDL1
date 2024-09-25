--CHƯƠNG 3: THIẾT KẾ CƠ SỞ DỮ LIỆU
--1. Tạo Database
create database QuanLyThuVienUFM
go
use QuanLyThuVienUFM
go

--2. Tạo các bảng
--Bảng Độc giả
CREATE TABLE DocGia (
  MaDG			nvarchar (5) constraint PK_DocGia_MaDG primary key, 
  HoTenDG		nvarchar (20)  not null,
  NgaySinhDG	datetime not null, 
  GioiTinhDG	nvarchar (6) not null constraint CK_DocGia_GioiTinhDG Check (GioiTinhDG in ('Nam', N'Nữ', N'Khác')),
  DthoaiDG		nvarchar(11) not null, 
  DiachiDG		nvarchar (50) not null,
  DoiTuong		nvarchar (15) not null constraint CK_DocGia_DoiTuong Check (DoiTuong in (N'Sinh viên', N'Giảng viên', N'Nhân viên')) 
)

go
--Bảng Thẻ thư viện
CREATE TABLE TheThuVien (
  Mathe nchar (5) not null Constraint TheThuVien_Mathe Primary key,
  MaDG			nvarchar (5) not null constraint FK_TheThuVien_MaDG references DocGia(MaDG),
  HanThe		datetime not null,
)

go
--Bảng Thủ thư
CREATE TABLE ThuThu (
  MaTT			nvarchar (5) constraint PK_ThuThu_MaTT primary key, 
  HoTenTT		nvarchar (20)  not null,
  NgaySinhTT	datetime not null, 
  GioiTinhTT	nvarchar (6) not null constraint CK_ThuThu_GioiTinhTT Check (GioiTinhTT in ('Nam', N'Nữ', N'Khác')),
  DthoaiTT		nvarchar(11) not null, 
  DiachiTT		nvarchar (50) not null
)

go
--Bảng Thể loại
CREATE TABLE TheLoai (
	MaLoai		nvarchar(5) constraint PK_TheLoai_MaLoai primary key,
	TenLoai		nvarchar(30) not null
)

go
--Bảng Nhà cung cấp
create table Nhacungcap (
	MaNCC		nvarchar(5) constraint PK_Nhacungcap_IDNCC primary key (MaNCC),
	TenNCC		nvarchar(100) not null,
	Diachi		nvarchar(150),
	Dienthoai	nvarchar(12) not null,
	Website		nvarchar(30)
)

go
--Bảng Đầu sách
CREATE TABLE Dausach (
	ISBN	nvarchar (5) not null  constraint PK_DauSach_ISBN primary key (ISBN),
	MaLoai	 nvarchar (5)  not null constraint FK_Dausach_MaLoai references TheLoai(MaLoai),
    TenSach nvarchar(100) not null,
    Tacgia nvarchar(50) not null,
    NXB nvarchar(50) not null,
    Thongtinsach nvarchar(1024)
)

go
--Bảng Sách
CREATE TABLE Sach (
    MaSach nvarchar (5) not null PRIMARY KEY,
	ISBN nvarchar(5) not null constraint FK_Sach_ISBN references DauSach(ISBN),
    SoLuong int not null,
	Gia int,
	NamXB int,
	Ghichu nvarchar (5)
)

go
--Bảng Phiếu mượn
CREATE TABLE PhieuMuon (
  MaM		    nvarchar (5) constraint PK_PhieuMuon_MaM primary key, 
  MaDG			nvarchar (5) not null constraint FK_PhieuMuon_MaDG references DocGia(MaDG),
  MaTT			nvarchar (5) not null constraint FK_PhieuMuon_MaTT references ThuThu(MaTT),
  Ngaymuon	    datetime  not null,
  Ngayhethan	datetime  not null,
)

go
--Bảng Chi tiết Phiếu mượn
CREATE TABLE CTPhieuMuon (
  MaM		    nvarchar (5) not null constraint FK_CTPhieuMuon_MaM references PhieuMuon(MaM),
  MaSach		nvarchar (5) not null constraint FK_CTPhieuMuon_MaSach references Sach(MaSach),
  constraint PK__CTPhieuMuon primary key (MaM, MaSach)
)

go
--Bảng Phiếu trả
CREATE TABLE PhieuTra (
  MaT		    nvarchar (5) constraint PK_PhieuTra_MaT primary key,
  MaM		    nvarchar (5) constraint FK_PhieuTra_MaM references PhieuMuon(MaM),
  Ngaytra		datetime not null,
)

go
--Bảng Trễ hạn
CREATE TABLE TreHan (
	IDTH int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	MaM nvarchar (5) not null constraint FK_TreHan_MaM references PhieuMuon(MaM),
	MaT	nvarchar (5) constraint FK_TreHan_MaT references PhieuTra(MaT), 
	MaSach nvarchar (5) not null constraint FK_TreHan_MaSach references Sach(MaSach),
	Ngaymuon datetime not null,
	Ngayhethan datetime not null,
	Ngaytra datetime null,
	Songaytrehan int not null,
	Sotien as (Songaytrehan*1000)
)

go
--Bảng Phiếu nhập
CREATE TABLE PhieuNhap (
    SoPN		nvarchar (5) not null constraint PK_PhieuNhap_IDPN primary key,
	MaNCC		nvarchar (5) not null constraint FK_PhieuNhap_MaNCC references Nhacungcap(MaNCC),
	MaTT	    nvarchar (5) not null constraint FK_PhieuNhap_MaTT references ThuThu(MaTT)
)

go
--Bảng Chi tiết Phiếu nhập
CREATE TABLE CTPhieuNhap (
	SoPN	 nvarchar(5) not null constraint FK_CTPhieuNhap_SoPN references PhieuNhap (SoPN),
	ISBN	 nvarchar (5) not null constraint FK_PhieuNhap_ISBN references Dausach(ISBN),
	Soluong	 int not null,
	Gianhap	 int not null,
	constraint FK_CTPhieuNhap primary key (SoPN, ISBN)
)

--3. Thêm dữ liệu mẫu cho các bảng
--Thêm dữ liệu mẫu vào bảng Thể loại
INSERT INTO TheLoai VALUES
	('APDK',	N'Ấn phẩm định kỳ'),
	('BT',		N'Bài trích'),
	('BTC',		N'Báo - tạp chí'),
	('GTBG',	N'Giáo trình, bài giảng'),
	('LATS',	N'Luận án Tiến sĩ'),
	('LVThS',	N'Luận văn Thạc sĩ'),
	('Sa',		N'Sách'),
	('TLNC',	N'Tài liệu nghiên cứu khoa học')

--Thêm dữ liệu mẫu vào bảng Nhà cung cấp
INSERT INTO Nhacungcap VALUES
	('NCC01',N'Công Ty Cổ Phần Phát Hành Sách Tp. HCM', N'60-62 Lê Lợi, P. Bến Nghé, Q. 1, TPHCM','02838225798','www.nhasachtritue.com'),
	('NCC02',N'Trí Tuệ - Công Ty Cổ Phần Sách & Thiết Bị Giáo Dục Trí Tuệ',N'187 Giảng Võ, Q. Đống Đa, Hà Nội', '02438515567','www.nhasachtritue.com'),
	('NCC03',N'Công Ty TNHH Văn Hóa Việt Long',N'14/35, Đào Duy Anh, P.9, Q. Phú Nhuận,Tp.HCM','02838452708','www.vietlongbook.com'),
	('NCC04',N'Công Ty TNHH Đăng Nguyên', N'Thôn Đức Mỹ, X. Suối Nghệ, H. Châu Đức, Bà Rịa-Vũng Tàu','02543716857','www.bachdangbook.com/'),
	('NCC05',N'Công Ty Cổ Phần Sách Giáo Dục Tại Thành Phố Hà Nội',N'Công Ty Cổ Phần Sách Giáo Dục Tại Tp.Hà Nội', '02462534308',''),
	('NCC06',N'Công Ty Cổ Phần Dịch Vụ Xuất Bản Giáo Dục Hà Nội',N'Tầng 4 Tòa Nhà Diamond Flower Tower 48 Lê Văn Lương, P. Nhân Chính, Q. Thanh Xuân Hà Nội','02435121977','www.xbgdhn.vn'),
	('NCC07',N'Trường Đại học Tài chính - Marketing', N'778 Nguyễn Kiệm, P.4, Q. Phú Nhuận, TP Hồ Chí Minh','02839976462','thuvien.ufm.edu.vn')

--Thêm dữ liệu mẫu vào bảng Đầu sách
INSERT INTO Dausach VALUES 
	('08667','APDK', N'Kinh tế và dự báo', N'Bộ Kế hoạch và đầu tư', N'Hà Nội', N'Tạp chí Kinh tế và Dự báo là Cơ quan của Bộ Kế hoạch và Đầu tư, phát hành số đầu tiên vào tháng 10 năm 1967 trên toàn quốc. Tạp chí Kinh tế và Dự báo hoạt động theo Giấy phép hoạt động báo chí in số 115/GP-BTTTT, ngày 14/5/2014 của Bộ trưởng Bộ Thông tin và Truyền thông, được xuất bản bằng tiếng Việt và tiếng Anh.'),
	('08683','APDK', N'Thời báo Kinh tế Sài gòn', N'Sở Công thương Tp. HCM', N'Tp.HCM', N'Tạp chí Kinh tế Sài Gòn (Saigon Times Group) là tên gọi chung của một Tạp chí gồm ba tạp chí tiếng Việt (Tạp chí Kinh tế Sài Gòn; Tạp chí Kinh tế Sài Gòn Online; Sài Gòn Tiếp thị Online); hai tạp chí tiếng Anh (Saigon Times Weekly; The Saigon Times), phụ trương quảng cáo Thị trường Địa ốc; hai tổ chức phi lợi nhuận là Saigon Times Club và Saigon Times Foundation'),
	('25754','APDK', N'Phát triển kinh tế', N'Đại học Kinh tế Tp.HCM', N'Thành phố Hồ Chí Minh', N'Tạp chí khoa học kinh tế xuất bản hàng tháng'),
	('26774','BT', N'Chiến lược phân phối sản phẩm của Công ty TNHH Gia Minh Hưng: Thực trạng và giải pháp', N'Nguyễn Thị Ngọc Trinh', N'Tp.HCM', N'Bậc Trung cấp K37'),
	('26761','BT', N'Một số biện pháp phòng ngừa và hạn chế rủi ro tín dụng tại Ngân hàng', N'Đặng Thị Thu Thùy', N'Tp.HCM', N'Bậc cao đẳng C11'),
	('26762','BT',N'Phát triển cho vay tiêu dùng tại Ngân hàng Thương mại Cổ phần Á Châu', N'Lê Thanh Thủy', N'Tp.HCM',N'Bậc cao đẳng C11'),
	('15142','BTC',N'Những vấn đề kinh tế & chính trị thế giới', N'Viện Hàn lâm Khoa học Xã hội Việt Nam', N'Hà Nội', N'Những vấn đề kinh tế thế giới do Viện Hàn lâm Khoa học Xã hội Việt Nam. Viện Kinh tế và Chính trị thế giới viết'),
	('14980','BTC', N'Thế giới phụ nữ. 15 : Phụ nữ Việt Nam', N'Báo Phụ nữ Việt Nam', N'Hà Nội', N'Tạp chí Thế giới phụ nữ xuất bản hàng tuần từ Báo Phụ nữ Việt Nam'),
	('32208','GTBG',N'Toán cơ sở cho kinh tế', N'Nguyễn Huy Hoàng (chủ biên); Nguyễn Trung Đông',N'TP. HCM : Trường Đại học Tài chính - Marketing', N'Cuốn sách này có 4 chương và phụ lục tính toán ma trận bằng máy tính cá nhân, phụ lục một số thuật ngữ then chốt Anh - Việt, cùng một số đề tham khảo để sinh viên có thể rèn luyện'),
	('32206','GTBG', N'Giáo trình khai phá dữ liệu', N'Tôn Thất Hòa An (chủ biên); Cao Thị Nhạn', N'TP. HCM : Trường Đại học Tài chính - Marketing',N'Cuốn sách này có 9 chương được biên soạn nhằm cung cấp kiến thức cơ sở cho tiến trình khám phá tri thức từ dữ liệu.'),
	('31908','GTBG', N'Tài liệu học tập đào tạo nhân viên trong khách sạn - nhà hàng', N'Tổng cục du lịch', N'TP. Hồ Chí Minh : UFM', N'Dự án phát triển nguồn nhân lực Du lịch Việt Nam: Chương trình phát triển đào tạo viên - kỹ năng đào tạo.'),
	('32148','LATS', N'Thuế và đầu tư trực tiếp nước ngoài tại các quốc gia đang phát triển', N'Nguyễn Thị Kim Chi', N' Giáo dục Việt Nam', N'Đầu tư trực tiếp nước ngoài đã và đang tác động mạnh đến nền kinh tế thế giới trong nhiều năm qua và là một chủ đề quan trọng đối với các quốc gia đang phát triển. Để thu hút đầu tư trực tiếp nước ngoài một cách hiệu quả, hầu hết các nước phải điều chỉnh chính sách thuế và pháp luật thuế, nổi bật với xu hướng cạnh tranh về thuế với các nước láng giềng, hoặc các quốc gia cùng điều kiện phát triển về kinh tế, xã hội. Trong đó, so với các loại thuế khác, thuế thu nhập doanh nghiệp là loại thuế trực thu, có cơ sở tính thuế là thu nhập chịu thuế của các doanh nghiệp, nên có ý nghĩa điều tiết rất nhạy cảm, có tác động sâu rộng đến hoạt động sản xuất kinh doanh, kể cả doanh nghiệp nhận đầu tư trực tiếp từ nước ngoài.'),
	('32147','LATS', N'Tác động của quản trị công ty đến thành quả công ty cổ phần Việt Nam', N'Phạm Đức Huy', N' Giáo dục Việt Nam',N'Luận án kiểm tra tác động của quản trị công ty đến thành quả công ty qua các giai đoạn của vòng đời doanh nghiệp. Dữ liệu được thu thập từ báo cáo tài chính, báo cáo quản trị, báo cáo thường niên của 415 công ty phi tài chính niêm yết trên HSX và HNX giai đoạn 2012-2019. Luận án kế thừa mô hình của Anthony và Ramesh (1992), Y. Li và Zhang (2018) nhằm phân loại dữ liệu thành 3 giai đoạn của vòng đời doanh nghiệp bao gồm: giai đoạn tăng trưởng, trưởng thành và suy thoái.'),
	('31782','LATS',N'Tác động của giá trị tiêu dùng và tính đổi mới của người tiêu dùng', N'Dư Thị Chung; Ngô Thị Thu', N'TP.HCM', N'Đề tài tìm hiểu tác động đồng thời của giá trị tiêu dùng, tính đổi bẩm sinh tính đổi mới theo sản phẩm đến ý định chấp nhận và hành vi chấp nhận sản phẩm mới. Phương pháp nghiên cứu được sử dụng trong đề tài gồm cả nghiên cứu định tính và định lượng. Dữ liệu trong nghiên cứu định tính được thu thập thông qua các cuộc thảo luận với 8 chuyên gia và 16 người tiêu dùng, dữ liệu trong nghiên cứu định lượng được thu thập qua việc khảo sát 915 người tiêu dùng các sản phẩm điện tử cá nhân, địa điểm tại Thành phố Hồ Chí Minh.'), 
	('32231','LVThS',N'Ảnh hưởng của các giá trị cảm nhận của khách hàng', N' La Thị Bích Hiền', N'TP. Hồ Chí Minh',N'Luận văn'),
	('32228','LVThS',N'Các yếu tố ảnh hưởng đến ý định của khách hàng sử dụng dịch vụ', N'Nguyễn Hoàng Bảo Ngọc', N'TP. Hồ Chí Minh', N'Luận văn phân tích, xác định các yếu tố ảnh hưởng đến ý định của khách hàng sử dụng dịch vụ khám chữa bệnh từ đó đề xuất hướng xây dựng chiến lược khuyến khích bệnh nhân chọn sử dụng dịch vụ khám chữa bệnh tại Bệnh viện Trưng Vương.'),
	('32314','Sa',N'Đi bộ và sức khỏe',N'Nguyễn Ngọc Kim Anh',N'Hà Nội : Thể thao và Du lịch',N'Trình bày những kiến thức cơ bản về vai trò đi bộ trong rèn luyện sức khỏe, lợi ích , kỹ thuật đi bộ thể thao'),
	('32283','Sa',N'Financial Management: Core Concepts',N'Brooks, Raymond',N'Harlow : Pearson',N'Includes bibliographical references and index'),
	('30827','TLNC',N'Nghiên cứu các yếu tố ảnh hưởng đến ý định mua hàng Việt của người tiêu dùng Việt tại TPHCM',N'Nguyễn Hà Phương Trâm...[và nh.ng. khác] thực hiện',N'TP. Hồ Chí Minh',N'Báo cáo tổng kết đề tài nghiên cứu khoa học của sinh viên, Lĩnh vực nghiên cứu : marketing'),
	('30824','TLNC',N'Tác động của social media và hallyu đến quyết định mua sản phẩm Hàn Quốc',N'Trương Thị Hồng thực hiện', N'TP. Hồ Chí Minh ', N'Báo cáo tổng kết đề tài nghiên cứu khoa học của sinh viên tham gia xét giải thưởng "Tài năng Kinh tế trẻ" - Lần 7, 2018'),
	('30821','TLNC',N'Nghiên cứu các yếu tố ảnh hưởng đến quyết định lựa chọn HomeStay', N'Lê Nhật Khả Vy thực hiện', N'TP. Hồ Chí Minh', N'Báo cáo tổng kết đề tài nghiên cứu khoa học của sinh viên, Lĩnh vực nghiên cứu: Khoa học xã hội'),
	('30817','TLNC',N'Analysis of the profitability of Hiep Luc Co.LTD', N'Nguyễn Lê Thanh Hằng... [et al.]',N'Ho Chi Minh city', N'Scientific research includes bibliographical references and indexs')

--Thêm dữ liệu mẫu vào bảng Sách
INSERT INTO Sach VALUES
	('S0001','08667',8,26000,2020,''),
	('S0002','08667',7,27000,2023,''),
	('S0003','08683',3,25000,2014,''),
	('S0004','25754',2,30000,2019,''),
	('S0005','26774',2,30000,2020,''),
	('S0006','26761',1,30000,2014,''),
	('S0007','26762',2,30000,2014,''),
	('S0008','15142',0,45000,2023,''),
	('S0009','15142',2,45000,2022,''),
	('S0010','14980',4,13800,2015,''),
	('S0011','14980',9,16000,2020,''),
	('S0012','32208',30,30000,2022,''),
	('S0013','32206',40,30000,2022,''),
	('S0014','31908',20,30000,2022,''),
	('S0015','32148',15,40000,2022,''),
	('S0016','32147',10,40000,2022,''),
	('S0017','31782',6,40000,2022,''),
	('S0018','32231',5,50000,2022,''),
	('S0019','32228',2,50000,2022,''),
	('S0020','32314',5,0,2022, N'Được tặng'),
	('S0021','32283',1,0,2016, N'Được tặng'),
	('S0022','30827',1,30000,2018,''),
	('S0023','30824',1,30000,2018,''),
	('S0024','30821',2,60000,2018,''),
	('S0025','30817',1,30000,2020,'')

--Thêm dữ liệu mẫu vào bảng Độc giả
INSERT INTO DocGia VALUES 
	('DG001', N'Nguyễn Thị Minh', '2004-03-12', N'Nữ', '0915007408', N'Q1, Tp.HCM',  N'Sinh viên'),
	('DG002', N'Nguyễn Thị Ngọc', '2003-03-12',N'Nữ','098123123', N'Phú Nhuận, Tp.HCM',  N'Sinh viên'),
	('DG003', N'Trần Anh Tuấn', '2002-05-20', 'Nam', '091321321', N'Q1, Tp.HCM',  N'Sinh viên'),
	('DG004', N'Lê Nam Mạnh', '2002-08-20', 'Nam', '090312312', N'Thanh Xuân, Hà Nội',  N'Sinh viên'),
	('DG005', N'Nguyễn Quốc Khánh', '2004-08-14','Nam', '0936868946', N'Bình Thạnh, Tp.HCM', N'Sinh viên'),
	('DG006', N'Nguyễn Duy', '2001-06-14', 'Nam', '090812812', N'Củ Chi, Tp.HCM', N'Sinh viên'),
	('DG007', N'Nguyễn Xuân Hùng', '2003-10-9', 'Nam', '0915007602',  N'Hóc Môn, Tp.HCM',N'Sinh viên'),
	('DG008', N'Nguyễn Xuân Dũng', '1978-7-9', 'Nam', '0915000233', N'Cam Ranh, Nha Trang', N'Giảng viên'),
	('DG009', N'Nguyễn Quốc Hùng', '1982-7-7', 'Nam', '0915007802',  N'Long Thành, Đồng Nai', N'Giảng viên'),
	('DG010', N'Nguyễn Mai Hồng', '1986-11-9', N'Nữ', '0975017602', N'Củ Chi, Tp.HCM', N'Giảng viên'),
	('DG011', N'Phạm Minh Tâm', '1991-02-25', 'Nam', '0321452167', N'Đức Huệ, Long An', N'Giảng viên'),
	('DG012', N'Trần Xuân Anh','1985-6-19', 'Nam', '0913007609',  N'Bến Cát, Bình Dương', N'Giảng viên'),
	('DG013', N'Trần Quốc An','1984-8-19', 'Nam', '0923007609', N'Dĩ An, Bình Dương', N'Giảng viên'),
	('DG014', N'Nguyễn Trà Giang', '1992-02-02', N'Nữ', '0907898867', N'Thuận An, Bình Dương', N'Giảng viên'),
	('DG015', N'Lê Văn Thịnh', '1990-02-02', 'Nam', '09365428761', N'',  N'Giảng viên'),
	('DG016', N'Lê Đức Minh', '1989-02-02','Nam', '0934521896', N'Bến Lức, Long An',  N'Nhân viên'),
	('DG017', N'Lê Văn Khương', '1990-02-02','Nam','0864123571', N'Châu Thành, Long An',  N'Nhân viên'),
	('DG018', N'Mai Hoàng Đức', '1992-02-02','Nam','0987132468', N'Dầu Tiếng, Bình Dương',  N'Nhân viên'),
	('DG019', N'Võ Cẩm Nhung', '1997-02-02',N'Nữ', '0362122358', N'Quận 12,Tp.HCM', N'Nhân viên'),
	('DG020', N'Trần Việt Hưng', '1991-02-02','Nam','0245612879', N'Bình Thạnh, Tp.HCM', N'Nhân viên')

--Thêm dữ liệu mẫu vào bảng Thủ thư
INSERT INTO ThuThu VALUES
	('TT001', N'Nguyễn Quang Khải', '1980-10-12', 'Nam', '0975007632', N'Q1 , Tp.HCM'),
	('TT002', N'Trần Xuân Hương','1979-7-9', N'Nữ','0935000433', N'Phú Giáo, Bình Dương'),
	('TT003', N'Nguyễn Quốc Đạt', '1978-7-7', 'Nam','0985007802', N'Diên Khánh, Nha Trang'),
	('TT004', N'Nguyễn Mai Quyên','1981-11-9', N'Nữ','0975017688', N'Trảng Bom, Đồng Nai'),
	('TT005', N'Trần Mai Thanh','1985-12-9', N'Nữ', '0935666602',N'Tân Uyên, Bình Dương'),
	('TT006', N'Phạm Xuân Anh', '1984-6-19', 'Nam','0913007677', N'Q2 , Tp.HCM'), 
	('TT007', N'Phạm Ngọc Anh','1984-6-15', 'Nam','0913447677', N'Q3 , Tp.HCM'),
	('TT008', N'Đỗ Ngọc Linh','1985-3-9', N'Nữ', '02116584443', N'Ninh Hòa, Nha Trang'),
	('TT009', N'Hoàng Khánh Hưng ', '1982-8-11','Nam', '02116584444' ,N'Q1 , Tp.HCM'),
	('TT010', N'Nguyễn Thế Duy', '1988-10-9', 'Nam', '0354879621', N'Cẩm Mỹ, Đồng Nai'),
	('TT011', N'Lê Thị Cúc', '1989-05-04', N'Nữ', '092987987', N'Củ Chi, Tp.HCM'),
	('TT012', N'Mai Minh Mẫn','1990-03-07', N'Nữ', '098789789', N'Q9, Tp.HCM'),
	('TT013', N'Võ Tú Hoàng', '2000-09-08', 'Nam', '091234234', N'Phú Đông, Tiền Giang'),
	('TT014', N'Trần Hữu Thắng', '1985-05-12', 'Nam', '092678678', N'Tân Phú, Đồng Nai'),
	('TT015', N'Nguyễn Duy Hưng', '1987-03-05', 'Nam', '098456654', N'67 Kỳ Đồng'),
	('TT016', N'Mai Thị Lựu', '1992-03-17', N'Nữ', '09181831444',N'Tân Trụ, Long An'),
	('TT017', N'Đào Thị Hồng', '1989-03-07', N'Nữ', '09754322222', N'Phú Nhuận, Tp.HCM'),
	('TT018', N'Phan Thành Nhân', '1987-02-4', N'Nữ','09135332332', N'Cai Lậy, Tiền Giang'),
	('TT019', N'Phan Ánh Dương', '1989-08-03', N'Nữ','09812127678',N'Mộc Hóa, Long An'),
	('TT020', N'Phan Ánh Nguyệt', '1990-01-08', N'Nữ','09812342356', N'Thuận AN, Bình Dương')

--Thêm dữ liệu mẫu vào bảng Thẻ thư viện
INSERT INTO TheThuVien VALUES
	('TTV01','DG001','2027-12-31'),
	('TTV02','DG002','2025-12-31'),
	('TTV03','DG003','2025-12-31'),
	('TTV04','DG004','2024-12-31'),
	('TTV05','DG005','2026-12-31'),
	('TTV06','DG006','2023-12-31'),
	('TTV07','DG007','2026-12-31'),
	('TTV08','DG008','2028-12-31'),
	('TTV09','DG009','2026-12-31'),
	('TTV10','DG010','2030-12-31'),
	('TTV11','DG011','2030-12-31'),
	('TTV12','DG012','2027-12-31'),
	('TTV13','DG013','2028-12-31'),
	('TTV14','DG014','2030-12-31'),
	('TTV15','DG015','2030-12-31'),
	('TTV16','DG016','2029-12-31'),
	('TTV17','DG017','2030-12-31'),
	('TTV18','DG018','2030-12-31'),
	('TTV19','DG019','2030-12-31'),
	('TTV20','DG020','2030-12-31')

--Thêm dữ liệu mẫu vào bảng Phiếu Mượn
INSERT INTO PhieuMuon VALUES 
	('PM001', 'DG001', 'TT001', '2022-01-09', '2022-01-19'),
	('PM002', 'DG005', 'TT002', '2022-02-09', '2022-02-19' ),
	('PM003', 'DG009', 'TT004', '2022-02-10', '2022-02-20'),
	('PM004', 'DG011', 'TT012', '2022-02-11', '2022-02-21'),
	('PM005', 'DG003', 'TT006', '2022-03-01', '2022-03-11'),
	('PM006', 'DG002', 'TT011', '2022-04-14', '2022-04-24'),
	('PM007', 'DG001', 'TT005', '2022-08-06', '2022-08-16'),
	('PM008', 'DG002', 'TT001', '2023-01-16', '2023-01-26'),
	('PM009', 'DG008', 'TT007', '2023-02-03', '2023-02-13'),
	('PM010', 'DG011', 'TT001', '2023-02-15', '2023-02-25'),
	('PM011', 'DG012', 'TT008', '2023-02-17', '2023-02-27'),
	('PM012', 'DG017', 'TT010', '2023-03-01', '2023-03-11'),
	('PM013', 'DG009', 'TT004', '2023-03-09', '2023-03-19'),
	('PM014', 'DG018', 'TT012', '2023-03-11', '2023-03-21'),
	('PM015', 'DG020', 'TT011', '2023-03-12', '2023-03-22'),
	('PM016', 'DG005', 'TT019', '2023-04-05', '2023-04-15'),
	('PM017', 'DG003', 'TT015', '2023-04-10', '2023-04-20'),
	('PM018', 'DG008', 'TT017', '2023-04-11', '2023-04-21'),
	('PM019', 'DG004', 'TT018', '2023-04-15', '2023-04-25'),
	('PM020', 'DG006', 'TT004', '2023-04-19', '2023-04-29')

--Thêm dữ liệu mẫu vào bảng Chi tiết Phiếu Mượn
INSERT INTO CTPhieuMuon VALUES 
	('PM001', 'S0001'),
	('PM001', 'S0002'),
	('PM001', 'S0003'),
	('PM002', 'S0002'),
	('PM003', 'S0006'),
	('PM003', 'S0007'),
	('PM004', 'S0008'),
	('PM005', 'S0010'),
	('PM005', 'S0011'),
	('PM006', 'S0012'),
	('PM007', 'S0013'),
	('PM007', 'S0014'),
	('PM008', 'S0015'),
	('PM009', 'S0016'),
	('PM010', 'S0017'),
	('PM011', 'S0018'),
	('PM012', 'S0019'),
	('PM013', 'S0020'),
	('PM013', 'S0013'),
	('PM014', 'S0014'),
	('PM014', 'S0015'),
	('PM015', 'S0016'),
	('PM016', 'S0017'),
	('PM017', 'S0018'),
	('PM018', 'S0019'),
	('PM019', 'S0020'),
	('PM020', 'S0003'),
	('PM020', 'S0002')

--Thêm dữ liệu mẫu vào bảng Phiếu Trả
INSERT INTO PhieuTra VALUES 
	('PT001', 'PM001', '2022-07-19'),
	('PT002', 'PM002', '2022-04-19'),
	('PT003', 'PM003', '2023-02-21'),
	('PT004', 'PM004', '2022-04-19'),
	('PT005', 'PM005', '2022-03-14'),
	('PT006', 'PM006', '2022-04-16'),
	('PT007', 'PM007', '2022-08-26'),
	('PT008', 'PM008', '2023-02-16'),
	('PT009', 'PM009', '2023-03-14'),
	('PT010', 'PM010', '2023-02-25'),
	('PT011', 'PM011', '2023-03-01'),
	('PT012', 'PM012', '2023-04-12'),
	('PT013', 'PM013', '2023-03-28'),
	('PT014', 'PM014', '2023-04-20'),
	('PT015', 'PM015', '2023-04-14')

--Thêm dữ liệu vào bảng Trễ hạn theo quy tắc:
--ngaymuon từ bảng PhieuMuon
--ngaytra từ bảng PhieuTra
--Chỉ thêm vào bảng những sách đã mượn quá 10 ngày (gồm 2 trường hợp):
--TH1: sách đã mượn nhưng chưa được trả (Có PhieuMuon nhưng không có PhieuTra)
--TH2: sách đã mượn và đã trả (Có PhieuMuon và có PhieuTra)
INSERT INTO TreHan (MaM, MaT, MaSach, Ngaymuon, Ngayhethan, Ngaytra, Songaytrehan)
SELECT PM.MaM, PT.MaT, CT.MaSach, PM.Ngaymuon, PM.Ngayhethan, PT.Ngaytra, 
    CASE
        -- Nếu có phieutra, songaytrehan = ngaytra - ngayhethan
        WHEN DATEDIFF(day, PM.Ngaymuon, PT.Ngaytra) > 10 THEN DATEDIFF(day, PM.Ngayhethan, PT.Ngaytra)
		-- Nếu chưa có phieutra, songaytrehan = ngayhientai - ngayhethan
        ELSE DATEDIFF(day, PM.Ngayhethan, GETDATE())
    END AS Songaytrehan
FROM PhieuMuon PM
LEFT JOIN PhieuTra PT ON PM.MaM = PT.MaM
JOIN CTPhieuMuon CT ON PM.MaM = CT.MaM
WHERE (DATEDIFF(day, PM.Ngaymuon, GETDATE()) > 10 OR (PT.MaT IS NULL AND DATEDIFF(day, PM.Ngaymuon,GETDATE()) > 10))
  AND NOT EXISTS (
        SELECT 1 FROM TreHan TH
        WHERE TH.MaM = PM.MaM AND TH.MaSach = CT.MaSach
	)

--Thêm dữ liệu mẫu vào bảng Phiếu Nhập
INSERT INTO PhieuNhap values
	('PN001','NCC01','TT002'),
	('PN002','NCC02','TT005'),
	('PN003','NCC03','TT007'),
	('PN004','NCC04','TT009'),
	('PN005','NCC05','TT010'),
	('PN006','NCC06','TT013'),
	('PN007','NCC07','TT017')

--Thêm dữ liệu mẫu vào bảng Chi tiết Phiếu Nhập
INSERT INTO CTPhieuNhap values
	('PN001', '25754', 2,60000),
	('PN001', '31782',6,240000),
	('PN002', '08667', 15,397000),  
	('PN002','26762',2,60000),
	('PN002', '32148',15,600000),
	('PN003', '08683', 3,75000), 
	('PN003', '32228',2,100000),
	('PN004', '26774',2,60000),
	('PN004', '26761',1,30000),
	('PN005', '15142',2,90000),
	('PN005','32147',10,400000),
	('PN006', '14980',13,199200),
	('PN007','32208',30,900000),
	('PN007','32206',40,1200000),
	('PN007', '31908',20,600000),
	('PN007','30827',1,30000),
	('PN007','30824',1,30000),
	('PN007','30821',2,60000),
	('PN007','30817',1,30000)

--CHƯƠNG 4: ỨNG DỤNG
--4.1 SYNONYM
--4.1.1.Tạo synonym cho bảng Sach
create synonym s
for dbo.Sach

--Kiểm thử
select *
from s

--4.1.2.Tạo synonym cho bảng DocGia
create synonym DG
for dbo.DocGia

--Kiểm thử
select *
from DG

--4.1.3.Tạo synonym cho bảng TreHan
create synonym TH
for dbo.TreHan

--Kiểm thử
select *
from TH

--4.2 INDEX
--4.2.1 Tạo chỉ mục cho tên thủ thư trong bảng thủ thư
create index index_HoTenTT
on ThuThu(HoTenTT)

--Kiểm thử
Select *
From ThuThu
With (index(index_HoTenTT))

Select *
From ThuThu

--4.2.2 Tạo chỉ mục cho tên Tên sách, tác giả trong bảng Dausach
create index index_TSTG
on Dausach(TenSach, Tacgia)

--Kiểm thử
Select *
From Dausach
With (index(index_TSTG))

Select *
From Dausach

--4.3 VIEW
/*4.3.1 Tạo view vwLuanVanThacSi với các thông tin: ISBN, TenSach, TacGia, 
ThongTinSach các đầu sách thuộc thể loại Luận văn Thạc sĩ*/
create view vwLuanVanThacSi as
select ISBN, TenSach, TacGia, ThongTinSach
from Dausach join TheLoai on Dausach.MaLoai = TheLoai.MaLoai
where TenLoai like N'Luận văn Thạc sĩ'

--kiểm thử:
select * from vwLuanVanThacSi

/*4.3.2 Tạo view vwSoLuongSachtheoTL với các thông tin: ISBN, TenLoai, MaSach,
TenSach, Soluong cho biết tổng số lượng sách theo từng loại đầu sách*/
CREATE VIEW vwSoLuongSachtheoTL AS
SELECT Dausach.ISBN, TenLoai, MaSach, TenSach, SUM(Soluong) as N'Số lượng'
FROM TheLoai join Dausach on  Dausach.MaLoai = TheLoai.MaLoai
	 join Sach on Sach.ISBN = Dausach.ISBN
GROUP BY Dausach.ISBN, TenLoai, MaSach, TenSach

--kiểm thử:
select * from vwSoLuongSachtheoTL

/*4.3.3 Tạo view vwSLSachMuon với các thông tin: Tháng, Năm, Số lượng thể hiện
danh sách các tháng năm có số lượng sách mượn > 3*/
CREATE VIEW vwSLSachMuon AS
SELECT MONTH(NgayMuon) AS Thang, YEAR(NgayMuon) AS Nam, COUNT(*) AS SoLuong
FROM PhieuMuon
GROUP BY MONTH(NgayMuon),YEAR(NgayMuon)
HAVING COUNT(*) > 3

--kiểm thử:
select * from vwSLSachMuon

/*4.3.4 Tạo view vwTreHanHonPM09 để tìm tất cả thông tin trễ hạn có số ngày trễ hạn
lớn hơn số ngày trễ hạn của PM09*/
Create view vwTreHanHonPM09 as 
Select *
from TreHan
where Songaytrehan > ALL (Select Songaytrehan
						   from TreHan
						   where MaM = 'PM009')
--kiểm thử:
select * from vwTreHanHonPM09

--4.4 STORE PROCEDURE
--4.4.1 Tạo thủ tục sp_DGGiangVien liệt kê những độc giả là giảng viên
create proc sp_DGGiangVien as
begin
select * 
from DocGia
where DoiTuong like N'Giảng viên'
end

--Kiểm thử
exec SP_DGGiangVien

--4.4.2 Tạo thủ tục sp_Top3SM cho biết danh sách 3 cuốn sách được mượn nhiều nhất
create proc sp_Top3SM as
select top(3) with ties count(CTPhieuMuon.MaSach) as SoLanMuon, TenSach
from CTPhieuMuon join Sach on CTPhieuMuon.MaSach = Sach.MaSach
		join Dausach on Dausach.ISBN = Sach.ISBN
group by TenSach
order by count(CTPhieuMuon.MaSach) desc

--Kiểm thử
exec sp_Top3SM

--4.4.3 Tạo thủ tục sp_TTDG xem thông tin độc giả với mã độc giả do người dùng nhập
create proc sp_TTDG @MaDG nvarchar(5) as
select *
from DocGia
where MaDG = @MaDG 

--Kiểm thử
exec sp_TTDG 'DG014'

--4.4.4 Tạo thủ tục sp_SLDGtheoDoiTuong  cho biết số lượng độc giả theo đối tượng, với 
--đối tượng do người dùng nhập
CREATE PROC sp_SLDGtheoDoiTuong (@DoiTuong nvarchar(15)) AS
BEGIN
DECLARE @SODG INT
IF EXISTS (SELECT MaDG FROM DocGia WHERE DoiTuong=@DoiTuong)
		   BEGIN 
		   SET @SODG = (SELECT COUNT(MaDG) FROM DocGia where DoiTuong=@DoiTuong
		   GROUP BY DoiTuong)
		   END
		   PRINT N'Số độc giả là đối tượng ' + @DoiTuong + N' là ' + CAST(@SODG AS NCHAR(7))
END

--Kiểm thử
exec  sp_SLDGtheoDoiTuong  N'Nhân viên'

/*4.4.5 Tạo thủ tục sp_TTinTreHan xem thông tin trễ hạn theo khoảng thời gian 
ngày mượn do người dùng yêu cầu. */
create proc sp_TTinTreHan @Tu datetime, @Den datetime as
select *
from TreHan
where (NgayMuon between @Tu and @Den)

--Kiểm thử
exec sp_TTinTreHan '2022-09-01', '2023-02-14'

/*4.4.6 Tạo thủ tục sp_SLSach xem số lượng sách của một đầu sách, nếu số lượng sách > 5 thì thông báo 
“Còn sách”, ngược lại thông báo “Sắp hết sách”, với mã ISBN do người dùng nhập */
create proc sp_SLSach @ISBN nvarchar(5) as
declare @SLSach int
select @SLSach = SUM(SoLuong) from Sach where ISBN = @ISBN
if @SLSach > 5
	begin
	print N'Còn sách'
	end
	else
	print N'Sắp hết sách'
	print N'Số lượng sách: '+cast(@SLSach as nvarchar(10))

--Kiểm thử
exec sp_SLSach '15142'
exec sp_SLSach '08667'

--4.5 FUNCTION
/*4.5.1 Tạo hàm f_TongSLSN cho biết tổng số lượng sách nhập trong từng phiếu nhập 
(gồm thông tin SoPN, MaNCC, Họ tên thủ thư, Tổng số lượng)*/
create function f_TongSLSN()
returns table
as
return (select ctpn.SoPN, MaNCC, HoTenTT, sum(SoLuong) as TongSLSachNhap
		from PhieuNhap pn join CTPhieuNhap ctpn on pn.SoPN=ctpn.SoPN 
			 join ThuThu tt on tt.MaTT = pn.MaTT
		group by ctpn.SoPN, MaNCC, HoTenTT)

--Kiểm thử
select * from f_TongSLSN()

/*4.5.2 Tạo hàm f_SLPMDG cho biết số lượng phiếu mượn theo từng độc giả
(gồm thông tin Mã độc giả, Họ tên độc giả, Số lượng sách mượn)*/
create function f_SLPMDG()
returns table
as
return (select DocGia.MaDG, HoTenDG, count(MaSach) as SLSachMuon
from DocGia join PhieuMuon on DocGia.MaDG = PhieuMuon.MaDG
	 join CTPhieuMuon on CTPhieuMuon.MaM = PhieuMuon.MaM
group by DocGia.MaDG, HoTenDG)

--Kiểm thử
select * from f_SLPMDG()

/*4.5.3 Tạo hàm f_TongSLDSachtheoISBN cho biết tổng số lượng đầu sách với
 tham số truyền vào là mã ISBN*/
create function f_TongSLDSachtheoISBN (@ISBN nvarchar(5))
returns int as
begin
declare @TongSL int
select @TongSL = sum(SoLuong)
from Sach
where ISBN=@ISBN
return @TongSL
end

--Kiểm thử
select dbo.f_TongSLDSachtheoISBN (N'08667')

/*4.5.4 Tạo hàm f_TongSLSachtheoMaM cho biết trong từng phiếu mượn có bao nhiêu 
cuốn sách với tham số truyền vào là mã phiếu mượn*/
create function f_TongSLSachtheoMaM (@MaM nvarchar(5))
returns int
as
begin
declare @TongSLS int
select @TongSLS = count(MaSach)
from CTPhieuMuon
where MaM=@MaM
return @TongSLS
end

--Kiểm thử
select dbo.f_TongSLSachtheoMaM('PM001')

--4.6. TRIGGER
--4.6.1 Tạo trigger tg_CTPhieuNhap, số lượng nhập phải lớn hơn 0
create trigger tg_CTPhieuNhap
on CTPhieuNhap
for insert, update as
if exists (select count(*) from inserted 
			where inserted.Soluong < 0)
begin 
	print (N'Số lượng nhập phải lớn hơn 0')
	rollback tran
end

--Kiểm thử 1
INSERT INTO CTPhieuNhap values ('PN007', '25754', 0,60000)

--Kiểm thử 2
update CTPhieuNhap set Soluong = -35 where SoPN = 'PN001'

--4.6.2 Tạo trigger tg_NmNHH Ngày mượn sách phải nhỏ hơn ngày hết hạn mượn sách
create trigger tg_NmNHH
on PhieuMuon
for insert, update
as
if (select count(*) from inserted
	where inserted.Ngayhethan < inserted.Ngaymuon)> 0
begin 
	print (N'Ngày mượn sách phải nhỏ hơn ngày hết hạn mượn sách')
	rollback tran
end

--Kiểm thử 1
INSERT INTO PhieuMuon VALUES ('PM021', 'DG001', 'TT001', '2022-02-09', '2022-01-19')

--Kiểm thử 2
update PhieuMuon set Ngaymuon = '2023-04-30' where MaM = 'PM001'

--4.6.3 Tạo trigger trg_PM_MaM và trg_CTPM_MaM, mỗi Phiếu mượn phải có ít nhất 1 Chi tiết Phiếu mượn
CREATE TRIGGER trg_PM_MaM
ON PhieuMuon
FOR delete, update as
if (select count(*) from CTPhieuMuon ctpm join deleted on ctpm.MaM = deleted.MaM) <= 0
begin
print (N'Không thể thực hiện vì mỗi Phiếu mượn có ít nhất 1 Chi tiết Phiếu mượn')
rollback tran
end

create trigger trg_CTPM_MaM
on CTPhieuMuon
for insert, update as
if (select count(*) from PhieuMuon pm join inserted on pm.MaM = inserted.MaM) <= 0
begin
print (N'Không thể thực hiện vì mỗi Phiếu mượn phải có ít nhất 1 Chi tiết Phiếu mượn')
rollback tran
end

--Insert dữ liệu mới để kiểm thử
INSERT INTO PhieuMuon VALUES ('PM021', 'DG001', 'TT001', '2022-01-09', '2022-01-19')

--Kiểm thử 1
delete from PhieuMuon where  MaM = 'PM021'
--Kiểm thử 2
update PhieuMuon set MaM = 'PM022' where MaM = 'PM021'
--Kiểm thử 3
update CTPhieuMuon set MaSach = 'S0001' where MaM = 'PM021'

--4.7 USER
--4.7.1 Tạo tài khoản đăng nhập cho Thủ thư
Create login ThuThu1
with password = 'ThuThu1',
default_database = QuanLyThuVienUFM
--Tạo người dùng ThuThu1
Create user ThuThu1 for login ThuThu1
--Cấp các quyền cho ThuThu1
grant select, insert, update, delete to ThuThu1

--4.7.2 Tạo tài khoản đăng nhập cho DocGia
Create login DocGia1
with password = 'DocGia1',
default_database = QuanLyThuVienUFM
--Tạo người dùng DocGia1
Create user DocGia1 for login DocGia1
--Cấp các quyền cho DocGia1
grant select on TheThuVien to DocGia1
grant select on Dausach to DocGia1
grant select on Sach to DocGia1
grant select on TheLoai to DocGia1
grant select on PhieuMuon to DocGia1
grant select on PhieuTra to DocGia1
grant select on TreHan to DocGia1
grant select on vwLuanVanThacSi to DocGia1

--4.7.3 Tạo tài khoản đăng nhập cho Nhà cung cấp
Create login Nhacungcap1
with password = 'Nhacungcap1',
default_database = QuanLyThuVienUFM
--Tạo người dùng Nhacungcap1
Create user Nhacungcap1 for login Nhacungcap1
--Cấp các quyền cho Nhacungcap1
grant select on Dausach to Nhacungcap1
grant select on Sach to Nhacungcap1
grant select on TheLoai to Nhacungcap1
grant select, insert on PhieuNhap to Nhacungcap1
grant select, insert on CTPhieuNhap to Nhacungcap1
grant select on vwSoLuongSachtheoTL to Nhacungcap1

--4.10 REPORT
--4.10.1 Tạo report Report_SoLuongSMTheoNam thống kê số lượng sách mượn theo năm
select Format(Ngaymuon, 'yyyy') as Nam,
count (distinct [MaSach]) as SoLuongSM
into Report_SoLuongSMTheoNam
from CTPhieuMuon join PhieuMuon on CTPhieuMuon.MaM = PhieuMuon.MaM
group by Format(Ngaymuon, 'yyyy')
order by Nam desc

--Kiểm thử
select*
from Report_SoLuongSMTheoNam

--4.10.2 Tạo report Report_SoLuongSMTheoTT thống kê số lượng sách mượn được cho mượn theo từng thủ thư
select ThuThu.MaTT, HoTenTT, count(MaM) as SoLuongSM
into Report_SoLuongSMTheoTT
from ThuThu left join PhieuMuon on ThuThu.MaTT = PhieuMuon.MaTT
group by ThuThu.MaTT, HoTenTT
order by SoLuongSM desc

--Kiểm thử
select*
from Report_SoLuongSMTheoTT

--4.10.3 Tạo report Report_SachMuonTheoDocGia thống kê số sách mượn theo từng khách hàng
select DocGia.MaDG, HoTenDG, count(MaSach) as SoSachMuon
into Report_SachMuonTheoDocGia
from DocGia left join PhieuMuon on DocGia.MaDG = PhieuMuon.MaDG 
	 join CTPhieuMuon on CTPhieuMuon.MaM = PhieuMuon.MaM
group by DocGia.MaDG, HoTenDG
order by SoSachMuon desc

--Kiểm thử
select*
from Report_SachMuonTheoDocGia