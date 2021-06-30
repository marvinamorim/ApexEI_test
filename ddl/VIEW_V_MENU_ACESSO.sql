CREATE OR REPLACE FORCE EDITIONABLE VIEW "WMS"."V_MENU_ACESSO" ("LABEL_VALUE", "TARGET_VALUE", "IS_CURRENT", "IMAGE_VALUE", "IMAGE_ATTR_VALUE", "IMAGE_ALT_VALUE", "LIST_ENTRY_ID", "LIST_ENTRY_PARENT_ID", "PARENT_SEQUENCE", "DISPLAY_SEQUENCE") AS 
  select ENTRY_TEXT as label_value   
      , ENTRY_TARGET as target_value  
      , null is_current   
      , ENTRY_IMAGE as image_value   
      , null as image_attr_value   
      , null as image_alt_value   
      , A.LIST_ENTRY_ID  
      , A.LIST_ENTRY_PARENT_ID  
      , case  
          when LIST_ENTRY_PARENT_ID is null then  
            A.DISPLAY_SEQUENCE  
          else  
            (select A1.DISPLAY_SEQUENCE  
               from apex_application_list_entries A1  
              where A1.LIST_ENTRY_ID = A.LIST_ENTRY_PARENT_ID)  
        end as PARENT_SEQUENCE,  
        A.DISPLAY_SEQUENCE  
from apex_application_list_entries A  
inner join GRUPO_PERMISSAO B  
  on A.LIST_ENTRY_ID = B.LIST_ENTRY_ID  
inner join USUARIO C  
  on upper(C.LOGIN) = upper(v('APP_USER'))  
  and C.GRUPO_ID = B.GRUPO_ACESSO_ID  
where application_id = 101  
  and LIST_ID = 19812088044429116  
order by DISPLAY_SEQUENCE  
----------------------------  
;