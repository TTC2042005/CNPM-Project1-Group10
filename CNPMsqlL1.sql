CREATE DATABASE N10CNPM1;
USE N10CNPM1;
-- Bảng Khách hàng
CREATE TABLE khach_hang (
    ID INT PRIMARY KEY,
    ten_khach_hang NVARCHAR(100),
    lien_he NVARCHAR(100),
    dia_chi NVARCHAR(200),
    so_dien_thoai NVARCHAR(20),
    email NVARCHAR(100),
    mat_khau NVARCHAR(50),
    nhan_vien BIT
);

-- Bảng Danh mục sản phẩm
CREATE TABLE danh_muc_san_pham (
    ID_danh_muc INT PRIMARY KEY,
    ten_danh_muc NVARCHAR(100),
    mo_ta NVARCHAR(255)
);

-- Bảng Sản phẩm
CREATE TABLE san_pham (
    ID INT PRIMARY KEY,
    ten_san_pham NVARCHAR(100),
    nguon_goc NVARCHAR(100),
    ID_danh_muc INT,
    kich_thuoc FLOAT,
    mau_sac NVARCHAR(50),
    gia DECIMAL(18,2),
    FOREIGN KEY (ID_danh_muc) REFERENCES danh_muc_san_pham(ID_danh_muc)
);

-- Bảng Điểm tích lũy
CREATE TABLE diem_tich_luy (
    ID INT PRIMARY KEY,
    ID_khach_hang INT,
    so_diem INT,
    ngay_tich_diem DATE,
    mo_ta NVARCHAR(255),
    FOREIGN KEY (ID_khach_hang) REFERENCES khach_hang(ID)
);

-- Bảng Lịch sử sử dụng điểm
CREATE TABLE lich_su_su_dung_diem (
    ID INT PRIMARY KEY,
    ID_khach_hang INT,
    so_diem_da_su_dung INT,
    mo_ta NVARCHAR(255),
    FOREIGN KEY (ID_khach_hang) REFERENCES khach_hang(ID)
);

-- Bảng Đơn hàng
CREATE TABLE don_hang (
    ID INT PRIMARY KEY,
    ID_khach_hang INT,
    ngay_dat_hang DATE,
    tong_tien DECIMAL(18,2),
    trang_thai NVARCHAR(50),
    phuong_thuc_thanh_toan NVARCHAR(50),
    ID_khuyen_mai INT,
    FOREIGN KEY (ID_khach_hang) REFERENCES khach_hang(ID),
    FOREIGN KEY (ID_khuyen_mai) REFERENCES san_pham_khuyen_mai(ID)
);

-- Bảng Chi tiết đơn hàng (N-N: Đơn hàng và Sản phẩm)
CREATE TABLE chi_tiet_don_hang (
    ID INT PRIMARY KEY,
    ID_don_hang INT,
    ID_san_pham INT,
    so_luong INT,
    gia DECIMAL(18,2),
    FOREIGN KEY (ID_don_hang) REFERENCES don_hang(ID),
    FOREIGN KEY (ID_san_pham) REFERENCES san_pham(ID)
);

-- Bảng Khuyến mãi
CREATE TABLE khuyen_mai (
    ID INT PRIMARY KEY,
    ten_chuong_trinh NVARCHAR(100),
    ngay_bat_dau DATE,
    ngay_ket_thuc DATE,
    chiet_khau DECIMAL(5,2),
    mo_ta NVARCHAR(255)
);

-- Bảng Sản phẩm khuyến mãi (N-N: Sản phẩm và Khuyến mãi)
CREATE TABLE san_pham_khuyen_mai (
    ID INT PRIMARY KEY,
    ID_khuyen_mai INT,
    ID_san_pham INT,
    FOREIGN KEY (ID_khuyen_mai) REFERENCES khuyen_mai(ID),
    FOREIGN KEY (ID_san_pham) REFERENCES san_pham(ID)
);

-- Bảng Cá Koi
CREATE TABLE ca_koi (
    ID INT PRIMARY KEY,
    ten NVARCHAR(100),
    nguon_goc NVARCHAR(100),
    tuoi INT,
    kich_thuoc FLOAT
);

-- Bảng Giống Cá Koi (1-N với Cá Koi)
CREATE TABLE giong_ca_koi (
    ID INT PRIMARY KEY,
    ten_giong NVARCHAR(100),
    mau_sac NVARCHAR(50),
    kich_thuoc FLOAT,
    nhiet_do_song NVARCHAR(50),
    yeu_cau_nuoc NVARCHAR(100),
    y_nghia NVARCHAR(255),
    gia_tri_kinh_te NVARCHAR(100),
    ID_ca_koi INT,
    FOREIGN KEY (ID_ca_koi) REFERENCES ca_koi(ID)
);
-- Bảng Giỏ hàng (N-N: Khách hàng và Sản phẩm)
CREATE TABLE gio_hang (
    ID INT PRIMARY KEY,
    ID_khach_hang INT,
    ID_san_pham INT,
    so_luong INT,
    FOREIGN KEY (ID_khach_hang) REFERENCES khach_hang(ID),
    FOREIGN KEY (ID_san_pham) REFERENCES san_pham(ID)
);

-- Bảng Thông tin ký gửi (1-N: Khách hàng và Cá Koi)
CREATE TABLE thong_tin_ki_gui (
    ID INT PRIMARY KEY,
    ID_khach_hang INT,
    ID_ca_koi INT,
    thoi_gian DATE,
    phi DECIMAL(18,2),
    FOREIGN KEY (ID_khach_hang) REFERENCES khach_hang(ID),
    FOREIGN KEY (ID_ca_koi) REFERENCES ca_koi(ID)
);
--bang vận chuyển
CREATE TABLE van_chuyen (
    ID INT PRIMARY KEY,
    ID_don_hang INT,
    dia_chi NVARCHAR(255),
    ngay_van_chuyen DATE,
    trang_thai NVARCHAR(50),  -- Ví dụ: đang vận chuyển, đã giao, không thành công
    FOREIGN KEY (ID_don_hang) REFERENCES don_hang(ID)
);
--bang cao cham sóc
CREATE TABLE bao_cao_cham_soc (
    ID INT PRIMARY KEY,
    ID_ca_koi INT,
    ngay_cham_soc DATE,
    loai_cham_soc NVARCHAR(100),  -- Ví dụ: cho ăn, thay nước, kiểm tra sức khỏe
    mo_ta NVARCHAR(255),
    FOREIGN KEY (ID_ca_koi) REFERENCES ca_koi(ID)
);

-- Bảng Khách hàng
INSERT INTO khach_hang (ID, ten_khach_hang, lien_he, dia_chi, so_dien_thoai, email, mat_khau, nhan_vien)
VALUES
(1, N'Nguyễn Văn A', N'Zalo', N'123 Đường A, Hà Nội', N'0123456789', N'nguyenvana@gmail.com', 'abc123', 0),
(2, N'Lê Thị B', N'Viber', N'456 Đường B, Đà Nẵng', N'0987654321', N'lethib@gmail.com', '123abc', 0),
(3, N'Trần Văn C', N'Facebook', N'789 Đường C, TP.HCM', N'0911222333', N'tranvanc@gmail.com', 'password', 0),
(4, N'Hoàng Thị D', N'Zalo', N'12 Đường D, Cần Thơ', N'0933445566', N'hoangthid@gmail.com', 'qwerty', 1),
(5, N'Phạm Văn E', N'Email', N'34 Đường E, Hải Phòng', N'0909090909', N'phamvane@gmail.com', '123456', 0),
(6, N'Đỗ Thị F', N'SMS', N'56 Đường F, Hà Nội', N'0888888888', N'dothif@gmail.com', 'abcabc', 0),
(7, N'Lý Văn G', N'Zalo', N'78 Đường G, Nha Trang', N'0777777777', N'lyvang@gmail.com', '123qwe', 1),
(8, N'Tô Thị H', N'Facebook', N'90 Đường H, Bình Dương', N'0666666666', N'tothih@gmail.com', 'admin123', 0);

INSERT INTO danh_muc_san_pham (ID_danh_muc, ten_danh_muc, mo_ta)
VALUES
(1, N'Cá Koi Nhật Bản', N'Các loại cá Koi có nguồn gốc từ Nhật Bản, chất lượng cao và giá trị kinh tế lớn'),
(2, N'Cá Koi Việt Nam', N'Cá Koi được lai tạo và nuôi dưỡng tại Việt Nam với giá thành hợp lý'),
(3, N'Thức ăn cho Cá Koi', N'Sản phẩm thức ăn chuyên dụng giúp cá Koi phát triển khỏe mạnh và lên màu đẹp'),
(4, N'Phụ kiện hồ cá Koi', N'Thiết bị và phụ kiện như bơm nước, hệ thống lọc, đèn UV cho hồ cá Koi'),
(5, N'Dịch vụ chăm sóc Cá Koi', N'Dịch vụ vệ sinh hồ, kiểm tra sức khỏe, và điều trị bệnh cho cá Koi'),
(6, N'Cá Koi mini', N'Cá Koi kích thước nhỏ phù hợp với hồ nhỏ hoặc bể kiểng trong nhà'),
(7, N'Cá Koi cao cấp', N'Cá Koi kích thước lớn, màu sắc nổi bật, thường dành cho người sưu tầm chuyên nghiệp'),
(8, N'Hồ nuôi cá Koi', N'Dịch vụ thiết kế và xây dựng hồ nuôi cá Koi đạt tiêu chuẩn');


-- Bảng Sản phẩm (Cá Koi)
INSERT INTO san_pham (ID, ten_san_pham, nguon_goc, ID_danh_muc, kich_thuoc, mau_sac, gia)
VALUES
(1, N'Cá Koi Kohaku', N'Nhật Bản', 1, 20.0, N'Đỏ-Trắng', 5000000),
(2, N'Cá Koi Showa', N'Nhật Bản', 1, 25.0, N'Đen-Đỏ-Trắng', 7000000),
(3, N'Cá Koi Sanke', N'Nhật Bản', 1, 22.0, N'Đỏ-Trắng-Đen', 6000000),
(4, N'Cá Koi Utsuri', N'Nhật Bản', 1, 18.0, N'Vàng-Đen', 4000000),
(5, N'Cá Koi Bekko', N'Nhật Bản', 1, 20.0, N'Trắng-Đen', 4500000),
(6, N'Cá Koi Asagi', N'Nhật Bản', 1, 30.0, N'Xanh-Đỏ', 8000000),
(7, N'Cá Koi Tancho', N'Nhật Bản', 1, 22.0, N'Trắng với đốm đỏ', 9000000),
(8, N'Cá Koi Ogon', N'Nhật Bản', 1, 28.0, N'Vàng kim loại', 10000000);

-- Bảng Điểm tích lũy
INSERT INTO diem_tich_luy (ID, ID_khach_hang, so_diem, ngay_tich_diem, mo_ta)
VALUES
(1, 1, 100, '2024-01-01', N'Tích lũy khi mua hàng'),
(2, 2, 200, '2024-01-05', N'Tích lũy khi giới thiệu bạn bè'),
(3, 3, 150, '2024-01-10', N'Tích lũy khi đánh giá sản phẩm'),
(4, 4, 300, '2024-01-15', N'Tích lũy khi tham gia sự kiện'),
(5, 5, 50, '2024-01-20', N'Tích lũy khi mua hàng lần đầu'),
(6, 6, 75, '2024-01-25', N'Tích lũy khi thanh toán online'),
(7, 7, 125, '2024-01-30', N'Tích lũy khi quay lại mua hàng'),
(8, 8, 175, '2024-02-01', N'Tích lũy khi sử dụng mã khuyến mãi');
INSERT INTO lich_su_su_dung_diem (ID, ID_khach_hang, so_diem_da_su_dung, mo_ta)
VALUES
(1, 1, 50, N'Sử dụng điểm để giảm giá'),
(2, 2, 100, N'Sử dụng điểm để đổi quà'),
(3, 3, 30, N'Sử dụng điểm cho đơn hàng đặc biệt'),
(4, 4, 150, N'Sử dụng điểm để mua hàng online'),
(5, 5, 20, N'Sử dụng điểm giảm giá sản phẩm'),
(6, 6, 50, N'Sử dụng điểm thanh toán'),
(7, 7, 70, N'Sử dụng điểm tại cửa hàng'),
(8, 8, 90, N'Sử dụng điểm để đổi phiếu mua hàng');
INSERT INTO don_hang (ID, ID_khach_hang, ngay_dat_hang, tong_tien, trang_thai, phuong_thuc_thanh_toan, ID_khuyen_mai)
VALUES
(1, 1, '2024-02-01', 1500000, N'Đang xử lý', N'Thẻ tín dụng', 1),
(2, 2, '2024-02-02', 2500000, N'Đã giao', N'Tiền mặt', 2),
(3, 3, '2024-02-03', 1000000, N'Đang vận chuyển', N'Thẻ ngân hàng', 3),
(4, 4, '2024-02-04', 5000000, N'Hủy bỏ', N'Thẻ tín dụng', 4),
(5, 5, '2024-02-05', 750000, N'Đang xử lý', N'Tiền mặt', 5),
(6, 6, '2024-02-06', 300000, N'Đã giao', N'Thẻ ngân hàng', 6),
(7, 7, '2024-02-07', 1800000, N'Đang vận chuyển', N'Thẻ tín dụng', 7),
(8, 8, '2024-02-08', 4500000, N'Đã giao', N'Tiền mặt', 8);
INSERT INTO chi_tiet_don_hang (ID, ID_don_hang, ID_san_pham, so_luong, gia)
VALUES
(1, 1, 1, 1, 800000),
(2, 1, 3, 2, 400000),
(3, 2, 2, 1, 5000000),
(4, 3, 4, 1, 300000),
(5, 4, 5, 1, 7000000),
(6, 5, 6, 1, 1500000),
(7, 6, 7, 1, 1200000),
(8, 7, 8, 2, 100000);
INSERT INTO khuyen_mai (ID, ten_chuong_trinh, ngay_bat_dau, ngay_ket_thuc, chiet_khau, mo_ta)
VALUES
(1, N'Tết Nguyên Đán', '2024-01-01', '2024-01-31', 10.0, N'Giảm giá dịp Tết'),
(2, N'Lễ Tình Nhân', '2024-02-01', '2024-02-14', 15.0, N'Giảm giá ngày Valentine'),
(3, N'Quốc Tế Phụ Nữ', '2024-03-01', '2024-03-08', 20.0, N'Ưu đãi ngày 8/3'),
(4, N'Lễ Phục Sinh', '2024-04-01', '2024-04-10', 5.0, N'Ưu đãi dịp Lễ Phục Sinh'),
(5, N'Ngày Quốc Tế Lao Động', '2024-05-01', '2024-05-07', 12.0, N'Khuyến mãi dịp 1/5'),
(6, N'Mùa Hè Sôi Động', '2024-06-01', '2024-06-30', 25.0, N'Giảm giá lớn mùa hè'),
(7, N'Trung Thu', '2024-09-01', '2024-09-30', 18.0, N'Khuyến mãi dịp Trung Thu'),
(8, N'Giáng Sinh', '2024-12-01', '2024-12-25', 30.0, N'Ưu đãi mùa Giáng Sinh');
INSERT INTO ca_koi (ID, ten, nguon_goc, tuoi, kich_thuoc)
VALUES
(1, N'Koi Showa', N'Nhật Bản', 3, 25.0),
(2, N'Koi Kohaku', N'Nhật Bản', 2, 30.0),
(3, N'Koi Sanke', N'Nhật Bản', 1, 20.0),
(4, N'Koi Shusui', N'Nhật Bản', 4, 35.0),
(5, N'Koi Utsuri', N'Nhật Bản', 5, 40.0),
(6, N'Koi Asagi', N'Nhật Bản', 2, 28.0),
(7, N'Koi Bekko', N'Nhật Bản', 3, 22.0),
(8, N'Koi Tancho', N'Nhật Bản', 1, 18.0);
INSERT INTO giong_ca_koi (ID, ten_giong, mau_sac, kich_thuoc, nhiet_do_song, yeu_cau_nuoc, y_nghia, gia_tri_kinh_te, ID_ca_koi)
VALUES
(1, N'Showa', N'Đỏ - Trắng - Đen', 25.0, N'20-25°C', N'Sạch và trong', N'Mang lại may mắn', N'Cao', 1),
(2, N'Kohaku', N'Đỏ - Trắng', 30.0, N'18-22°C', N'Sạch và trong', N'Tượng trưng cho hòa bình', N'Rất cao', 2),
(3, N'Sanke', N'Đỏ - Trắng - Đen', 20.0, N'20-24°C', N'Sạch và trong', N'Biểu tượng thịnh vượng', N'Trung bình', 3),
(4, N'Shusui', N'Xanh - Đỏ', 35.0, N'18-26°C', N'Sạch và trong', N'Biểu tượng của sự hòa hợp', N'Trung bình', 4),
(5, N'Utsuri', N'Đen - Vàng', 40.0, N'22-28°C', N'Sạch và trong', N'Tượng trưng cho năng lượng', N'Cao', 5),
(6, N'Asagi', N'Xanh - Đỏ', 28.0, N'18-25°C', N'Sạch và trong', N'Mang lại bình an', N'Trung bình', 6),
(7, N'Bekko', N'Đen - Trắng', 22.0, N'20-24°C', N'Sạch và trong', N'Tượng trưng cho ổn định', N'Thấp', 7),
(8, N'Tancho', N'Trắng - Đỏ', 18.0, N'20-23°C', N'Sạch và trong', N'Tượng trưng cho hạnh phúc', N'Cao', 8);
INSERT INTO gio_hang (ID, ID_khach_hang, ID_san_pham, so_luong)
VALUES
(1, 1, 1, 2),
(2, 2, 3, 1),
(3, 3, 5, 3),
(4, 4, 6, 1),
(5, 5, 2, 2),
(6, 6, 4, 4),
(7, 7, 7, 1),
(8, 8, 8, 2);
INSERT INTO thong_tin_ki_gui (ID, ID_khach_hang, ID_ca_koi, thoi_gian, phi)
VALUES
(1, 1, 1, '2024-02-01', 500000),
(2, 2, 2, '2024-02-02', 750000),
(3, 3, 3, '2024-02-03', 300000),
(4, 4, 4, '2024-02-04', 1000000),
(5, 5, 5, '2024-02-05', 600000),
(6, 6, 6, '2024-02-06', 450000),
(7, 7, 7, '2024-02-07', 550000),
(8, 8, 8, '2024-02-08', 700000);
INSERT INTO van_chuyen (ID, ID_don_hang, dia_chi, ngay_van_chuyen, trang_thai)
VALUES
(1, 1, N'123 Đường A, TP. Hà Nội', '2024-02-02', N'Đang vận chuyển'),
(2, 2, N'456 Đường B, TP. Hồ Chí Minh', '2024-02-03', N'Đã giao'),
(3, 3, N'789 Đường C, TP. Đà Nẵng', '2024-02-04', N'Đang vận chuyển'),
(4, 4, N'111 Đường D, TP. Huế', '2024-02-05', N'Hủy bỏ'),
(5, 5, N'222 Đường E, TP. Hải Phòng', '2024-02-06', N'Đang vận chuyển'),
(6, 6, N'333 Đường F, TP. Cần Thơ', '2024-02-07', N'Đã giao'),
(7, 7, N'444 Đường G, TP. Biên Hòa', '2024-02-08', N'Đang vận chuyển'),
(8, 8, N'555 Đường H, TP. Vinh', '2024-02-09', N'Đã giao');
INSERT INTO bao_cao_cham_soc (ID, ID_ca_koi, ngay_cham_soc, loai_cham_soc, mo_ta)
VALUES
(1, 1, '2024-02-01', N'Cho ăn', N'Sử dụng thức ăn đặc biệt cho cá Koi'),
(2, 2, '2024-02-02', N'Thay nước', N'Thay nước 50% để duy trì môi trường sạch'),
(3, 3, '2024-02-03', N'Kiểm tra sức khỏe', N'Không phát hiện vấn đề gì bất thường'),
(4, 4, '2024-02-04', N'Cho ăn', N'Sử dụng thức ăn giàu dinh dưỡng'),
(5, 5, '2024-02-05', N'Thay nước', N'Thay toàn bộ nước hồ và làm sạch'),
(6, 6, '2024-02-06', N'Kiểm tra sức khỏe', N'Kiểm tra tổng quan, cá khỏe mạnh'),
(7, 7, '2024-02-07', N'Cho ăn', N'Tăng cường thức ăn để cá phát triển'),
(8, 8, '2024-02-08', N'Thay nước', N'Kiểm tra chất lượng nước và lọc nước sạch');
