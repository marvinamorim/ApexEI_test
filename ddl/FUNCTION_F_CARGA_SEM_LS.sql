CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_CARGA_SEM_LS" (code number, dtai date, dtaf date) 
   RETURN number 
IS 
qtd number; 
BEGIN 
SELECT count(*) into qtd 
FROM CONSINCO.MRL_CARGAEXPED C 
WHERE C.DTAHORGERACAO > SYSDATE - nvl(null,8) 
  AND C.STATUSCARGA <> 'F' 
  AND EXISTS (SELECT 1 FROM WMS.CARGA F WHERE F.ID = C.NROCARGA) 
  and C.NROCARGA not in (323679) 
  and C.NROCARGA in ( 
    select D.CARGA from APEX.TB_CDA_MOTORISTA_CARGA D 
    where D.PLC_CODIGO = code 
      and trunc(D.DTAINCLUSAO) between dtai and dtaf 
  ) 
  ; 
return qtd; 
 
END F_CARGA_SEM_LS; 
/