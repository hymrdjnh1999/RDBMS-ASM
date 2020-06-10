-- create view
CREATE VIEW v_product
AS SELECT c.categoryName,p.productName, p.ProductRootPrice,p.productSalePrice,p.productQuantityInStock,p.quantitySold,concat(substring(p.productDescription,1,10),'...') as `Sort Description`,p.productRate
FROM category c inner join productCategory pc on pc.categoryID = c.categoryID inner join product p on p.productID = pc.productID;

CREATE VIEW v_orderDetails
AS SELECT c.CustomerName,c.customerAddress,concat(o.totalbill,' Đồng') totalBill,o.orderDate ,sa.AddressDetails `Receive Address`,sm.shippingName,pm.paymentMethodName,o.orderStatus
FROM orders o inner join shippingMethod sm on sm.shippingMethodID = o.shippingMethodID inner join paymentMethod pm on pm.paymentMethodID = o.paymentMethodID inner join shippingAddress sa on sa.shippingAddressID = o.shippingAddressID inner join Customer c on c.customerID = sa.CustomerID;
