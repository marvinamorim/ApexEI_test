CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_JOIN" ( 
  i_table_name   varchar2, 
  i_column_name  varchar2, 
  i_separator    varchar2 default ';', 
  i_query_column varchar2 default null, 
  i_query_value  varchar2 default null 
) return varchar2 as 
  v_query_value varchar2(4000); 
  v_vc_arr2     apex_application_global.vc_arr2; 
  v_result      varchar2(32000); 
  v_statement   varchar2(4000); 
begin 
  v_statement := 'select ' || i_column_name || ' from ' || i_table_name; 
   
  if i_query_column is not null and i_query_value is not null then 
    begin 
      v_query_value := to_number(i_query_value); 
      exception when VALUE_ERROR then v_query_value := ''''||i_query_value||''''; 
    end; 
    v_statement := v_statement || 
                   ' where ' || i_query_column || ' = ' || v_query_value || 
                   ' order by 1'; 
  end if; 
  execute immediate v_statement bulk collect into v_vc_arr2; 
  v_result := apex_util.table_to_string (v_vc_arr2,';');  
  return v_result; 
end f_join; 
/