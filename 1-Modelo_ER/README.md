## Especificação do Projeto:
### Gestão de Equipes de Ciclismo

Desenvolver um banco de dados para gerenciar equipes de ciclismo, ciclistas e as provas nas quais participam.

- Registrar informações detalhadas sobre as equipes de ciclismo.
- Manter dados dos ciclistas, incluindo seus feitos e participação em provas.
- Gerenciar informações sobre as provas de ciclismo, incluindo localização, data e resultados.

Requisitos:

- Registro de equipes de ciclismo com detalhes como nome, país, ano de fundação, etc.
- Manutenção de informações dos ciclistas, incluindo nome, país, data de nascimento, feitos, etc.
- Registro de provas de ciclismo com detalhes como nome, localização, data, distância, categoria, etc.
- Acompanhamento dos resultados dos ciclistas em cada prova.



## Modelagem dos Dados:

### Entidades:
- Equipe (ID, Nome, País, Ano de Fundação).
- Ciclista (ID, Nome, País, Data de Nascimento, ID da Equipe).
- Prova (ID, Nome, Localização, Data, Distância, Categoria).
- Resultado (ID do Ciclista, ID da Prova, Posição, Tempo) - Entidade fraca vinculada a Ciclista e Prova.

### Relações:
- Uma equipe pode ter vários ciclistas.
- Um ciclista pode pertencer a apenas uma equipe.
- Um ciclista pode participar de várias provas.
- Uma prova pode ter vários ciclistas participantes.
- Um resultado pertence a um ciclista e uma prova.


![diagrama_ER](https://github.com/Joangopa/ada_dados/blob/main/1-Modelo_ER/modelo_ER.jpg)
