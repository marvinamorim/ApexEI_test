CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."PRODUTIVO_AUD" 
    after update or delete on produtivo  
    for each row  
declare  
    t varchar2(128) := 'PRODUTIVO';  
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
    if (:old.nome is null and :new.nome is not null) or   
        (:old.nome is not null and :new.nome is null) or   
        :old.nome != :new.nome then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
            history_seq.nextval, t, 'NOME', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.nome, :new.nome);  
  
    end if;  
    if (:old.apelido is null and :new.apelido is not null) or   
        (:old.apelido is not null and :new.apelido is null) or   
        :old.apelido != :new.apelido then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
            history_seq.nextval, t, 'APELIDO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.apelido, :new.apelido);  
  
    end if;  
    if (:old.nome_api_msg is null and :new.nome_api_msg is not null) or   
        (:old.nome_api_msg is not null and :new.nome_api_msg is null) or   
        :old.nome_api_msg != :new.nome_api_msg then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
            history_seq.nextval, t, 'NOME_API_MSG', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.nome_api_msg, :new.nome_api_msg);  
  
    end if;  
    if (:old.atividade is null and :new.atividade is not null) or   
        (:old.atividade is not null and :new.atividade is null) or   
        :old.atividade != :new.atividade then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
            history_seq.nextval, t, 'ATIVIDADE', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.atividade, :new.atividade);  
  
    end if;  
    if (:old.funcao is null and :new.funcao is not null) or   
        (:old.funcao is not null and :new.funcao is null) or   
        :old.funcao != :new.funcao then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
            history_seq.nextval, t, 'FUNCAO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.funcao, :new.funcao);  
  
    end if;  
    if (:old.padrao is null and :new.padrao is not null) or   
        (:old.padrao is not null and :new.padrao is null) or   
        :old.padrao != :new.padrao then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'PADRAO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.padrao, :new.padrao);  
  
    end if;  
    if (:old.exclusivo is null and :new.exclusivo is not null) or   
        (:old.exclusivo is not null and :new.exclusivo is null) or   
        :old.exclusivo != :new.exclusivo then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'EXCLUSIVO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.exclusivo, :new.exclusivo);  
  
    end if;  
    if (:old.order_atv is null and :new.order_atv is not null) or   
        (:old.order_atv is not null and :new.order_atv is null) or   
        :old.order_atv != :new.order_atv then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
            history_seq.nextval, t, 'ORDER_ATV', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.order_atv, :new.order_atv);  
  
    end if;  
    if (:old.empnivel is null and :new.empnivel is not null) or   
        (:old.empnivel is not null and :new.empnivel is null) or   
        :old.empnivel != :new.empnivel then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'EMPNIVEL', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.empnivel, :new.empnivel);  
  
    end if;  
    if (:old.emptipo is null and :new.emptipo is not null) or   
        (:old.emptipo is not null and :new.emptipo is null) or   
        :old.emptipo != :new.emptipo then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'EMPTIPO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.emptipo, :new.emptipo);  
  
    end if;  
    if (:old.estacao is null and :new.estacao is not null) or   
        (:old.estacao is not null and :new.estacao is null) or   
        :old.estacao != :new.estacao then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'ESTACAO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.estacao, :new.estacao);  
  
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
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        history_seq.nextval, t, 'NOME', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.nome, :new.nome);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        history_seq.nextval, t, 'APELIDO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.apelido, :new.apelido);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        history_seq.nextval, t, 'NOME_API_MSG', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.nome_api_msg, :new.nome_api_msg);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        history_seq.nextval, t, 'ATIVIDADE', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.atividade, :new.atividade);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        history_seq.nextval, t, 'FUNCAO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.funcao, :new.funcao);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'PADRAO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.padrao, :new.padrao);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'EXCLUSIVO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.exclusivo, :new.exclusivo);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        history_seq.nextval, t, 'ORDER_ATV', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.order_atv, :new.order_atv);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'EMPNIVEL', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.empnivel, :new.empnivel);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'EMPTIPO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.emptipo, :new.emptipo);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'ESTACAO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.estacao, :new.estacao);  
  
end if;  
end produtivo_aud;  
 

/
ALTER TRIGGER "WMS"."PRODUTIVO_AUD" DISABLE;