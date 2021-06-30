CREATE OR REPLACE EDITIONABLE PROCEDURE "WMS"."P_PRINT_ZPL" ( 
  i_carga   IN NUMBER, 
  i_lote    IN NUMBER, 
  i_user    IN NUMBER, 
  i_printer IN VARCHAR2 
) as 
  c utl_tcp.connection; 
  ret_val pls_integer; 
  str varchar2(6000); 
begin 
  select F_GET_ZPL(i_carga, i_lote) 
    into str 
    from dual; 
  str := '^XA' || str || '^XZ'; 
  c := utl_tcp.open_connection(remote_host => i_printer, 
                               remote_port => '9100', 
                               charset     => 'US7ASCII'); 
  ret_val := utl_tcp.WRITE_TEXT(c, str); 
 
  utl_tcp.close_connection(c); 
 
  insert into LOTE_PRINT_LOG (CARGA_ID, LOTE, SEP_ID) 
  values (i_carga, i_lote, i_user); 
end; 
/