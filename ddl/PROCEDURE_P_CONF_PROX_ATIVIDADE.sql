CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_CONF_PROX_ATIVIDADE" ( 
  i_produtivo IN NUMBER, 
  o_carga OUT NUMBER, 
  o_lote OUT NUMBER 
) as 
  v_prioridade number; 
  v_exclusivo number; 
  v_box number; 
  v_idle_activity number; 
begin 
  --Verificar se existe uma ativade pausada que deve ser retomada 
  select count(*) 
    into v_idle_activity 
    from LOTE 
   where CONF_ID = i_produtivo 
     and STATUS = 6 
  ; 
   
  if v_idle_activity = 0 then 
    --Verificar se o produtivo é exclusivo 
    select EXCLUSIVO 
      into v_exclusivo 
      from PRODUTIVO 
     where ID = i_produtivo 
    ; 
    --htp.p('v_exclusivo: '||v_exclusivo); 
     
    --Verificar a prioridade para uma atividade de exclusividade 
    select min(A.PRIORIDADE) 
      into v_prioridade 
      from CARGA         A, 
           LOTE          B, 
           PRODUTIVO     C, 
           PRODUTIVO_BOX D 
     where A.ID = B.CARGA_ID 
       and C.ID = i_produtivo 
       and B.STATUS = 2 
       and D.PRODUTIVO_ID = C.ID 
       and D.BOX = TO_NUMBER(SUBSTR(TO_CHAR(A.BOX_ID), 1, LENGTH(TO_CHAR(A.BOX_ID))-1)) 
       and C.EXCLUSIVO = 1 
       and B.LS not in ('ME','FR','CA','MF') 
    ; 
    --htp.p('v_prioridade: '||nvl(v_prioridade,1)); 
    if v_prioridade is not null and v_exclusivo = 1 then 
      --htp.p('if'); 
      -- 
      select distinct ID 
        into o_carga 
        from (select distinct A.ID, RANK() OVER(order by F.DTAHORGERAPALETE) n, F.DTAHORGERAPALETE 
                     from CARGA         A, 
                          LOTE          B, 
                          PRODUTIVO     C, 
                          PRODUTIVO_BOX D, 
                          CONSINCO.MLO_CARGAEXPED F 
                    where A.ID = B.CARGA_ID 
                      and C.ID = i_produtivo 
                      and A.ID = F.NROCARGA 
                      and B.STATUS = 2 
                      and D.BOX = TO_NUMBER(SUBSTR(TO_CHAR(A.BOX_ID), 1, LENGTH(TO_CHAR(A.BOX_ID))-1)) 
                      and D.PRODUTIVO_ID = C.ID 
                      and A.PRIORIDADE = v_prioridade 
                      and B.LS not in ('ME','FR','CA','MF')) 
       where n = 1 
      ; 
      --htp.p('o_carga: '||nvl(o_carga,1)); 
      SELECT min(E.ID) INTO o_lote 
      FROM 
        (SELECT B.ID, 
                RANK() OVER( 
                            ORDER BY B.PESO DESC) N 
         FROM CARGA A, 
              LOTE B, 
              PRODUTIVO C, 
              PRODUTIVO_BOX D 
         WHERE A.ID = B.CARGA_ID 
           AND C.ID = i_produtivo 
           AND B.STATUS = 2 
           AND D.BOX = TO_NUMBER(SUBSTR(TO_CHAR(A.BOX_ID), 1, LENGTH(TO_CHAR(A.BOX_ID))-1)) 
           AND D.PRODUTIVO_ID = C.ID 
           AND A.ID = o_carga 
           AND B.LS not in ('ME', 
                            'FR', 
                            'CA', 
                            'MF')) E 
      WHERE E.N=1 
      ; 
    else 
      --htp.p('else'); 
      select min(A.PRIORIDADE) 
        into v_prioridade 
        from BOX A 
       where exists ( 
         select 1 
           from CARGA B, 
                LOTE C 
          where A.ID = TO_NUMBER(SUBSTR(TO_CHAR(B.BOX_ID), 1, LENGTH(TO_CHAR(B.BOX_ID))-1)) 
            and C.CARGA_ID = B.ID 
            and C.STATUS = 2 
            and C.LS not in ('ME','FR','CA','MF') 
       ) 
      ; 
      --htp.p('v_box: '||v_prioridade); 
      select min(ID) 
        into v_box  
        from BOX A 
       where PRIORIDADE = v_prioridade 
         and exists ( 
           select 1 
             from CARGA B, 
                  LOTE C 
            where A.ID = TO_NUMBER(SUBSTR(TO_CHAR(B.BOX_ID), 1, LENGTH(TO_CHAR(B.BOX_ID))-1)) 
              and C.CARGA_ID = B.ID 
              and C.STATUS = 2 
              and C.LS not in ('ME','FR','CA','MF') 
         ); 
 
      --htp.p('v_box: '||v_box); 
      select distinct ID 
        into o_carga 
        from (select distinct 
                     A.ID, 
                     RANK() OVER(order by A.PRIORIDADE, F.DTAHORGERAPALETE) n, 
                     F.DTAHORGERAPALETE 
                from CARGA         A, 
                     LOTE          B, 
                     CONSINCO.MLO_CARGAEXPED F 
               where A.ID = B.CARGA_ID 
                 and A.ID = F.NROCARGA 
                 and B.STATUS = 2 
                 and TO_NUMBER(SUBSTR(TO_CHAR(A.BOX_ID), 1, LENGTH(TO_CHAR(A.BOX_ID))-1)) = v_box 
                 and B.LS not in ('ME','FR','CA','MF')) 
       where n = 1 
      ; 
      --htp.p('o_carga: '||o_carga); 
      /* 
      select min(A.ID) 
        into o_carga 
        from CARGA A, 
             LOTE  B, 
             BOX   C 
       where A.ID = B.CARGA_ID 
         and B.STATUS = 2 
         and B.LS not in ('ME','FR','CA','MF') 
         and C.ID = TO_NUMBER(SUBSTR(TO_CHAR(A.BOX_ID), 1, LENGTH(TO_CHAR(A.BOX_ID))-1)) 
         and C.PRIORIDADE = v_prioridade 
      ; 
      --htp.p();*/ 
      SELECT min(E.ID) 
        INTO o_lote 
        FROM (SELECT B.ID, 
                     RANK() OVER(ORDER BY B.PESO DESC) N 
                FROM CARGA A, 
                     LOTE B 
               WHERE A.ID = B.CARGA_ID 
                 AND B.STATUS = 2 
                 AND B.LS not in ('ME','FR','CA','MF') 
                 AND A.ID = o_carga) E 
        WHERE E.N = 1 
      ; 
      --htp.p('o_lote: '||o_lote); 
    end if; 
    o_carga := nvl(o_carga, 0); 
    o_lote := nvl(o_lote, 0); 
    select count(*) 
      into v_idle_activity 
      from LOTE 
     where CONF_ID = i_produtivo 
       and STATUS = 5 
    ; 
     
    if v_idle_activity = 1 then 
      update LOTE 
         set STATUS = 6 
       where CONF_ID = i_produtivo 
         and STATUS = 5 
      ; 
    end if; 
     
  else 
    select CARGA_ID, ID 
      into o_carga, o_lote 
      from LOTE 
     where CONF_ID = i_produtivo 
       and STATUS = 6 
    ; 
  end if; 
  exception 
    when NO_DATA_FOUND 
      then o_carga := nvl(o_carga, 0); 
           o_lote := nvl(o_lote, 0); 
            
  --htp.p('Carga: ' || o_carga); 
  --htp.p('Lote: ' || o_lote); 
  --htp.p('Prioridade: ' || v_prioridade); 
  --htp.p('Exclusivo: ' || v_exclusivo); 
end; 
/