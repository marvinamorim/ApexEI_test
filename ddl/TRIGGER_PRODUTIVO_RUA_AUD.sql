CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."PRODUTIVO_RUA_AUD" 
    after update or delete on produtivo_rua  
    for each row  
declare  
    t varchar2(128) := 'PRODUTIVO_RUA';  
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
    if (:old.produtivo_id is null and :new.produtivo_id is not null) or   
        (:old.produtivo_id is not null and :new.produtivo_id is null) or   
        :old.produtivo_id != :new.produtivo_id then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'PRODUTIVO_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.produtivo_id, :new.produtivo_id);  
  
    end if;  
    if (:old.rua is null and :new.rua is not null) or   
        (:old.rua is not null and :new.rua is null) or   
        :old.rua != :new.rua then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
            history_seq.nextval, t, 'RUA', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.rua, :new.rua);  
  
    end if;  
elsif deleting then  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'PRODUTIVO_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.produtivo_id, :new.produtivo_id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        history_seq.nextval, t, 'RUA', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.rua, :new.rua);  
  
end if;  
end produtivo_rua_aud;  
 

/
ALTER TRIGGER "WMS"."PRODUTIVO_RUA_AUD" DISABLE;