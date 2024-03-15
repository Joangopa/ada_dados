## Criação do Banco de Dados e Consultas

Para o desenvolver esta parte do projeto, usamos a base de dados classicmodels a qual pode ser encontrada em: https://www.mysqltutorial.org/getting-started-with-mysql/mysql-sample-database/ 

Para facilidade, o arquivo SQL gerador da base encontra-se nesta pasta com o nome classicmodels_DB.sql [https://github.com/Joangopa/ada_dados/blob/main/3-Criacao_Consultas_BD/classicmodels_DB.sql]


O banco de dados classicmodels é um banco de dados de um varejista de modelos em escala de carros clássicos.
Consiste nas seguintes tabelas:

-customers: armazena os dados do cliente.
-products: armazena uma lista de carros modelo em escala.
-productlines: armazena uma lista de linhas de produtos.
-orders: armazena pedidos de vendas feitos pelos clientes.
-orderdetails: armazena itens de linha de pedidos de vendas para cada pedido de venda.
-payments: armazena pagamentos feitos pelos clientes com base em suas contas.
-employees:  armazena informações dos funcionários e a estrutura organizacional, como quem reporta para quem.
-offices: armazena dados do escritório de vendas.


A seguinte imagem ilustra o diagrama ER do banco de dados de exemplo:

![modelo_ER_banco](https://github.com/Joangopa/ada_dados/blob/main/3-Criacao_Consultas_BD/modelo_ER_classicmodels.png)

No arquivo ComandosDDL.sql [https://github.com/Joangopa/ada_dados/blob/main/3-Criacao_Consultas_BD/ComandosDDL.sql] encontra-se os comandos para a criação do Banco de Dados, assim como alguns outros comandos DDL para criação de tabelas, modificação estrutural de tabelas e remoção de tabelas.
 
No arquivo  ComandoDML_Basico.sql[https://github.com/Joangopa/ada_dados/blob/main/3-Criacao_Consultas_BD/ComandoDML_Basico.sql] encontra-se comandos de inserção, edição e remoção de dados nas tabelas.


## Consultas em Base de Dados

Inicialmente estamos interessados em consultar as diferentes categorias de produtos, assim com a quantidade de produtos diferentes por cada categoria
```
SELECT productLine as Categoria_produtos, COUNT(*) AS total_produtos
FROM products
GROUP BY productline
;
```
![categoria_produtos](https://github.com/Joangopa/ada_dados/blob/main/3-Criacao_Consultas_BD/resultados_consultas/categoria_produtos.png)

Em uma análise rápida sobre o desempenho nas vendas, queremos considerar os empregados que não tem vendas registradas, assim como sua posição na empresa (nem todos tem que ser vendedores)
```
SELECT e.employeeNumber, e.firstName, e.lastName
FROM employees e
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE c.customerNumber IS NULL
;
```
![empleados_sem_vendas](https://github.com/Joangopa/ada_dados/blob/main/3-Criacao_Consultas_BD/resultados_consultas/empleados_semVendas.png)


Também temos interesse na existência de produtos que nunca tem sido vendidos: 
``` 
SELECT p.productCode, p.productName
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
WHERE od.productCode IS NULL
;
```
![produtos_nao_vendidos](https://github.com/Joangopa/ada_dados/blob/main/3-Criacao_Consultas_BD/resultados_consultas/produto_sem_vendas.png)


Em uma nova proposta para incentivar o aumento das vendas a nivel global, a liderança da empresa quer saber a posição de cada unidade com respeito a quantidade de valor de vendas geradas historicamente
```
SELECT o.officeCode as cof_loja, o.city as cidade, SUM(od.quantityOrdered * od.priceEach) AS vendas_totais
FROM offices o
INNER JOIN employees e ON o.officeCode = e.officeCode
INNER JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
INNER JOIN orders orde ON c.customerNumber = orde.customerNumber
INNER JOIN orderdetails od ON orde.orderNumber = od.orderNumber
GROUP BY o.officeCode
ORDER BY vendas_totais DESC
;
```
![valor_vendas_lojas](https://github.com/Joangopa/ada_dados/blob/main/3-Criacao_Consultas_BD/resultados_consultas/vendas_lojas.png)



Também temos interesse nas vendas por empregado
```
SELECT e.employeeNumber as cod, e.firstName as Nome, e.lastName as Sobrenome, o.city as Cidade,
       COUNT(c.customerNumber) AS quantidade_vendas
FROM employees e
LEFT JOIN offices o ON e.officeCode = o.officeCode
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.employeeNumber, e.firstName, e.lastName, o.city
HAVING quantidade_vendas > 0
ORDER BY quantidade_vendas DESC 
;
```
![quantidade_vendas_empleado](https://github.com/Joangopa/ada_dados/blob/main/3-Criacao_Consultas_BD/resultados_consultas/quantidade_vendas_empleado.png)



Seguindo com a ideia de incrementar as vendas, serão selecionados para oferta de preço os produtos com valor de venda maior ao valor por meio de venda de todos os produtos
```
SELECT productName as produto, productLine as categoria,  buyPrice as preco_venda
FROM products
WHERE buyPrice > (
    SELECT AVG(buyPrice) 
    FROM products)
ORDER BY preco_venda DESC
;
```
![mais_caros_promedio](https://github.com/Joangopa/ada_dados/blob/main/3-Criacao_Consultas_BD/resultados_consultas/mais_caros_promedio.png)


Uma das novas propostas é dar ofertas especiais aos compradores que registrem mais de 10 ordens de compras
```
SELECT c.customerNumber as cod_comprador, c.customerName as comprador, COUNT(o.orderNumber) AS total_ordens
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerNumber, c.customerName
HAVING COUNT(o.orderNumber) > 5
;
```
![maiores_compradores](https://github.com/Joangopa/ada_dados/blob/main/3-Criacao_Consultas_BD/resultados_consultas/maiores_compradores.png)



Finalmente, queremos saber quais são os 5 produtos com menor quantidade de vendas no mundo
```
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
```
![produtos_menos_vendidos](https://github.com/Joangopa/ada_dados/blob/main/3-Criacao_Consultas_BD/resultados_consultas/produtos_menos_vendidos.png)
