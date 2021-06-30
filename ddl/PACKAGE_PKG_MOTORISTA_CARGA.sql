CREATE OR REPLACE EDITIONABLE PACKAGE "WMS"."PKG_MOTORISTA_CARGA" as
  procedure p_add_placa(
    i_placa varchar2,
    i_user varchar2
  );
  
  procedure p_vincular_motorista(
    i_motorista number,
    i_user varchar2,
    i_plc_codigo number
  );
  
  procedure p_add_motorista_dia(
    i_motorista number,
    i_box number,
    i_user varchar2,
    i_desc varchar2 default null
  );
  
  procedure p_update_box(
    i_cgd_code number,
    i_box number,
    i_user varchar2
  );
  
  procedure p_update_desc(
    i_cgd_code number,
    i_desc varchar2,
    i_user varchar2
  );
  
  procedure p_del_motorista_dia(
    i_motorista number
  );
  
  procedure p_add_carga(
    i_motorista number,
    i_carga number,
    i_user varchar2,
    i_tipo varchar2,
    o_return out number
  );
  
  procedure p_update_carga(
    i_motorista number,
    i_carga number,
    i_user varchar2
  );
  
  procedure p_del_carga(
    i_carga number,
    i_tipo varchar2
  );
  
  procedure p_finish_dia(
    i_cgd_code number
  );
  
  procedure p_clear_virtual(
    i_motorista number,
    i_data_inicial date,
    i_data_final date
  );
  
  procedure p_publicar_cargas(
    i_motorista number,
    i_data_inicial date,
    i_data_final date,
    i_user varchar2
  );
end;
/