CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."LOTE_AUD" 
    after update or delete on lote  
    for each row  
declare  
    t varchar2(128) := 'LOTE';  
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
    if (:old.pessoa_id is null and :new.pessoa_id is not null) or   
        (:old.pessoa_id is not null and :new.pessoa_id is null) or   
        :old.pessoa_id != :new.pessoa_id then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'PESSOA_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.pessoa_id, :new.pessoa_id);  
  
    end if;  
    if (:old.prioridade is null and :new.prioridade is not null) or   
        (:old.prioridade is not null and :new.prioridade is null) or   
        :old.prioridade != :new.prioridade then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'PRIORIDADE', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.prioridade, :new.prioridade);  
  
    end if;  
    if (:old.lote is null and :new.lote is not null) or   
        (:old.lote is not null and :new.lote is null) or   
        :old.lote != :new.lote then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'LOTE', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.lote, :new.lote);  
  
    end if;  
    if (:old.ls_id is null and :new.ls_id is not null) or   
        (:old.ls_id is not null and :new.ls_id is null) or   
        :old.ls_id != :new.ls_id then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'LS_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.ls_id, :new.ls_id);  
  
    end if;  
    if (:old.ls is null and :new.ls is not null) or   
        (:old.ls is not null and :new.ls is null) or   
        :old.ls != :new.ls then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
            history_seq.nextval, t, 'LS', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.ls, :new.ls);  
  
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
    if (:old.qtd_item is null and :new.qtd_item is not null) or   
        (:old.qtd_item is not null and :new.qtd_item is null) or   
        :old.qtd_item != :new.qtd_item then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'QTD_ITEM', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.qtd_item, :new.qtd_item);  
  
    end if;  
    if (:old.qtd_volume is null and :new.qtd_volume is not null) or   
        (:old.qtd_volume is not null and :new.qtd_volume is null) or   
        :old.qtd_volume != :new.qtd_volume then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'QTD_VOLUME', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.qtd_volume, :new.qtd_volume);  
  
    end if;  
    if (:old.status is null and :new.status is not null) or   
        (:old.status is not null and :new.status is null) or   
        :old.status != :new.status then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'STATUS', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.status, :new.status);  
  
    end if;  
    if (:old.sep_id is null and :new.sep_id is not null) or   
        (:old.sep_id is not null and :new.sep_id is null) or   
        :old.sep_id != :new.sep_id then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'SEP_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.sep_id, :new.sep_id);  
  
    end if;  
    if (:old.sep_start is null and :new.sep_start is not null) or   
        (:old.sep_start is not null and :new.sep_start is null) or   
        :old.sep_start != :new.sep_start then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_date, new_date  
        ) values (  
            history_seq.nextval, t, 'SEP_START', :old.id, null, 'U', sysdate, u, 'DATE', :old.sep_start, :new.sep_start);  
  
    end if;  
    if (:old.sep_end is null and :new.sep_end is not null) or   
        (:old.sep_end is not null and :new.sep_end is null) or   
        :old.sep_end != :new.sep_end then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_date, new_date  
        ) values (  
            history_seq.nextval, t, 'SEP_END', :old.id, null, 'U', sysdate, u, 'DATE', :old.sep_end, :new.sep_end);  
  
    end if;  
    if (:old.conf_id is null and :new.conf_id is not null) or   
        (:old.conf_id is not null and :new.conf_id is null) or   
        :old.conf_id != :new.conf_id then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
            history_seq.nextval, t, 'CONF_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.conf_id, :new.conf_id);  
  
    end if;  
    if (:old.conf_start is null and :new.conf_start is not null) or   
        (:old.conf_start is not null and :new.conf_start is null) or   
        :old.conf_start != :new.conf_start then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_date, new_date  
        ) values (  
            history_seq.nextval, t, 'CONF_START', :old.id, null, 'U', sysdate, u, 'DATE', :old.conf_start, :new.conf_start);  
  
    end if;  
    if (:old.conf_end is null and :new.conf_end is not null) or   
        (:old.conf_end is not null and :new.conf_end is null) or   
        :old.conf_end != :new.conf_end then   
        insert into history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_date, new_date  
        ) values (  
            history_seq.nextval, t, 'CONF_END', :old.id, null, 'U', sysdate, u, 'DATE', :old.conf_end, :new.conf_end);  
  
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
        history_seq.nextval, t, 'PESSOA_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.pessoa_id, :new.pessoa_id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'PRIORIDADE', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.prioridade, :new.prioridade);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'LOTE', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.lote, :new.lote);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'LS_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.ls_id, :new.ls_id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        history_seq.nextval, t, 'LS', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.ls, :new.ls);  
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
        history_seq.nextval, t, 'QTD_ITEM', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.qtd_item, :new.qtd_item);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'QTD_VOLUME', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.qtd_volume, :new.qtd_volume);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'STATUS', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.status, :new.status);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'SEP_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.sep_id, :new.sep_id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_date, new_date  
    ) values (  
        history_seq.nextval, t, 'SEP_START', :old.id, null, 'D', sysdate, u, 'DATE', :old.sep_start, :new.sep_start);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_date, new_date  
    ) values (  
        history_seq.nextval, t, 'SEP_END', :old.id, null, 'D', sysdate, u, 'DATE', :old.sep_end, :new.sep_end);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        history_seq.nextval, t, 'CONF_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.conf_id, :new.conf_id);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_date, new_date  
    ) values (  
        history_seq.nextval, t, 'CONF_START', :old.id, null, 'D', sysdate, u, 'DATE', :old.conf_start, :new.conf_start);  
    insert into history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_date, new_date  
    ) values (  
        history_seq.nextval, t, 'CONF_END', :old.id, null, 'D', sysdate, u, 'DATE', :old.conf_end, :new.conf_end);  
  
end if;  
end lote_aud;  
 

/
ALTER TRIGGER "WMS"."LOTE_AUD" DISABLE;