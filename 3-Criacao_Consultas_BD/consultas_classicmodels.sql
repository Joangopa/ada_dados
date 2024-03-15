use classicmodels;


SELECT productLine as Categoria_produtos, COUNT(*) AS total_produtos
FROM products
GROUP BY productline
;


SELECT officeCode, city from offices
;

SELECT e.employeeNumber, e.firstName, e.jobTitle 
FROM employees e
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE c.customerNumber IS NULL
;

SELECT DISTINCT jobTitle
FROM employees;

SELECT p.productCode, p.productName
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
WHERE od.productCode IS NULL
;


SELECT o.officeCode as cof_loja, o.city as cidade, SUM(od.quantityOrdered * od.priceEach) AS vendas_totais
FROM offices o
INNER JOIN employees e ON o.officeCode = e.officeCode
INNER JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
INNER JOIN orders orde ON c.customerNumber = orde.customerNumber
INNER JOIN orderdetails od ON orde.orderNumber = od.orderNumber
GROUP BY o.officeCode
ORDER BY vendas_totais DESC
;

SELECT e.employeeNumber as cod, e.firstName as Nome, e.lastName as Sobrenome, o.city as Cidade,
       COUNT(c.customerNumber) AS quantidade_vendas
FROM employees e
LEFT JOIN offices o ON e.officeCode = o.officeCode
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.employeeNumber, e.firstName, e.lastName, o.city
HAVING quantidade_vendas > 0
ORDER BY quantidade_vendas DESC 
;

SELECT productName as produto, productLine as categoria,  buyPrice as preco_venda
FROM products
WHERE buyPrice > (
    SELECT AVG(buyPrice) 
    FROM products)
ORDER BY preco_venda DESC
;

SELECT c.customerNumber as cod_comprador, c.customerName as comprador, COUNT(o.orderNumber) AS total_ordens
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerNumber, c.customerName
HAVING COUNT(o.orderNumber) > 5
;

SELECT 
    p.productCode as cod_produto, 
    p.productName as produto,
    p.productLine as categoria,
    SUM(od.quantityOrdered) AS total_vendas
FROM 
    products p
LEFT JOIN 
    orderdetails od ON p.productCode = od.productCode
GROUP BY 
    p.productCode, 
    p.productName
ORDER BY 
    total_vendas
LIMIT 5
;

