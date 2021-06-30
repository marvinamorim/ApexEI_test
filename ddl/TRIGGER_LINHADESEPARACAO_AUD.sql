CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."LINHADESEPARACAO_AUD" 
    after update or delete on linhadeseparacao  
    for each row  
declare  
    t varchar2(128) := 'LINHADESEPARACAO';  
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
    if (:old.nome is null and :new.nome is not null) or   
        (:old.nome is not null and :new.nome is null) or   
        :old.nome != :new.nome then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
            history_seq.nextval, t, 'NOME', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.nome, :new.nome);  
  
    end if;  
    if (:old.atacadovarejo is null and :new.atacadovarejo is not null) or   
        (:old.atacadovarejo is not null and :new.atacadovarejo is null) or   
        :old.atacadovarejo != :new.atacadovarejo then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
            history_seq.nextval, t, 'ATACADOVAREJO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.atacadovarejo, :new.atacadovarejo);  
  
    end if;  
    if (:old.tiposepar is null and :new.tiposepar is not null) or   
        (:old.tiposepar is not null and :new.tiposepar is null) or   
        :old.tiposepar != :new.tiposepar then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
            history_seq.nextval, t, 'TIPOSEPAR', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.tiposepar, :new.tiposepar);  
  
    end if;  
    if (:old.status is null and :new.status is not null) or   
        (:old.status is not null and :new.status is null) or   
        :old.status != :new.status then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'STATUS', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.status, :new.status);  
  
    end if;  
    if (:old.pesomax is null and :new.pesomax is not null) or   
        (:old.pesomax is not null and :new.pesomax is null) or   
        :old.pesomax != :new.pesomax then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'PESOMAX', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.pesomax, :new.pesomax);  
  
    end if;  
    if (:old.volumemax is null and :new.volumemax is not null) or   
        (:old.volumemax is not null and :new.volumemax is null) or   
        :old.volumemax != :new.volumemax then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'VOLUMEMAX', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.volumemax, :new.volumemax);  
  
    end if;  
    if (:old.maxatv_abast is null and :new.maxatv_abast is not null) or   
        (:old.maxatv_abast is not null and :new.maxatv_abast is null) or   
        :old.maxatv_abast != :new.maxatv_abast then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'MAXATV_ABAST', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.maxatv_abast, :new.maxatv_abast);  
  
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
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        history_seq.nextval, t, 'NOME', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.nome, :new.nome);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        history_seq.nextval, t, 'ATACADOVAREJO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.atacadovarejo, :new.atacadovarejo);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        history_seq.nextval, t, 'TIPOSEPAR', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.tiposepar, :new.tiposepar);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'STATUS', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.status, :new.status);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'PESOMAX', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.pesomax, :new.pesomax);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'VOLUMEMAX', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.volumemax, :new.volumemax);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'MAXATV_ABAST', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.maxatv_abast, :new.maxatv_abast);  
  
end if;  
end linhadeseparacao_aud;  
 

/
ALTER TRIGGER "WMS"."LINHADESEPARACAO_AUD" DISABLE;