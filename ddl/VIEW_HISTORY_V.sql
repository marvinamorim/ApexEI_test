CREATE OR REPLACE FORCE EDITIONABLE VIEW "WMS"."HISTORY_V" ("ID", "TABLE_NAME", "COLUMN_NAME", "ACTION", "ACTION_DATE", "ACTION_BY", "TABLE_PRIMARY_KEY", "TABLE_ROW_VERSION", "CHANGE") AS 
  select id,  
       table_name,  
       column_name,  
       decode(action,'U','Update','D','Delete') action,  
       action_date,  
       action_by,  
       pk1 table_primary_key,  
       tab_row_version table_row_version,  
       decode(data_type,  
         'NUMBER',old_number||' > '||new_number,  
         'VARCHAR2',substr(old_vc,1,50)||' > '||substr(new_vc,1,50),  
         'DATE',to_char(old_date,'YYYYMMDD HH24:MI:SS')||' > '||to_char(new_date,'YYYYMMDD HH24:MI:SS'),  
         'TIMESTAMP',to_char(old_ts,'YYYYMMDD HH24:MI:SS')||' > '||to_char(new_ts,'YYYYMMDD HH24:MI:SS'),  
         'TIMESTAMP WITH TIMEZONE',to_char(old_tswtz,'YYYYMMDD HH24:MI:SS')||' > '||to_char(new_tswtz,'YYYYMMDD HH24:MI:SS'),  
         'TIMESTAMP WITH LOCAL TIMEZONE',to_char(old_tswltz,'YYYYMMDD HH24:MI:SS')||' > '||to_char(new_tswltz,'YYYYMMDD HH24:MI:SS'),  
         'BLOB','length '||sys.dbms_lob.getlength(old_blob)||' > '||' length '||sys.dbms_lob.getlength(new_blob),  
         'CLOB',sys.dbms_lob.substr(old_vc,50,1)||' > '||sys.dbms_lob.substr(new_vc,50,1)  
         ) change  
from history  
;