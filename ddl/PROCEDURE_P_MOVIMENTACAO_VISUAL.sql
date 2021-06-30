CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_MOVIMENTACAO_VISUAL" (
  i_origem_id in number,
  i_destino_id in number,
  i_qtd in number,
  i_tipo in varchar2,
  i_emb_id in number,
  i_user in varchar2
) as
  v_qtd_emb number;
  v_emb varchar2(3);
  v_next_id number;
  v_palete_id number;
begin
  select min(id)
    into v_palete_id
    from palete
   where endereco_id = i_origem_id;

  select movimentacao_seq.nextval
    into v_next_id
    from dual;
    
  select emb, qtd_emb
    into v_emb, v_qtd_emb
    from produto_embalagem
   where id = i_emb_id
  ;
  insert into movimentacao_visual (
    tipo,
    origem_id,
    destino_id,
    embalagem_id,
    qtd,
    movimentacao_id,
    palete_id,
    created_by
  ) values (
    i_tipo,
    i_origem_id,
    i_destino_id,
    i_emb_id,
    i_qtd,
    v_next_id,
    v_palete_id,
    i_user
  );
  insert into movimentacao (
    id,
    tipo,
    origem_id,
    destino_id,
    status,
    qtd,
    emb,
    qtd_emb,
    prioridade,
    palete_id
  ) values (
    v_next_id,
    i_tipo,
    i_origem_id,
    i_destino_id,
    0,
    i_qtd*v_qtd_emb,
    v_emb,
    v_qtd_emb,
    1,
    v_palete_id
  );
  update endereco
     set qtd_atual = qtd_atual - i_qtd*v_qtd_emb
   where id = i_origem_id;
  update endereco
     set qtd_atual = qtd_atual + i_qtd*v_qtd_emb
   where id = i_destino_id;
end;
/