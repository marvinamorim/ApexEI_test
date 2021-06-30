CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."CARGA_IMPORT_AUD" 
    after update or delete on carga_import  
    for each row  
declare  
    t varchar2(128) := 'CARGA_IMPORT';  
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
    if (:old.status is null and :new.status is not null) or   
        (:old.status is not null and :new.status is null) or   
        :old.status != :new.status then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'STATUS', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.status, :new.status);  
  
    end if;  
    if (:old.prioridade is null and :new.prioridade is not null) or   
        (:old.prioridade is not null and :new.prioridade is null) or   
        :old.prioridade != :new.prioridade then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'PRIORIDADE', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.prioridade, :new.prioridade);  
  
    end if;  
    if (:old.lotes is null and :new.lotes is not null) or   
        (:old.lotes is not null and :new.lotes is null) or   
        :old.lotes != :new.lotes then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'LOTES', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.lotes, :new.lotes);  
  
    end if;  
    if (:old.peso is null and :new.peso is not null) or   
        (:old.peso is not null and :new.peso is null) or   
        :old.peso != :new.peso then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'PESO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.peso, :new.peso);  
  
    end if;  
    if (:old.volume is null and :new.volume is not null) or   
        (:old.volume is not null and :new.volume is null) or   
        :old.volume != :new.volume then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'VOLUME', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.volume, :new.volume);  
  
    end if;  
    if (:old.box_id is null and :new.box_id is not null) or   
        (:old.box_id is not null and :new.box_id is null) or   
        :old.box_id != :new.box_id then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'BOX_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.box_id, :new.box_id);  
  
    end if;  
    if (:old.destino is null and :new.destino is not null) or   
        (:old.destino is not null and :new.destino is null) or   
        :old.destino != :new.destino then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
            history_seq.nextval, t, 'DESTINO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.destino, :new.destino);  
  
    end if;  
elsif deleting then  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'STATUS', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.status, :new.status);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'PRIORIDADE', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.prioridade, :new.prioridade);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'LOTES', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.lotes, :new.lotes);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'PESO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.peso, :new.peso);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'VOLUME', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.volume, :new.volume);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'BOX_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.box_id, :new.box_id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        history_seq.nextval, t, 'DESTINO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.destino, :new.destino);  
  
end if;  
end carga_import_aud;  
 

/
ALTER TRIGGER "WMS"."CARGA_IMPORT_AUD" DISABLE;