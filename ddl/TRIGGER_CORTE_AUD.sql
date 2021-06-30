CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."CORTE_AUD" 
    after update or delete on corte  
    for each row  
declare  
    t varchar2(128) := 'CORTE';  
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
    if (:old.carga_id is null and :new.carga_id is not null) or   
        (:old.carga_id is not null and :new.carga_id is null) or   
        :old.carga_id != :new.carga_id then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'CARGA_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.carga_id, :new.carga_id);  
  
    end if;  
    if (:old.lote is null and :new.lote is not null) or   
        (:old.lote is not null and :new.lote is null) or   
        :old.lote != :new.lote then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'LOTE', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.lote, :new.lote);  
  
    end if;  
    if (:old.produto_id is null and :new.produto_id is not null) or   
        (:old.produto_id is not null and :new.produto_id is null) or   
        :old.produto_id != :new.produto_id then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'PRODUTO_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.produto_id, :new.produto_id);  
  
    end if;  
    if (:old.conf_id is null and :new.conf_id is not null) or   
        (:old.conf_id is not null and :new.conf_id is null) or   
        :old.conf_id != :new.conf_id then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'CONF_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.conf_id, :new.conf_id);  
  
    end if;  
    if (:old.conf_qtd is null and :new.conf_qtd is not null) or   
        (:old.conf_qtd is not null and :new.conf_qtd is null) or   
        :old.conf_qtd != :new.conf_qtd then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
            history_seq.nextval, t, 'CONF_QTD', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.conf_qtd, :new.conf_qtd);  
  
    end if;  
    if (:old.qtd_pedido is null and :new.qtd_pedido is not null) or   
        (:old.qtd_pedido is not null and :new.qtd_pedido is null) or   
        :old.qtd_pedido != :new.qtd_pedido then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
            history_seq.nextval, t, 'QTD_PEDIDO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.qtd_pedido, :new.qtd_pedido);  
  
    end if;  
    if (:old.done is null and :new.done is not null) or   
        (:old.done is not null and :new.done is null) or   
        :old.done != :new.done then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'DONE', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.done, :new.done);  
  
    end if;  
elsif deleting then  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'CARGA_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.carga_id, :new.carga_id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'LOTE', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.lote, :new.lote);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'PRODUTO_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.produto_id, :new.produto_id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'CONF_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.conf_id, :new.conf_id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        history_seq.nextval, t, 'CONF_QTD', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.conf_qtd, :new.conf_qtd);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        history_seq.nextval, t, 'QTD_PEDIDO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.qtd_pedido, :new.qtd_pedido);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'DONE', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.done, :new.done);  
  
end if;  
end corte_aud;  
 

/
ALTER TRIGGER "WMS"."CORTE_AUD" DISABLE;