CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_CONF_AMOSTRAGEM" ( 
  i_carga IN NUMBER 
) as 
v_finish_carga number; 
begin 
  update LOTE 
     set STATUS = 4, 
         CONF_END = sysdate 
   where CARGA_ID = i_carga 
     and STATUS = 3 
     and LS in ('ME','MF','FR','CA')    
  ; 
  update ATIVIDADE A 
     set STATUS = 4, 
         CONF_END = sysdate, 
         CONF_QTD = case 
                      when (select count(*) from CORTE B 
                             where B.PRODUTO_ID = A.PRODUTO_ID 
                               and B.QTD_EMB = A.QTD_EMB 
                               and B.CARGA_ID = A.CARGA_ID 
                               and B.LOTE = A.LOTE) > 0 then 
                        CONF_QTD 
                      else 
                        QTD_PEDIDO 
                    end 
   where CARGA_ID = i_carga 
     and STATUS = 3 
     and LS in ('ME','MF','FR','CA') 
  ; 
  select count(*) 
    into v_finish_carga 
    from LOTE 
   where CARGA_ID = i_carga 
     and STATUS < 4 
  ; 
  if v_finish_carga = 0 then 
    consinco.P_WMS_FINISH_SEPC5(i_carga); 
    update CARGA 
       set STATUS = 2, 
           DATE_END = sysdate 
     where ID = i_carga 
    ; 
  end if; 
end; 
/