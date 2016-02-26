
-- SOMATORIO POR SUBGRUPO DE PRODUTOS / COM NOME
SELECT 
producao.ano,
producao.mes,
produto.nome,
subgrupo.nome_grupo AS subgrupo,
SUM(producao.area_plantada) AS area_plantada,
SUM(producao.area_colhida) AS area_colhida,
SUM(producao.producao) AS producao
FROM agricultura_produto AS produto
INNER JOIN agricultura_grupo AS subgrupo ON produto.grupo_id = subgrupo.id
INNER JOIN agricultura_producao AS producao ON produto.id = producao.produto_id 
GROUP BY produto.nome,subgrupo.nome_grupo, producao.ano, producao.mes
ORDER BY subgrupo.nome_grupo

-- SOMATORIO POR SUBGRUPOS/ SEM NOME
SELECT 
producao.ano,
producao.mes,
subgrupo.nome_grupo AS subgrupo,
SUM(producao.area_plantada) AS area_plantada,
SUM(producao.area_colhida) AS area_colhida,
SUM(producao.producao) AS producao
FROM agricultura_produto AS produto
INNER JOIN agricultura_grupo AS subgrupo ON produto.grupo_id = subgrupo.id
INNER JOIN agricultura_producao AS producao ON produto.id = producao.produto_id 
GROUP BY subgrupo.nome_grupo, producao.ano, producao.mes
ORDER BY subgrupo.nome_grupo

--POR MUNICIPIO/ AGRUPADO POR PRODUTO
SELECT 
producao.ano,
producao.mes,
produto.nome,
municipio.nome AS municipio,
SUM(producao.area_colhida) AS area_colhida, 
SUM(producao.area_plantada) AS area_plantada,
SUM(producao.producao) AS producao
FROM core_municipio AS municipio 
INNER JOIN agricultura_producao AS producao ON municipio.id = producao.municipio_id
INNER JOIN agricultura_produto AS produto ON produto.id = producao.produto_id
GROUP BY municipio.nome, produto.nome, producao.mes, producao.ano
ORDER BY produto.nome


--PRODUTO/MUNICIPIO
SELECT
producao.ano, 
producao.mes, 
produto.nome AS produto, 
municipio.nome AS municipio, 
SUM(producao.area_plantada) AS area_plantada,
SUM(producao.area_colhida) AS area_colhida,
SUM(producao.producao) AS producao, 
SUM(producao.area_em_formacao) AS area_em_formacao,
producao.irrigado AS irrigado 
FROM core_municipio AS municipio 
INNER JOIN agricultura_producao AS producao ON municipio.id = producao.municipio_id
INNER JOIN agricultura_produto AS produto ON producao.produto_id = produto.id
GROUP BY municipio.nome,produto.nome,producao.irrigado,producao.ano,producao.mes
ORDER BY municipio.nome


--PRODUTO/MESO
SELECT 
producao.ano, 
producao.mes, 
produto.nome AS produto,
mesoregiao.nome AS mesorregiao, 
SUM(producao.area_plantada) AS area_plantada,
SUM(producao.area_colhida) AS area_colhida,
SUM(producao.producao) AS producao, 
SUM(producao.area_em_formacao) AS area_em_formacao,
producao.irrigado AS irrigado
FROM core_municipio AS municipio
INNER JOIN core_microregiao AS microregiao ON municipio.microregiao_id = microregiao.id
INNER JOIN core_mesoregiao AS mesoregiao ON microregiao.id = mesoregiao.id
INNER JOIN agricultura_producao AS producao ON municipio.id = producao.municipio_id
INNER JOIN agricultura_produto AS produto ON produto.id = producao.produto_id
GROUP BY mesoregiao.nome, produto.nome,producao.irrigado,producao.ano,producao.mes
ORDER BY mesoregiao.nome


--PRODUTO/MICRO
SELECT 
producao.ano, 
producao.mes, 
produto.nome AS produto,
microregiao.nome AS microrregiao, 
SUM(producao.area_plantada) AS area_plantada,
SUM(producao.area_colhida) AS area_colhida,
SUM(producao.producao) AS producao, 
SUM(producao.area_em_formacao) AS area_em_formacao,
producao.irrigado AS irrigado
FROM core_municipio AS municipio
INNER JOIN core_microregiao AS microregiao ON municipio.microregiao_id = microregiao.id
INNER JOIN core_mesoregiao AS mesoregiao ON microregiao.id = mesoregiao.id
INNER JOIN agricultura_producao AS producao ON municipio.id = producao.municipio_id
INNER JOIN agricultura_produto AS produto ON produto.id = producao.produto_id
GROUP BY microregiao.nome, produto.nome, producao.ano, producao.mes, mesoregiao.nome,producao.irrigado
ORDER BY microregiao.nome

-- POR MUNICIPIO/ IRRIGADO/ NAO IRRIGADO
SELECT 
producao.ano,
producao.mes,
produto.nome AS produto,
municipio.nome as municipio_nome,
SUM(CASE WHEN producao.irrigado = 'N' THEN producao.area_plantada ELSE 0 END) area_plantada_Nao_Irrigado,
SUM(CASE WHEN producao.irrigado = 'S' THEN producao.area_plantada ELSE 0 END) area_plantada_Irrigado,
SUM(CASE WHEN producao.irrigado = 'N' THEN producao.area_colhida ELSE 0 END) area_colhida_Nao_Irrigado,
SUM(CASE WHEN producao.irrigado = 'S' THEN producao.area_colhida ELSE 0 END) area_colhida_Irrigado,
SUM(CASE WHEN producao.irrigado = 'N' THEN producao.producao ELSE 0 END) Producao_Nao_Irrigado,
SUM(CASE WHEN producao.irrigado = 'S' THEN producao.producao ELSE 0 END) Producao_Irrigado
FROM       
agricultura_produto AS produto
INNER JOIN agricultura_producao AS producao ON produto.id = producao.produto_id
INNER JOIN core_municipio as municipio on municipio.id = producao.municipio_id
GROUP BY producao.mes, producao.ano,produto.nome, municipio.nome 
ORDER BY municipio.nome

-- TODO ESTADO/ IRRIGADO/ NAO IRRIGADO
SELECT 
producao.ano,
producao.mes,
produto.nome AS produto,
SUM(CASE WHEN producao.irrigado = 'N' THEN producao.area_plantada ELSE 0 END) area_plantada_Nao_Irrigado,
SUM(CASE WHEN producao.irrigado = 'S' THEN producao.area_plantada ELSE 0 END) area_plantada_Irrigado,
SUM(CASE WHEN producao.irrigado = 'N' THEN producao.area_colhida ELSE 0 END) area_colhida_Nao_Irrigado,
SUM(CASE WHEN producao.irrigado = 'S' THEN producao.area_colhida ELSE 0 END) area_colhida_Irrigado,
SUM(CASE WHEN producao.irrigado = 'N' THEN producao.producao ELSE 0 END) Producao_Nao_Irrigado,
SUM(CASE WHEN producao.irrigado = 'S' THEN producao.producao ELSE 0 END) Producao_Irrigado
FROM       
agricultura_produto AS produto
INNER JOIN agricultura_producao AS producao ON produto.id = producao.produto_id
GROUP BY producao.mes, producao.ano,produto.nome
ORDER BY produto.nome

