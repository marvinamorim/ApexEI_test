CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_STATUS_DESC" (i_status in number)  
return varchar2 is  
    v_return varchar2(10);  
begin  
  select decode(i_status,0,'Inativo',1,'Ativo')  
    into v_return  
    from dual;  
  return v_return;  
end;  
----------------------------  
/