CREATE OR REPLACE EDITIONABLE PACKAGE "WMS"."PKG_KANBAN" as

function f_get_carga_column(
  i_carga in number
) return number;

function f_get_carga_column_title(
  i_carga in number
) return varchar2;

function f_get_title(
  i_carga in number
) return varchar2;

function f_get_footer(
  i_carga in number
) return varchar2;

function f_get_box(
  i_carga in number
) return varchar2;

function f_get_group_title(
  i_box in number,
  i_data_i in date,
  i_data_f in date
) return varchar2;

function f_get_group_footer(
  i_carga in number,
  i_data_i in date,
  i_data_f in date
) return varchar2;
end;
/
CREATE OR REPLACE EDITIONABLE PACKAGE BODY "WMS"."PKG_KANBAN" as
function f_get_carga_column(
    i_carga in number
) return number is
    v_return number;
begin

select decode(A.STATUS,
       0, 0,
       1, 1,
       2, case
              when (select STATUSCARGA
                      from consinco.mlo_cargaexped D
                     where D.nrocarga = A.ID) = 'L'
               and (select count(*)
                      from corte D
                     where D.CARGA_ID = A.ID
                       and D.DONE = 0) = 0
                then 4
              when (select STATUSCARGA
                      from consinco.mlo_cargaexped D
                     where D.nrocarga = A.ID) = 'F'
               and (select count(*)
                      from wms.corte D
                     where D.CARGA_ID = A.ID
                       and D.DONE = 0) = 0
                then 5
              when (select count(*)
                      from wms.corte D
                     where D.CARGA_ID = A.ID
                       and D.DONE = 0) > 0
                then 2
                else 3
              end
       )
  into v_return
  from WMS.CARGA         A,
       WMS.CARGA_IMPORT  B,
       CONSINCO.MLO_CARGAEXPED C
 where A.ID = B.ID
  and A.ID = C.NROCARGA
  and exists (select 1 from WMS.LOTE D WHERE A.ID = D.CARGA_ID)
  and A.ID = i_carga;
return v_return;
end f_get_carga_column;

function f_get_carga_column_title(
    i_carga in number
) return varchar2 is
    v_return varchar2(100);
begin
select decode(A.STATUS,
       0, 'Não iniciado',
       1, 'Iniciado',
       2, case
              when (select STATUSCARGA
                      from consinco.mlo_cargaexped D
                     where D.nrocarga = A.ID) = 'L'
               and (select count(*)
                      from corte D
                     where D.CARGA_ID = A.ID
                       and D.DONE = 0) = 0
                then 'Liberado'
              when (select STATUSCARGA
                      from consinco.mlo_cargaexped D
                     where D.nrocarga = A.ID) = 'F'
               and (select count(*)
                      from wms.corte D
                     where D.CARGA_ID = A.ID
                       and D.DONE = 0) = 0
                then 'Faturado'
              when (select count(*)
                      from wms.corte D
                     where D.CARGA_ID = A.ID
                       and D.DONE = 0) > 0
                then 'CORTE'
                else 'Finalizado'
              end
       )
  into v_return
  from WMS.CARGA         A,
       WMS.CARGA_IMPORT  B,
       CONSINCO.MLO_CARGAEXPED C
 where A.ID = B.ID
  and A.ID = C.NROCARGA
  and exists (select 1 from WMS.LOTE D WHERE A.ID = D.CARGA_ID)
  and A.ID = i_carga;
return v_return;
end f_get_carga_column_title;

function f_get_title(
  i_carga in number
) return varchar2 is
  v_return varchar2(100);
  v_finalizada number;
  v_qtd_conf number;
  v_total number;
  v_box number;
begin
  select count(*)
    into v_finalizada
    from WMS.LOTE E
   where E.CARGA_ID = i_carga
     and E.STATUS = 4
  ;
  select count(*)
    into v_qtd_conf
    from wms.lote
   where carga_id = i_carga
     and status = 3
     and LS not in ('FR','ME','CA','MF')
  ;
  select count(*)
    into v_total
    from WMS.LOTE E
   where E.CARGA_ID = i_carga
  ;
  select box_id/10
    into v_box
    from WMS.CARGA_IMPORT
   where ID = i_carga
  ;
  v_return := '<span '||
              case when v_finalizada > 0
                then 'class="c-green"'
                else 'class=""'
              end || '>'|| i_carga || ' - ' ||
              v_finalizada || '/' || v_total ||
              ' - C. ' || v_qtd_conf ||
              '</span>';
return v_return;
end f_get_title;

function f_get_footer(
  i_carga in number
) return varchar2 is
  v_return varchar2(1000);
begin
  select 'B.' || box_id/10 || ' / ' || destino
    into v_return
    from wms.carga_import
   where id = i_carga;
  return v_return;
end f_get_footer;

function f_get_box(
  i_carga in number
) return varchar2 is
  v_return varchar2(1000);
begin
  select 'B.' || substr(lpad(box_id, 3, '0'), 1, 2)
    into v_return
    from wms.carga_import B
   where id = i_carga;
  return v_return;
end f_get_box;

function f_get_group_title (
  i_box in number,
  i_data_i in date,
  i_data_f in date
) return varchar2 is
  v_return varchar2(1000);
  v_valor number;
begin
  select sum(VALORCARGA)
    into v_valor
    from WMS.CARGA         A,
         WMS.CARGA_IMPORT  B,
         CONSINCO.MLO_CARGAEXPED C
   where A.ID = B.ID
     and A.ID = C.NROCARGA
     and TRUNC(A.CREATED) between i_data_i and i_data_f
     and exists (select 1 from WMS.LOTE D WHERE A.ID = D.CARGA_ID)
     and C.TIPENTREGA != 'R'
     and B.BOX_ID != 999
     and B.BOX_ID = i_box;
  
  v_return := 'B.'||i_box||' - '|| to_char(v_valor,'FML999G999G999G999G990D00');
  return v_return;
end f_get_group_title;

function f_get_group_footer(
  i_carga in number,
  i_data_i in date,
  i_data_f in date
) return varchar2 as
  v_box number;
  v_qtd_volume number;
  v_qtd_item number;
  v_peso number;
  v_volume number;
  v_valor number;
  v_return varchar2(1000);
begin
  select box_id
    into v_box
    from wms.carga_import
   where id = i_carga
  ;
  select sum(valorcarga)
    into v_valor
    from consinco.mlo_cargaexped
   where nrobox = v_box
     and trunc(dtahorgeracao) between i_data_i and i_data_f
  ;
  select sum(a.qtd_volume), sum(a.qtd_item), sum(a.peso), sum(a.volume)
    into v_qtd_volume, v_qtd_item, v_peso, v_volume
    from wms.lote a
   inner join carga_import b
      on b.id = a.carga_id
   where b.box_id = v_box
     and trunc(b.created) between i_data_i and i_data_f
     and B.BOX_ID = v_box
  ;
  
  v_return := 'Valor: ' || to_char(v_valor,'FML999G999G999G999G990D00') ||
              '<br>Qtd.Itens: '||v_qtd_item||
              '<br>Qtd.Volume: '||v_qtd_volume ||
              '<br>Peso: ' ||to_char(v_peso,'999G999G999G999G990D00') ||
              '<br>Volume: '|| to_char(v_volume,'999G999G999G999G990D0000');
  return v_return;
end f_get_group_footer;
end;
/