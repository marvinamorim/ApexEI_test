CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_PRINT_ZPL_ELMA" ( 
  i_carga   IN NUMBER, 
  i_printer IN VARCHAR2 
) as 
  c utl_tcp.connection; 
  ret_val pls_integer; 
  str varchar2(4000); 
begin 
  c := utl_tcp.open_connection(remote_host => i_printer, 
                           remote_port => '9100', 
                           charset     => 'US7ASCII'); 
  for c1 in ( 
    select F_GET_ZPL(A.CARGA_ID, A.LOTE) zpl from lote A 
     where A.CARGA_ID = i_carga 
       and A.LS in ('CA','FR','ME') 
     order by A.LS, A.LOTE 
  ) loop 
    str := '^XA' || c1.zpl || '^XZ'; 
    ret_val := utl_tcp.WRITE_TEXT(c, str); 
  end loop; 
  utl_tcp.close_connection(c); 
end; 
/