CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_VERIFY_PTA" ( 
  i_carga IN NUMBER 
) return number is 
v_is_pta number; 
begin 
  select count(*) 
    into v_is_pta 
    from CONSINCO.MLO_CARGAEXPPROD 
   where NROCARGA = i_carga 
     and TIPESPECIE = 'PTA'; 
 
  return v_is_pta; 
end; 
/