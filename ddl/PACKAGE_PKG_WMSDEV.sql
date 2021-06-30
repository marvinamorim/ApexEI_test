CREATE OR REPLACE EDITIONABLE PACKAGE "WMS"."PKG_WMSDEV" as 
  procedure p_init_data;  
  procedure p_clear_all;  
  procedure p_insert_produto;  
  procedure p_insert_produto_embalagem;  
  procedure p_insert_embalagem_codigo;  
  procedure p_insert_produto_especie;  
  procedure p_insert_endereco_rua; 
  procedure p_insert_endereco;  
  procedure p_insert_endereco_armazenagem;  
  procedure p_insert_endereco_validade;  
  procedure p_insert_palete;  
end pkg_wmsdev;  
/
CREATE OR REPLACE EDITIONABLE PACKAGE BODY "WMS"."PKG_WMSDEV" as 
  procedure p_init_data as  
  begin  
    --teste diff  
    p_clear_all;  
    p_insert_produto;  
    p_insert_produto_embalagem;  
    p_insert_embalagem_codigo;  
    p_insert_produto_especie;  
    p_insert_endereco_rua; 
  	p_insert_endereco;  
    p_insert_endereco_armazenagem;  
    p_insert_endereco_validade;  
    p_insert_palete;  
    commit;  
  end p_init_data;  
    
  procedure p_clear_all as  
  begin  
    delete from wms.carga_import;  
    delete from wms.carga;  
    delete from wms.corte; 
    delete from wms.lote_print_log; 
    delete from wms.movimentacao; 
    delete from wms.produto; 
    delete from wms.produto_embalagem; 
    delete from wms.embalagem_codigo; 
    delete from wms.produto_especie; 
    delete from wms.endereco_rua; 
    delete from wms.endereco; 
    delete from wms.endereco_armazenagem; 
    delete from wms.endereco_validade; 
    delete from wms.palete; 
    commit;  
  end p_clear_all;  
    
  procedure p_insert_produto as  
  begin  
  	insert into wms.produto(  
      id,  
      nome,  
      endereco_tipo_id,   
      tipo_armazenagem_id,  
      dias_validade,  
      fornecedor_id,  
      status, 
      REFFABRICANTE  
    )  
    select A.SEQPRODUTO,  
           A.DESCCOMPLETA,  
           (  
           select x.ordemascend  
             from consinco.mlo_produto z  
            inner join consinco.mlo_tipendereco x  
               on z.CODTIPENDERECO = x.codtipendereco  
            where z.SEQPRODUTO = a.seqproduto  
           ) as endereco_tipo,  
           (  
           select c.id  
             from consinco.MLO_ATRIBUTOFIXO b  
            inner join wms.tipo_armazenagem c  
               on b.descricao = c.nome  
            inner join consinco.mlo_produto d  
               on d.TIPARMAZENAGEM = b.lista  
            Where TIPATRIBUTOFIXO = 'TIPARMAZ'  
              and d.SEQPRODUTO = a.seqproduto  
              and d.nroempresa = 1  
           ) as tipo_armazenagem,  
           A.PZOVALIDADEDIA,  
           F_FORNECEDOR_AGG(A.SEQPRODUTO),  
           1 as status , 
           A.REFFABRICANTE 
      from CONSINCO.MLO_PRODUTO A  
     where A.NROEMPRESA = 1  
       and exists (  
         select 1 from consinco.mlo_prodembalagem k  
          where k.seqproduto = a.seqproduto  
            and k.statusembalagem = 'A'  
       );  
  end p_insert_produto;  
    
  procedure p_insert_produto_embalagem as  
  begin  
  	insert into wms.produto_embalagem  
    select null as id,   
           c.codlinhasepar as ls,  
           b.id as produto_id, 
           a.embalagem as emb,  
           a.qtdembalagem as qtd_emb,  
           a.pesobruto as peso_bruto,  
           a.pesoliquido as peso_liquido,  
           a.altura as altura,  
           a.largura as largura,  
           a.profundidade as profundidade  
      from consinco.mlo_prodembalagem a  
     inner join wms.produto b  
        on a.seqproduto = b.id  
      left join consinco.mlo_prodembwm c  
        on c.seqproduto = a.seqproduto 
       and c.qtdembalagem =  a.qtdembalagem 
       and c.nroempresa = a.nroempresa 
     where a.nroempresa = 1  
       and a.statusembalagem = 'A';  
    commit; 
    update wms.produto c  
       set embalagem_id = (  
         select d.id  
           from consinco.MAP_FAMDIVISAO A  
          inner join consinco.MAP_PRODUTO B  
             on a.seqfamilia = b.seqfamilia  
          inner join wms.produto_embalagem d  
             on d.qtd_emb = a.padraoembcompra  
            and c.id = d.produto_id  
          where c.id = b.seqproduto  
            and a.nrodivisao = 1  
       );  
    delete from wms.produto  
     where embalagem_id is null;  
  end p_insert_produto_embalagem;  
    
  procedure p_insert_embalagem_codigo as  
  begin  
  	insert into wms.embalagem_codigo  
    select null,  
           b.id,  
           c.CODACESSO,  
           c.TIPCODIGO  
      from wms.produto a  
     inner join wms.produto_embalagem b  
        on a.id = b.produto_id  
     inner join consinco.mlo_prodcodigo c  
        on a.id = c.Seqproduto  
       and b.produto_id = c.Seqproduto  
     where c.Nroempresa = 1  
     order by 4, 3;  
  end p_insert_embalagem_codigo;  
    
  procedure p_insert_produto_especie as  
  begin  
  	insert into wms.PRODUTO_ESPECIE (ID,ESPECIE_ID,EMBALAGEM_ID,ESTOQUE_MIN,LASTRO,ALTURA,SOBRA,PRODUTO_ID)  
    select null as id,  
           decode(C.ESPECIEENDERECO, 'A',1, 'M',2, 'P',5, 'V',3) as especie_id,  
           b.id as embalagem_id,  
           C.ESTQMINIMOREP as estoque_min,  
           C.PALETELASTRO as lastro,  
           C.PALETEALTURA as altura,  
           0 as sobra,  
           a.id as produto_id  
      from consinco.MLO_PRODESPENDERECO C,  
           wms.produto a,  
           wms.produto_embalagem b  
     where a.id = b.produto_id  
       and b.qtd_emb = c.qtdembalagem  
       and a.id = c.seqproduto  
       And c.NROEMPRESA = 1  
       and C.ESPECIEENDERECO in ('A','M','P','V')  
     order by 3,2;  
  end p_insert_produto_especie;  
   
  procedure p_insert_endereco_rua as 
  begin 
    insert into wms.ENDERECO_RUA 
    select null, codrua, 1, 0, 1 
      from consinco.mlo_rua; 
  end; 
    
  procedure p_insert_endereco as  
  begin  
  	insert into wms.endereco j (  
      id,   
      tipo_id,   
      especie_id,  
      rua,  
      predio,  
      apartamento,  
      sala,  
      pulmao,  
      terreo,  
      produto_id,  
      embalagem_id,  
      qtd_atual,  
      status,  
      expedicao,  
      TIPO_REPOSICAO,  
      tipo_especial,  
      gerar_reposicao,  
      virtual 
    )  
    select a.seqendereco,  
           max(c.ordemascend),  
           e.id especie_id,  
           codrua as rua,  
           nropredio as predio,  
           nroapartamento as apartamento,  
           nrosala as sala,  
           case when e.sigla = 'P' then 1 else 0 end as PULMAO,  
           decode(a.indterreoaereo, 'T', 1, 0) as TERREO,  
           a.seqproduto,  
           f.id,  
           case when a.qtdatual >= 0 then a.qtdatual else 0 end,  
           1,  
           case when e.sigla = 'P' or a.codrua in ('AV','998','996') then 0 else 1 end,  
           decode(A.TIPREPOSICAOEND, 'M','A','N','P','C','M'),  
           (select count(*)  
              from consinco.Mlo_Tipendperm b1  
             where b1.seqendereco = a.seqendereco  
               and b1.codtipendereco = 'S') as tipo_especial,  
           case  
             when a.codrua in ('990','995','996','997','998','999','AV') or  
                  e.sigla = 'P'  
               then 0  
               else 1  
           end,  
           case  
             when a.codrua in ('990','995','996','997','998','999','AV')  
               then 1  
               else 0  
           end 
      from consinco.mlo_endereco A  
     inner join consinco.Mlo_Tipendperm b  
        on a.seqendereco = b.seqendereco  
     inner join consinco.mlo_tipendereco c  
        on b.codtipendereco = c.codtipendereco  
     inner join consinco.mlo_especieendereco d  
        on d.especieendereco = a.especieendereco  
     inner join wms.endereco_especie e  
        on e.sigla = d.especieendereco  
      left join wms.produto_embalagem f  
        on f.qtd_emb = a.qtdembalagem  
       and f.produto_id = a.seqproduto  
     where b.codtipendereco not in ('S')  
       and a.statusendereco not in ('I','B')  
       and ((a.seqproduto is null and e.sigla = 'P') or  
            (a.seqproduto is not null))  
     group by a.seqendereco,  
           e.id,  
           e.sigla,  
           codrua,  
           nropredio,  
           nroapartamento,  
           nrosala,  
           a.indterreoaereo,  
           a.seqproduto,  
           a.qtdatual,  
           f.id,  
           a.seqpaleterf,  
           decode(A.TIPREPOSICAOEND, 'M','A','N','P','C','M')  
     order by 2, 3, 4, 5;  
  end p_insert_endereco;  
    
  procedure p_insert_endereco_armazenagem as  
  begin  
  	insert into wms.endereco_armazenagem (endereco_id, armazenagem_id)  
    select c.id, d.id as tip  
      from consinco.mlo_armazenperm a  
     inner join consinco.MLO_ATRIBUTOFIXO b  
        on a.tiparmazenagem = b.lista  
     inner join wms.endereco c  
        on c.id = a.seqendereco  
     inner join wms.TIPO_ARMAZENAGEM d  
        on d.nome = b.descricao  
     where b.TIPATRIBUTOFIXO = 'TIPARMAZ'  
     order by 1, 2;  
  end p_insert_endereco_armazenagem;  
    
  procedure p_insert_endereco_validade as  
  begin  
  	insert into wms.endereco_validade  
    select a.seqenderecoqtde, a.seqendereco, a.qtdatual, a.dtavalidade, a.dtarecebimento, 1  
      from CONSINCO.MLO_ENDERECOQTDE a  
     where exists (  
           select 1  
             from wms.endereco b  
            where a.seqendereco = b.id 
              and b.especie_id = 5 /*especie pulmao*/ 
     );  
  end p_insert_endereco_validade;  
    
  procedure p_insert_palete as  
  begin  
    insert into wms.palete(id, qtd, endereco_id, embalagem_id, carga_id, status) 
  	select a.seqpaleterf, 
           a.lastro*a.altura+a.sobra, 
           b.seqendereco, 
           c.id, 
           nvl(a.nrocargareceb, 0), 
           4 
      from consinco.mlo_palete a 
     inner join consinco.mlo_endereco b 
        on a.seqpaleterf = b.seqpaleterf 
     inner join wms.produto_embalagem c 
        on a.qtdembalagem = c.qtd_emb 
       and c.produto_id = a.seqproduto 
     order by 1; 
  end p_insert_palete;  
end pkg_wmsdev;  
----------------------------  
/