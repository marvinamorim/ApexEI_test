CREATE OR REPLACE FORCE EDITIONABLE VIEW "WMS"."V_CARGAS_SEM_LS" ("NROCARGA", "DESCRICAO", "VALOR") AS 
  select a.nrocarga,
       a.descricao,
       wms.f_get_valor_carga(a.nrocarga) as valor
  from consinco.mrl_cargaexped a
  left join wms.carga_import b
    on b.id = a.nrocarga
 where b.id is null
   and tipentrega = 'E'
   and statuscarga in ('G','S')
   and nroempresa = 1
   and trunc(dtahorgeracao) = trunc(sysdate)
 order by 1 desc
;