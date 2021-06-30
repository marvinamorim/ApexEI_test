CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_SEP_PROX_ATIVIDADE" (i_produtivo IN NUMBER) 
return number is 
  v_carga number; --carga 
  v_lote_id number := 0; --lote 
  v_prioridade number; 
  v_exclusivo number; 
begin 
  select EXCLUSIVO 
    into v_exclusivo 
    from PRODUTIVO 
   where ID = i_produtivo; 
   
  if v_exclusivo = 1 then 
    select min(A.PRIORIDADE) 
      into v_prioridade 
      from CARGA A, 
           LOTE B, 
           PRODUTIVO_LS C, 
           LINHADESEPARACAO D 
     where A.ID = B.CARGA_ID 
       and B.LS = D.LS 
       and D.ID = C.LS_ID 
       and C.PRODUTIVO_ID = i_produtivo 
       and B.STATUS = 0 
    ; 
    select min(A.ID) 
      into v_carga 
      from CARGA A, 
           LOTE B, 
           PRODUTIVO_LS C, 
           LINHADESEPARACAO D 
     where A.ID = B.CARGA_ID 
       and B.LS = D.LS 
       and D.ID = C.LS_ID 
       and C.PRODUTIVO_ID = i_produtivo 
       and B.STATUS = 0 
       and A.PRIORIDADE = v_prioridade 
    ; 
    select min(B.ID) 
      into v_lote_id 
      from CARGA            A, 
           LOTE             B, 
           PRODUTIVO_LS     C, 
           LINHADESEPARACAO D 
     where A.ID = B.CARGA_ID 
       and B.LS = D.LS 
       and D.ID = C.LS_ID 
       and C.PRODUTIVO_ID = i_produtivo 
       and B.STATUS = 0 
       and A.ID = v_carga 
    ; 
  else 
    null; 
  end if; 
  if v_prioridade is null or v_carga is null or v_lote_id is null then 
    return 0; 
  else 
    return v_lote_id; 
  end if; 
   
   
  EXCEPTION 
    when NO_DATA_FOUND then 
      return 0; 
    when OTHERS then 
      return SQLCODE; 
end; 
/