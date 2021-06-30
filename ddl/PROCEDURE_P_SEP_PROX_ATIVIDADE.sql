CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_SEP_PROX_ATIVIDADE" ( 
  i_produtivo IN NUMBER, 
  o_carga OUT NUMBER, 
  o_lote OUT NUMBER 
) as 
  v_prioridade number; 
  v_exclusivo number; 
  v_is_mabel number; 
  v_mabel varchar2(2); 
begin 
  --Verificar se atividade é mabel 
  select count(*) 
    into v_is_mabel 
    from PRODUTIVO_LS A, 
         LINHADESEPARACAO B 
   where PRODUTIVO_ID = i_produtivo 
     and A.LS_ID = B.ID 
     and B.LS = 'MF' 
  ; 
 
  select EXCLUSIVO 
    into v_exclusivo 
    from PRODUTIVO 
   where ID = i_produtivo; 
  --htp.p('Exclusivo: '||v_exclusivo); 
   
  --Mudança em todos os wheres que envolvem linha de separação 
  --DE: B.LS not in ('ME','FR','TE','CA') 
  --PARA: ((B.LS in ('MF') and v_is_mabel = 1 ) or (B.LS not in ('ME','FR','TE','CA','MF') and v_is_mabel = 0)) 
  select min(A.PRIORIDADE) 
    into v_prioridade  
    from CARGA            A, 
         LOTE             B, 
         PRODUTIVO_LS     C, 
         LINHADESEPARACAO D, 
         PRODUTIVO        E 
   where A.ID = B.CARGA_ID 
     and B.LS = D.LS 
     and D.ID = C.LS_ID 
     and E.ID = C.PRODUTIVO_ID 
     and E.ID = i_produtivo 
     and B.STATUS = 0 
     and ((B.LS in ('MF') and v_is_mabel = 1 ) or (B.LS not in ('ME','FR','TE','CA','MF') and v_is_mabel = 0)) 
  ; 
  --htp.p('Prioridade: '||v_prioridade); 
  if v_prioridade is not null and v_exclusivo = 1 then 
    select distinct ID 
      into o_carga 
      from (select distinct A.ID, RANK() OVER(order by F.DTAHORGERAPALETE) n, F.DTAHORGERAPALETE 
              from CARGA            A, 
                   LOTE             B, 
                   PRODUTIVO_LS     C, 
                   LINHADESEPARACAO D, 
                   PRODUTIVO        E, 
                   CONSINCO.MLO_CARGAEXPED F 
             where A.ID = B.CARGA_ID 
               and A.ID = F.NROCARGA 
               and B.LS = D.LS 
               and D.ID = C.LS_ID 
               and E.ID = C.PRODUTIVO_ID 
               and E.ID = i_produtivo 
               and A.PRIORIDADE = v_prioridade 
               and B.STATUS = 0 
               and ((B.LS in ('MF') and v_is_mabel = 1 ) or (B.LS not in ('ME','FR','TE','CA','MF') and v_is_mabel = 0))) 
     where n = 1 
    ; 
    select min(B.ID) 
      into o_lote 
      from CARGA            A, 
           LOTE             B, 
           PRODUTIVO_LS     C, 
           LINHADESEPARACAO D, 
           PRODUTIVO        E 
     where A.ID = B.CARGA_ID 
       and B.LS = D.LS 
       and D.ID = C.LS_ID 
       and E.ID = C.PRODUTIVO_ID 
       and E.ID = i_produtivo 
       and B.STATUS = 0 
       and A.ID = o_carga 
       and ((B.LS in ('MF') and v_is_mabel = 1 ) or (B.LS not in ('ME','FR','TE','CA','MF') and v_is_mabel = 0)) 
    ; 
  else 
    select min(A.PRIORIDADE) 
      into v_prioridade 
      from CARGA A, 
           LOTE  B 
     where A.ID = B.CARGA_ID 
       and B.STATUS = 0 
       and ((B.LS in ('MF') and v_is_mabel = 1 ) or (B.LS not in ('ME','FR','TE','CA','MF') and v_is_mabel = 0)) 
    ; 
    --htp.p(v_prioridade); 
    select distinct ID 
      into o_carga 
      from (select distinct A.ID, RANK() OVER(order by C.DTAHORGERAPALETE) n, C.DTAHORGERAPALETE 
              from CARGA A, 
                   LOTE B, 
                   CONSINCO.MLO_CARGAEXPED C 
             where A.ID = B.CARGA_ID 
               and A.ID = C.NROCARGA 
               and B.STATUS = 0 
               and A.PRIORIDADE = v_prioridade 
               and ((B.LS in ('MF') and v_is_mabel = 1 ) or (B.LS not in ('ME','FR','TE','CA','MF') and v_is_mabel = 0))) 
     where n = 1; 
 
    /* 
    select min(A.ID) 
      into o_carga 
      from CARGA A, 
           LOTE B 
     where A.ID = B.CARGA_ID 
       and B.STATUS = 0 
       and A.PRIORIDADE = v_prioridade 
       and ((B.LS in ('MF') and v_is_mabel = 1 ) or (B.LS not in ('ME','FR','TE','CA','MF') and v_is_mabel = 0)) 
    ;*/ 
     
    select min(B.ID) 
      into o_lote 
      from CARGA A, 
           LOTE B 
     where A.ID = B.CARGA_ID 
       and B.STATUS = 0 
       and A.ID = o_carga 
       and ((B.LS in ('MF') and v_is_mabel = 1 ) or (B.LS not in ('ME','FR','TE','CA','MF') and v_is_mabel = 0)) 
    ; 
  end if; 
  o_carga := nvl(o_carga, 0); 
  o_lote := nvl(o_lote, 0); 
   
  exception 
  when NO_DATA_FOUND 
    then o_carga := nvl(o_carga, 0); 
         o_lote := nvl(o_lote, 0); 
   
  --htp.p('-----------------------'); 
  --htp.p('Carga: ' || o_carga); 
  --htp.p('Lote: ' || o_lote); 
  --htp.p('Prioridade: ' || v_prioridade); 
  --htp.p('Exclusivo: ' || v_exclusivo); 
end; 
/