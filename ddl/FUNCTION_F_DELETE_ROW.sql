CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_DELETE_ROW" (  
    i_id in number,  
    i_ajax_callback in varchar2,  
    i_form_prefix in varchar2,  
    i_region_id in varchar2  
)  
return varchar2 is  
begin  
    return '<a class="cursor_pointer fa fa-trash-o" onclick="deleteRow('||  
           i_id||','''||i_ajax_callback||''','''||i_form_prefix||  
           ''','''||i_region_id||''')"></a>';  
end;  
/