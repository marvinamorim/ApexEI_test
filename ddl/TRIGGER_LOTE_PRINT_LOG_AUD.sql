CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."LOTE_PRINT_LOG_AUD" 
    after update or delete on lote_print_log  
    for each row  
declare  
    t varchar2(128) := 'LOTE_PRINT_LOG';  
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
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
            history_seq.nextval, t, 'LOTE', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.lote, :new.lote);  
  
    end if;  
    if (:old.sep_id is null and :new.sep_id is not null) or   
        (:old.sep_id is not null and :new.sep_id is null) or   
        :old.sep_id != :new.sep_id then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'SEP_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.sep_id, :new.sep_id);  
  
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
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        history_seq.nextval, t, 'LOTE', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.lote, :new.lote);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'SEP_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.sep_id, :new.sep_id);  
  
end if;  
end lote_print_log_aud;  
 

/
ALTER TRIGGER "WMS"."LOTE_PRINT_LOG_AUD" DISABLE;