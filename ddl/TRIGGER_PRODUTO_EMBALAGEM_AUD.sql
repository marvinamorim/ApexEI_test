CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."PRODUTO_EMBALAGEM_AUD" 
    after update or delete on produto_embalagem  
    for each row  
declare  
    t varchar2(128) := 'PRODUTO_EMBALAGEM';  
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
begin  
if updating then  
    if (:old.id is null and :new.id is not null) or   
        (:old.id is not null and :new.id is null) or   
        :old.id != :new.id then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);  
  
    end if;  
    if (:old.ls is null and :new.ls is not null) or   
        (:old.ls is not null and :new.ls is null) or   
        :old.ls != :new.ls then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
            history_seq.nextval, t, 'LS', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.ls, :new.ls);  
  
    end if;  
    if (:old.produto_id is null and :new.produto_id is not null) or   
        (:old.produto_id is not null and :new.produto_id is null) or   
        :old.produto_id != :new.produto_id then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'PRODUTO_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.produto_id, :new.produto_id);  
  
    end if;  
    if (:old.emb is null and :new.emb is not null) or   
        (:old.emb is not null and :new.emb is null) or   
        :old.emb != :new.emb then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
            history_seq.nextval, t, 'EMB', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.emb, :new.emb);  
  
    end if;  
    if (:old.qtd_emb is null and :new.qtd_emb is not null) or   
        (:old.qtd_emb is not null and :new.qtd_emb is null) or   
        :old.qtd_emb != :new.qtd_emb then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'QTD_EMB', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.qtd_emb, :new.qtd_emb);  
  
    end if;  
    if (:old.peso_bruto is null and :new.peso_bruto is not null) or   
        (:old.peso_bruto is not null and :new.peso_bruto is null) or   
        :old.peso_bruto != :new.peso_bruto then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'PESO_BRUTO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.peso_bruto, :new.peso_bruto);  
  
    end if;  
    if (:old.peso_liquido is null and :new.peso_liquido is not null) or   
        (:old.peso_liquido is not null and :new.peso_liquido is null) or   
        :old.peso_liquido != :new.peso_liquido then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'PESO_LIQUIDO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.peso_liquido, :new.peso_liquido);  
  
    end if;  
    if (:old.altura is null and :new.altura is not null) or   
        (:old.altura is not null and :new.altura is null) or   
        :old.altura != :new.altura then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'ALTURA', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.altura, :new.altura);  
  
    end if;  
    if (:old.largura is null and :new.largura is not null) or   
        (:old.largura is not null and :new.largura is null) or   
        :old.largura != :new.largura then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'LARGURA', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.largura, :new.largura);  
  
    end if;  
    if (:old.profundidade is null and :new.profundidade is not null) or   
        (:old.profundidade is not null and :new.profundidade is null) or   
        :old.profundidade != :new.profundidade then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'PROFUNDIDADE', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.profundidade, :new.profundidade);  
  
    end if;  
elsif deleting then  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        history_seq.nextval, t, 'LS', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.ls, :new.ls);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'PRODUTO_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.produto_id, :new.produto_id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        history_seq.nextval, t, 'EMB', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.emb, :new.emb);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'QTD_EMB', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.qtd_emb, :new.qtd_emb);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'PESO_BRUTO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.peso_bruto, :new.peso_bruto);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'PESO_LIQUIDO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.peso_liquido, :new.peso_liquido);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'ALTURA', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.altura, :new.altura);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'LARGURA', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.largura, :new.largura);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'PROFUNDIDADE', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.profundidade, :new.profundidade);  
  
end if;  
end produto_embalagem_aud;  
 

/
ALTER TRIGGER "WMS"."PRODUTO_EMBALAGEM_AUD" DISABLE;