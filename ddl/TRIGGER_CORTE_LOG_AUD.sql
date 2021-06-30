CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."CORTE_LOG_AUD" 
    after update or delete on corte_log  
    for each row  
declare  
    t varchar2(128) := 'CORTE_LOG';  
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
    if (:old.corte_id is null and :new.corte_id is not null) or   
        (:old.corte_id is not null and :new.corte_id is null) or   
        :old.corte_id != :new.corte_id then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'CORTE_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.corte_id, :new.corte_id);  
  
    end if;  
    if (:old.pessoa_id is null and :new.pessoa_id is not null) or   
        (:old.pessoa_id is not null and :new.pessoa_id is null) or   
        :old.pessoa_id != :new.pessoa_id then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'PESSOA_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.pessoa_id, :new.pessoa_id);  
  
    end if;  
    if (:old.qtd_emb is null and :new.qtd_emb is not null) or   
        (:old.qtd_emb is not null and :new.qtd_emb is null) or   
        :old.qtd_emb != :new.qtd_emb then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'QTD_EMB', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.qtd_emb, :new.qtd_emb);  
  
    end if;  
    if (:old.qtd_pedido is null and :new.qtd_pedido is not null) or   
        (:old.qtd_pedido is not null and :new.qtd_pedido is null) or   
        :old.qtd_pedido != :new.qtd_pedido then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'QTD_PEDIDO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.qtd_pedido, :new.qtd_pedido);  
  
    end if;  
    if (:old.qtd_digitado is null and :new.qtd_digitado is not null) or   
        (:old.qtd_digitado is not null and :new.qtd_digitado is null) or   
        :old.qtd_digitado != :new.qtd_digitado then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'QTD_DIGITADO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.qtd_digitado, :new.qtd_digitado);  
  
    end if;  
elsif deleting then  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'CORTE_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.corte_id, :new.corte_id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'PESSOA_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.pessoa_id, :new.pessoa_id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'QTD_EMB', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.qtd_emb, :new.qtd_emb);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'QTD_PEDIDO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.qtd_pedido, :new.qtd_pedido);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'QTD_DIGITADO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.qtd_digitado, :new.qtd_digitado);  
  
end if;  
end corte_log_aud; 
 

/
ALTER TRIGGER "WMS"."CORTE_LOG_AUD" DISABLE;