-- create view
CREATE VIEW v_product AS
    SELECT 
        c.categoryName,
        CONCAT(SUBSTRING(p.productName,1,10),'...') SortName,
        p.ProductRootPrice,
        p.productSalePrice,
        p.productQuantityInStock,
        p.quantitySold,
        CONCAT(SUBSTRING(p.productDescription, 1, 10),
                '...') AS `Sort Description`,
        p.productRate
    FROM
        category c
            INNER JOIN
        productCategory pc ON pc.categoryID = c.categoryID
            INNER JOIN
        product p ON p.productID = pc.productID;

CREATE VIEW v_orderDetails AS
    SELECT 
        c.CustomerName,
        c.customerAddress,
        CONCAT(o.totalbill, ' Đồng') totalBill,
        o.orderDate,
        sa.AddressDetails `Receive Address`,
        sm.shippingName,
        pm.paymentMethodName,
        o.orderStatus
    FROM
        orders o
            INNER JOIN
        Customer c ON c.customerID = o.customerID
            INNER JOIN
        paymentMethod pm ON pm.paymentMethodID = o.paymentMethodID
            INNER JOIN
        shippingAddress sa ON sa.customerID = c.customerID
        INNER JOIN shippingmethod sm on sm.shippingMethodID= o.shippingMethodID;
        