CREATE OR REPLACE EDITIONABLE PACKAGE "WMS"."PKG_ATUALIZAR" is 
  PROCEDURE P_PRODUTOS; 
  PROCEDURE P_PRODUTO_EMBALAGEMS; 
  PROCEDURE P_EMBALAGEM_CODIGOS;  
END; 
/
CREATE OR REPLACE EDITIONABLE PACKAGE BODY "WMS"."PKG_ATUALIZAR" IS 
 
PROCEDURE P_PRODUTOS IS 
  BEGIN 
    MERGE INTO WMS.PRODUTO DST 
    USING (SELECT VW.ID, 
                  VW.NOME, 
                  VW.FORNECEDOR_ID, 
                  VW.REFFABRICANTE, 
                  1 AS MASK 
             FROM WMS.V_PRODUTO VW 
           UNION ALL 
           SELECT TB.ID, 
                  TB.NOME, 
                  TB.FORNECEDOR_ID, 
                  TB.REFFABRICANTE, 
                  0 AS MASK 
             FROM WMS.PRODUTO TB 
             LEFT JOIN WMS.V_PRODUTO VW 
               ON VW.ID = TB.ID 
            WHERE VW.ID IS NULL) SRC 
    ON (DST.ID = SRC.ID) 
    WHEN MATCHED THEN 
      UPDATE 
         SET DST.NOME       = SRC.NOME, 
             DST.FORNECEDOR_ID          = SRC.FORNECEDOR_ID, 
             DST.REFFABRICANTE = SRC.REFFABRICANTE 
              DELETE 
       WHERE SRC.MASK = 0 
    WHEN NOT MATCHED THEN 
      INSERT 
        (DST.ID, 
         DST.NOME, 
         DST.FORNECEDOR_ID, 
         DST.REFFABRICANTE 
         ) 
      VALUES 
        (SRC.ID, 
         SRC.NOME, 
         SRC.FORNECEDOR_ID, 
         SRC.REFFABRICANTE 
         ); 
 
  END; 
   
PROCEDURE P_PRODUTO_EMBALAGEMS IS 
  BEGIN 
    MERGE INTO WMS.PRODUTO_EMBALAGEM DST 
    USING (SELECT VW.PRODUTO_ID, 
                  VW.EMB, 
                  VW.QTD_EMB, 
                  VW.PESO_BRUTO, 
                  VW.PESO_LIQUIDO, 
                  VW.ALTURA, 
                  VW.LARGURA, 
                  VW.PROFUNDIDADE, 
                  1 AS MASK 
             FROM WMS.V_PRODUTO_EMBALAGEM VW 
           UNION ALL 
           SELECT TB.PRODUTO_ID, 
                  TB.EMB, 
                  TB.QTD_EMB, 
                  TB.PESO_BRUTO, 
                  TB.PESO_LIQUIDO, 
                  TB.ALTURA, 
                  TB.LARGURA, 
                  TB.PROFUNDIDADE, 
                  0 AS MASK 
             FROM WMS.PRODUTO_EMBALAGEM TB 
             LEFT JOIN WMS.V_PRODUTO_EMBALAGEM VW 
               ON VW.PRODUTO_ID = TB.PRODUTO_ID AND VW.QTD_EMB = TB.QTD_EMB 
            WHERE VW.PRODUTO_ID IS NULL AND VW.QTD_EMB IS NULL) SRC 
    ON (DST.PRODUTO_ID = SRC.PRODUTO_ID AND DST.QTD_EMB = SRC.QTD_EMB) 
    WHEN MATCHED THEN 
      UPDATE 
         SET DST.EMB   = SRC.EMB, 
             DST.PESO_BRUTO          = SRC.PESO_BRUTO, 
             DST.PESO_LIQUIDO = SRC.PESO_LIQUIDO, 
             DST.ALTURA = SRC.ALTURA, 
             DST.LARGURA = SRC.LARGURA, 
             DST.PROFUNDIDADE = SRC.PROFUNDIDADE 
              DELETE 
       WHERE SRC.MASK = 0 
    WHEN NOT MATCHED THEN 
      INSERT 
        (DST.PRODUTO_ID, 
          DST.EMB, 
          DST.QTD_EMB, 
          DST.PESO_BRUTO, 
          DST.PESO_LIQUIDO, 
          DST.ALTURA, 
          DST.LARGURA, 
          DST.PROFUNDIDADE 
         ) 
      VALUES 
        (SRC.PRODUTO_ID, 
          SRC.EMB, 
          SRC.QTD_EMB, 
          SRC.PESO_BRUTO, 
          SRC.PESO_LIQUIDO, 
          SRC.ALTURA, 
          SRC.LARGURA, 
          SRC.PROFUNDIDADE 
         ); 
 
  END; 
   
PROCEDURE P_EMBALAGEM_CODIGOS IS 
  BEGIN 
    MERGE INTO WMS.EMBALAGEM_CODIGO DST 
    USING (SELECT VW.EMBALAGEM_ID, 
                  VW.CODIGO, 
                  VW.TIPO, 
                  1 AS MASK 
             FROM WMS.V_EMBALAGEM_CODIGO VW 
           UNION ALL 
           SELECT TB.EMBALAGEM_ID, 
                  TB.CODIGO, 
                  TB.TIPO, 
                  0 AS MASK 
             FROM WMS.EMBALAGEM_CODIGO TB 
             LEFT JOIN WMS.V_EMBALAGEM_CODIGO VW 
               ON VW.EMBALAGEM_ID = TB.EMBALAGEM_ID 
            WHERE VW.EMBALAGEM_ID IS NULL) SRC 
    ON (DST.EMBALAGEM_ID = SRC.EMBALAGEM_ID) 
    WHEN MATCHED THEN 
      UPDATE 
         SET DST.CODIGO       = SRC.CODIGO, 
             DST.TIPO          = SRC.TIPO 
              DELETE 
       WHERE SRC.MASK = 0 
    WHEN NOT MATCHED THEN 
      INSERT 
        (DST.EMBALAGEM_ID, 
         DST.CODIGO, 
         DST.TIPO 
         ) 
      VALUES 
        (SRC.EMBALAGEM_ID, 
         SRC.CODIGO, 
         SRC.TIPO 
         ); 
 
  END;     
END; 
/