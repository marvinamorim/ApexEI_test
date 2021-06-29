prompt --application/shared_components/files/js_app_js_map
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
wwv_flow_api.g_varchar2_table(1) := '7B2276657273696F6E223A332C226E616D6573223A5B5D2C226D617070696E6773223A22222C22736F7572636573223A5B226170702E6A73225D2C22736F7572636573436F6E74656E74223A5B22636F6E736F6C652E6C6F67285C225465737465313233';
wwv_flow_api.g_varchar2_table(2) := '5C2229225D2C2266696C65223A226170702E6A73227D';
wwv_flow_api.create_app_static_file(
 p_id=>wwv_flow_api.id(57201385896023441)
,p_file_name=>'js/app.js.map'
,p_mime_type=>'text/plain'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
wwv_flow_api.component_end;
end;
/
