CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_PRINT_ZPL_REC_CG" ( 
  i_carga   IN NUMBER, 
  i_user    IN NUMBER, 
  i_printer IN VARCHAR2, 
  i_id      IN NUMBER 
) as 
  c utl_tcp.connection; 
  ret_val pls_integer; 
  str varchar2(6000); 
begin 
c := utl_tcp.open_connection(remote_host => i_printer, 
                           remote_port => '9100', 
                           charset     => 'US7ASCII'); 
  for c1 in ( 
    select WMS.F_GET_ZPL_REC(A.CARGA_ID, A.ID) zpl from WMS.PALETE A 
     where A.CARGA_ID = i_carga 
     and nvl(i_id,0) = 0 or i_id = id 
  ) loop 
    str := '^XA' || c1.zpl || '^XZ'; 
    ret_val := utl_tcp.WRITE_TEXT(c, str); 
  end loop; 
  utl_tcp.close_connection(c); 
 
  --insert into LOTE_PRINT_LOG (CARGA_ID, LOTE, SEP_ID) 
  --values (i_carga, i_lote, i_user); 
end; 
 
 
/