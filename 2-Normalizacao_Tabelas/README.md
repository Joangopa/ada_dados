## Normalização de tabelas 1FN, 2FN, 3FN

A normalização de tabelas é um processo fundamental no design de bases de dados, que visa a organização eficiente e livre de redundâncias dos dados. Através da normalização, as tabelas são estruturadas de forma a minimizar a duplicação de informações e garantir a integridade dos dados armazenados.

Iniciamos com a nossa tabela sem normalização
![forma0](https://github.com/Joangopa/ada_dados/blob/main/2-Normalizacao_Tabelas/0F.png)


Na primeira forma normal (1FN), cada coluna em uma tabela contém apenas valores atômicos, ou seja, valores indivisíveis. 
![forma1](https://github.com/Joangopa/ada_dados/blob/main/2-Normalizacao_Tabelas/1F.png)

Ao avançar para a segunda forma normal (2FN), busca-se eliminar dependências parciais, garantindo que cada coluna em uma tabela esteja totalmente dependente da chave primária. 
![forma2](https://github.com/Joangopa/ada_dados/blob/main/2-Normalizacao_Tabelas/2F.png)

Na terceira forma normal (3FN), o objetivo é eliminar dependências transitivas, garantindo que não haja colunas não chave que dependam de outras colunas não chave. 
![forma3](https://github.com/Joangopa/ada_dados/blob/main/2-Normalizacao_Tabelas/3F.png)
