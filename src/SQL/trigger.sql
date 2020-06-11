use shopee;
delimiter $$
CREATE 
    TRIGGER tg_historyUpdate
	AFTER UPDATE ON product FOR EACH ROW 
    BEGIN
    insert into productHistoryUpdate 
    values(
    old.productID,
    old.productName,
    old.ProductRootPrice,
    old.productSalePrice,
    old.productQuantityInStock,
    now()
    );
    END $$
    DELIMITER ;
	DELIMITER $$
    CREATE TRIGGER tg_checkPriceBeforeUpdateProduct
	BEFORE UPDATE ON product FOR EACH ROW
    BEGIN
		IF NEW.ProductRootPrice <=0 OR NEW.productSalePrice <=0 THEN
        SIGNAL sqlstate '45001' set message_text = "Please don't let price <0 or = 0 ";
        END IF;
    END $$
    DELIMITER ;
    DELIMITER $$
    CREATE TRIGGER tg_setPrice_Quantity_Product
	BEFORE insert ON product FOR EACH ROW
    BEGIN
		IF NEW.ProductRootPrice<0 THEN
        SET NEW.ProductRootPrice = 0;
        END IF;
        IF NEW.ProductSalePrice<0 THEN
        SET NEW.ProductSalePrice = 0;
        END IF;
		IF NEW.productQuantityInStock<0 THEN
        SET NEW.productQuantityInStock= 0;
        END IF;
        
    END $$
    
    DELIMITER $$
    CREATE TRIGGER tg_setProductStatus
    BEFORE UPDATE ON product FOR EACH ROW
    BEGIN
		IF NEW.productQuantityInStock = 0 THEN
        SET NEW.productStatus = 2;
        END IF ;
    END $$
DELIMITER ;