CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."ERRO_SEPARACAO_AUD" 
    after update or delete on erro_separacao  
    for each row  
declare  
    t varchar2(128) := 'ERRO_SEPARACAO';  
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
    if (:old.atividade_id is null and :new.atividade_id is not null) or   
        (:old.atividade_id is not null and :new.atividade_id is null) or   
        :old.atividade_id != :new.atividade_id then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'ATIVIDADE_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.atividade_id, :new.atividade_id);  
  
    end if;  
    if (:old.qtd_erro is null and :new.qtd_erro is not null) or   
        (:old.qtd_erro is not null and :new.qtd_erro is null) or   
        :old.qtd_erro != :new.qtd_erro then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'QTD_ERRO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.qtd_erro, :new.qtd_erro);  
  
    end if;  
elsif deleting then  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'ATIVIDADE_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.atividade_id, :new.atividade_id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'QTD_ERRO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.qtd_erro, :new.qtd_erro);  
  
end if;  
end erro_separacao_aud;  
 

/
ALTER TRIGGER "WMS"."ERRO_SEPARACAO_AUD" DISABLE;