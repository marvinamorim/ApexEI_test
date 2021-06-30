CREATE OR REPLACE FORCE EDITIONABLE VIEW "WMS"."HISTORY_V_CUSTOM" ("ID", "TABLE_NAME", "COLUMN_NAME", "ACTION", "ACTION_DATE", "ACTION_BY", "PK1", "OLD_VALUE", "NEW_VALUE") AS 
  select id,  
       table_name,  
       column_name,  
       action, 
       action_date,  
       action_by,  
       pk1,  
       decode(data_type,  
         'NUMBER',to_char(old_number),  
         'VARCHAR2',substr(old_vc,1,50),  
         'DATE',to_char(old_date,'HH24:MI:SS DD/MM/YYYY'),  
         'TIMESTAMP',to_char(old_ts,'HH24:MI:SS DD/MM/YYYY'),  
         'TIMESTAMP WITH TIMEZONE',to_char(old_tswtz,'HH24:MI:SS DD/MM/YYYY'),  
         'TIMESTAMP WITH LOCAL TIMEZONE',to_char(old_tswltz,'HH24:MI:SS DD/MM/YYYY'),  
         'BLOB','length '||sys.dbms_lob.getlength(old_blob),  
         'CLOB',sys.dbms_lob.substr(old_vc,50,1) 
         ) old_value, 
       decode(data_type,  
         'NUMBER',to_char(new_number),  
         'VARCHAR2',substr(new_vc,1,50),  
         'DATE',to_char(new_date,'HH24:MI:SS DD/MM/YYYY'),  
         'TIMESTAMP',to_char(new_ts,'HH24:MI:SS DD/MM/YYYY'),  
         'TIMESTAMP WITH TIMEZONE',to_char(new_tswtz,'HH24:MI:SS DD/MM/YYYY'),  
         'TIMESTAMP WITH LOCAL TIMEZONE',to_char(new_tswltz,'HH24:MI:SS DD/MM/YYYY'),  
         'BLOB','length '||sys.dbms_lob.getlength(new_blob),  
         'CLOB',sys.dbms_lob.substr(new_vc,50,1)  
         ) new_value 
from wms.history 
;