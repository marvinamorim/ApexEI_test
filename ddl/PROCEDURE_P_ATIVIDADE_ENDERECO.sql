CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_ATIVIDADE_ENDERECO" (i_carga_id in number) as
v_av varchar2(1);
v_exists number;
v_endereco_id number;
v_qtd_atual number;
begin
  for c1 in (
    select * from atividade
     where carga_id = i_carga_id
       and LS not in ('CA','FR')
  ) loop
    select ATACADOVAREJO
      into v_av
      from WMS.LINHADESEPARACAO
     where LS = c1.LS;
    if v_av = 'A' then
      select count(*)
        into v_exists
        from WMS.endereco
       where produto_id = c1.produto_id
         and especie_id = 1
      ;
      if v_exists = 0 then
        select min(id)
          into v_endereco_id
          from WMS.endereco
         where produto_id = c1.produto_id
           and especie_id = 2
        ;
      else
        select min(id)
          into v_endereco_id
          from WMS.endereco
         where produto_id = c1.produto_id
           and especie_id = 1
        ;
      end if;
    else
      select count(*)
        into v_exists
        from WMS.endereco
       where produto_id = c1.produto_id
         and especie_id = 2
      ;
      if v_exists = 0 then
        select min(id)
          into v_endereco_id
          from WMS.endereco
         where produto_id = c1.produto_id
           and especie_id = 1
        ;
      else
        select min(id)
          into v_endereco_id
          from WMS.endereco
         where produto_id = c1.produto_id
           and especie_id = 2
        ;
      end if;
    end if;
    update WMS.endereco
       set qtd_atual = qtd_atual - c1.qtd_pedido
     where id = v_endereco_id;
    select qtd_atual
      into v_qtd_atual
      from WMS.endereco
     where id = v_endereco_id;
    WMS.P_VERIFICAR_REPOSICAO(v_endereco_id);
  end loop;
end;
/