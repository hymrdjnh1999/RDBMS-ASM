/*	1. Create database Shopee*/
drop database if exists shopee;
create database if not exists shopee;

-- 2. user shopee database
use shopee;
/*	3. Create table category*/
CREATE TABLE category (
    categoryID INT AUTO_INCREMENT,
    categoryName NVARCHAR(255) NOT NULL UNIQUE,
    PRIMARY KEY (categoryID)
);
/*	4. Create table product*/
CREATE TABLE product (
    productID INT AUTO_INCREMENT,
    productName NVARCHAR(255) NOT NULL,
    ProductRootPrice DECIMAL(13 , 2 ) NOT NULL,
    productSalePrice DECIMAL(13 , 2 ) NOT NULL,
    productQuantityInStock NVARCHAR(255) NOT NULL,
    quantitySold INT NOT NULL DEFAULT 0,
    productDescription TEXT NOT NULL,
    productRate DECIMAL(2 , 1 ) DEFAULT 0.0,
    productStatus 	enum('Còn Hàng','Bán Hết','Không Còn Kinh Doanh') NOT NULL DEFAULT 'Còn Hàng', 
    PRIMARY KEY (productID)
);
create table productHistoryUpdate as select p.productID ,p.productName , p.ProductRootPrice, p.productSalePrice,p.productQuantityInStock from product p;
alter table productHistoryUpdate add column updateTime datetime;
-- 4.1 Create productCategory
CREATE TABLE productCategory (
    categoryID INT,
    productID INT,
    PRIMARY KEY (categoryID , productID),
    FOREIGN KEY (categoryID)
        REFERENCES category (categoryID)
        ON DELETE CASCADE,
    FOREIGN KEY (productID)
        REFERENCES product (productID)
        ON DELETE CASCADE
);
/*	5. Create table optionGroup*/
CREATE TABLE IF NOT EXISTS optionGroup (
    optionGroupID INT AUTO_INCREMENT,
    optionName NVARCHAR(255) NOT NULL,
    PRIMARY KEY (optionGroupID)
);
-- 6. create table productOption
CREATE TABLE IF NOT EXISTS productOption (
    productID INT,
    optionGroupID INT,
    resources NVARCHAR(255) NOT NULL,
    PRIMARY KEY (productID , optionGroupID),
    FOREIGN KEY (optionGroupID)
        REFERENCES optionGroup (optionGroupID)
        ON DELETE CASCADE,
    FOREIGN KEY (productID)
        REFERENCES product (productID)
        ON DELETE CASCADE
);
-- 6.	 create table customer 
CREATE TABLE customer (
    customerID INT AUTO_INCREMENT,
    customerName NVARCHAR(30) NOT NULL,
    customerBirthDate DATE,
    customerEmail VARCHAR(50) UNIQUE,
    customerPassword VARCHAR(25) NOT NULL,
    customerPhoneNumber VARCHAR(11) NOT NULL UNIQUE,
    customerAddress NVARCHAR(255),
    customerStatus ENUM('active', 'non-active', 'banned') NOT NULL,
    PRIMARY KEY (customerID)
);
-- 7. create table shippingAddress
CREATE TABLE shippingAddress (
    shippingAddressID INT AUTO_INCREMENT,
    customerID INT,
    receiverName NVARCHAR(255),
    receiverPhoneNumber VARCHAR(11),
    addressDetails NVARCHAR(255) NOT NULL,
    PRIMARY KEY (shippingAddressID),
    FOREIGN KEY (customerID)
        REFERENCES customer (customerID)
        ON DELETE CASCADE
);
-- 8. create table paymentMethod
CREATE TABLE paymentMethod (
    paymentMethodID INT AUTO_INCREMENT,
    paymentMethodName NVARCHAR(255) NOT NULL,
    PRIMARY KEY (paymentMethodID)
);
-- 9.create table ShippingMethod
CREATE TABLE shippingMethod (
    shippingMethodID INT AUTO_INCREMENT,
    shippingName NVARCHAR(100) NOT NULL UNIQUE,
    deliveryDate VARCHAR(50) NOT NULL,
    shippingFee DECIMAL(13 , 2 ) NOT NULL,
    PRIMARY KEY (shippingMethodID)
);
-- 10.create table order 
CREATE TABLE orders (
    orderID INT AUTO_INCREMENT,
    shippingMethodID INT,
    paymentMethodID INT,
    customerID INT,
    shippingAddressID INT,
    totalBill DECIMAL(13 , 2 ) NOT NULL,
    orderDate DATE,
    orderStatus ENUM('Đang Xử Lý', 'Đang Giao', 'Đã Giao', 'Đã Hủy') NOT NULL,
    PRIMARY KEY (orderID),
    FOREIGN KEY (shippingMethodID)
        REFERENCES shippingMethod (shippingMethodID)
        ON DELETE CASCADE,
    FOREIGN KEY (shippingAddressID)
        REFERENCES shippingAddress (shippingAddressID)
        ON DELETE CASCADE,
    FOREIGN KEY (paymentMethodID)
        REFERENCES paymentMethod (paymentMethodID)
        ON DELETE CASCADE,
    FOREIGN KEY (customerID)
        REFERENCES customer (customerID)
        ON DELETE CASCADE
);
-- 11.create table orderDetails
CREATE TABLE orderDetails (
    productID INT,
    orderID INT,
    productAmount INT NOT NULL,
    ProductRootPrice DECIMAL(13 , 2 ) NOT NULL,
    quantity_of_product INT NOT NULL,
    PRIMARY KEY (productID , orderID),
    FOREIGN KEY (orderID)
        REFERENCES orders (orderID)
        ON DELETE CASCADE,
    FOREIGN KEY (productID)
        REFERENCES product (productID)
        ON DELETE CASCADE
);




INSERT INTO category(categoryName)      VALUES ('Thời Trang Nam');
INSERT INTO category(categoryName)      VALUES ('Thiết Bị Điện Tử');
INSERT INTO category(categoryName)      VALUES ('Đồng Hồ');
INSERT INTO category(categoryName)      VALUES ('Giày Dép Nam');
INSERT INTO category(categoryName)      VALUES ('Thời Trang Nữ' );
INSERT INTO category(categoryName)      VALUES ('Túi Ví' );
INSERT INTO category(categoryName)      VALUES ('Ô tô - xe máy - xe đạp' );
INSERT INTO category(categoryName)      VALUES ('Mẹ & Bé' );
INSERT INTO category(categoryName)      VALUES ('Sức Khỏe & Sắc Đẹp' );
INSERT INTO category(categoryName)      VALUES ('Giày Dép Nữ' );
INSERT INTO category(categoryName)      VALUES ('Thiết Bị Gia Dụng');

-- product 1
insert into product      VALUES(
	1,
	'Áo thun ngắn tay phong cách độc đáo',
	125000,
	125000,
	1750,	
	0,
	'Áo Thun Bao Ngầu Bao Chất…!',
	0.0,
	'Còn Hàng'
);
insert into optionGroup      VALUES(1,'Kích Cỡ');
insert into optionGroup      VALUES(2,'Kích Cỡ');
insert into optionGroup      VALUES(3,'Kích Cỡ');
insert into optionGroup      VALUES(4,'Kích Cỡ');
insert into optionGroup      VALUES(5,'Hình');
insert into optionGroup      VALUES(6,'Hình');
insert into optionGroup      VALUES(7,'Image 1 của áo thun tay ngắn phong cách');
insert into optionGroup      VALUES(8,'Image 2 của áo thun tay ngắn phong cách');
insert into productOption      VALUES(1,1,'M');
insert into productOption      VALUES(1,2,'L');
insert into productOption      VALUES(1,3,'XL');
insert into productOption      VALUES(1,4,'XXL');
insert into productOption      VALUES(1,5,'Hình 1');
insert into productOption      VALUES(1,6,'Hình 2');
insert into productOption      VALUES(1,7,'https://cf.shopee.vn/file/ad8754f46b5239229ce922ba844a74d8');
insert into productOption      VALUES(1,8,'https://cf.shopee.vn/file/4a35070888afed290dd6a64e765ac3b2');
-- product 2 
insert into product      VALUES(
	2,
	'Set thời trang cao cấp Adidas hoa Original [ hot trend ]',
	995000,
	746250,
	220,
	0,
	'BỘ THỂ THAO CAO CẤP ADIDAS HOA ORIGINAL',
	0.0,
	'Còn Hàng'
);
insert into optionGroup      VALUES(9,'Kích Cỡ');
insert into optionGroup      VALUES(10,'Kích Cỡ');
insert into optionGroup      VALUES(11,'Kích Cỡ');
insert into optionGroup      VALUES(12,'Kích Cỡ');
insert into optionGroup      VALUES(13,'Image');
insert into optionGroup      VALUES(14,'Image');
insert into productOption      VALUES(2,9,'M');
insert into productOption      VALUES(2,10,'L');
insert into productOption      VALUES(2,11,'XL');
insert into productOption      VALUES(2,12,'XXL');
insert into productOption      VALUES(2,13,'https://cf.shopee.vn/file/bf4556bc65f458910bfdeb7d9703bd7f');
insert into productOption      VALUES(2,14,'https://cf.shopee.vn/file/4815be036d2fd305ce349d52e0349d32');
-- product 3 

insert into product      VALUES(
	3,
	'Bóp Ví Nam Da Bò Thật Cao Cấp Giá Rẻ Nhiều Ngăn Đựng Tiền Thẻ Card Phong Cách Lịch Lãm Giản Dị',
	612500,
	50000,
	38,
	376,
	'Cam kết:chất lượng sản phẩm tốt',
    4.6,
	'Còn Hàng'
);

insert into optionGroup      VALUES(15,'Image');
insert into optionGroup      VALUES(16,'Image');
insert into productOption      VALUES(3,15,'https://cf.shopee.vn/file/94ea8b904b84e4e9bb5e61e36f11faaa');
insert into productOption      VALUES(3,16,'https://cf.shopee.vn/file/8c9189904a749fdd5c30fa6f84c4f8c8');
-- product 4
insert into product      VALUES(
	4,
	'Áo Thun Nam - Áo Thun Thể Thao Nam ATTA05 Chất Thun Cotton Cao Cấp Co Giãn',
	115000,
	115000,
	1593,
	4,
	'Áo thun nam mang đến sự thoải mái, dễ chịu nhất cho người mặc.',
	5.0,
	'Còn Hàng'
);
insert into optionGroup      VALUES(17,'Kích Cỡ');
insert into optionGroup      VALUES(18,'Kích Cỡ');
insert into optionGroup      VALUES(19,'Kích Cỡ');
insert into optionGroup      VALUES(20,'Kích Cỡ');
insert into optionGroup      VALUES(21,'Image');
insert into optionGroup      VALUES(22,'Màu');
insert into optionGroup      VALUES(23,'Màu');
insert into productOption      VALUES(4,17,'M');
insert into productOption      VALUES(4,18,'L');
insert into productOption      VALUES(4,19,'XL');
insert into productOption      VALUES(4,20,'XXL');
insert into productOption      VALUES(4,21,'https://cf.shopee.vn/file/715a1fd4cda8c73d4fe4a48825360fd8');
insert into productOption      VALUES(4,22,'Đỏ');
insert into productOption      VALUES(4,23,'Đen');

-- product 5
insert into product      VALUES(
	5,
	'Túi Đeo Chéo Nam Cổng USB Sạc Điện Thoại Da Phối Vải Polyester Cao Cấp Tặng Cáp Chuyển Đầu USB - M04',
	119000,
	69000,
	50,
	138,
	'Dòng sản phẩm có thể chứa  những vật dụng cần thiết tiện lợi khi đi học, đi chơi, đi làm, đi du lịch,...',
	4.9,
	'Còn hàng'
);
insert into optionGroup      VALUES(24,'Màu');
insert into optionGroup      VALUES(25,'Màu');
insert into optionGroup      VALUES(26,'Image');
insert into optionGroup      VALUES(27,'Image');
insert into productOption      VALUES(5,24,'Đen');
insert into productOption      VALUES(5,25,'Trắng Xám');
insert into productOption      VALUES(5,26,'https://cf.shopee.vn/file/34bd44c4d16835976bb26d5f9b0d9ff2');
insert into productOption      VALUES(5,27,'https://cf.shopee.vn/file/b0a88555c2765c2be3027ab4da2413f0');
-- product 6
insert into product      VALUES(
	6,

	'Áo Chống Nắng Nam Vải Kim Cương Chống Tia UV Thoáng Mát Mới Nhất 2020',
	160000,
	88000,
	997,
	2100,
	'Áo Chống Nắng Nam Vải Kim Cương Chống Tia UV Thoáng Mát Mới Nhất 2020',
	4.8,
	'Còn hàng'
);
insert into optionGroup      VALUES(28,'Kích Cỡ');
insert into optionGroup      VALUES(29,'Kích Cỡ');
insert into optionGroup      VALUES(30,'Kích Cỡ');
insert into optionGroup      VALUES(31,'Màu Sắc');
insert into optionGroup      VALUES(32,'Màu Sắc');
insert into optionGroup      VALUES(33,'Image');
insert into optionGroup      VALUES(34,'Image');
insert into productOption      VALUES(6,28,'M');
insert into productOption      VALUES(6,29,'L');
insert into productOption      VALUES(6,30,'XL');
insert into productOption      VALUES(6,31,'Ghi Sáng');
insert into productOption      VALUES(6,32,'Xanh');
insert into productOption      VALUES(6,33,'https://cf.shopee.vn/file/aaefe0817c47fd19b101da81f3f2aa38');
insert into productOption      VALUES(6,34,'https://cf.shopee.vn/file/092abf27d6bd11a73ec3d5ea6e7fec1f');
-- product 7
insert into product      VALUES(
	7,
	'Áo Thun tay dài Thời Trang Nam siêu hot',
	280000,
	169000,
	240,
	60,
	'Áo thun tay dài nam hàng VNXK',
	5.0,
'1'
);
insert into optionGroup      VALUES(35,'Kích Cỡ');
insert into optionGroup      VALUES(36,'Kích Cỡ');
insert into optionGroup      VALUES(37,'Kích Cỡ');
insert into optionGroup      VALUES(38,'Màu Sắc');
insert into optionGroup      VALUES(39,'Màu Sắc');
insert into optionGroup      VALUES(40,'Image');
insert into optionGroup      VALUES(41,'Image');
insert into productOption      VALUES(7,35,'S');
insert into productOption      VALUES(7,36,'M');
insert into productOption      VALUES(7,37,'L');
insert into productOption      VALUES(7,38,'Trắng');
insert into productOption      VALUES(7,39,'Đen');
insert into productOption      VALUES(7,40,'https://cf.shopee.vn/file/389f9f58d01cb04ac877bab18f688b41');
insert into productOption      VALUES(7,41,'https://cf.shopee.vn/file/6ce55cc13ecf64ff1d075e398d0710e2');
-- product 8
insert into product      VALUES(	
	8,
	'Quần Jogger kaki khoá kéo',
	320000,
	210000,
	10043,
	933,
	'Mẫu Jogger vải kaki cotton co giãn tốt',
	4.9,
	'1'
);
insert into optionGroup      VALUES(42,'Kích Cỡ');
insert into optionGroup      VALUES(43,'Kích Cỡ');
insert into optionGroup      VALUES(44,'Kích Cỡ');
insert into optionGroup      VALUES(45,'Màu Sắc');
insert into optionGroup      VALUES(46,'Màu Sắc');
insert into optionGroup      VALUES(47,'Image');
insert into optionGroup      VALUES(48,'Image');
insert into productOption      VALUES(8,42,'29');
insert into productOption      VALUES(8,43,'30');
insert into productOption      VALUES(8,44,'31');
insert into productOption      VALUES(8,45,'Xám Nhạt');
insert into productOption      VALUES(8,46,'Đen');
insert into productOption      VALUES(8,47,'https://cf.shopee.vn/file/f7d2cbb81800c64af3d0a2d382c02dac');
insert into productOption      VALUES(8,48,'https://cf.shopee.vn/file/70194b861f4b31bb2407facd5b9b5c2d');
-- product 9
insert into product      VALUES(
	9,
	'Quần Đùi Nam 3 Sọc Xuất Xịn',
	99000,
	68000,
	559,
	147,
	'- Hàng chuẩn đẹp từ đường kim mũi chỉ, 2 túi cầm lên đảm bảo chỉ ưng và ưng.',
	4.6,
	'1'
);
insert into optionGroup      VALUES(49,'Image');
insert into optionGroup value(50,'Image');
insert into optionGroup      VALUES(51,'Kích Cỡ');
insert into optionGroup      VALUES(52,'Kích Cỡ');
insert into optionGroup      VALUES(53,'Kích Cỡ');
insert into optionGroup      VALUES (54,'Màu Sắc');
insert into optionGroup      VALUES (55,'Màu Sắc');
insert into productOption      VALUES(9,49,'https://cf.shopee.vn/file/afcff2a26cea1953e90b6a7158abe523');
insert into productOption      VALUES(9,50,'https://cf.shopee.vn/file/ffbe1fc9261dea9bfedfc9f5dddd7d4f');
insert into productOption      VALUES(9,51,'L(40-48kg)');
insert into productOption      VALUES(9,52,'XL(48-58kg)');
insert into productOption      VALUES(9,53,'XXL(58-75kg)');
insert into productOption      VALUES(9,54,'Sọc Trắng');
insert into productOption      VALUES(9,55,'Sọc Xanh');
-- prodcut 10
insert into product      VALUES(
	10,
    'Sơ mi trắng đen tay ngắn Zara Việt Nam Xuất Khẩu',
    290000,
    175000,
    103,
    37,
    'Sơ mi tay ngắn cơ bản dành cho Nam',
    5.0,
    '1'
);
insert into optionGroup      VALUES(56,'Kích Cỡ');
insert into optionGroup      VALUES(57,'Kích Cỡ');
insert into optionGroup      VALUES(58,'Kích Cỡ');
insert into optionGroup      VALUES(59,'Màu Sắc');
insert into optionGroup      VALUES(60,'Màu Sắc');
insert into optionGroup      VALUES(61,'Image');
insert into optionGroup      VALUES(62,'Image');
insert into productOption      VALUES(10,56,'S');
insert into productOption      VALUES(10,57,'M');
insert into productOption      VALUES(10,58,'L');
insert into productOption      VALUES(10,59,'Trắng');
insert into productOption      VALUES(10,60,'Đen');
insert into productOption      VALUES(10,61,'https://cf.shopee.vn/file/6a0a26d4b693034ff6c9eeeb0597b8ed');
insert into productOption      VALUES(10,62,'https://cf.shopee.vn/file/501321efc68588d4357b5ad59784c66a');
-- product 11
insert into product      VALUES(
	11,

    'Tai nghe bluetooth Airpods 2 [ FREE SHIP TOÀN QUỐC ] TWS Định vị, đổi tên nguyên seal Cao Cấp,pin trâu,bảo hành 12 thang',
	450000,
    370000,
    99999,
    0,
    'CAM KẾT 100% NHẬN HÀNG KHÔNG ƯNG HOÀN LẠI 100% TIỀN',
	0.0,
    'Còn Hàng'
);
insert into optionGroup      VALUES(63,'Image');
insert into optionGroup      VALUES(64,'Image');

insert into productOption      VALUES(11,63,'https://cf.shopee.vn/file/7e96e8ba2fa44d124102c11f99beb8f9');
insert into productOption      VALUES(11,64,'https://cf.shopee.vn/file/59688ee0675cb2efe7e4f766d788d2c5');
-- product 12
insert into product      VALUES(
	12,

    'Loa Bluetooth KIMISO KM-S1 - Tặng kèm Mic hát Karaoke - Lỗi đổi mới',
	390000,
    351000,
    2535,
    554,
    'Đặc Biệt Với Loa Super Bass, Cho Tiếng Bass Siêu Trầm, Âm Thanh Cực Chắc Và Không Bị Rè.',
	5.0,
    'Còn Hàng'
);
insert into optionGroup      VALUES(65,'Image');
insert into optionGroup      VALUES(66,'Image');

insert into productOption      VALUES(12,65,'https://cf.shopee.vn/file/023d6dcccfd025c8853761b699e799a2');
insert into productOption      VALUES(12,66,'https://cf.shopee.vn/file/67e48f954eca5cdcff5d2002ef438360');
-- product 13
insert into product      VALUES(
	13,
    'Đồng hồ thông minh T500 thay dây chống nước chuẩn ip67',
	799000,
    799000,
    23173,
    26,
    'Chip chính: MT2503
	Bộ nhớ: 64 M + 128 M
	Màn hình: Màn hình màu thật IPS
	Kích thước màn hình: 1.54 inch
	Độ phân giải: 240x240',
	5.0,
    'Còn Hàng'
);
insert into optionGroup      VALUES(67,'Image');
insert into optionGroup      VALUES(68,'Image');
insert into optionGroup      VALUES(69,'Màu Sắc');
insert into productOption      VALUES(13,67,'https://cf.shopee.vn/file/c553052daba6638a4300f5c03478a37e');
insert into productOption      VALUES(13,68,'https://cf.shopee.vn/file/3b08f7be6a5bb92074a03f12e239268d');
insert into productOption      VALUES(13,69 ,'Đen');
-- product 14
insert into product      VALUES(
	14,
    'Smart Tivi Philips 50 Inch 4K UHD 50PUT6103S/67 (Netflix Remote) - (Model 2020)',
	9990000,
    7290000,
    164,
    363,
    'Hình ảnh sắc nét, chi tiết với độ phân giải 4K UHD',
	4.8,
    'Còn Hàng'
);
insert into optionGroup      VALUES(70,'Image');
insert into optionGroup      VALUES(71,'Image');
insert into productOption      VALUES(14,70,'https://cf.shopee.vn/file/f7785c6e35a4923ea366b7c7877b2371');
insert into productOption      VALUES(14,71,'https://cf.shopee.vn/file/0960ac08cf5a3dc4ab614507f47562d0');
-- product 15
insert into product      VALUES(
	15,
    'Bộ Máy Ps4 Slim 1tb Model 2218B -Hàng New - Chính Hãng Sony Việt Nam',
	7690000,
    7290000,
    10,
    389,
    'CPU: x86-64 AMD Jaguar, 8 nhân
	GPU: 4.20 TFLOPS, đồ họa nền tảng AMD Radeon
	RAM: GDDR5 8GB',
	4.9,
    'Còn Hàng'
);
insert into optionGroup      VALUES(72,'Image');
insert into optionGroup      VALUES(73,'Image');
insert into productOption      VALUES(15,72,'https://cf.shopee.vn/file/7662e5c364efe12c5d41f3c1feb7813c');
insert into productOption      VALUES(15,73,'https://cf.shopee.vn/file/8d9ee45ae30c54c2aa640f7a80f5596d');
-- product 16
insert into product      VALUES(
	16,
    'Phụ Kiện Desktop Dock Asus Rog Phone 2 ( Chính Hãng )',
	3999000,
    3999000,
    88,
    11,
    'Kết nối với màn hình, chuột và bàn phím 4K UHD bên ngoài trong khi sử dụng ROG Phone II làm màn hình phụ, 
    nối với mạng LAN gigabit có dây và sử dụng đầu ra S / PDIF để điều khiển hệ thống âm thanh vòm 5.1 kênh',
	5.0,
    'Còn Hàng'
);
insert into optionGroup      VALUES(74,'Image');
insert into optionGroup      VALUES(75,'Image');
insert into productOption      VALUES(16,74,'https://cf.shopee.vn/file/abcca557f959a17e5ca3c19fadd49d7b');
insert into productOption      VALUES(16,75,'https://cf.shopee.vn/file/18f4acc22c4c359e00a7b6922290dbd6');
-- product 17
insert into product      VALUES(
	17,
    'Loa Kéo Karaoke Bluetooth JBZ NE108 150W Bass 2 Tấc - BH 6 Tháng',
	1800000,
    1045000,
    1800,
    191,
    '+ Âm thanh hay nhất trong các dòng loa kéo cùng tầm giá
+ Bass đúng 2 tấc chắc và sâu
+ Tặng kèm 1 Micro không dây JBZ, cầm chắc tay, hát rất nhẹ, hút tiếng',
	5.0,
    'Còn Hàng'
);
insert into optionGroup      VALUES(76,'Image');
insert into optionGroup      VALUES(77,'Image');
insert into optionGroup      VALUES(78,'variation');
insert into optionGroup      VALUES(79,'variation');
insert into productOption      VALUES(17,76,'https://cf.shopee.vn/file/2fe82174f01790edc7a1e23ef48daac5');
insert into productOption      VALUES(17,77,'https://cf.shopee.vn/file/b88fd50ded088571fcc9050997db659c');
insert into productOption      VALUES(17,78,'1 micro ko dây');
insert into productOption      VALUES(17,79,'2 micro ko dây');
-- product 18
insert into product      VALUES(
	18,

    'Kích sóng Wifi Mercury 3 râu MW310RE | Kích Wifi Mercury MW310re 3 Ăng Ten - Kích wifi - Sóng wifi căng hơn',
	250000,
    250000,
    9,
    1,
    '- Thuận tiện cho người sử dụng dễ dàng cài đặt chỉ cần 3 bước
- Sản phẩm nổi tiếng của Mercury số 1 về thiết bị mạng
- Bộ siêu kích sóng wifi lên đến 300 Mbps',
	0.0,
    'Còn Hàng'
);
insert into optionGroup      VALUES(80,'Image');
insert into optionGroup      VALUES(81,'Image');
insert into productOption      VALUES(18,80,'https://cf.shopee.vn/file/f005d40de91a1c40500e121752bd4660');
insert into productOption      VALUES(18,81,'https://cf.shopee.vn/file/620dfadf21ad768fb582718f72f1d5ab');
-- product 19
insert into product      VALUES(
	19,
    
    'Máy nghe nhạc ipod gen 5',
	1750000,
    1750000,
    2,
    0,
    'pod Touch Gen 5 32Gb máy nghe nhạc chơi Game cao cấp
Ipod Touch thế hệ 5 chỉ có 2 phiên bản: 16Gb, 32Gb và 64Gb (không có 8Gb)',
	0.0,
    'Còn Hàng'
);
insert into optionGroup      VALUES(82,'Image');
insert into optionGroup      VALUES(83,'Image');
insert into optionGroup      VALUES(84,'Màu Sắc');
insert into optionGroup      VALUES(85,'Màu Sắc');
insert into productOption      VALUES(19,82,'https://cf.shopee.vn/file/5140a8400078a991306df04cd9c4109b');
insert into productOption      VALUES(19,83,'https://cf.shopee.vn/file/6793237fa4aa8e2574e14750cfcf3f11');
insert into productOption      VALUES(19,84,'Đỏ');
insert into productOption      VALUES(19,85,'Xanh');
-- product 20
insert into product      VALUES(
	20,
    
    'Thiết Vị Định Vị GPS Không Dây Pin Khủng 6400mAh',
	1190000,
    1390000,
    281,
    416,
    'ĐỊNH VỊ KHÔNG DÂY PIN KHỦNG 6400 mAh',
	4.8,
    'Còn Hàng'
);
insert into optionGroup      VALUES(86,'Image');
insert into optionGroup      VALUES(87,'Image');
insert into optionGroup      VALUES(88,'NTT202A');
insert into optionGroup      VALUES(89,'NTT202A');
insert into productOption      VALUES(20,86,'https://cf.shopee.vn/file/332e47015e2a5dc3b5a5d27e3d05c329');
insert into productOption      VALUES(20,87,'https://cf.shopee.vn/file/6d4d08c7c02087b59d9ed77e9bba8100');
insert into productOption      VALUES(20,88,'Định Vị Pin 6400mAh');
insert into productOption      VALUES(20,89,'Định Vị + SIM 4G');
-- product 21
insert into product      VALUES(
	21,
    
    'Đồng hồ Nam Reef Tiger RGA1699',
	4650000,
    4417500,
    35,
    1,
    'Mã sản phẩm: RGA1699 P',
	0.0,
    'Còn Hàng'
);
insert into optionGroup      VALUES(90,'Image');
insert into optionGroup      VALUES(91,'Image');
insert into optionGroup      VALUES(92,'Màu,Thân,Dây');
insert into optionGroup      VALUES(93,'Màu,Thân,Dây');
insert into productOption      VALUES(21,90,'https://cf.shopee.vn/file/a663f34ae68d8787b41a19556a8fc5ef');
insert into productOption      VALUES(21,91,'https://cf.shopee.vn/file/2953b4a2705a4217f6b3575de0a028a8');
insert into productOption      VALUES(21,92,'Trắng-Vàng Hồng-Nâu');
insert into productOption      VALUES(21,93,'Dương xanh-Trắng-Đen');
-- product 22
insert into product      VALUES(
	22,
    
    'Đồng hồ nữ Rowngo dây da trẻ trung, sang chảnh',
	260000,
    133000,
    126,
    17,
    'BẢO HÀNH : 6 tháng tính từ ngày khách nhận hàng',
	4.2,
    'Còn Hàng'
);
insert into optionGroup      VALUES(94,'Image');
insert into optionGroup      VALUES(95,'Image');
insert into optionGroup      VALUES(96,'variation');
insert into optionGroup      VALUES(97,'variation');
insert into productOption      VALUES(22,94,'https://cf.shopee.vn/file/f689302006b0a6433e963c81700db5b2');
insert into productOption      VALUES(22,95,'https://cf.shopee.vn/file/dc3d95d890840d0978e3d9fc04a038e4');
insert into productOption      VALUES(22,96,'Trắng');
insert into productOption      VALUES(22	,97,'Đỏ');
-- product 23
insert into product      VALUES(
	23,
    
    'Đồng hồ nữ Citizen EM0550 năng lượng mặt trờ',
	3050000,
    2775500,
    2,
    2,
    '*** Cam đoan 100% chính hãng. No fake. Full box ***',
	5.0,
    'Còn Hàng'
);
insert into optionGroup      VALUES(98,'Image');
insert into optionGroup      VALUES(99,'Image');
insert into productOption      VALUES(23,98,'https://cf.shopee.vn/file/710cc2cbbc7642f47e216f5e5c0c726');
insert into productOption      VALUES(23,99,'https://cf.shopee.vn/file/dc3d95d890840d0978e3d9fc04a038e4');
-- product 24
insert into product      VALUES(
	24,
    
    '[Nhập SHOPVIP11 giảm tới 100K] Đồng Hồ Reward Vip - Thương Hiệu Chính Hãng Reward phiên bản Vip - Đồng Hồ Nam Cao Cấp',
	750000,
    375000,
    2000,
    50,
    'Đồng hồ Nam Reward Vip – Đồng hồ thời trang phong cách dành cho quý ông',
	5.0,
    'Còn Hàng'
);
insert into optionGroup      VALUES(100,'Image');
insert into optionGroup      VALUES(101,'Image');
insert into productOption      VALUES(24,100,'https://cf.shopee.vn/file/710cc2cbbc7642f47e216f5e5c0c726b');
insert into productOption      VALUES(24,101,'https://cf.shopee.vn/file/1baba6d936011d9acac72e259745734e');
-- product 25
insert into product      VALUES(
	25,
   
    'Đồng hồ nữ Minhin DHO03 đính đá thời trang cao cấp hàn quốc sang trọng và lịch thiệp (HOT2019+ĐẸP+SIÊU RẺ)',
	285000,
    149000,
    317,
    8,
    '▶ Khách lưu ý nên đọc thật kỹ thông tin mô tả sản phẩm, size, độ chống nước để hiểu hơn về sản phẩm nhé!',
	0.0,
    'Còn Hàng'
);
insert into optionGroup      VALUES(102,'Image');
insert into optionGroup      VALUES(103,'Image');
insert into optionGroup      VALUES(104,'variation');
insert into optionGroup      VALUES(105,'variation');
insert into productOption      VALUES(25,102,'https://cf.shopee.vn/file/94dbaf45e6dabbd60e6ac5528f77887e');
insert into productOption      VALUES(25,103,'https://cf.shopee.vn/file/ed0a92ecde7809d7518665cfd67a9eaf');
insert into productOption      VALUES(25,104,'Vàng');
insert into productOption      VALUES(25,105,'Hồng');
-- product 26
insert into product      VALUES(
	26,
  
    '[Hàng Xịn] Đồng hồ nữ BS Bee Sister đính đá sang trọng',
	190000,
    129000,
    1388,
    521,
    'Thương Hiệu: BEE SISTER
	Giới Tính: Nữ
	Kiểu Máy: Quartz
	Nguồn gốc: Nhật Bản',
	4.7,
    'Còn Hàng'
);
insert into optionGroup      VALUES(106,'Image');
insert into optionGroup      VALUES(107,'Image');
insert into optionGroup      VALUES(108,'Đồng Hồ Nữ');
insert into optionGroup      VALUES(109,'Đồng Hồ Nữ');
insert into productOption      VALUES(26,106,'https://cf.shopee.vn/file/4599d861e1930d1233ecf3a5500e6f23');
insert into productOption      VALUES(26,107,'https://cf.shopee.vn/file/b4be400afb752d0769f8f7606a908dea');
insert into productOption      VALUES(26,108,'Xanh');
insert into productOption      VALUES(26,109,'Đen');
-- product 27
insert into product      VALUES(
	27,
    
    'Đồng hồ thể thao Shock nam nữ dây silicon cá tính',
	200000,
    200000,
    1146,
    159,
    '✚ Sản Phẩm : Shock
✚ Tình trạng : mới
✚ Đồng hồ : nam , nữ
✚ Kích thước mặt:  3,4cm
✚ Kích thước dây : 1,5cm',
	4.8,
    'Còn Hàng'
);
insert into optionGroup      VALUES(110,'Image');
insert into optionGroup      VALUES(111,'Image');
insert into optionGroup      VALUES(112,'Đồng Hồ Nữ');
insert into optionGroup      VALUES(113,'Đồng Hồ Nữ');
insert into productOption      VALUES(27,110,'https://cf.shopee.vn/file/d31fecfb2d6a0c334e4cc97bffd19002');
insert into productOption      VALUES(27,111,'https://cf.shopee.vn/file/9aa5759e9cb8b14d72dca631a0bc4cab');
insert into productOption      VALUES(27,112,'Xanh');
insert into productOption      VALUES(27,113,'Đen');
-- product 28
insert into product      VALUES(
	28,
    
    'Đồng hồ nữ BURGI BUR246 metalic xanh ngọc lục bảo',
	2300000,
    1978000,
    2,
    2,
    '✚ Sản Phẩm : Shock
✚ Tình trạng : mới
✚ Đồng hồ : nam , nữ
✚ Kích thước mặt:  3,4cm
✚ Kích thước dây : 1,5cm',
	5.0,
    'Còn Hàng'
);
insert into optionGroup      VALUES(114,'Image');
insert into optionGroup      VALUES(115,'Image');

insert into productOption      VALUES(28,114,'https://cf.shopee.vn/file/e98565d424d2d93d59720436a8f559f5');
insert into productOption      VALUES(28,115,'https://cf.shopee.vn/file/c7197fa44e6cd96df4f226baf1904b21');

-- product 29
insert into product      VALUES(
	29,
    
    'Đồng hồ nam dây da Citizen AT0550-11X Eco-drive 6 kim Chronograph chính hãng',
	3950000,
    3357500,
	1,
    0,
    '✚ Sản Phẩm : Shock
✚ Tình trạng : mới
✚ Đồng hồ : nam , nữ
✚ Kích thước mặt:  3,4cm
✚ Kích thước dây : 1,5cm',
	0.0,
    'Còn Hàng'
);
insert into optionGroup     VALUES(116,'Image');
insert into optionGroup     VALUES(117,'Image');
insert into productOption   VALUES(28,116,'https://cf.shopee.vn/file/7a6ff916aebd9c5f5996aa0f54d8a1c6');
insert into productOption	VALUES(28,117,'https://cf.shopee.vn/file/d0397f5ebe769109c95c201dca1d97de');
-- product 30
insert into product      VALUES(
	30,
    
    'Đồng hồ nam Bulova 98B237 máy Quartz (pin) - Kính cứng - chống nước 30m - size 40mm chính hãng',
	2590000,
    2123800,
	2,
    0,
    'Bulova 98B237. Sang trọng lịch lãm với thiết kế 2 tone kinh điển
Một sản phẩm phù hợp với các anh chàng công sở
Size 40mm cho các cổ tay vừa và nhỏ
Lịch ngày tiện dụng góc 3h',
	0.0,
    'Còn Hàng'
);
insert into optionGroup     VALUES(118,'Image');
insert into optionGroup     VALUES(119,'Image');
insert into productOption 	VALUES(30,118,'https://cf.shopee.vn/file/909a23139ba1908c7e12a297d7711fae');
insert into productOption 	VALUES(30,119,'https://cf.shopee.vn/file/8bac88189798bd0151ef3ee4586a5d6b');
-- product 31
insert into product      VALUES(
	31,
    
    'Giày thể thao',
	500000,
    500000,
    4,
    0,
    'thông thường Nhóm tuổi áp dụng Thanh niên (18-40 tuổi)',
	0.0,
    'Còn Hàng'
);
insert into optionGroup   	VALUES(120,'Image');
insert into optionGroup     VALUES(121,'Image');
insert into optionGroup     VALUES(122,'Màu Sắc');
insert into optionGroup     VALUES(123,'Màu Sắc');
insert into optionGroup    	VALUES(124,'SIZE');
insert into optionGroup     VALUES(125,'SIZE');
insert into productOption   VALUES(31,120,'https://cf.shopee.vn/file/987d1a6147d20574b726baa1223adde0');
insert into productOption   VALUES(31,121,'https://cf.shopee.vn/file/8e50c27646dcf6a9b98359bdecd06df3');
insert into productOption 	VALUES(31,122,'đen đế vàng');
insert into productOption   VALUES(31,123,'đen đế đen');
insert into productOption   VALUES(31,124,'39');
insert into productOption 	VALUES(31,125,'40');
-- product 32
insert into product      VALUES(
	32,
    
    'GIÀY Sneakers zy 700 static Phản Quang',
	700000,
    350000,
    1356,
    1654,
    '-Mình ôm 5000 đôi bán giá ctv ,ae ctv đặt hàng bán lẻ vẫn ngon ơ nhé.',
	4.8,
    'Còn Hàng'
);
insert into optionGroup          VALUES(126,'Image');
insert into optionGroup 	VALUES(127,'Image');
insert into optionGroup 	VALUES(128,'Chọn SIZE');
insert into optionGroup 	VALUES(129,'Chọn SIZE');
insert into optionGroup 	VALUES(130,'Chọn SIZE');
insert into optionGroup 	VALUES(131,'Chọn SIZE');
insert into productOption 	VALUES(32,126,'https://cf.shopee.vn/file/ca8a228e43cb5837f716278ca4d08b3e');
insert into productOption 	VALUES(32,127,'https://cf.shopee.vn/file/5c62aa4bddd0bdb3e985e4e7b74cc258');
insert into productOption 	VALUES(32,128,'39');
insert into productOption 	VALUES(32,129,'40');
insert into productOption 	VALUES(32,130,'41');
insert into productOption 	VALUES(32,131,'42');
-- product 33
insert into product      VALUES(
	33,
    
    'HOT! 2020 Siêu phẩm giày nam - sneakers nam Gu-xì cực chất',
	499000,
    249000,
    37,
    1134,
    'TIÊU CHÍ CHẤT LƯỢNG LÀ SỐ 1 - KHÔNG BÁN HÀNG KÉM CHẤT LƯỢNG
GIÀY THỂ THAO NAM - SNEAKER NAM HOT NHẤT 2020',
	5,
    'Còn Hàng'
);
insert into optionGroup 	VALUES(132,'Image');
insert into optionGroup 	VALUES(133,'Image');
insert into optionGroup 	VALUES(134,'SIZE');
insert into optionGroup 	VALUES(135,'SIZE');
insert into optionGroup 	VALUES(136,'Màu');
insert into optionGroup 	VALUES(137,'Màu');
insert into productOption 	VALUES(33,132,'https://cf.shopee.vn/file/584d968cd5100810e1caf8c56b994270');
insert into productOption 	VALUES(33,133,'https://cf.shopee.vn/file/96e7fcd3e8f36f095c4bae158500fc37');
insert into productOption 	VALUES(33,134,'39');
insert into productOption 	VALUES(33,135,'40');
insert into productOption 	VALUES(33,136,'Trắng');
insert into productOption 	VALUES(33,137,'Vàng');
-- product 34
insert into product      VALUES(
	34,
    'Dép Quai Ngang Lê Bảo Bình New Hot',
	250000,
    250000,
    19,
    11,
    '-Shop Nhận Đổi Trả Linh Hoạt Khi Khách Hàng Nhận Hàng Không Ưng Ý',
	4.3,
    'Còn Hàng'
);
insert into optionGroup 	VALUES(138,'Image');
insert into optionGroup 	VALUES(139,'Image');
insert into optionGroup 	VALUES(140,'SIZE');
insert into optionGroup 	VALUES(141,'SIZE');
insert into optionGroup 	VALUES(142,'Màu');
insert into optionGroup 	VALUES(143,'Màu');
insert into productOption 	VALUES(34,138,'https://cf.shopee.vn/file/88638a718e8333bc929c02e925b420b0');
insert into productOption 	VALUES(34,139,'https://cf.shopee.vn/file/f03d33293884573a54ffec2f1282d695');
insert into productOption 	VALUES(34,140,'41');
insert into productOption 	VALUES(34,141,'42');
insert into productOption 	VALUES(34,142,'Trắng');
insert into productOption 	VALUES(34,143,'Đen');
-- product 35
INSERT INTO product 		VALUES ('35',  'Dép nam nữ Quai ngang phối tam giác đế siêu êm', '120000.00', '75000.00', '25648', '951', '- chất liệu đế đúc cao su nguyên khối', '4.8', 'Còn Hàng');
INSERT INTO optiongroup 	VALUES ('144', 'Image');
INSERT INTO optiongroup 	VALUES ('145', 'Image');
INSERT INTO optiongroup 	VALUES ('146', 'Màu');
INSERT INTO optiongroup 	VALUES ('147', 'Màu');
INSERT INTO optiongroup 	VALUES ('148', 'Size');
INSERT INTO optiongroup 	VALUES ('149', 'Size');
INSERT INTO  productoption       VALUES ('35', '144', 'https://cf.shopee.vn/file/f17ee7dc933b470f9ddcbdf3cb341414');
INSERT INTO  productoption       VALUES ('35', '145', 'https://cf.shopee.vn/file/e10ff28e7a267d5b0c1d9a13ae79a1bb');
INSERT INTO  productoption       VALUES ('35', '146', 'Quai Đen');
INSERT INTO  productoption       VALUES ('35', '147', 'Quai Vàng');
INSERT INTO  productoption       VALUES ('35', '148', '40-41');
INSERT INTO  productoption       VALUES ('35', '149', '42-43');
-- product 36
INSERT INTO product 		VALUES ('36',  'Giày thể thao nam nữ MQ trắng ( ảnh tự chụp )', '169000.00', '16900.00', '814', '81', 'Giày Thể Thao Nam Alexander MQueen Trắng ', '4.7', 'Còn Hàng');
INSERT INTO optiongroup 	VALUES ('150', 'Image');
INSERT INTO optiongroup 	VALUES ('151', 'Image');
INSERT INTO optiongroup 	VALUES ('152', 'Màu Sắc');
INSERT INTO optiongroup 	VALUES ('153', 'Màu Sắc');
INSERT INTO   optiongroup   VALUES ('154', 'Kích Cỡ');
INSERT INTO   optiongroup        VALUES ('155', 'Kích Cỡ');
INSERT INTO  productoption       VALUES ('36', '150', 'https://cf.shopee.vn/file/cc6eaf7949822c71e69e164876d3ec31');
INSERT INTO  productoption       VALUES ('36', '151', 'https://cf.shopee.vn/file/e53c868ff175701c53a59b373afb14ee');
INSERT INTO  productoption       VALUES ('36', '152', 'NAM GÓT ĐEN');
INSERT INTO  productoption       VALUES ('36', '153', 'NỮ GÓT ĐEN');
INSERT INTO  productoption       VALUES ('36', '154', '39');
INSERT INTO  productoption       VALUES ('36', '155', '40');
-- product 37
INSERT INTO product       VALUES ('37','Dép Đi Trong Nhà ⭐️ Dép Massage Chân Nam Nữ, Đế Đúc, Chống Trơn, Có Gai Massage Cực Tốt Cho Sức Khỏe', '80000.00', '48000.00', '697', '43', 'DÉP ĐI TRONG NHÀ - DÉP MASSAGE CHÂN UNISEX', '5.0', 'Còn Hàng');
INSERT INTO   optiongroup        VALUES ('156', 'Image');
INSERT INTO   optiongroup        VALUES ('157', 'Image');
INSERT INTO   optiongroup        VALUES ('158', 'Màu Sắc');
INSERT INTO   optiongroup        VALUES ('159', 'Màu Sắc');
INSERT INTO   optiongroup        VALUES ('160', 'Kích Cỡ');
INSERT INTO   optiongroup        VALUES ('161', 'Kích Cỡ');
INSERT INTO  productoption       VALUES ('37', '156', 'https://cf.shopee.vn/file/da46f559311be486cf09fdd24925d628');
INSERT INTO  productoption       VALUES ('37', '157', 'https://cf.shopee.vn/file/72fd3d32a5342f332aab8049e1a56f3f');
INSERT INTO  productoption       VALUES ('37', '158', 'Xanh Nhạt');
INSERT INTO  productoption       VALUES ('37', '159', 'Xanh Than');
INSERT INTO  productoption       VALUES ('37', '160', '40/41');
INSERT INTO  productoption       VALUES ('37', '161', '42/43');

-- product 38
INSERT INTO product 		VALUES ('38', '[FREE SHIP 50K] Chai Tẩy Trắng Giày Dép Túi Xách Plac Kèm Đầu Chùi Tiện Dụng', '12800.00', '12800.00', '5', '743', '[FREE SHIP 50K] Chai Tẩy Trắng Giày Dép Túi Xách Plac Kèm Đầu Chùi Tiện Dụng', '4.8', 'Còn Hàng');
INSERT INTO   optiongroup   VALUES ('162', 'Image');
INSERT INTO   optiongroup   VALUES ('163', 'Image');
INSERT INTO  productoption  VALUES ('38', '162', 'https://cf.shopee.vn/file/d24f54c30de268b873333b03b6e45c16');
INSERT INTO  productoption  VALUES ('38', '163', 'https://cf.shopee.vn/file/a4e7ecac456b0dd552fb7e88fdbc899b');
-- product 39
INSERT INTO product  		VALUES ('39','Giày nam da bò vân da trăn màu đen LS7195', '1119000.00', '619000.00', '60', '64', ' - Tên sản phẩm: Giày nam da bò vân da trăn màu đen LS7195', '5.0', 'Còn Hàng');
INSERT INTO   optiongroup 	VALUES ('164', 'Image');
INSERT INTO   optiongroup 	VALUES ('165', 'Image');
INSERT INTO   optiongroup   VALUES ('166', 'SIZE');
INSERT INTO   optiongroup   VALUES ('167', 'SIZE');
INSERT INTO  productoption  VALUES ('39', '164', 'https://cf.shopee.vn/file/134554c0a0a6f3d8952a64ca74d587f9');
INSERT INTO  productoption  VALUES ('39', '165', 'https://cf.shopee.vn/file/7a5911b206e6cc03766245fe60fce557');
INSERT INTO  productoption  VALUES ('39', '166', '41');
INSERT INTO  productoption  VALUES ('39', '167', '42');

-- product 40
INSERT INTO product 		VALUES ('40','Giày Thể Thao Sneaker Nam 99K Giày buộc dây Watahhh Phản Quang, Tăng Chiều Cao 5cm Full Box', '340000.00', '179000.00', '3480', '40', 'BẠN SẼ VỮNG VÀNG NẾU LỰA CHỌN CHO MÌNH MỘT ĐÔI GIÀY TỐT', '5', 'Còn Hàng');
INSERT INTO optiongroup   	VALUES ('168', 'Image');
INSERT INTO optiongroup   	VALUES ('169', 'Image');
INSERT INTO optiongroup   	VALUES ('170', 'SIZE');
INSERT INTO optiongroup   	VALUES ('171', 'SIZE');
INSERT INTO productoption  	VALUES ('40', '168', 'https://cf.shopee.vn/file/9c81a975cb8227515ad3cf8235a0c946');
INSERT INTO productoption  	VALUES ('40', '169', 'https://cf.shopee.vn/file/6b9803e76eca48e17c26629da7ea754b');
INSERT INTO productoption  	VALUES ('40', '170', '40');
INSERT INTO productoption  	VALUES ('40', '171', '41');
-- product 41
INSERT INTO  product VALUES ('41','Quần shorts  nữ, quần đùi đũi cạp chun - QDD - SLIKY', '75000.00', '55750.00', '10733', '4985', ' LƯU Ý : SHOP KHÔNG NHẬN ĐẶT ĐƠN QUÁ GHI CHÚ VÀ TIN NHẮN. DO PHẦN MÊM IN ĐƠN CỦA SHOPEE KHÔNG HIỂN THỊ. MONG QUÝ KHÁCH THÔNG CẢM ❗️ VUI LÒNG CHỌN ĐÚNG PHÂN LOẠI QUÝ KHÁCH MUỐN MUA Ạ.', '4.9', 'Còn Hàng');
INSERT INTO  optiongroup  VALUES ('172', 'Image');
INSERT INTO  optiongroup  VALUES ('173', 'Image');
INSERT INTO  optiongroup  VALUES ('174', 'Màu');
INSERT INTO  optiongroup  VALUES ('175', 'Màu');
INSERT INTO  optiongroup  VALUES ('176', 'Size');
INSERT INTO  optiongroup  VALUES ('177', 'Size');
INSERT INTO productoption VALUES ('41', '174', 'Be sữa');
INSERT INTO productoption VALUES ('41', '175', 'Đỏ đất');
INSERT INTO productoption VALUES ('41', '176', 'L(53-60kg)');
INSERT INTO productoption VALUES ('41', '177', 'XL(61-73kg)');
INSERT INTO productoption VALUES ('41', '172', 'https://cf.shopee.vn/file/5b39766a0af197121091cf9dedf2f6a2');
INSERT INTO productoption VALUES ('41', '173', 'https://cf.shopee.vn/file/8b0aff41e7c196b3816d384d74f2211f');

-- product 42
INSERT INTO  product VALUES ('42', 'ÁO THUN TAY LỠ FORM RỘNG CÁ TÍNH CÓ UP VIDEO HÀNG THÂT', '65000.00', '35999.00', '74653', '10843', 'Áo thun tay lỡ form rộng', '4.9', 'Còn Hàng');
INSERT INTO  optiongroup  VALUES ('178', 'Image');
INSERT INTO  optiongroup  VALUES ('179', 'Image');
INSERT INTO  optiongroup  VALUES ('180', 'Màu Sắc');
INSERT INTO  optiongroup  VALUES ('181', 'Màu Sắc');
INSERT INTO  optiongroup  VALUES ('182', 'Kích Cỡ');

-- product 43
INSERT INTO  product VALUES ('43', 'Quần Jogger SPUN 3 Màu Unisex (ĐEN S & ĐEN M ngắn hơn 2cm so Với XÁM và TRẮNG ạ)', '150000.00', '79000.00', '827', '3874', 'RIÊNG ĐEN S & ĐEN M ngắn hơn 2cm so Với XÁM và TRẮNG các bạn nhé (Vải mới ra lò nên Co lại 1 chút ạ)', '4.9', 'Còn Hàng');
INSERT INTO  optiongroup  VALUES ('183', 'Image');
INSERT INTO  optiongroup  VALUES ('184', 'Image');
INSERT INTO  optiongroup  VALUES ('185', 'Màu-Kiểu');
INSERT INTO  optiongroup  VALUES ('186', 'Màu-Kiểu');
INSERT INTO  optiongroup  VALUES ('187', 'Size');
INSERT INTO  optiongroup  VALUES ('188', 'Size');
INSERT INTO productoption VALUES ('43', '183', 'https://cf.shopee.vn/file/719c5bbc11355bec5097f39d50c636dc');
INSERT INTO productoption VALUES ('43', '184', 'https://cf.shopee.vn/file/1eb11f52ac8a2771a21db322979edcf2');
INSERT INTO productoption VALUES ('43', '185', 'Trắng-Thêu Spun');
INSERT INTO productoption VALUES ('43', '186', 'Đen- Trơn');
INSERT INTO productoption VALUES ('43', '187', 'Size L');
INSERT INTO productoption VALUES ('43', '188', 'Size XL');

-- product 44
INSERT INTO  product VALUES ('44','(Ảnh chính chủ) Áo croptop nút 2 màu giới hạn', '62000.00', '62000.00', '950', '7392', 'SẢN PHẨM ĐƯỢC MAY VÀ CHỤP ẢNH BỞI PINKYSTORE, HÌNH CHÍNH CHỦ CỦA SHOP MÌNH CHỤP Ạ', '5.0', 'Còn Hàng');
INSERT INTO  optiongroup  VALUES ('189', 'Image');
INSERT INTO  optiongroup  VALUES ('190', 'Image');
INSERT INTO  optiongroup  VALUES ('191', 'Màu Sắc');
INSERT INTO  optiongroup  VALUES ('192', 'Màu Sắc');
INSERT INTO productoption VALUES ('44', '189', 'https://cf.shopee.vn/file/1fe7167032b2113924b879f38189cb92');
INSERT INTO productoption VALUES ('44', '190', 'https://cf.shopee.vn/file/be8b6ff65a260f6c4a2581c1cda141b6');
INSERT INTO productoption VALUES ('44', '191', 'Hồng');
INSERT INTO productoption VALUES ('44', '192', 'Tím');
-- product 45
INSERT INTO  product VALUES ('45', 'ÁO THUN trơn 11 Màu UNISEX', '130000.00', '69000.00', '1732', '13503', 'Bảng SIZE: Quần / Áo form châu Âu rộng rộng nhé các cậu ', '5.0', 'Còn Hàng');
INSERT INTO  optiongroup  VALUES ('193', 'Image');
INSERT INTO  optiongroup  VALUES ('194', 'Image');
INSERT INTO  optiongroup  VALUES ('195', 'MÀU');
INSERT INTO  optiongroup  VALUES ('196', 'MÀU');
INSERT INTO  optiongroup  VALUES ('197', 'SIZE');
INSERT INTO  optiongroup  VALUES ('198', 'SIZE');
INSERT INTO productoption VALUES ('45', '193', 'https://cf.shopee.vn/file/23ddb42a39d593e83d52c643853d172c');
INSERT INTO productoption VALUES ('45', '194', 'https://cf.shopee.vn/file/4c371d251a9f08908fec82bda8b076a0');
INSERT INTO productoption VALUES ('45', '195', 'Xanh Biển');
INSERT INTO productoption VALUES ('45', '196', 'Xanh Chuối');
INSERT INTO productoption VALUES ('45', '197', 'L');
INSERT INTO productoption VALUES ('45', '198', 'XL');
-- product 46
INSERT INTO  product VALUES ('46','Quần kẻ karo to mẫu mới', '42000.00', '42000.00', '11942', '6890', 'Chất Thô mềm có hai màu chủ đạo là kẻ vàng và kẻ đen ', '4.8', 'Còn Hàng');
INSERT INTO  optiongroup  VALUES ('199', 'Image');
INSERT INTO  optiongroup  VALUES ('200', 'Image');
INSERT INTO  optiongroup  VALUES ('201', 'Màu Sắc');
INSERT INTO  optiongroup  VALUES ('202', 'Màu Sắc');
INSERT INTO  optiongroup  VALUES ('203', 'Kích Cỡ');
INSERT INTO productoption VALUES ('46', '199', 'https://cf.shopee.vn/file/149d0500ba4f75c65c6f6f8ebae584b2');
INSERT INTO productoption VALUES ('46', '200', 'https://cf.shopee.vn/file/ccc3aa5e2cb8e4cbfb4a325da42e2f7a');
INSERT INTO productoption VALUES ('46', '201', 'Kẻ Than');
INSERT INTO productoption VALUES ('46', '202', 'Kẻ vàng đậm');
INSERT INTO productoption VALUES ('46', '203', 'Freesize');
-- product 47
INSERT INTO  product VALUES ('47','Áo Khoác Hoodie OHOH 2 Màu TAY PHỒNG Unisex (Form lửng - Đầu khóa màu ĐEN)', '250000.00', '135000.00', '491', '2603', 'Bảng SIZE: Quần / Áo form châu Âu rộng rộng nhé các cậu ', '5.0', 'Còn Hàng');
INSERT INTO  optiongroup  VALUES ('204', 'Image');
INSERT INTO  optiongroup  VALUES ('205', 'Image');
INSERT INTO  optiongroup  VALUES ('206', 'MÀU');
INSERT INTO  optiongroup  VALUES ('207', 'MÀU');
INSERT INTO  optiongroup  VALUES ('208', 'Size');
INSERT INTO  optiongroup  VALUES ('209', 'Size');
INSERT INTO productoption VALUES ('47', '204', 'https://cf.shopee.vn/file/42e9416e2dfe04e70f65d0e246a78d42');
INSERT INTO productoption VALUES ('47', '205', 'https://cf.shopee.vn/file/c8310b17da07cc447430240f4c82c15d');
INSERT INTO productoption VALUES ('47', '206', 'Trắng');
INSERT INTO productoption VALUES ('47', '207', 'Xám');
INSERT INTO productoption VALUES ('47', '208', 'Size L');
INSERT INTO productoption VALUES ('47', '209', 'Size XL');
-- product 48
INSERT INTO  product VALUES ('48', 'Bộ Pijama Phi Lụa Cao Cấp Hàng VNXK', '80000.00', '45000.00', '23', '1294', 'Bộ Pijama Phi Lụa Cao Cấp Hàng VNXK', '4.8', 'Còn Hàng');
INSERT INTO  optiongroup  VALUES ('210', 'Image');
INSERT INTO  optiongroup  VALUES ('211', 'Image');
INSERT INTO  optiongroup  VALUES ('212', 'Size');
INSERT INTO productoption VALUES ('48', '210', 'https://cf.shopee.vn/file/36deb7e2f11c21df3d3b1420e7b1dc28');
INSERT INTO productoption VALUES ('48', '211', 'https://cf.shopee.vn/file/36deb7e2f11c21df3d3b1420e7b1dc28');
INSERT INTO productoption VALUES ('48', '212', 'Size M(40-48kg)');
-- product 49
INSERT INTO  product      VALUES ('49',  'Áo khoác kaki nam nữ bigsize', '180000.00', '117000.00', '120', '0', '- Thích hợp cho cả nam và nữ mọi lứa tuổi ', '0.0', 'Còn Hàng');
INSERT INTO  optiongroup  VALUES ('213', 'Image');
INSERT INTO  optiongroup  VALUES ('214', 'Image');
INSERT INTO  optiongroup  VALUES ('215', 'Màu Sắc');
INSERT INTO  optiongroup  VALUES ('216', 'Màu Sắc');
INSERT INTO  optiongroup  VALUES ('217', 'Kích Cỡ');
INSERT INTO  optiongroup  VALUES ('218', 'Kích Cỡ');
INSERT INTO productoption VALUES ('49', '213', 'https://cf.shopee.vn/file/50410d2a70b3675cc0cc61668c0cb4c5');
INSERT INTO productoption VALUES ('49', '214', 'https://cf.shopee.vn/file/545e483471208004cb1cdf3915f099ed');
INSERT INTO productoption VALUES ('49', '215', 'Đen');
INSERT INTO productoption VALUES ('49', '216', 'Rêu');
INSERT INTO productoption VALUES ('49', '217', 'L');
INSERT INTO productoption VALUES ('49', '218', 'XL');
-- product 50
INSERT INTO  product 	  VALUES ('50', 'FREE SHIP 50K - Áo thun nữ Mickey hot trend năm 2020 thời trang nữ giá rẻ', '150000.00', '75000.00', '499', '300', 'Áo thun nữ Quảng Châu, mẫu đang hot trend trên mạng 2020.', '5.0', 'Còn Hàng');
INSERT INTO  optiongroup  VALUES ('219', 'Image');
INSERT INTO  optiongroup  VALUES ('220', 'Image');
INSERT INTO productoption VALUES ('50', '219', 'https://cf.shopee.vn/file/53b3743a15f30490a99b65387b28c387');
INSERT INTO productoption VALUES ('50', '220', 'https://cf.shopee.vn/file/651812e609d978138544d688f2abbc7e');
-- product 51
INSERT INTO product VALUES ('51',  'Ví nữ dài đẹp đựng tiền cầm tay nhiều ngăn thời trang cao cấp VD69', '35000.00', '22000.00', '4761', '50689', 'Ví nữ dài đẹp đựng tiền cầm tay nhiều ngăn thời trang cao cấp VD69', '4.9', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('221', 'Image');
INSERT INTO optiongroup VALUES ('222', 'Image');
INSERT INTO optiongroup VALUES ('223', 'Variation');
INSERT INTO optiongroup VALUES ('224', 'Variation');
INSERT INTO productoption VALUES ('51', '221', 'https://cf.shopee.vn/file/6b14c18fe17665a5436146b275a6c3b9');
INSERT INTO productoption VALUES ('51', '222', 'https://cf.shopee.vn/file/ef08f8d3dea85cb84a552b04a305862c');
INSERT INTO productoption VALUES ('51', '223', 'VD69 Hồng Đậm');
INSERT INTO productoption VALUES ('51', '224', 'VD69 Hồng Nhạt');

-- product 52
INSERT INTO product VALUES ('52',  'Túi tote vải vanvas đeo chéo trơn mềm đi học đẹp giá rẻ TX29', '45000.00', '39000.00', '221', '10004', 'Túi tote vải bố đựng đồ canvas đeo chéo ATTITUDE TX29', '4.9', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('225', 'Image');
INSERT INTO optiongroup VALUES ('226', 'Image');
INSERT INTO optiongroup VALUES ('227', 'Variation');
INSERT INTO optiongroup VALUES ('228', 'Variation');
INSERT INTO productoption VALUES ('52', '225', 'https://cf.shopee.vn/file/7a375c71de16a52eabff11b2c5ffce51');
INSERT INTO productoption VALUES ('52', '226', 'https://cf.shopee.vn/file/3fa99d899ef02d7bb4a10b60cb33ef4f');
INSERT INTO productoption VALUES ('52', '227', 'tx29 đỏ');
INSERT INTO productoption VALUES ('52', '228', 'tx29 đen');
-- product 53
INSERT INTO product VALUES ('53', 'Túi vải canvas giá rẻ thời trang đeo vai đựng đồ giá rẻ TX14', '90000.00', '49000.00', '836', '23234', 'Túi tote vải bố đựng đồ canvas đeo chéo NETA TX14', '4.9', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('229', 'Image');
INSERT INTO optiongroup VALUES ('230', 'Image');
INSERT INTO optiongroup VALUES ('231', 'Variation');
INSERT INTO optiongroup VALUES ('232', 'Variation');
INSERT INTO productoption VALUES ('53', '229', 'https://cf.shopee.vn/file/b013e146503eea64ae1ef2f69abba2ac');
INSERT INTO productoption VALUES ('53', '230', 'https://cf.shopee.vn/file/5074f3ae9a876bc7ef433df004020a98');
INSERT INTO productoption VALUES ('53', '231', 'tx14 hồng');
INSERT INTO productoption VALUES ('53', '232', 'tx14 vàng');
-- product 54
INSERT INTO product VALUES ('54',  'Ví nữ ngắn đẹp cầm tay mini nhỏ gọn bỏ túi nhiều ngăn dễ thương VD68', '23000.00', '13900.00', '175', '620', 'Ví nữ đẹp mini cầm tay  VD68', '4.9', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('233', 'Image');
INSERT INTO optiongroup VALUES ('234', 'Image');
INSERT INTO optiongroup VALUES ('235', 'VD68');
INSERT INTO optiongroup VALUES ('236', 'VD68');
INSERT INTO productoption VALUES ('54', '233', 'https://cf.shopee.vn/file/2c8f523f713e288d9b0a2f6fef809014');
INSERT INTO productoption VALUES ('54', '234', 'https://cf.shopee.vn/file/8d405e6e0cf2f2b76329e43cce2ca461');
INSERT INTO productoption VALUES ('54', '235', 'VD68 Hồng Nhạt');
INSERT INTO productoption VALUES ('54', '236', 'VD68 Đen');
-- product 55
INSERT INTO product VALUES ('55', 'Túi tote đẹp vải canvas đeo chéo mềm đi học giá rẻ TX436', '169000.00', '159000.00', '47', '1', 'Túi tote đẹp vải canvas đeo chéo mềm đi học giá rẻ TX436', '5.0', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('237', 'Image');
INSERT INTO optiongroup VALUES ('238', 'Image');
INSERT INTO optiongroup VALUES ('239', 'TX436');
INSERT INTO optiongroup VALUES ('240', 'TX436');
INSERT INTO productoption VALUES ('55', '237', 'https://cf.shopee.vn/file/4bddf436509ff39658d9b08cc081e3a2');
INSERT INTO productoption VALUES ('55', '238', 'https://cf.shopee.vn/file/117bbcdee438dbb7b0406a3f45bc3446');
INSERT INTO productoption VALUES ('55', '239', 'TX436 Vàng');
INSERT INTO productoption VALUES ('55', '240', 'TX436 Đen');

-- product 56
INSERT INTO product VALUES ('56','Ví nữ mini ngắn đẹp cầm tay thời trang cao cấp nhỏ gọn bỏ túi VD40', '23000.00', '13900.00', '4581', '446', 'Ví nữ đẹp mini cầm tay  VD40', '5.0', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('241', 'Image');
INSERT INTO optiongroup VALUES ('242', 'Image');
INSERT INTO optiongroup VALUES ('243', 'VD40');
INSERT INTO optiongroup VALUES ('244', 'VD40');
INSERT INTO productoption VALUES ('56', '241', 'https://cf.shopee.vn/file/c4d871316ab5ac6165d57b9519fcdc91');
INSERT INTO productoption VALUES ('56', '242', 'https://cf.shopee.vn/file/6c067d3ccd4024f3840fb980d512dcd0');
INSERT INTO productoption VALUES ('56', '243', 'VD40 Đen');
INSERT INTO productoption VALUES ('56', '244', 'VD40 Tím Nhạt');
-- product 57
INSERT INTO product VALUES ('57',  'Ví nữ nhỏ gọn bỏ túi mini cao cấp cầm tay đựng tiền cute VD141', '50000.00', '25900.00', '343', '2485', 'Ví nữ ngắn cầm tay mini đẹp VD141', '5.0', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('245', 'Image');
INSERT INTO optiongroup VALUES ('246', 'Image');
INSERT INTO optiongroup VALUES ('247', 'VD141');
INSERT INTO optiongroup VALUES ('248', 'VD141');
INSERT INTO productoption VALUES ('57', '245', 'https://cf.shopee.vn/file/db591d5fd4f71479bb989318e2629213');
INSERT INTO productoption VALUES ('57', '246', 'https://cf.shopee.vn/file/10f569fc559a2a55d73b9e3cd1a369b4');
INSERT INTO productoption VALUES ('57', '247', 'VD141 XANH NHẠT');
INSERT INTO productoption VALUES ('57', '248', 'VD141 ĐỎ');
-- product 58
INSERT INTO product VALUES ('58','Balo Nữ Thời Trang FOREVER YOUNG Phong Cách Hàn Quốc Siêu Đẹp FY14 - TUKADO', '450000.00', '235000.00', '7', '102', 'Balo Nữ Thời Trang FOREVER YOUNG Phong Cách Hàn Quốc Siêu Đẹp FY14', '5.0', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('249', 'Image');
INSERT INTO optiongroup VALUES ('250', 'Image');
INSERT INTO optiongroup VALUES ('251', 'MÀU SẮC');
INSERT INTO optiongroup VALUES ('252', 'MÀU SẮC');
INSERT INTO productoption VALUES ('58', '249', 'https://cf.shopee.vn/file/c878b4769ec499f33e8c2f0b146f95aa');
INSERT INTO productoption VALUES ('58', '250', 'https://cf.shopee.vn/file/2c41d6969a578d9eb54a907f7ca4c9be');
INSERT INTO productoption VALUES ('58', '251', 'NÂU');
INSERT INTO productoption VALUES ('58', '252', 'GHI');
-- product 59
INSERT INTO product VALUES ('59','Túi Đeo Chéo Nữ Đựng Điện Thọai FOREVER YOUNG Siêu Đẹp FY02 - Tukado', '250000.00', '139000.00', '48', '88', 'Túi Đeo Chéo Nữ Đựng Điện Thọai FOREVER YOUNG Siêu Đẹp FY02', '4.9', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('253', 'Image');
INSERT INTO optiongroup VALUES ('254', 'Image');
INSERT INTO optiongroup VALUES ('255', 'MÀU SẮC');
INSERT INTO optiongroup VALUES ('256', 'MÀU SẮC');
INSERT INTO productoption VALUES ('59', '253', 'https://cf.shopee.vn/file/2a83c86031296c707090e3e93e203362');
INSERT INTO productoption VALUES ('59', '254', 'https://cf.shopee.vn/file/b495e31fb4ff9862261caefebb7e8f92');
INSERT INTO productoption VALUES ('59', '255', 'PL832-3 Đỏ');
INSERT INTO productoption VALUES ('59', '256', 'PL832-3 XANH THAN');
-- product 60
INSERT INTO product VALUES ('60', '[XẢ HÀNG]Túi công sở kiêm balo El Vi STAR DOUBLE ZIPPER', '229000.00', '199000.00', '5', '15', 'NHẤN VÀO THEO DÕI SHOP ĐỂ ĐƯỢC TẶNG 7000đ KHI MUA TÚI NÀY', '5.0', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('257', 'Image');
INSERT INTO optiongroup VALUES ('258', 'Image');
INSERT INTO productoption VALUES ('60', '257', 'https://cf.shopee.vn/file/0ed7e3d8e58eca9722b3fe72d24dbab9');
INSERT INTO productoption VALUES ('60', '258', 'https://cf.shopee.vn/file/8b322491d49b9098fe296af1499f3386');
-- product 61
INSERT INTO product VALUES ('61',  '[CHÍNH HÃNG] Mũ Bảo Hiểm Thể Thao X Pro X100 Hình Thú Size (S, M, L)', '258000.00', '199888.00', '1799', '1294', ' Tên sản phẩm: Mũ Bảo Hiểm Thể Thao Nữa Đầu X Pro Hình Thú', '4.9', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('259', 'Image');
INSERT INTO optiongroup VALUES ('260', 'Image');
INSERT INTO optiongroup VALUES ('261', 'Mẫu');
INSERT INTO optiongroup VALUES ('262', 'Mẫu');
INSERT INTO optiongroup VALUES ('263', 'Size');
INSERT INTO optiongroup VALUES ('264', 'Size');

INSERT INTO productoption VALUES ('61', '259', 'https://cf.shopee.vn/file/97b6ea2f6427bf8d560297ff6d38ae83');
INSERT INTO productoption VALUES ('61', '260', 'https://cf.shopee.vn/file/098c3fecf6a6c224c934d673fc924d49');
INSERT INTO productoption VALUES ('61', '261', 'KL Màu Cam(X0001)');
INSERT INTO productoption VALUES ('61', '262', 'Cá Mập Cam(X0009)');
INSERT INTO productoption VALUES ('61', '263', 'M');
INSERT INTO productoption VALUES ('61', '264', 'L');

-- product 62
INSERT INTO product VALUES ('62','Bơm lốp ô tô, xe hơi điện tử thông minh AIKESI Đầu Cắm Tẩu Sạc 12v (Qùa Tặng 4 Lắp chụp Van và 2 đầu bơm)', '329000.00', '329000.00', '9', '23', 'Thông số kỹ thuật: Màn hình hiển thị điện tử', '4.6', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('265', 'Image');
INSERT INTO optiongroup VALUES ('266', 'Image');
INSERT INTO productoption VALUES ('62', '265', 'https://cf.shopee.vn/file/dbf6407502f1f44f4b5bc29c691be9fd');
INSERT INTO productoption VALUES ('62', '266', 'https://cf.shopee.vn/file/4e0789d49370c3e8ee53c22405321e75');


-- product 63
INSERT INTO product VALUES ('63','4 miếng [Full box Cao cấp]dán kính ô tô size lớn', '119000.00', '83300.00', '992', '6', 'ACCCCCCCCCC', '5.0', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('267', 'Image');
INSERT INTO productoption VALUES ('63', '267', 'https://cf.shopee.vn/file/c5bb125c0d6f7180b3f2d66c9cf79ec7');
-- product 64
INSERT INTO product VALUES ('64','1 túi bi xe đạp 7li - 8li Siêu rẻ', '15000.00', '15000.00', '674', '326', 'SHOP NÁ CAO SU CAO CẤP_LOẠI 1', '5.0', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('268', 'Image');
INSERT INTO optiongroup VALUES ('269', 'Image');
INSERT INTO productoption VALUES ('64', '268', 'https://cf.shopee.vn/file/02fe42d46a165271aecdb181d95fc827');
INSERT INTO productoption VALUES ('64', '269', 'https://cf.shopee.vn/file/12e1f2eadd183c1020c1799705b7b9e5');


-- product 65	
INSERT INTO product VALUES ('65', 'Xe Đạp Trẻ Em Jianer Có Giảm Xóc, Vành Đúc, 2 Phanh Đĩa, Tay Lái Gấp Gọn Đủ Màu Sắc', '2049000.00', '2049000.00', '194', '3', 'sale sale sốc, không đâu rẻ hơn Bicyclekid', '4.3', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('270', 'Image');
INSERT INTO optiongroup VALUES ('271', 'Image');
INSERT INTO optiongroup VALUES ('272', 'Variation');
INSERT INTO optiongroup VALUES ('273', 'Variation');
INSERT INTO productoption VALUES ('65', '270', 'https://cf.shopee.vn/file/33a875b8ea251e45a07f310b886abe2f');
INSERT INTO productoption VALUES ('65', '271', 'https://cf.shopee.vn/file/b2766b90b66dbc145c069936f0c9b962');
INSERT INTO productoption VALUES ('65', '272', 'Nâu Cafe,12 inchs');
INSERT INTO productoption VALUES ('65', '273', 'Vàng Chanh,14 inchs');


-- product 66	
INSERT INTO product VALUES ('66', 'NGỰA VÀNG ĐỒNG HỒ NƯỚC HOA PHONG THUỶ - MÃ ĐÁO THÀNH CÔNG - Để Trên Ô Tô/Bàn Làm Việc', '360000.00', '235000.00', '5', '2', '-Tượng làm bằng chất liệu hợp kim mạ vàng 24K. ', '5.0', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('274', 'Image');
INSERT INTO optiongroup VALUES ('275', 'Image');
INSERT INTO productoption VALUES ('66', '274', 'https://cf.shopee.vn/file/b68a93eb65ed98a40a3adbab98969607');
INSERT INTO productoption VALUES ('66', '275', 'https://cf.shopee.vn/file/e8daddf27df0d26fd5d6d3f4410419f9');
-- product 67
INSERT INTO product VALUES ('67', 'Bảng ghi số điện thoại cho ô tô, xe hơi phát quang kèm đế cài điện thoại tiện dụng (mẫu 6)', '54000.00', '29000.00', '108', '491', 'Thanh dán số điện thoại bằng kim loại', '4.9', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('276', 'Image');
INSERT INTO optiongroup VALUES ('277', 'Image');
INSERT INTO optiongroup VALUES ('278', 'Màu');
INSERT INTO productoption VALUES ('67', '276', 'https://cf.shopee.vn/file/452e0949b6b1106871f5e11c11e3da14');
INSERT INTO productoption VALUES ('67', '277', 'https://cf.shopee.vn/file/4d24ade667b242b2bf9bb3f6a18d56ac');
INSERT INTO productoption VALUES ('67', '278', 'Đen');

-- product 68
INSERT INTO product VALUES ('68',  'Nắp bình nước trong suốt và màu khói dành cho dè con Ab Airblade Click Vario gắn nhu Zin siêu đẹp. DoChoiXeMay', '90000.00', '65000.00', '583', '402', 'Sản phẩm nắp bình nước ', '4.9', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('279', 'Image');
INSERT INTO optiongroup VALUES ('280', 'Image');
INSERT INTO optiongroup VALUES ('281', 'Màu Sắc');
INSERT INTO optiongroup VALUES ('282', 'Màu Sắc');
INSERT INTO productoption VALUES ('68', '279', 'https://cf.shopee.vn/file/4540b1b2bcc00e432251ca79a039b10c');
INSERT INTO productoption VALUES ('68', '280', 'https://cf.shopee.vn/file/fd21d879061c964a0254c950259f677e');
INSERT INTO productoption VALUES ('68', '281', 'Trong Suốt');
INSERT INTO productoption VALUES ('68', '282', 'Xám Khói');

-- product 69
INSERT INTO product VALUES ('69',  '[NHẬP SHOPAOGHE GIẢM NGAY 100K ] ÁO GHẾ Ô TÔ LƯỚI TẢN NHIỆT 10D DA CAO CẤP - KÈM 2 TỰA ĐẦU CAO CẤP', '3132000.00', '1566000.00', '100', '0', 'ÁO GHẾ 10D CAO CẤP CÓ GÌ KHÁC SO VỚI CÁC MẪU ÁO GHẾ TRÊN THỊ TRƯỜNG:', '0.0', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('283', 'Image');
INSERT INTO optiongroup VALUES ('284', 'Image');
INSERT INTO optiongroup VALUES ('285', 'Phân Loại 1');
INSERT INTO optiongroup VALUES ('286', 'Phân Loại 1');
INSERT INTO productoption VALUES ('69', '283', 'https://cf.shopee.vn/file/ac2b78569ea67f4a47eb2951142436c4');
INSERT INTO productoption VALUES ('69', '284', 'https://cf.shopee.vn/file/db1c26367599aebcd074289bc5555741');
INSERT INTO productoption VALUES ('69', '285', 'KEM');
INSERT INTO productoption VALUES ('69', '286', 'ĐỎ');
-- product 70
INSERT INTO product VALUES ('70',  'Bạt phủ Ô tô 3 lớp chống mưa nắng, bảo vệ sơn và nội thất', '355000.00', '355000.00', '28', '1', 'Bạt che phủ ôtô được làm từ chất liệu cao cấp, bền bỉ, rất tốt cho việc bảo vệ xe ô tô của bạn trước nắng, mưa, bụi bẩn... và tác động từ môi trường.', '0.0', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('287', 'Image');
INSERT INTO optiongroup VALUES ('288', 'Image');
INSERT INTO optiongroup VALUES ('289', 'Kích Cỡ');
INSERT INTO optiongroup VALUES ('290', 'Kích Cỡ');
INSERT INTO productoption VALUES ('70', '287', 'https://cf.shopee.vn/file/3bcc81e41bc0f57cb133af85c6a92071');
INSERT INTO productoption VALUES ('70', '288', 'https://cf.shopee.vn/file/5184425b3ae0a47cb5392cc2aeacc277');
INSERT INTO productoption VALUES ('70', '289', 'L');
INSERT INTO productoption VALUES ('70', '290', 'XL');
-- product 71
INSERT INTO product VALUES ('71',  'ÁO YẾM ĂN DẶM IKEA KLADDIG cao cấp _Hàng Chính Hãng', '139000.00', '139000.00', '85', '3', 'Thiết kế tiện dụng', '5.0', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('291', 'Image');
INSERT INTO optiongroup VALUES ('292', 'Image');
INSERT INTO productoption VALUES ('71', '291', 'https://cf.shopee.vn/file/6850252c9337f482efb5bd9a9462a69c');
INSERT INTO productoption VALUES ('71', '292', 'https://cf.shopee.vn/file/f7ebbf728af263ecc7cfb2ac8a7f1b84');
-- product 72
INSERT INTO product VALUES ('72', 'LĂN BÔI TRỊ MUỖI ĐỐT VÀ CÔN TRÙNG CẮN MUHI', '150000.00', '150000.00', '5', '9', 'LĂN BÔI TRỊ MUỖI ĐỐT VÀ CÔN TRÙNG CẮN MUHI', '5.0', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('293', 'Image');
INSERT INTO productoption VALUES ('72', '293', 'https://cf.shopee.vn/file/19a5c410532c510d06d02ca2d24b8538');

-- product 73
INSERT INTO product VALUES ('73', 'Combo 10 chiếc bỉm quần MIJUKU dùng thử size M/L/XL', '39000.00', '39000.00', '2887', '125', 'Đây là những g ảnh chân thực nhất, sắc nét nhất.', '5.0', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('294', 'Image');
INSERT INTO optiongroup VALUES ('295', 'Image');
INSERT INTO optiongroup VALUES ('296', 'Màu Sắc');
INSERT INTO optiongroup VALUES ('297', 'Size');
INSERT INTO optiongroup VALUES ('298', 'Size');
INSERT INTO productoption VALUES ('73', '294', 'https://cf.shopee.vn/file/f1efd4795dd4701cc008542a41396ffb');
INSERT INTO productoption VALUES ('73', '295', 'https://cf.shopee.vn/file/dec8bec0b6f53107f29db271f4c81676');
INSERT INTO productoption VALUES ('73', '296', 'Trắng');
INSERT INTO productoption VALUES ('73', '297', 'L');
INSERT INTO productoption VALUES ('73', '298', 'XL');
-- product 74
INSERT INTO product VALUES ('74',  '[Nhập MKBMT6 Giảm 6% Đơn từ 399K] Tã Quần Pampers Điều Hoà Gói Lớn L60/XL52/XXL44', '399000.00', '280000.00', '143', '852', 'Mùa hè là thời điểm bé luôn có nhiều thời gian dành cho các hoạt động vui chơi, chính vì vậy thời gian này mẹ luôn lựa chọn các sản phẩm giúp bé vận động thoải mái để bé tận hưởng mùa hè của mình. ', '4.9', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('299', 'Image');
INSERT INTO optiongroup VALUES ('300', 'Image');
INSERT INTO optiongroup VALUES ('301', 'Size');
INSERT INTO optiongroup VALUES ('302', 'Size');
INSERT INTO productoption VALUES ('74', '299', 'https://cf.shopee.vn/file/532b31027e291ee29a9f35fa3bbd0b3c');
INSERT INTO productoption VALUES ('74', '300', 'https://cf.shopee.vn/file/87a1b68ac00af26fb04c508566d1152d');
INSERT INTO productoption VALUES ('74', '301', 'XL52');
INSERT INTO productoption VALUES ('74', '302', 'XXL44');
-- product 75
INSERT INTO product VALUES ('75','Địu EG 360 Baby', '325000.00', '325000.00', '80', '425', 'KHÁCH LƯU Ý: TẤT CẢ ẢNH ĐỀU LÀ SHOP TỰ CHỤP, SHOP KHÁC VUI LÒNG KHÔNG LẤY DƯỚI MỌI HÌNH THỨC!!! ', '5.0', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('303', 'Image');
INSERT INTO optiongroup VALUES ('304', 'Image');
INSERT INTO optiongroup VALUES ('305', 'Màu Sắc');
INSERT INTO optiongroup VALUES ('306', 'Màu Sắc');
INSERT INTO productoption VALUES ('75', '303', 'https://cf.shopee.vn/file/d2518b32fd9fb7fd779ac56a26dcb0a5');
INSERT INTO productoption VALUES ('75', '304', 'https://cf.shopee.vn/file/264f2c0e82cf427e0d6f9909205098f6');
INSERT INTO productoption VALUES ('75', '305', 'Màu Số 1');
INSERT INTO productoption VALUES ('75', '306', 'Màu Số 4');
-- product 76	
INSERT INTO product VALUES ('76','[Mã MKBMABBT6 giảm 4% đơn 599k] [Tặng 2 chai 237ml/chai] Bộ 2 lon PediaSure 850g/lon', '1273000.00', '1130000.00', '864', '8642', 'Thực phẩm dinh dưỡng y học cho trẻ 1-10 tuổi PediaSure', '4.9', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('307', 'Image');
INSERT INTO optiongroup VALUES ('308', 'Image');
INSERT INTO productoption VALUES ('76', '307', 'https://cf.shopee.vn/file/b9898a682b55cb13347da86bc1f31667');
INSERT INTO productoption VALUES ('76', '308', 'https://cf.shopee.vn/file/d0308bd4289ff4dbc80bdfa38b6e70dd');
-- product 77	
INSERT INTO product VALUES ('77', 'Combo Dầu Ăn Ajinomoto', '925000.00', '925000.00', '3', '51', 'Xuất xứ: nhật', '5.0', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('309', 'Image');
INSERT INTO productoption VALUES ('77', '309', 'https://cf.shopee.vn/file/dbae749415d5fbc6e9b2a7107e7a35e6');
-- product 78
INSERT INTO product VALUES ('78', 'Sữa Pediasure hương vani 850g date mới nhất 2021', '547000.00', '547000.00', '1130', '2854', 'Pediasure là sữa được các mẹ tin dùng ', '4.9', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('310', 'Image');
INSERT INTO optiongroup VALUES ('311', 'Image');
INSERT INTO productoption VALUES ('78', '310', 'https://cf.shopee.vn/file/6757ed423ee692a3ec90ccc208147d1b');
INSERT INTO productoption VALUES ('78', '311', 'https://cf.shopee.vn/file/144527878848cf9e406e1cdbe53fb303');


-- product 79
INSERT INTO product VALUES ('79', 'Mẫu dùng thử tã dán/quần Pampers Nhật Bản size NB/M 4 miếng', '50000.00', '50000.00', '2972', '880', 'Tã dán Pampers Nhật Bản Cao Cấp', '5.0', 'Còn Hàng');
INSERT INTO optiongroup VALUES ('312', 'Image');
INSERT INTO optiongroup VALUES ('313', 'Image');
INSERT INTO optiongroup VALUES ('314', 'Size');
INSERT INTO optiongroup VALUES ('315', 'Size');
INSERT INTO productoption VALUES ('79', '312', 'https://cf.shopee.vn/file/d51c919ce9e0dd1cded3f79ddb42e23f');
INSERT INTO productoption VALUES ('79', '313', 'https://cf.shopee.vn/file/4a48d19b5420d804b39c6f561c9f9865');
INSERT INTO productoption VALUES ('79', '314', 'NB');
INSERT INTO productoption VALUES ('79', '315', 'M');
-- product 80
INSERT INTO product VALUES ('80', 'Nối dài xe đẩy vovo', '265000.00', '265000.00', '6', '2', '#Noidaichan #vovo #xeday #xeday3tuthe', '5.0', 'Còn hàng');
INSERT INTO optiongroup VALUES ('316', 'Image');
INSERT INTO optiongroup VALUES ('317', 'Image');
INSERT INTO optiongroup VALUES ('318', 'Màu Sắc');
INSERT INTO optiongroup VALUES ('319', 'Màu Sắc');
INSERT INTO productoption VALUES ('80', '316', 'https://cf.shopee.vn/file/820a905a154ce6b53d9219ee1addcdc6');
INSERT INTO productoption VALUES ('80', '317', 'https://cf.shopee.vn/file/8506d0750fbed511c382b398438c070d');
INSERT INTO productoption VALUES ('80', '318', 'Ghi');
INSERT INTO productoption VALUES ('80', '319', 'Đen');
-- product 81
INSERT INTO product VALUES ('81',  'XỊT DƯỠNG KÍCH MỌC TÓC dày và dài, TRỊ RỤNG TÓC, chống hói đầu, Giảm khô xơ, Dưỡng mềm mượt, trị gàu ZOO-ZD01', '89000.00', '89000.00', '378', '418', 'Thông Tin Sản Phẩm: XỊT TINH DẦU BƯỞI KÍCH MỌC TÓC ', '5.0', 'Còn hàng');
INSERT INTO optiongroup VALUES ('320', 'Image');
INSERT INTO optiongroup VALUES ('321', 'Image');
INSERT INTO productoption VALUES ('81', '320', 'https://cf.shopee.vn/file/f1876c6478e2b7aa0aac5f2d02d34a2e');
INSERT INTO productoption VALUES ('81', '321', 'https://cf.shopee.vn/file/ed13d5bcf8158eddb8bbe8ec0de9f9a2');
-- product 82
INSERT INTO product VALUES ('82', '[COSMALL66 -10% ĐH250k]Sữa rửa mặt Cetaphil Gentle Skin Cleanser 125ml', '110000.00', '110000.00', '537', '6494', 'HSD: 03 năm từ ngày sản xuất in trên bao bì sản phẩm ', '4.9', 'Còn hàng');
INSERT INTO optiongroup VALUES ('322', 'Image');
INSERT INTO optiongroup VALUES ('323', 'Image');
INSERT INTO productoption VALUES ('82', '322', 'https://cf.shopee.vn/file/a8feaa9f217d90cbc086494220b96bf2');
INSERT INTO productoption VALUES ('82', '323', 'https://cf.shopee.vn/file/16ca84f6ab38fb78296eef3e087d94e3');
-- product 83	
INSERT INTO product VALUES ('83',  '[COSMALL66 -10% ĐH250k]Sữa dưỡng thể trắng da Vaseline 350ml', '141000.00', '118000.00', '536', '10032', '1/ SỮA DƯỠNG THỂ SÁNG DA TỨC THÌ VASELINE HEALTHY WHITE INSTANT FAIR', '4.9', 'Còn hàng');
INSERT INTO optiongroup VALUES ('324', 'Image');
INSERT INTO optiongroup VALUES ('325', 'Image');
INSERT INTO optiongroup VALUES ('326', 'Variation');
INSERT INTO optiongroup VALUES ('327', 'Variation');
INSERT INTO productoption VALUES ('83', '324', 'https://cf.shopee.vn/file/dd7a6e25f779a5259fa83f7a1abe8ed3');
INSERT INTO productoption VALUES ('83', '325', 'https://cf.shopee.vn/file/0ad790c5e0cc57088acc1a6cd3bafae7');
INSERT INTO productoption VALUES ('83', '326', 'trắng da tức thì');
INSERT INTO productoption VALUES ('83', '327', 'Trắng da 10 lợi ích');
-- product 84
INSERT INTO product VALUES ('84','[COSMALL66 -10% ĐH250k]Combo gội 640g + xả 620g TRESemmé Keratin Smooth Tinh dầu Argan và Keratin vào nếp suôn mượt', '354000.00', '290000.00', '286', '14985', 'TRESemmé là sản phẩm chăm sóc tóc cao cấp đến từ Mỹ, là nhãn hiệu được sử dụng bởi các chuyên gia tại Tuần lễ Thời trang New York - New York Fashion Week', '4.9', 'Còn hàng');
INSERT INTO optiongroup VALUES ('328', 'Image');
INSERT INTO optiongroup VALUES ('329', 'Image');
INSERT INTO productoption VALUES ('84', '328', 'https://cf.shopee.vn/file/9315a2ddeea81330b8d928cf1f836b96');
INSERT INTO productoption VALUES ('84', '329', 'https://cf.shopee.vn/file/4bd74ef81ed1bf091357ea72d3dbc45f');
-- product 85
INSERT INTO product VALUES ('85', 'dầu xả phục hồi tóc khô xơ, hư tổn ozana (100ml)_chính hãng_ozana03', '59000.00', '29500.00', '528', '22', 'Dầu Gội Dầu Xả Thảo Dược Trị Rụng Tóc, Kích Thích Mọc Tóc Không Chứa Hoá Chất:', '5.0', 'Còn hàng');
INSERT INTO optiongroup VALUES ('330', 'Image');
INSERT INTO optiongroup VALUES ('331', 'Image');
INSERT INTO productoption VALUES ('85', '330', 'https://cf.shopee.vn/file/1c068ff66351c7d5fa4299d961875aa9');
INSERT INTO productoption VALUES ('85', '331', 'https://cf.shopee.vn/file/e0af3035a77835a1d20051d0813ec1c6');
-- product 86	
INSERT INTO product VALUES ('86', 'Bộ đôi kem dưỡng giảm mụn, ngừa thâm La Roche Posay Effaclar Duo+ 40ml và Xịt khoáng làm dịu da 50ml', '490000.00', '339000.00', '166', '11984', 'BỘ SẢN PHẨM BAO GỒM:', '4.9', 'Còn hàng');
INSERT INTO optiongroup VALUES ('332', 'Image');
INSERT INTO optiongroup VALUES ('333', 'Image');
INSERT INTO productoption VALUES ('86', '332', 'https://cf.shopee.vn/file/0020175f4c73ffb7d82eea37724fe423');
INSERT INTO productoption VALUES ('86', '333', 'https://cf.shopee.vn/file/0e83b2f880505a5deed51ae2af2bf18f');

-- product 87
INSERT INTO product VALUES ('87', 'Bộ dưỡng da căng mướt trắng sáng & chống nắng toàn diện LOreal Paris', '545000.00', '289000.00', '640', '3856', 'Bộ sản phẩm làm sạch và trắng da L’Oreal thuộc dòng sản phẩm dưỡng trắng White Perfect', '4.9', 'Còn hàng');
INSERT INTO optiongroup VALUES ('334', 'Image');
INSERT INTO optiongroup VALUES ('335', 'Image');
INSERT INTO productoption VALUES ('87', '334', 'https://cf.shopee.vn/file/4e4bb712c307704a5b048d1675d1cdd4');
INSERT INTO productoption VALUES ('87', '335', 'https://cf.shopee.vn/file/78794e795645b137ecdefa30ce60747a');
-- product 88
INSERT INTO product VALUES ('88', '{COMBO 3 GÓI} Dầu gội đen tóc-OZANA (Chính Hãng 100%)-OZA2', '19000.00', '19000.00', '323', '374', 'Thông tin sản phẩm:', '5.0', 'Còn hàng');
INSERT INTO optiongroup VALUES ('336', 'Image');
INSERT INTO optiongroup VALUES ('337', 'Image');

INSERT INTO productoption VALUES ('88', '336', 'https://cf.shopee.vn/file/9f74622959b73da1f7564f4bd413a7a2');
INSERT INTO productoption VALUES ('88', '337', 'https://cf.shopee.vn/file/2cf429bba469c34e81f8104892595f34');
-- product 89
INSERT INTO product VALUES ('89',  '[COSMALL66 -10% ĐH250k]Sữa rửa mặt dành cho da mụn Senka perfect whip acne care 100g_15554', '105000.00', '79000.00', '1642', '26496', 'THÀNH PHẦN ĐẶC TRỊ: KHÁNG VIÊM - NGĂN NGỪA MỤN', '4.9', 'Còn hàng');
INSERT INTO optiongroup VALUES ('338', 'Image');
INSERT INTO optiongroup VALUES ('339', 'Image');
INSERT INTO productoption VALUES ('89', '338', 'https://cf.shopee.vn/file/b535732c0fd3ef1b652607ebf41790b1');
INSERT INTO productoption VALUES ('89', '339', 'https://cf.shopee.vn/file/62a884adecab7bb5f4e3def5d39ad331');
-- product 90
INSERT INTO product VALUES ('90', 'Son Tint Bóng Cho Đôi Môi Căng Mọng Merzy Aurora Dewy Tint 5.5g', '179000.00', '139000.00', '1932', '3054', 'Son Tint Bóng Siêu Lì, Cho Đôi Môi Căng Mọng Merzy Aurora Dewy Tint 5.5g', '4.9', 'Còn hàng');
INSERT INTO optiongroup VALUES ('340', 'Image');
INSERT INTO optiongroup VALUES ('341', 'Image');
INSERT INTO optiongroup VALUES ('342', 'Màu');
INSERT INTO optiongroup VALUES ('343', 'Màu');
INSERT INTO productoption VALUES ('90', '340', 'https://cf.shopee.vn/file/3505f52f9867d6d3fda1d8fce03961ec');
INSERT INTO productoption VALUES ('90', '341', 'https://cf.shopee.vn/file/5a96078085dcf8f3991bd185f602d171');
INSERT INTO productoption VALUES ('90', '342', '#DT2');
INSERT INTO productoption VALUES ('90', '343', '#DT9');
-- product 91
INSERT INTO product VALUES ('91','Máy Phun Sương Khuếch Tán Hơi Nước Gấu CUTE - Phun Sương Tạo Độ Ẩm', '231000.00', '99000.00', '178', '208', 'Máy Phun Sương Khuếch Tán Hơi Nước Gấu CUTE  - Phun Sương Tạo Độ Ẩm', '4.9', 'Còn hàng');
INSERT INTO optiongroup VALUES ('344', 'Image');
INSERT INTO optiongroup VALUES ('345', 'Image');
INSERT INTO optiongroup VALUES ('346', 'Màu Sắc');
INSERT INTO optiongroup VALUES ('347', 'Màu Sắc');
INSERT INTO productoption VALUES ('91', '344', 'https://cf.shopee.vn/file/14f60e388481ed6713bce516e7926f9a');
INSERT INTO productoption VALUES ('91', '345', 'https://cf.shopee.vn/file/34e42aea9b40701db106bc0c79bade6d');
INSERT INTO productoption VALUES ('91', '346', 'Màu Trắng');
INSERT INTO productoption VALUES ('91', '347', 'Màu Xanh');
-- product 92
INSERT INTO product VALUES ('92', 'Robot hút bụi lau nhà DN55 NEW 100% FULLBOX', '8000000.00', '8000000.00', '100', '36', '√ Tặng TÀI KHOẢN ĐĂNG NHẬP APP', '5.0', 'Còn hàng');
INSERT INTO optiongroup VALUES ('348', 'Image');
INSERT INTO optiongroup VALUES ('349', 'Image');
INSERT INTO productoption VALUES ('92', '348', 'https://cf.shopee.vn/file/5163b17a74dda029d5c03e0f0d1dfc48');
INSERT INTO productoption VALUES ('92', '349', 'https://cf.shopee.vn/file/24bebdbe3eb89207739d491666e7c033');
-- product 93
INSERT INTO product VALUES ('93',  'Máy xay sinh tố, thịt, hoa quả, rau đa năng Osaka mẫu mới nhất [Có Tem BH]', '320000.00', '235000.00', '4924', '2634', 'CÓ \"THẺ BẢO HÀNH + TEM BẢO HÀNH 12 THÁNG\" SẼ ĐƯỢC GỬI KÈM. CÁC BẠN BẢO NHÂN TÊN GIAO HÀNG GỌI CHO SHOP ĐỂ SHOP CHO PHEP XEM HÀNG THẬT VÀ THẺ Và TEM BẢO HÀNH ', '4.9', 'Còn hàng');
INSERT INTO optiongroup VALUES ('350', 'Image');
INSERT INTO optiongroup VALUES ('351', 'Image');
INSERT INTO productoption VALUES ('93', '350', 'https://cf.shopee.vn/file/9c4e20475363b99c745aac87f897aa9f');
INSERT INTO productoption VALUES ('93', '351', 'https://cf.shopee.vn/file/a9844c6a81aee508193edc18eeec8ddd');

-- product 94
INSERT INTO product VALUES ('94', 'RON CAO SU DÙNG CHO TẤT CẢ MÁY XAY SINH TỐ ĐƯỜNG KÍNH 8CM, 8,5CM VÀ 9CM- MSCLV', '15000.00', '14700.00', '1028', '57', 'Dùng thay thế cho máy xay sinh tố bị hỏng ron.', '4.5', 'Còn hàng');
INSERT INTO optiongroup VALUES ('352', 'Image');
INSERT INTO optiongroup VALUES ('353', 'Image');
INSERT INTO optiongroup VALUES ('354', 'Kích Thước');
INSERT INTO optiongroup VALUES ('355', 'Kích Thước');
INSERT INTO productoption VALUES ('94', '352', 'https://cf.shopee.vn/file/476205986433c96ad64ea253637330c5');
INSERT INTO productoption VALUES ('94', '353', 'https://cf.shopee.vn/file/8e2e5db60dbcccc4d7622759f890968c');
INSERT INTO productoption VALUES ('94', '354', '8.5cm');
INSERT INTO productoption VALUES ('94', '355', '8cm');
-- product 95
INSERT INTO product VALUES ('95', 'Nồi chiên không dầu Hongxin 6L', '1300000.00', '975000.00', '59', '49', 'Nồi chiên không dầu Hongxin 6L', '5.0', 'Còn hàng');
INSERT INTO optiongroup VALUES ('356', 'Image');
INSERT INTO optiongroup VALUES ('357', 'Image');
INSERT INTO productoption VALUES ('95', '356', 'https://cf.shopee.vn/file/caa9c53dc5619445f4f5711b56e2fe95');
INSERT INTO productoption VALUES ('95', '357', 'https://cf.shopee.vn/file/651250e9a8099ae78ec9b05e3642bf3e');
-- product 96
INSERT INTO product VALUES ('96','Quạt Điều Hòa Mini Hơi Nước Siêu mát, Hàng Mới Đẹp Cao Cấp Mùa Hè 2020, Bảo Hành 12 Tháng', '250000.00', '179000.00', '9257', '3154', 'Hàng Mới 2020🔥 Quạt Đi
ều Hòa Mini Hơi Nước Siêu mát, Hàng Mới Đẹp Cao Cấp Mùa Hè 2020, Bảo Hành 12 Tháng', '4.4', 'Còn hàng');
INSERT INTO optiongroup VALUES ('358', 'Image');
INSERT INTO optiongroup VALUES ('359', 'Image');
INSERT INTO optiongroup VALUES ('360', 'Quạt Điều Hòa');
INSERT INTO optiongroup VALUES ('361', 'Quạt Điều Hòa');
INSERT INTO productoption VALUES ('96', '358', 'https://cf.shopee.vn/file/51f5711c14eaf8229cd54ed819a77353');
INSERT INTO productoption VALUES ('96', '359', 'https://cf.shopee.vn/file/1eec7a632798a3ee408ca6df626241d0');
INSERT INTO productoption VALUES ('96', '360', 'Quạt G02 + Quà Tặng');
INSERT INTO productoption VALUES ('96', '361', 'Quạt Ddiefu Hòa G01');
-- product 97
INSERT INTO product VALUES ('97','Tấm kẽm nối pin lithium- 32650 - sợi kép', '40000.00', '30000.00', '4777', '217', 'MÔ TẢ SẢN PHẨM : Kẽm gắn cell pin LiFePO4 32650 Lithium Sắt Photphat có đục lỗ sẵn, chỉ cần mua về cắt theo ý mình và gắn pin vào thôi.', '5.0', 'Còn hàng');
INSERT INTO optiongroup VALUES ('362', 'Image');
INSERT INTO optiongroup VALUES ('363', 'Image');
INSERT INTO productoption VALUES ('97', '362', 'https://cf.shopee.vn/file/b2cf4354ed5b858b063b3b8702b24964');
INSERT INTO productoption VALUES ('97', '363', 'https://cf.shopee.vn/file/86d4624e2ee587fafb0c4cd17c21b232');
-- product 98
INSERT INTO product VALUES ('98','MÁY HÚT BỤI MINI CẦM TAY 2 CHIỀU VACUUM', '400000.00', '330000.00', '3784', '1854', 'Máy hút bụi mini hai chiều JK - 8 là loại đồ điện gia dụng giúp cho công việc hàng ngày của bạn ở nhà thật đơn giản. Sở hữu chiếc máy hút bụi này rồi bạn sẽ thấy công việc dọn dẹp nhà cửa trở nên thật dễ dàng và thú vị!', '4.9', 'Còn hàng');
INSERT INTO optiongroup VALUES ('364', 'Image');
INSERT INTO optiongroup VALUES ('365', 'Image');
INSERT INTO productoption VALUES ('98', '364', 'https://cf.shopee.vn/file/275f6ba05977b473dfc3b93d7f8ad638');
INSERT INTO productoption VALUES ('98', '365', 'https://cf.shopee.vn/file/de0a75f5807b1eb4f8cdd926ceca064b');
-- product 99 
INSERT INTO product VALUES ('99','Máy Giặt', '400000.00', '330000.00', '3784', '1854', 'Giặt xịn', '4.9', 'Còn hàng');
INSERT INTO optiongroup VALUES ('366', 'Image');
INSERT INTO optiongroup VALUES ('367', 'Image');
INSERT INTO productoption VALUES ('99', '366', 'https://cf.shopee.vn/file/275f6ba05977b473dfc3b93d7f9ad638');
INSERT INTO productoption VALUES ('99', '367', 'https://cf.shopee.vn/file/de0a75f5807b1eb4f8cdd926ceda064b');
-- product 100
INSERT INTO product VALUES ('100','Bàn Là', '40000.00', '30000.00', '4777', '217', 'Bàn Là Sắt', '5.0', 'Còn hàng');
INSERT INTO optiongroup VALUES ('368', 'Image');
INSERT INTO optiongroup VALUES ('369', 'Image');
INSERT INTO productoption VALUES ('100', '368', 'https://cf.shopee.vn/file/b2cf4354ed5b858b063b3b8702b24964');
INSERT INTO productoption VALUES ('100', '369', 'https://cf.shopee.vn/file/86d4624e2ee587fafb0c4cd17c21b232');
-- 13.INSERT INTO productCategory
INSERT INTO productCategory VALUES ('1', '1');
INSERT INTO productCategory VALUES ('1', '2');
INSERT INTO productCategory VALUES ('1', '3');
INSERT INTO productCategory VALUES ('1', '4');
INSERT INTO productCategory VALUES ('1', '5');
INSERT INTO productCategory VALUES ('1', '6');
INSERT INTO productCategory VALUES ('1', '7');
INSERT INTO productCategory VALUES ('1', '8');
INSERT INTO productCategory VALUES ('1', '9');
INSERT INTO productCategory VALUES ('1', '10');
INSERT INTO productCategory VALUES ('2', '11');
INSERT INTO productCategory VALUES ('2', '12');
INSERT INTO productCategory VALUES ('2', '13');
INSERT INTO productCategory VALUES ('2', '14');
INSERT INTO productCategory VALUES ('2', '15');
INSERT INTO productCategory VALUES ('2', '16');
INSERT INTO productCategory VALUES ('2', '17');
INSERT INTO productCategory VALUES ('2', '18');
INSERT INTO productCategory VALUES ('2', '19');
INSERT INTO productCategory VALUES ('2', '20');
INSERT INTO productCategory VALUES ('3', '21');
INSERT INTO productCategory VALUES ('3', '22');
INSERT INTO productCategory VALUES ('3', '23');
INSERT INTO productCategory VALUES ('3', '24');
INSERT INTO productCategory VALUES ('3', '25');
INSERT INTO productCategory VALUES ('3', '26');
INSERT INTO productCategory VALUES ('3', '27');
INSERT INTO productCategory VALUES ('3', '28');
INSERT INTO productCategory VALUES ('3', '29');
INSERT INTO productCategory VALUES ('3', '30');
INSERT INTO productCategory VALUES ('4', '31');
INSERT INTO productCategory VALUES ('4', '32');
INSERT INTO productCategory VALUES ('4', '33');
INSERT INTO productCategory VALUES ('4', '34');
INSERT INTO productCategory VALUES ('4', '35');
INSERT INTO productCategory VALUES ('4', '36');
INSERT INTO productCategory VALUES ('4', '37');
INSERT INTO productCategory VALUES ('4', '38');
INSERT INTO productCategory VALUES ('4', '39');
INSERT INTO productCategory VALUES ('4', '40');
INSERT INTO productCategory VALUES ('5', '41');
INSERT INTO productCategory VALUES ('5', '42');
INSERT INTO productCategory VALUES ('5', '43');
INSERT INTO productCategory VALUES ('5', '44');
INSERT INTO productCategory VALUES ('5', '45');
INSERT INTO productCategory VALUES ('5', '46');
INSERT INTO productCategory VALUES ('5', '47');
INSERT INTO productCategory VALUES ('5', '48');
INSERT INTO productCategory VALUES ('5', '49');
INSERT INTO productCategory VALUES ('5', '50');
INSERT INTO productCategory VALUES ('6', '51');
INSERT INTO productCategory VALUES ('6', '52');
INSERT INTO productCategory VALUES ('6', '53');
INSERT INTO productCategory VALUES ('6', '54');
INSERT INTO productCategory VALUES ('6', '55');
INSERT INTO productCategory VALUES ('6', '56');
INSERT INTO productCategory VALUES ('6', '57');
INSERT INTO productCategory VALUES ('6', '58');
INSERT INTO productCategory VALUES ('6', '59');
INSERT INTO productCategory VALUES ('6', '60');
INSERT INTO productCategory VALUES ('7', '61');
INSERT INTO productCategory VALUES ('7', '62');
INSERT INTO productCategory VALUES ('7', '63');
INSERT INTO productCategory VALUES ('7', '64');
INSERT INTO productCategory VALUES ('7', '65');
INSERT INTO productCategory VALUES ('7', '66');
INSERT INTO productCategory VALUES ('7', '67');
INSERT INTO productCategory VALUES ('7', '68');
INSERT INTO productCategory VALUES ('7', '69');
INSERT INTO productCategory VALUES ('7', '70');
INSERT INTO productCategory VALUES ('8', '71');
INSERT INTO productCategory VALUES ('8', '72');
INSERT INTO productCategory VALUES ('8', '73');
INSERT INTO productCategory VALUES ('8', '74');
INSERT INTO productCategory VALUES ('8', '75');
INSERT INTO productCategory VALUES ('8', '76');
INSERT INTO productCategory VALUES ('8', '77');
INSERT INTO productCategory VALUES ('8', '78');
INSERT INTO productCategory VALUES ('8', '79');
INSERT INTO productCategory VALUES ('8', '80');
INSERT INTO productCategory VALUES ('9', '81');
INSERT INTO productCategory VALUES ('9', '82');
INSERT INTO productCategory VALUES ('9', '83');
INSERT INTO productCategory VALUES ('9', '84');
INSERT INTO productCategory VALUES ('9', '85');
INSERT INTO productCategory VALUES ('9', '86');
INSERT INTO productCategory VALUES ('9', '87');
INSERT INTO productCategory VALUES ('9', '88');
INSERT INTO productCategory VALUES ('9', '89');
INSERT INTO productCategory VALUES ('9', '90');
INSERT INTO productCategory VALUES ('10', '91');
INSERT INTO productCategory VALUES ('10', '92');
INSERT INTO productCategory VALUES ('10', '93');
INSERT INTO productCategory VALUES ('10', '94');
INSERT INTO productCategory VALUES ('10', '95');
INSERT INTO productCategory VALUES ('10', '96');
INSERT INTO productCategory VALUES ('10', '97');
INSERT INTO productCategory VALUES ('10', '98');
INSERT INTO productCategory VALUES ('10', '99');
INSERT INTO productCategory VALUES ('10', '100');

-- insert customer infor

INSERT INTO customer VALUES ('1', 'đỗ tiến định', '1999-6-21', 'dotiendinh1@gmail.com', 'adolhp', '0968686868', 'Hung Yyen', '1');
INSERT INTO customer VALUES ('2', 'lê văn luyện', '1985-9-5', 'luyen23@gmail.com', 'dasg', '0852856334', 'Bac Giang', '1');
INSERT INTO customer VALUES ('3', 'Lee min Hu', '1995-9-23', 'leminho@gmail.com', 'kg3fd', '0335447543', 'Thanh Hoa', '1');
INSERT INTO customer VALUES ('4', 'vu tran lam', '1983-7-9', 'vutranlam1@gmail.com', 'jgkdl', '0987495432', 'Ha Noi', '1');
INSERT INTO customer VALUES ('5', 'phạm thái hoàng', '2001-5-12', 'hoangpt@gmail..com', 'kkjk4', '0567335346', 'ha noi', '1');
INSERT INTO customer VALUES ('6', 'phạm thái lừa', '2003-12-12', 'luapt@gmail.com', 'itr44re', '0884953744', 'bac kan', '1');
INSERT INTO customer VALUES ('7', 'trần đại nghĩa', '1974-1-8', 'tranadainghia@gmail.com', 'jtjrt499', '0784859223', 'tphcm', '1');
INSERT INTO customer VALUES ('8', 'nguyễn hữu minh', '1997-12-4', 'minhhn2@gmail.com', 'congangoc232', '0123451322', 'ha noi', '1');
INSERT INTO customer VALUES ('9', 'lê mai sương', '1998-5-2', 'maisuong11@gmail.com', 'lemaisuong11', '0974923444', 'ha tinh', '1');
INSERT INTO customer VALUES ('10', 'mai nhật ánh', '1999-9-8', 'anhNhatmai@gmail.com', 'anh99dk', '0335754786', 'thanh hoa', '1');
INSERT INTO customer VALUES ('11', 'tran ngoc huyen', '1998-8-28', 'huynhuyn@gmail.com', 'huyenxjnkdep1998', '0987845821', 'quang ninh', '1');
INSERT INTO customer VALUES ('12', 'nguyễn huy thắng', '1989-12-31', 'thagndeptrai@gmail.com', 'deptraiprovjp', '0893588499', 'quang ninh', '1');
INSERT INTO customer VALUES ('13', 'phan văn nhiều tiền', '1991-10-2', 'chacogingoaitien@gmail.com', 'nhieutientieuchahet', '0999999999', 'gia lai', '1');
INSERT INTO customer VALUES ('14', 'bạch công tử', '1999-9-9', 'bachcongtudepzai@gmail.com', 'lamboghini', '0686868688', 'gia lai', '1');
INSERT INTO customer VALUES ('15', 'bùi hoàng', '1999-3-9', 'hoangbui@gmail.com', 'buihoangdep', '0977395548', 'phu tho', '1');
INSERT INTO customer VALUES ('16', 'khánh trắng', '1982-1-20', 'khanhtrang@gmail.com', 'khanhtrang', '0848578994', 'ha noi', '1');
INSERT INTO customer VALUES ('17', 'vu kim chi', '2000-10-4', 'vukimchi@gmail.com', 'kimchi', '0983791022', 'ha noi', '1');
INSERT INTO customer VALUES ('18', 'phan gia long', '1990-04-04', 'gialongphan@gmail.com', 'longphandepzai', '0892315542', 'nam dinh', '1');
INSERT INTO customer VALUES ('19', 'thuận thiếu', '2003-8-1', 'thuanngovan@gmail.com', 'thieugiathuan', '0999838490', 'nam dinh', '1');
INSERT INTO customer VALUES ('20', 'nguyễn hồng sơn', '1996-7-30', 'hongson@gmail.com', 'caothutangai2020', '0898848979', 'ha nam', '1');
INSERT INTO customer VALUES ('21', 'đỗ lâm tùng', '2001-8-29', 'tungdeptrai@gmail.com', 'tunglamcaoto', '0897738490', 'hung yen', '1');
INSERT INTO customer VALUES ('22', 'đỗ năng thực', '1998-11-19', 'thucnang@gmail.com', 'lucsithuc', '0978783658', 'phu tho', '1');
INSERT INTO customer VALUES ('23', 'phạm hồng sơn', '1999-3-2', 'hongsonpham11@gmail.com', 'phamhongson2', '0335323296', 'phu tho', '1');
INSERT INTO customer VALUES ('24', 'vu manh tan', '1987-1-28', 'vumanhtan11@gmail.com', 'tandeptrao', '0987999790', 'quang ninh', '1');
INSERT INTO customer VALUES ('25', 'hoàng thị hường', '1998-9-8', 'huongdeptrai@gmail.com', 'byebye998', '0565638999', 'bac giang', '1');
INSERT INTO customer VALUES ('26', 'tạ văn ước', '1990-9-7', 'uocdeptrai@gmail.com', 'buivanuoc', '0876488768', 'bac giang', '1');
INSERT INTO customer VALUES ('27', 'nguyễn dũng', '1999-4-5', 'nguyendungdevv@gmail.com', 'nguyenvandung', '0987496790', 'hung yen', '1');
INSERT INTO customer VALUES ('28', 'vu hoang long', '1994-7-10', 'longvu11@gmail.com', 'longhoang', '0879923994', 'hung yen ', '1');
INSERT INTO customer VALUES ('29', 'nguyen duy long', '1999-12-4', 'duylong11@gmail.com', 'longgay', '0989395850', 'ha noi', '1');
INSERT INTO customer VALUES ('30', 'Đen Vâu', '1989-5-13', 'denvau@gmail.com', 'denvaudatrang', '0974937492', 'quang ninh', '1');
INSERT INTO customer VALUES ('31', 'hiền hồ', '1997-2-26', 'hienho@gmail.com', 'hienho1111', '0912894758', 'dong nai', '1');
INSERT INTO customer VALUES ('32', 'Min', '1988-12-7', 'mindepgai@gmail.com', 'minnnnnnn', '0768998978', 'ha noi', '1');
INSERT INTO customer VALUES ('33', 'Binz', '1988-5-24', 'binzzzz@gmail.com', 'binzdeprai', '0777777777', 'tp.hcm', '1');
INSERT INTO customer VALUES ('34', 'Phương Ly', '1990-10-28', 'phuongly@gmail.com', 'phuonglyyy', '0938941245', 'cao bang', '1');
INSERT INTO customer VALUES ('35', 'phúc du', '1996-12-25', 'phucanhtruong@gmail.com', 'truonganhphuc', '0982418957', 'ha noi', '1');
INSERT INTO customer VALUES ('36', 'lê thị thùy giang', '1999-04-5', 'giangggheo@gmail.com', 'giangheooo', '0993959900', 'quang nam', '1');
INSERT INTO customer VALUES ('37', 'lê thị thùy dương', '1996-4-17', 'thuyduong@gmail.com', 'duongque', '0987945000', 'quang nam', '1');
INSERT INTO customer VALUES ('38', 'đào văn bính', '1986-9-20', 'binhdaovna@gmail.com', 'bincute', '0976544678', 'bac giang', '1');
INSERT INTO customer VALUES ('39', 'ngô thị ngọc trâm', '1989-9-8', 'tramngoc@gmail.com', 'ngoctram', '0864678964', 'hue', '1');
INSERT INTO customer VALUES ('40', 'lê thị hậu', '1993-8-8', 'haule@gmail.com', 'lehau00', '0527384995', 'hung yen', '1');
INSERT INTO customer VALUES ('41', 'lâm thị thảo anh', '1997-6-3', 'lamthaoanh@gmail.com', 'thaoanh', '0975937657', 'thai binh', '1');
INSERT INTO customer VALUES ('42', 'hoàng thị yến', '1993-04-19', 'cun@gmail.com', 'cuncute', '0457485789', 'thai binh', '1');
INSERT INTO customer VALUES ('43', 'đỗ thanh tùng', '1999-3-1', 'tungthanhdo@gmail.com', 'tungnhagiau', '0938947900', 'hung yen', '1');
INSERT INTO customer VALUES ('44', 'đỗ văn dũng', '1996-8-3', 'dungdovan@gmail.com', 'dungdovan23@gmail.com', '0812739590', 'hung yen', '1');
INSERT INTO customer VALUES ('45', 'đỗ quang khải', '1998-10-1', 'khaiyen@gmail.com', 'khaijapan', '0974791241', 'hung yen', '1');
INSERT INTO customer VALUES ('46', 'lâm thanh tâm', '1999-12-24', 'lamthanhtam@gmail.com', 'lamthanhtam', '0987665579', 'quang nam', '1');
INSERT INTO customer VALUES ('47', 'đặng minh quang', '1998-12-3', 'quangdang22@gmail.com', 'dangminhquang', '0873012370', 'binh minh', '1');
INSERT INTO customer VALUES ('48', 'đặng mỹ hạnh', '1999-3-5', 'hanh@gmail.com', 'danghang', '0931239590', 'phu tho', '1');
INSERT INTO customer VALUES ('49', 'đoàn văn thạch', '2000-3-12', 'thach@gmail.com', 'thach', '0182390514', 'hai duong', '1');
INSERT INTO customer VALUES ('50', 'Đào Văn Đức', '1991-4-7', 'daovanduc@gmail.com', 'ducdevdeptrai', '0948210345', 'thai binh', '1');
INSERT INTO customer VALUES ('51', 'nguyễn minh thông', '2001-2-6', 'thongdeptria@gmail.com', 'thongggggggg', '0123253205', 'bac giang', '1');

-- INSERT INTO shipping address

INSERT INTO shippingAddress VALUES ('1', '1', 'do van dung', '0974959202', 'doi 9 - nhu quynh-van lam - hung yen');
INSERT INTO shippingAddress VALUES ('2', '2', 'do tien dinh', '0984859201', '18-tam trinh-hai ba trung - ha noi');
INSERT INTO shippingAddress VALUES ('3', '3', 'le van luyen', '0432453251', 'hiep hoa- bac giang');
INSERT INTO shippingAddress VALUES ('4', '4', 'le van a', '0512850202', '120-hang bong- ha noi');
INSERT INTO shippingAddress VALUES ('5', '5', 'lee min hu', '0549432030', '65-47 pho nguyen thai hoc - van mieu - ha noi');
INSERT INTO shippingAddress VALUES ('6', '6', 'le minh ha', '0512232221', '2 phan boi chau - cua nam - hoan kiem - ha noi');
INSERT INTO shippingAddress VALUES ('7', '7', 'vu tran lam', '0549924231', '18-tam trinh- hai ba trung - ha noi');
INSERT INTO shippingAddress VALUES ('8', '8', 'vu tran lam', '0549924231', '85-le duc tho - ba dinh - ha noi');
INSERT INTO shippingAddress VALUES ('9', '9', 'pham thai hoang', '0984219406', 'VTC Academy-tam trinh- hai ba trung - ha noi');
INSERT INTO shippingAddress VALUES ('10', '10', 'pham thai lo', '0812340412', 'Testino- ngo 139 tam trinh - hai ba trung - ha noi');
INSERT INTO shippingAddress VALUES ('11', '11', 'phamthailua', '0912485295', '38b- nguyen thai hoc');
INSERT INTO shippingAddress VALUES ('12', '12', 'pham thai lua', '0941238244', 'ton duc thang');
INSERT INTO shippingAddress VALUES ('13', '13', 'tran dai nghia', '0342143249', '32 tong duy tan - hoan kiem - ha noi');
INSERT INTO shippingAddress VALUES ('14', '14', 'tran dai nghia', '0412841245', '64 hang bo - hoan kiem - ha noi');
INSERT INTO shippingAddress VALUES ('15', '15', 'nguyen huu minh', '0549593293', '5 luong ngoc quyen- hoan kiem- ha noi');
INSERT INTO shippingAddress VALUES ('16', '16', 'nguyen huu minh', '0548342495', '53 bach dang - hoan kiem - ha noi');
INSERT INTO shippingAddress VALUES ('17', '17', 'le mai suong', '0234823495', '30 hang voi- ly thai to -hoan kiem - ha noi');
INSERT INTO shippingAddress VALUES ('18', '46', 'lam thanh tam', '0895932145', '16b ly thai to - hoan kiem - ha noi');
INSERT INTO shippingAddress VALUES ('19', '43', 'do thanh tung', '0348350305', '91 vong ha-  hoan kiem ha noi');
INSERT INTO shippingAddress VALUES ('20', '16', 'khanh trang', '0534i548399', '18 tam trinh - hai ba trung -  ha noi');

-- INSERT INTO shipping method

INSERT INTO shippingMethod VALUES ('1', 'Giao Hàng Nhanh', '2 ngay', '30000');
INSERT INTO shippingMethod VALUES ('2', 'Ninjavan', '3 ngay', '24000');
INSERT INTO shippingMethod VALUES ('3', 'Giao Hàng Tiết Kiệm', '6 ngay', '12000');
-- INSERT INTO payment method 

INSERT INTO paymentMethod VALUES('1','online Payment');
INSERT INTO paymentMethod VALUES('2','COD');

-- INSERT INTO orders 

INSERT INTO orders  VALUES ('1', '1', '2', '1',1, '743974.5','2020-06-08', '3');
INSERT INTO orders  VALUES ('2', '3', '2', '4',3, '387000','2020-06-01', '1');
INSERT INTO orders  VALUES ('3', '2', '2', '8', 4,'313000','2020-06-3', '2');
INSERT INTO orders  VALUES ('4', '1', '1', '17',5 ,'4117500','2020-06-4', '3');
INSERT INTO orders  VALUES ('5', '1', '2', '17', 7,'2775500','2020-06-1', '2');
INSERT INTO orders  VALUES ('6', '1', '2', '10', 8,'387000','2020-06-4', '1');
INSERT INTO orders  VALUES ('7', '3', '2', '20', 1,'3357500','2020-06-7', '3');
INSERT INTO orders  VALUES ('8', '1', '2', '9', 7,'2123800','2020-1-30', '2');
INSERT INTO orders  VALUES ('9', '1', '2', '15',17 ,'368000','2020-2-4', '3');
INSERT INTO orders  VALUES ('10', '1', '2', '15',15, '267000','2020-3-22', '3');
INSERT INTO orders  VALUES ('11', '1', '2', '16', 12,'52000','2020-2-16', '3');
INSERT INTO orders  VALUES ('12', '2', '2', '14',10, '79600','2020-5-7', '3');
INSERT INTO orders  VALUES ('13', '3', '1', '13', 10,'95300','2020-4-12', '3');
INSERT INTO orders  VALUES ('14', '2', '2', '12', 4,'259000','2020-4-6', '3');
INSERT INTO orders  VALUES ('15', '1', '1', '6', 6,'360000','2020-2-6', '3');
INSERT INTO orders  VALUES ('16', '1', '1', '4', 8,'268000','2020-1-23', '3');
INSERT INTO orders  VALUES ('17', '1', '1', '3', 8,'879200','2020-4-28', '3');
INSERT INTO orders  VALUES ('18', '1', '1', '12',9, '429000','2020-3-30', '3');
INSERT INTO orders  VALUES ('19', '1', '2', '20',9 ,'2107000','2020-2-2', '2');
INSERT INTO orders  VALUES ('20', '1', '2', '8', 13,'724000','2020-4-1', '2');
INSERT INTO orders  VALUES ('21', '1', '2', '7', 12,'1045000','2020-2-1', '2');
INSERT INTO orders  VALUES ('22', '2', '2', '5', 14,'1295000','2020-4-11', '1');
INSERT INTO orders  VALUES ('23', '3', '2', '1', 16,'363000','2020-5-10', '2');
INSERT INTO orders  VALUES ('24', '3', '2', '5', 1,'195000','2020-5-2', '2');
INSERT INTO orders  VALUES ('25', '3', '2', '2', 2,'746250','2020-2-2', '2');
INSERT INTO orders  VALUES ('26', '2', '2', '5', 3,'799000','2020-5-3', '3');
INSERT INTO orders  VALUES ('27', '3', '2', '4', 4,'15290000','2020-1-5', '3');
INSERT INTO orders  VALUES ('28', '3', '2', '9', 5,'342000','2020-3-5', '3');
INSERT INTO orders  VALUES ('29', '3', '2', '10',3, '51000','2020-3-7', '2');
INSERT INTO orders  VALUES ('30', '3', '2', '11', 3,'380000','2020-1-5', '1');
INSERT INTO orders  VALUES ('31', '2', '2', '19', 2,'1130000','2020-1-15', '3');
INSERT INTO orders  VALUES ('32', '1', '1', '18', 1,'1003000','2020-3-8', '3');
INSERT INTO orders  VALUES ('33', '2', '1', '17', 2,'1566000','2020-2-27', '2');
INSERT INTO orders  VALUES ('34', '3', '1', '12', 3,'367000','2020-1-4', '2');
INSERT INTO orders  VALUES ('35', '2', '2', '9', 2,'2049000','2020-3-08', '1');
INSERT INTO orders  VALUES ('36', '2', '2', '8',2 ,'1443000','2020-2-9', '3');
INSERT INTO orders  VALUES ('37', '2', '2', '7', 2,'570000','2020-3-22', '3');
INSERT INTO orders  VALUES ('38', '2', '1', '3', 2,'764000','2020-4-18', '2');
INSERT INTO orders  VALUES ('39', '1', '2', '6', 1,'352749','2020-5-9', '1');
INSERT INTO orders  VALUES ('40', '1', '2', '3', 1,'279000','2020-5-16', '2');
INSERT INTO orders  VALUES ('41', '1', '1', '2', 1,'4753500','2020-5-7', '3');
INSERT INTO orders  VALUES ('42', '1', '2', '15', 1,'2120000','2020-4-18', '1');
INSERT INTO orders  VALUES ('43', '3', '2', '1', 3,'181000','2020-3-18', '3');
INSERT INTO orders  VALUES ('44', '3', '2', '2', 3,'1504000','2020-2-28', '2');
INSERT INTO orders  VALUES ('45', '3', '1', '17',3, '292000','2020-2-23', '1');
INSERT INTO orders  VALUES ('46', '3', '2', '14', 3,'925000','2020-2-25', '2');
INSERT INTO orders  VALUES ('47', '3', '2', '4', 3,'395000','2020-2-29', '3');
INSERT INTO orders  VALUES ('48', '3', '2', '20',3 ,'91000','2020-1-22', '3');
INSERT INTO orders  VALUES ('49', '1', '2', '12', 1,'69000','2020-1-15', '2');
INSERT INTO orders  VALUES ('50', '2', '2', '9', 2,'6474500','2020-1-12', '3');




-- INSERT INTO order details 


INSERT INTO orderDetails VALUES ('1', '1', '2', '125000', '1');
INSERT INTO orderDetails VALUES ('3', '1', '2', '612500', '1');
INSERT INTO orderDetails VALUES ('24', '2', '1', '375000', '1');
INSERT INTO orderDetails VALUES ('87', '3', '1', '289000', '1');
INSERT INTO orderDetails VALUES ('21', '4', '1', '4417500', '1');
INSERT INTO orderDetails VALUES ('23', '5', '1', '2775500', '1');
INSERT INTO orderDetails VALUES ('24', '6', '1', '375000', '1');
INSERT INTO orderDetails VALUES ('29', '7', '1', '3357500', '1');
INSERT INTO orderDetails VALUES ('30', '8', '1', '2123800', '1');
INSERT INTO orderDetails VALUES ('36', '9', '1', '169000', '2');
INSERT INTO orderDetails VALUES ('43', '10', '1', '79000', '3');
INSERT INTO orderDetails VALUES ('51', '11', '1', '22000', '1');
INSERT INTO orderDetails VALUES ('56', '12', '1', '13900', '4');
INSERT INTO orderDetails VALUES ('63', '13', '1', '83300', '1');
INSERT INTO orderDetails VALUES ('93', '14', '1', '235000', '1');
INSERT INTO orderDetails VALUES ('98', '15', '1', '330000', '1');
INSERT INTO orderDetails VALUES ('100', '16', '2', '119000', '2');
INSERT INTO orderDetails VALUES ('93', '16', '2', '235000', '1');
INSERT INTO orderDetails VALUES ('40', '17', '3', '179000', '1');
INSERT INTO orderDetails VALUES ('39', '17', '3', '619000', '1');
INSERT INTO orderDetails VALUES ('38', '17', '3', '12800', '4');
INSERT INTO orderDetails VALUES ('33', '18', '2', '249000', '1');
INSERT INTO orderDetails VALUES ('34', '18', '2', '250000', '1');
INSERT INTO orderDetails VALUES ('28', '19', '2', '1978000', '1');
INSERT INTO orderDetails VALUES ('26', '19', '2', '129000', '1');
INSERT INTO orderDetails VALUES ('27', '20', '3', '200000', '1');
INSERT INTO orderDetails VALUES ('24', '20', '3', '375000', '1');
INSERT INTO orderDetails VALUES ('25', '20', '3', '149000', '1');
INSERT INTO orderDetails VALUES ('17', '21', '1', '1045000', '1');
INSERT INTO orderDetails VALUES ('18', '22', '2', '250000', '1');
INSERT INTO orderDetails VALUES ('17', '22', '2', '1045000', '1');
INSERT INTO orderDetails VALUES ('12', '23', '1', '351000', '1');
INSERT INTO orderDetails VALUES ('9', '24', '2', '68000', '1');
INSERT INTO orderDetails VALUES ('4', '24', '2', '115000', '1');
INSERT INTO orderDetails VALUES ('2', '25', '1', '746250', '1');
INSERT INTO orderDetails VALUES ('13', '26', '1', '799000', '1');
INSERT INTO orderDetails VALUES ('14', '27', '2', '7290000', '1');
INSERT INTO orderDetails VALUES ('92', '27', '2', '8000000', '1');
INSERT INTO orderDetails VALUES ('98', '28', '1', '330000', '1');
INSERT INTO orderDetails VALUES ('99', '29', '1', '39000', '1');
INSERT INTO orderDetails VALUES ('87', '30', '2', '289000', '1');
INSERT INTO orderDetails VALUES ('89', '30', '2', '79000', '1');
INSERT INTO orderDetails VALUES ('76', '31', '1', '1130000', '1');
INSERT INTO orderDetails VALUES ('77', '32', '3', '925000', '1');
INSERT INTO orderDetails VALUES ('79', '32', '3', '50000', '1');
INSERT INTO orderDetails VALUES ('74', '32', '3', '280000', '1');
INSERT INTO orderDetails VALUES ('69', '33', '1', '1566000', '1');
INSERT INTO orderDetails VALUES ('70', '34', '1', '355000', '1');
INSERT INTO orderDetails VALUES ('65', '35', '1', '2049000', '1');
INSERT INTO orderDetails VALUES ('66', '36', '2', '235000', '2');
INSERT INTO orderDetails VALUES ('59', '36', '2', '139000', '7');
INSERT INTO orderDetails VALUES ('56', '37', '1', '13900', '40');
INSERT INTO orderDetails VALUES ('47', '38', '2', '135000', '2');
INSERT INTO orderDetails VALUES ('49', '38', '2', '117000', '4');
INSERT INTO orderDetails VALUES ('42', '39', '4', '35999', '1');
INSERT INTO orderDetails VALUES ('44', '39', '4', '62000', '2');
INSERT INTO orderDetails VALUES ('41', '39', '4', '55750', '1');
INSERT INTO orderDetails VALUES ('48', '39', '4', '117000', '1');
INSERT INTO orderDetails VALUES ('33', '40', '1', '249000', '1');
INSERT INTO orderDetails VALUES ('28', '41', '2', '1978000', '1');
INSERT INTO orderDetails VALUES ('23', '41', '2', '2775500', '1');
INSERT INTO orderDetails VALUES ('19', '42', '2', '1750000', '1');
INSERT INTO orderDetails VALUES ('11', '42', '2', '370000', '1');
INSERT INTO orderDetails VALUES ('7', '43', '1', '169000', '1');
INSERT INTO orderDetails VALUES ('62', '44', '2', '329000', '1');
INSERT INTO orderDetails VALUES ('66', '44', '2', '235000', '5');
INSERT INTO orderDetails VALUES ('74', '45', '1', '280000', '8');
INSERT INTO orderDetails VALUES ('77', '46', '1', '925000', '2');
INSERT INTO orderDetails VALUES ('80', '47', '2', '265000', '1');
INSERT INTO orderDetails VALUES ('83', '47', '2', '118000', '1');
INSERT INTO orderDetails VALUES ('89', '48', '1', '79000', '1');
INSERT INTO orderDetails VALUES ('96', '49', '2', '179000', '1');
INSERT INTO orderDetails VALUES ('99', '49', '2', '39000', '1');
INSERT INTO orderDetails VALUES ('67', '50', '5', '29000', '4');
INSERT INTO orderDetails VALUES ('69', '50', '5', '1566000', '1');
INSERT INTO orderDetails VALUES ('75', '50', '5', '325000', '1');
INSERT INTO orderDetails VALUES ('79', '50', '5', '50000', '1');
INSERT INTO orderDetails VALUES ('21', '50', '5', '4417500', '1');












    


