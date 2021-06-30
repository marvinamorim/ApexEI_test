CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."IMPRESSORA_AUD" 
    after update or delete on impressora  
    for each row  
declare  
    t varchar2(128) := 'IMPRESSORA';  
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
    if (:old.nome is null and :new.nome is not null) or   
        (:old.nome is not null and :new.nome is null) or   
        :old.nome != :new.nome then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
            history_seq.nextval, t, 'NOME', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.nome, :new.nome);  
  
    end if;  
    if (:old.ip is null and :new.ip is not null) or   
        (:old.ip is not null and :new.ip is null) or   
        :old.ip != :new.ip then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
            history_seq.nextval, t, 'IP', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.ip, :new.ip);  
  
    end if;  
    if (:old.descricao is null and :new.descricao is not null) or   
        (:old.descricao is not null and :new.descricao is null) or   
        :old.descricao != :new.descricao then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
            history_seq.nextval, t, 'DESCRICAO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.descricao, :new.descricao);  
  
    end if;  
elsif deleting then  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        history_seq.nextval, t, 'NOME', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.nome, :new.nome);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        history_seq.nextval, t, 'IP', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.ip, :new.ip);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        history_seq.nextval, t, 'DESCRICAO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.descricao, :new.descricao);  
  
end if;  
end impressora_aud;  
 

/
ALTER TRIGGER "WMS"."IMPRESSORA_AUD" DISABLE;