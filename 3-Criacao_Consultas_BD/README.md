## Criação do Banco de Dados e Consultas

Para o desarrollo desta parte do projeto usamos a base de dados classicmodels a qual pode ser encontrada em https://www.mysqltutorial.org/getting-started-with-mysql/mysql-sample-database/ 

Para facilidade, o arquivo sql gerador da base encontrase nesta pasta com o nome classicmodels_DB.sql [https://github.com/Joangopa/ada_dados/blob/main/3-Criacao_Consultas_BD/classicmodels_DB.sql]


O banco de dados classicmodels é um banco de dados de um varejista de modelos em escala de carros clássicos. Ele contém dados comerciais típicos, incluindo informações sobre clientes, produtos, pedidos de vendas, itens de linha de pedidos de vendas e muito mais. 

No arquivo ComandosDDL.sql [https://github.com/Joangopa/ada_dados/blob/main/3-Criacao_Consultas_BD/ComandosDDL.sql] encontra-se os comandos para a criação do Banco de Dados, assim como algusn outros comandos DDL para criação de tabelas, modificação estrutural de tabelas e remoção de tabelas.
 
No arquivo  ComandoDML_Basico.sql[https://github.com/Joangopa/ada_dados/blob/main/3-Criacao_Consultas_BD/ComandoDML_Basico.sql] encontra-se comandos de inserção, edição e remoção de dados nas tabelas.


## Consultas em Base de Dados

```
SELECT productLine as Categoria_produtos, COUNT(*) AS total_produtos
FROM products
GROUP BY productline
;
```

```
SELECT officeCode, city from offices
;
```

Em uma análise rápeda sobre o desempnho nas vendas, queremos considerar os empleados que não tem vendas registradas, assim como sua posição na empresa (não tedos tem que ser vendedores)
```
SELECT e.employeeNumber, e.firstName, e.lastName
FROM employees e
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE c.customerNumber IS NULL
;
```
![empleados_sem_vendas](https://github.com/Joangopa/ada_dados/blob/main/3-Criacao_Consultas_BD/resultados_consultas/empleados_semVendas.png)


Também temos interese na existencia de produtos que nunca tem sido vendidos 
``` 
SELECT p.productCode, p.productName
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
WHERE od.productCode IS NULL
;
```
![produtos_nao_vendidos](https://github.com/Joangopa/ada_dados/blob/main/3-Criacao_Consultas_BD/resultados_consultas/produto_sem_vendas.png)


Em uma nova proposta para incentivar aumentar as vendas a nivel global, a liderança da empresa quer saber a posição de cada unidade com respeito a quantidade de valor en vendas geradas historicamente
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






