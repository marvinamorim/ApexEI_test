CREATE OR REPLACE FORCE EDITIONABLE VIEW "WMS"."V_ATIVIDADE_INFO" ("CARGA", "SEQLOTE", "CODPROD", "PROD", "PRODFULL", "EMBCODE", "EMB", "LOCAL", "BOX", "CODRUA", "NROPREDIO", "QTDEMBALAGEM", "QTDPED", "QTDSEP", "CONF_QTD", "DESTINO", "QTD_EMB") AS 
  SELECT A.CARGA_ID CARGA, 
       A.LOTE SEQLOTE, 
       A.PRODUTO_ID CODPROD, 
       RPAD(SUBSTR(B.DESCCOMPLETA, 1, 25), 25, CHR(32)) PROD, 
       B.DESCCOMPLETA PRODFULL, 
       (SELECT MIN(TO_NUMBER(REGEXP_REPLACE(D.CODACESSO, '[^0-9]+', ''))) 
          FROM CONSINCO.MAP_PRODCODIGO D 
         WHERE D.SEQPRODUTO = A.PRODUTO_ID 
           AND D.QTDEMBALAGEM = a.qtd_emb 
           AND D.INDUTILWMS = 'S' 
           AND D.TIPCODIGO IN ('E', 'D') ) EMBCODE, 
       G.EMBALAGEM || '-' || G.QTDEMBALAGEM EMB, 
       E.CODRUA || '.' || E.NROPREDIO || '.' || E.NROAPARTAMENTO || '.' || 
       E.NROSALA LOCAL, 
       F.NROBOX BOX, 
       E.CODRUA AS CODRUA, 
       E.NROPREDIO AS NROPREDIO, 
       G.QTDEMBALAGEM, 
       A.QTD_PEDIDO as QTDPED, 
       A.SEP_QTD as QTDSEP, 
       A.CONF_QTD, 
       F.DESTINO, 
       A.QTD_EMB 
FROM WMS.ATIVIDADE             A, 
       CONSINCO.MAP_PRODUTO      B, 
       CONSINCO.MAP_FAMEMBALAGEM G, 
       WMS.V_ENDERECO_EMB     E, 
       CONSINCO.MLO_CARGAEXPED   F 
 WHERE B.SEQFAMILIA   = G.SEQFAMILIA 
   AND B.SEQPRODUTO   = A.PRODUTO_ID 
   --AND A.EMB          = G.EMBALAGEM 
   AND A.PRODUTO_ID   = B.SEQPRODUTO 
   AND F.NROCARGA     = A.CARGA_ID 
   AND E.SEQPRODUTO = A.PRODUTO_ID 
   AND E.QTDEMBALAGEM = A.QTD_EMB 
   AND A.QTD_EMB = G.QTDEMBALAGEM 
 ORDER BY E.CODRUA, 
          (CASE 
            WHEN E.CODRUA IN (SELECT A.CODRUA 
                                FROM CONSINCO.MLO_RUA A 
                               WHERE A.INDNUMASCDESC = 'D' 
                                 AND A.NROEMPRESA = 1) THEN 
             E.NROPREDIO 
          END) DESC, 
          (CASE 
            WHEN E.CODRUA NOT IN (SELECT A.CODRUA 
                                    FROM CONSINCO.MLO_RUA A 
                                   WHERE A.INDNUMASCDESC = 'D' 
                                     AND A.NROEMPRESA = 1) THEN 
             E.NROPREDIO 
          END) ASC, 
 
          (CASE 
            WHEN E.CODRUA IN (SELECT A.CODRUA 
                                FROM CONSINCO.MLO_RUA A 
                               WHERE A.INDNUMASCDESC = 'D' 
                                 AND A.NROEMPRESA = 1) THEN 
             E.NROAPARTAMENTO 
          END) DESC, 
          (CASE 
            WHEN E.CODRUA NOT IN (SELECT A.CODRUA 
                                    FROM CONSINCO.MLO_RUA A 
                                   WHERE A.INDNUMASCDESC = 'D' 
                                     AND A.NROEMPRESA = 1) THEN 
             E.NROAPARTAMENTO 
          END) ASC, 
 
          (CASE 
            WHEN E.CODRUA IN (SELECT A.CODRUA 
                                FROM CONSINCO.MLO_RUA A 
                               WHERE A.INDNUMASCDESC = 'D' 
                                 AND A.NROEMPRESA = 1) THEN 
             E.NROSALA 
          END) DESC, 
          (CASE 
            WHEN E.CODRUA NOT IN (SELECT A.CODRUA 
                                    FROM CONSINCO.MLO_RUA A 
                                   WHERE A.INDNUMASCDESC = 'D' 
                                     AND A.NROEMPRESA = 1) THEN 
             E.NROSALA 
          END) ASC 
;