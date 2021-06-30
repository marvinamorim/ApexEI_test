CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_GET_RUA" (i_produto in number, i_qtd_emb in number, i_tipo in varchar2)
return varchar2 as
  v_return varchar2(100);
  v_exists number;
  v_rua varchar2(3);
  v_predio number;
  v_apto number;
  v_sala number;
begin
  select count(*)
    into v_exists
    from wms.V_ENDERECO_EMB a
   where a.SEQPRODUTO = i_produto
     and a.QTDEMBALAGEM = i_qtd_emb;

  if v_exists > 0 then
    select max(A.CODRUA)
      into v_rua
      from wms.V_ENDERECO_EMB a
     where a.SEQPRODUTO = i_produto
       and a.QTDEMBALAGEM = i_qtd_emb;
     
     select max(A.NROPREDIO)
      into v_predio
      from wms.V_ENDERECO_EMB a
     where a.SEQPRODUTO = i_produto
       and a.QTDEMBALAGEM = i_qtd_emb
       and a.CODRUA = v_rua;
     
     select max(A.NROAPARTAMENTO)
      into v_apto
      from wms.V_ENDERECO_EMB a
     where a.SEQPRODUTO = i_produto
       and a.QTDEMBALAGEM = i_qtd_emb
       and a.CODRUA = v_rua
       and a.NROPREDIO = v_predio;
     
     select max(A.NROSALA)
      into v_sala
      from wms.V_ENDERECO_EMB a
     where a.SEQPRODUTO = i_produto
       and a.QTDEMBALAGEM = i_qtd_emb
       and a.CODRUA = v_rua
       and a.NROPREDIO = v_predio
       and a.NROAPARTAMENTO = v_apto;
  else
    select max(A.CODRUA)
      into v_rua
      from wms.V_ENDERECO_EMB a
     where a.SEQPRODUTO = i_produto;
     
     select max(A.NROPREDIO)
      into v_predio
      from wms.V_ENDERECO_EMB a
     where a.SEQPRODUTO = i_produto
       and a.CODRUA = v_rua;
     
     select max(A.NROAPARTAMENTO)
      into v_apto
      from wms.V_ENDERECO_EMB a
     where a.SEQPRODUTO = i_produto
       and a.CODRUA = v_rua
       and a.NROPREDIO = v_predio;
     
     select max(A.NROSALA)
      into v_sala
      from wms.V_ENDERECO_EMB a
     where a.SEQPRODUTO = i_produto
       and a.CODRUA = v_rua
       and a.NROPREDIO = v_predio
       and a.NROAPARTAMENTO = v_apto;
  end if;
  if i_tipo = 'RUA' then
    return v_rua;
  elsif   i_tipo = 'PREDIO' then
    return v_predio;
  elsif i_tipo = 'APTO' then
    return v_apto;
  elsif i_tipo = 'SALA' then
    return v_sala;
  else
    return v_rua ||'.'||v_predio ||'.'||v_apto ||'.'||v_sala;
  end if;
end;
/