--
use shopee;
-- procedure input infor product
delimiter //
create procedure inputInfoProduct(in productName nvarchar(255),in ProductRootPrice decimal(13,2), in productSalePrice decimal(13,2), in productQuantityInStock int, in productDescription nvarchar(255))
begin	
	INSERT INTO product(productName,ProductRootPrice,productSalePrice,productQuantityInStock,productDescription)
    values(productName,ProductRootPrice,productSalePrice,productQuantityInStock,productDescription);
end //
DELIMITER ;


--
-- procedure update
delimiter //
create procedure updateProductInfo( id int , in pName nvarchar(255),in pPrice decimal(13,2),in pSalePrice decimal(13,2))
begin
	update product p
    set p.productName = pName, p.ProductRootPrice = pPrice, p.productSalePrice = pSalePrice
    where p.productID = id;
end //

--
delimiter //
create procedure updateProductPrice(in id int ,in pPrice decimal(13,2),in pSalePrice decimal(13,2) )
begin
	update product p
    set p.productRootPrice = pPrice, p.productSalePrice = pSalePrice
    where p.productID = id;
end //

--
delimiter //
create procedure updateProductName(in id int ,in pName nvarchar(255))
begin
	update product p
    set p.productName = pName
    where p.productID = id;
end //



--
-- procedure search Product By Name
delimiter //
create procedure searchProductByName(in pName nvarchar(255))
begin
	select * from v_product v
    where v.productName like concat('%',pName,'5') 
    limit 20;
end //
DELIMITER ;
-- procedure search Product by category,name
delimiter //
create procedure searchProductbyCategoryName(in category nvarchar(255),in pName nvarchar(255))
begin
	select  *from v_product v
    where v.categoryName like concat('%',category,'%') and  v.productName like concat('%',pName,'%'); 
end //
-- procedure search Product by category,name,price range
delimiter //
create procedure searchProductbyPriceRange(in category nvarchar(255),in pName nvarchar(255),in startPrice decimal(13,2),in endPrice decimal(13,2))
begin
	select *  from v_product v
    where v.categoryName like concat('%',category,'%') and  v.productName like concat('%',pName,'%') and v.ProductRootPrice >= startPrice and v.ProductRootPrice <= endPrice;
end //
DELIMITER ;
