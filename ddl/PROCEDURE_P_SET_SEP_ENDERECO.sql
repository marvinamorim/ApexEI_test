CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_SET_SEP_ENDERECO" ( 
  i_carga IN NUMBER, 
  i_lote IN NUMBER, 
  i_is_pta IN NUMBER 
) is 
begin 
  for c2 in ( 
    select A.CODPROD as PRODUTO_ID, 
           A.QTDEMBALAGEM as QTD_EMB, 
           case 
             when i_is_pta > 0 then 
               F_GET_LOCAL_PTA(a.codprod) 
             else 
               A.LOCAL 
           end as LOCAL 
      from V_ATIVIDADE_SEP A 
     where A.carga = i_carga 
       And A.seqlote = i_lote 
  ) loop 
    update ATIVIDADE A 
       set A.SEP_ENDERECO = c2.LOCAL 
     where A.PRODUTO_ID = c2.PRODUTO_ID 
       and A.QTD_EMB = c2.QTD_EMB 
       and A.CARGA_ID = i_carga 
       and A.LOTE = i_lote 
       and A.SEP_ENDERECO is null 
    ; 
  end loop; 
end; 
/