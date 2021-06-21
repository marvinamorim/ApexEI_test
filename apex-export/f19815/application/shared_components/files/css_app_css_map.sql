prompt --application/shared_components/files/css_app_css_map
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
wwv_flow_api.g_varchar2_table(1) := '7B2276657273696F6E223A332C22736F7572636573223A5B226170702E637373225D2C226E616D6573223A5B5D2C226D617070696E6773223A22414141412C4D41414D2C7342414173422C43414143222C2266696C65223A226170702E637373222C2273';
wwv_flow_api.g_varchar2_table(2) := '6F7572636573436F6E74656E74223A5B22626F6479207B6261636B67726F756E642D636F6C6F723A20234646463B7D225D7D';
wwv_flow_api.create_app_static_file(
 p_id=>wwv_flow_api.id(57200488774023433)
,p_file_name=>'css/app.css.map'
,p_mime_type=>'text/plain'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
wwv_flow_api.component_end;
end;
/
