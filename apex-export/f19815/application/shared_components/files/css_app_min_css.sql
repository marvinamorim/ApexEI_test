prompt --application/shared_components/files/css_app_min_css
begin
--   Manifest
--     APP STATIC FILES: 19815
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>29300347010897583
,p_default_application_id=>19815
,p_default_id_offset=>0
,p_default_owner=>'DEV'
);
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '626F64797B6261636B67726F756E642D636F6C6F723A236666667D';
wwv_flow_api.create_app_static_file(
 p_id=>wwv_flow_api.id(57200774842023436)
,p_file_name=>'css/app.min.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
wwv_flow_api.component_end;
end;
/
