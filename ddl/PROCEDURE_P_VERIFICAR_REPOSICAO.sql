CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_VERIFICAR_REPOSICAO" (v_endereco_id in number) as
  v_qtd_minima number;
  v_exists number;
  v_qtd_reposicao number;
  v_emb varchar2(3);
  v_qtd_emb number;
  v_origem_id number;
  v_qtd_temp number;
begin
  for c1 in (
    select *
      from endereco
     where id = v_endereco_id
  ) loop
    select a.estoque_min * b.qtd_emb,
           a.lastro*a.altura*b.qtd_emb,
           b.emb,
           b.qtd_emb
      into v_qtd_minima, v_qtd_reposicao, v_emb, v_qtd_emb
      from wms.produto_especie a
     inner join wms.produto_embalagem b
        on b.id = a.embalagem_id
     where a.especie_id = c1.especie_id
       and a.produto_id = c1.produto_id
    ;
    if c1.qtd_atual <= v_qtd_minima then
      if c1.especie_id = 1 then
        select count(*)
          into v_exists
          from wms.endereco
         where especie_id = 5
           and virtual = 0
           and produto_id = c1.produto_id
           and qtd_atual > 0;
      else
        select count(*)
          into v_exists
          from wms.endereco
         where especie_id = 1
           and produto_id = c1.produto_id
           and qtd_atual > 0;
      end if;
      if v_exists > 0 then
        if c1.especie_id = 1 then
          select id, qtd_atual
            into v_origem_id, v_qtd_temp
            from (
            select id, rank() over (order by qtd_atual) as n, qtd_atual
              from wms.endereco a
             where especie_id = 5
               and virtual = 0
               and qtd_atual > 0
               and produto_id = c1.produto_id
             order by 2)
           where rownum = 1
          ;
          if v_qtd_temp > v_qtd_reposicao then
            insert into wms.movimentacao (
              tipo,
              origem_id,
              destino_id,
              status,
              qtd,
              emb,
              qtd_emb,
              prioridade
            ) values (
              'A',
              c1.id,
              v_origem_id,
              0,
              v_qtd_temp - v_qtd_reposicao,
              v_emb,
              v_qtd_emb,
              0
            );
            v_qtd_temp := v_qtd_reposicao;
          end if;
          insert into wms.movimentacao (
            tipo,
            origem_id,
            destino_id,
            status,
            qtd,
            emb,
            qtd_emb,
            prioridade
          ) values (
            'D',
            v_origem_id,
            c1.id,
            0,
            v_qtd_temp,
            v_emb,
            v_qtd_emb,
            0
          );
        else
          select id, qtd_atual
            into v_origem_id, v_qtd_temp
            from (
            select id, rank() over (order by qtd_atual) as n, qtd_atual
              from wms.endereco a
             where especie_id = 1
               and virtual = 0
               and qtd_atual > 0
               and produto_id = c1.produto_id
             order by 2)
           where rownum = 1
          ;
          if v_qtd_temp > v_qtd_reposicao then
            v_qtd_temp := v_qtd_reposicao;
          end if;
          insert into wms.movimentacao (
            tipo,
            origem_id,
            destino_id,
            status,
            qtd,
            emb,
            qtd_emb,
            prioridade
          ) values (
            'R',
            v_origem_id,
            c1.id,
            0,
            v_qtd_temp,
            v_emb,
            v_qtd_emb,
            0
          );
        end if;
      end if;
    end if;
  end loop;
end;
/