CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."MOVIMENTACAO_VISUAL_AUD" 
    after update or delete on movimentacao_visual 
    for each row 
declare 
    t varchar2(128) := 'MOVIMENTACAO_VISUAL'; 
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
    if (:old.origem_id is null and :new.origem_id is not null) or  
        (:old.origem_id is not null and :new.origem_id is null) or  
        :old.origem_id != :new.origem_id then  
        insert into history ( 
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number 
        ) values ( 
            history_seq.nextval, t, 'ORIGEM_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.origem_id, :new.origem_id); 
 
    end if; 
    if (:old.destino_id is null and :new.destino_id is not null) or  
        (:old.destino_id is not null and :new.destino_id is null) or  
        :old.destino_id != :new.destino_id then  
        insert into history ( 
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number 
        ) values ( 
            history_seq.nextval, t, 'DESTINO_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.destino_id, :new.destino_id); 
 
    end if; 
    if (:old.qtd is null and :new.qtd is not null) or  
        (:old.qtd is not null and :new.qtd is null) or  
        :old.qtd != :new.qtd then  
        insert into history ( 
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number 
        ) values ( 
            history_seq.nextval, t, 'QTD', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.qtd, :new.qtd); 
 
    end if; 
    if (:old.embalagem_id is null and :new.embalagem_id is not null) or  
        (:old.embalagem_id is not null and :new.embalagem_id is null) or  
        :old.embalagem_id != :new.embalagem_id then  
        insert into history ( 
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number 
        ) values ( 
            history_seq.nextval, t, 'EMBALAGEM_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.embalagem_id, :new.embalagem_id); 
 
    end if; 
    if (:old.tipo is null and :new.tipo is not null) or  
        (:old.tipo is not null and :new.tipo is null) or  
        :old.tipo != :new.tipo then  
        insert into history ( 
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc 
        ) values ( 
            history_seq.nextval, t, 'TIPO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.tipo, :new.tipo); 
 
    end if; 
    if (:old.palete_id is null and :new.palete_id is not null) or  
        (:old.palete_id is not null and :new.palete_id is null) or  
        :old.palete_id != :new.palete_id then  
        insert into history ( 
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number 
        ) values ( 
            history_seq.nextval, t, 'PALETE_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.palete_id, :new.palete_id); 
 
    end if; 
    if (:old.movimentacao_id is null and :new.movimentacao_id is not null) or  
        (:old.movimentacao_id is not null and :new.movimentacao_id is null) or  
        :old.movimentacao_id != :new.movimentacao_id then  
        insert into history ( 
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number 
        ) values ( 
            history_seq.nextval, t, 'MOVIMENTACAO_ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.movimentacao_id, :new.movimentacao_id); 
 
    end if; 
elsif deleting then 
    insert into history ( 
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number 
    ) values ( 
        history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id); 
    insert into history ( 
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number 
    ) values ( 
        history_seq.nextval, t, 'ORIGEM_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.origem_id, :new.origem_id); 
    insert into history ( 
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number 
    ) values ( 
        history_seq.nextval, t, 'DESTINO_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.destino_id, :new.destino_id); 
    insert into history ( 
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number 
    ) values ( 
        history_seq.nextval, t, 'QTD', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.qtd, :new.qtd); 
    insert into history ( 
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number 
    ) values ( 
        history_seq.nextval, t, 'EMBALAGEM_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.embalagem_id, :new.embalagem_id); 
    insert into history ( 
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc 
    ) values ( 
        history_seq.nextval, t, 'TIPO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.tipo, :new.tipo); 
    insert into history ( 
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number 
    ) values ( 
        history_seq.nextval, t, 'PALETE_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.palete_id, :new.palete_id); 
    insert into history ( 
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number 
    ) values ( 
        history_seq.nextval, t, 'MOVIMENTACAO_ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.movimentacao_id, :new.movimentacao_id); 
 
end if; 
end movimentacao_visual_aud; 

/
ALTER TRIGGER "WMS"."MOVIMENTACAO_VISUAL_AUD" DISABLE;