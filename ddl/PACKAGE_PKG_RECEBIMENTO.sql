CREATE OR REPLACE EDITIONABLE PACKAGE "WMS"."PKG_RECEBIMENTO" as  
  procedure p_check_palete(  
    i_palete_id in number,  
    i_user in varchar2  
  );  
    
  procedure p_set_conf_palete(  
    i_conf_id IN NUMBER,  
    i_palete_id IN NUMBER  
  );  
    
  procedure p_check_codigo_barras(  
    i_palete_id in number,  
    i_codigo_barras in varchar2  
  );  
    
  function f_get_validade_parametro(  
    i_produto_id in number,  
    i_tipo in varchar2  
  ) return number;  
    
  function f_check_validade_recebimento(  
    i_produto_id in number,  
    i_validade in date  
  ) return boolean;  
    
  procedure p_solicitar_validade(  
    i_palete_id in number,  
    i_validade in date,  
    i_conf_qtd in number  
  );  
    
  procedure p_finalizar_solicitacao(  
    i_id in number,  
    i_status in number  
  );  
    
  procedure p_finalizar_palete(  
    i_palete_id in number,  
    i_validade in date,  
    i_conf_qtd in number  
  );  
   
  procedure p_criar_movimentacao( 
    i_palete_id in number 
  ); 
end;  
/
CREATE OR REPLACE EDITIONABLE PACKAGE BODY "WMS"."PKG_RECEBIMENTO" as  
--------------------------------------------------------------------------------  
--------------------------------------------------------------------------------  
  procedure p_criar_movimentacao( 
    i_palete_id in number 
  ) as  
    v_movimentacao_id number; 
  begin 
    select movimentacao_seq.nextval 
      into v_movimentacao_id 
      from dual; 
    insert into movimentacao ( 
      id, 
      tipo, 
      palete_id, 
      origem_id, 
      destino_id, 
      status, 
      qtd, 
      emb, 
      qtd_emb 
    ) 
    select v_movimentacao_id, 
           'E', 
           a.id as palete_id, 
           c.box_id, 
           a.endereco_id, 
           0, 
           a.conf_qtd, 
           b.emb, 
           b.qtd_emb 
      from palete a 
     inner join produto_embalagem b 
        on a.embalagem_id = b.id 
     inner join carga_import c 
        on a.carga_id = c.id 
     where a.id = i_palete_id; 
    insert into movimentacao_palete (palete_id, movimentacao_id) 
    values (i_palete_id, v_movimentacao_id); 
  end; 
--------------------------------------------------------------------------------  
  procedure p_finalizar_palete(  
    i_palete_id in number,  
    i_validade in date,  
    i_conf_qtd in number  
  ) as  
  begin  
    update palete  
       set conf_qtd = i_conf_qtd,  
           conf_end = sysdate,  
           validade = i_validade,  
           status = 2  
     where id = i_palete_id  
    ; 
    p_criar_movimentacao(i_palete_id); 
  end;  
--------------------------------------------------------------------------------  
  procedure p_finalizar_solicitacao(  
    i_id in number,  
    i_status in number  
  ) as  
    v_validade date;  
    v_palete_id number;  
  begin  
    update palete_validade  
       set status = i_status  
     where id = i_id  
    ;  
    select palete_id, validade  
      into v_palete_id, v_validade  
      from palete_validade  
     where id = i_id  
    ;  
    if i_status = 1 then  
      update palete  
         set validade = v_validade,  
             status = 2  
       where id = v_palete_id  
      ;  
    elsif i_status = -1 then  
      update palete  
         set conf_qtd = null,  
             conf_end = null,  
             validade = null,  
             status = 1  
       where id = v_palete_id  
      ;  
    else  
      raise_application_error(-20009,'Erro interno. Entre em contato com o TI.');  
    end if;  
    commit;  
  end p_finalizar_solicitacao;  
--------------------------------------------------------------------------------  
  procedure p_solicitar_validade(  
    i_palete_id in number,  
    i_validade in date,  
    i_conf_qtd in number  
  ) as  
    v_exists number;  
  begin  
    select count(*)  
      into v_exists  
      from PALETE_VALIDADE  
     where palete_id = i_palete_id  
       and validade = i_validade;  
      
    if v_exists = 0 then  
      insert into PALETE_VALIDADE(  
        palete_id,  
        validade,  
        status,  
        conf_qtd  
      ) values (  
        i_palete_id,  
        i_validade,  
        0,  
        i_conf_qtd  
      );  
      update palete  
         set conf_qtd = i_conf_qtd,  
             conf_end = sysdate  
       where id = i_palete_id  
      ;  
    else  
      raise_application_error(-20008,'Ja foi realizada uma solicitao para esta data.');  
    end if;  
  end p_solicitar_validade;  
--------------------------------------------------------------------------------  
  function f_check_validade_recebimento(  
    i_produto_id in number,  
    i_validade in date  
  ) return boolean as  
    v_dias_parametro number;  
    v_sysdate date := trunc(sysdate);  
    v_shelflife number;  
  begin  
    select DIAS_VALIDADE  
      into v_shelflife  
      from PRODUTO  
     where ID = i_produto_id;  
    v_dias_parametro := f_get_validade_parametro(i_produto_id, 'R');  
    if v_sysdate - v_dias_parametro < i_validade - v_shelflife then  
      return true;  
    else  
      return false;  
    end if;  
  end f_check_validade_recebimento;  
--------------------------------------------------------------------------------  
  function f_get_validade_parametro(  
    i_produto_id in number,  
    i_tipo in varchar2  
  ) return number as  
    v_produto_exists number;  
    v_fornecedor_id number;  
    v_fornecedor_exists number;  
    v_dias number;  
  begin  
    select count(*)  
      into v_produto_exists  
      from REGRA_VALIDADE A  
     where PRODUTO_ID = i_produto_id  
       and (VALOR_RECEBIMENTO is not null and i_tipo = 'R')  
        or (VALOR_EXPEDICAO is not null and i_tipo = 'E');  
      
    if v_produto_exists = 1 then  
      select case  
               when B.VALOR_RECEBIMENTO < 1 and i_tipo = 'R'  
                 then (1-B.VALOR_RECEBIMENTO) * A.DIAS_VALIDADE  
               when B.VALOR_RECEBIMENTO >= 1 and i_tipo = 'R'  
                 then A.DIAS_VALIDADE - B.VALOR_RECEBIMENTO  
             end  
        into v_dias  
        from PRODUTO A  
       inner join REGRA_VALIDADE B  
          on A.ID = B.PRODUTO_ID  
       where A.ID = i_produto_id;  
      return v_dias;  
    end if;  
      
    select count(*)  
      into v_fornecedor_exists  
      from REGRA_VALIDADE A  
     where FORNECEDOR_ID = F_FORNECEDOR_AGG(i_produto_id)  
       and (VALOR_RECEBIMENTO is not null and i_tipo = 'R')  
        or (VALOR_EXPEDICAO is not null and i_tipo = 'E');  
      
    if v_fornecedor_exists = 1 then  
      select case  
               when B.VALOR_RECEBIMENTO < 1 and i_tipo = 'R'  
                 then (1-B.VALOR_RECEBIMENTO) * A.DIAS_VALIDADE  
               when B.VALOR_RECEBIMENTO >= 1 and i_tipo = 'R'  
                 then A.DIAS_VALIDADE - B.VALOR_RECEBIMENTO  
             end  
        into v_dias  
        from PRODUTO A  
       inner join REGRA_VALIDADE B  
          on F_FORNECEDOR_AGG(A.ID) = B.FORNECEDOR_ID  
       where A.ID = i_produto_id;  
      return v_dias;  
    end if;   
    select case  
             when B.VALOR_RECEBIMENTO < 1 and i_tipo = 'R'  
               then (1-B.VALOR_RECEBIMENTO) * A.DIAS_VALIDADE  
             when B.VALOR_RECEBIMENTO >= 1 and i_tipo = 'R'  
               then A.DIAS_VALIDADE - B.VALOR_RECEBIMENTO  
           end  
      into v_dias  
      from PRODUTO A  
     inner join REGRA_VALIDADE B  
        on B.EMPRESA_ID is not null  
     where A.ID = i_produto_id;  
    return v_dias;  
  end f_get_validade_parametro;  
--------------------------------------------------------------------------------  
  procedure p_check_codigo_barras(  
    i_palete_id in number,  
    i_codigo_barras in varchar2  
  ) as  
    v_exists number;  
  begin  
    select count(distinct b.produto_id)  
      into v_exists  
      from embalagem_codigo a  
     inner join produto_embalagem b  
        on a.embalagem_id = b.id  
     inner join produto c  
        on b.produto_id = c.id  
     where a.codigo =  i_codigo_barras;  
      
    if v_exists = 0 then  
      raise_application_error(-20005,'Codigoo de barras nao esta cadastrado no sistema.');  
    elsif v_exists > 1 then  
      raise_application_error(-20006,'Duplicidade de codigoo de barras. Entre em contato com o cadastro.');  
    end if;  
    select count(*)  
      into v_exists  
      from PRODUTO_EMBALAGEM A  
     inner join EMBALAGEM_CODIGO B  
        on B.EMBALAGEM_ID = A.ID  
     inner join PALETE C  
        on C.EMBALAGEM_ID = A.ID  
     inner join PRODUTO D  
        on D.ID = A.PRODUTO_ID  
     inner join PRODUTO_ESPECIE E  
        on E.EMBALAGEM_ID = A.ID  
     where E.ESPECIE_ID = 5  
       and B.CODIGO = i_codigo_barras  
       and C.ID = i_palete_id;  
    if v_exists = 0 then  
      raise_application_error(-20007,'Codigoo de barras invalido para este palete.');  
    end if;  
  end p_check_codigo_barras;  
--------------------------------------------------------------------------------  
  procedure p_set_conf_palete(  
    i_conf_id IN NUMBER,  
    i_palete_id IN NUMBER  
  ) as  
  begin  
    update PALETE  
       set CONF_ID = i_conf_id,  
           CONF_START = sysdate,  
           STATUS = 1  
     where ID = i_palete_id;  
  end p_set_conf_palete;  
--------------------------------------------------------------------------------  
  procedure p_check_palete(  
    i_palete_id in number,  
    i_user in varchar2  
  ) as  
    v_status number;  
    v_conf_id number;  
    v_solicitacao number;  
  begin  
    select a.status, a.conf_id, b.status  
      into v_status, v_conf_id, v_solicitacao  
      from palete a  
      left join palete_validade b  
        on a.id = b.palete_id  
       and b.status in (0)  
     where a.id = i_palete_id  
    ;  
    if v_status = 0 then  
      p_set_conf_palete(  
        i_user,  
        i_palete_id  
      );  
    elsif v_status = 1 and v_conf_id != i_user then  
      --Palete sendo conferido por outro conferente  
      raise_application_error(-20001,'Palete sendo conferido pelo conferente'||v_conf_id||'.');  
    elsif v_status = 1 and v_conf_id = i_user and v_solicitacao = 0 then  
      --Palete em processo de solicita¿ de valida¿  
      raise_application_error(-20002,'Aguardando aprovacao da validade fora do prazo.');  
    elsif v_status = 2 then  
      --Processo de conferencia deste palete esta finalizada 
      --Verificar se a movimentacao ja foi finalizada 
       
      raise_application_error(-20003,'Conferencia do palete finalizada.');  
    end if;  
    exception  
      when no_data_found then  
        raise_application_error(-20004,'Palete nao existe.');  
  end p_check_palete;  
--------------------------------------------------------------------------------  
end;  
----------------------------  
/