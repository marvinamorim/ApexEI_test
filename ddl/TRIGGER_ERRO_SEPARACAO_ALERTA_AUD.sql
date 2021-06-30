CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."ERRO_SEPARACAO_ALERTA_AUD" 
    after update or delete on erro_separacao_alerta  
    for each row  
declare  
    t varchar2(128) := 'ERRO_SEPARACAO_ALERTA';  
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
    if (:old.erro_separacao_id is null and :new.erro_separacao_id is not null) or   
        (:old.erro_separacao_id is not null and :new.erro_separacao_id is null) or   
        :old.erro_separacao_id != :new.erro_separacao_id then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'ERRO_SEPARACAO_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.erro_separacao_id, :new.erro_separacao_id);  
  
    end if;  
    if (:old.box_id is null and :new.box_id is not null) or   
        (:old.box_id is not null and :new.box_id is null) or   
        :old.box_id != :new.box_id then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'BOX_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.box_id, :new.box_id);  
  
    end if;  
    if (:old.local is null and :new.local is not null) or   
        (:old.local is not null and :new.local is null) or   
        :old.local != :new.local then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
            history_seq.nextval, t, 'LOCAL', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.local, :new.local);  
  
    end if;  
    if (:old.done_publico is null and :new.done_publico is not null) or   
        (:old.done_publico is not null and :new.done_publico is null) or   
        :old.done_publico != :new.done_publico then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'DONE_PUBLICO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.done_publico, :new.done_publico);  
  
    end if;  
    if (:old.done_privado is null and :new.done_privado is not null) or   
        (:old.done_privado is not null and :new.done_privado is null) or   
        :old.done_privado != :new.done_privado then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'DONE_PRIVADO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.done_privado, :new.done_privado);  
  
    end if;  
    if (:old.done_admin is null and :new.done_admin is not null) or   
        (:old.done_admin is not null and :new.done_admin is null) or   
        :old.done_admin != :new.done_admin then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'DONE_ADMIN', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.done_admin, :new.done_admin);  
  
    end if;  
elsif deleting then  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'ERRO_SEPARACAO_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.erro_separacao_id, :new.erro_separacao_id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'BOX_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.box_id, :new.box_id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        history_seq.nextval, t, 'LOCAL', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.local, :new.local);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'DONE_PUBLICO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.done_publico, :new.done_publico);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'DONE_PRIVADO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.done_privado, :new.done_privado);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'DONE_ADMIN', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.done_admin, :new.done_admin);  
  
end if;  
end erro_separacao_alerta_aud;  
 

/
ALTER TRIGGER "WMS"."ERRO_SEPARACAO_ALERTA_AUD" DISABLE;