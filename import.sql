begin
	apex_application_install.set_workspace('WMS');
	apex_application_install.set_application_id(19815);
	apex_application_install.generate_offset;
	apex_application_install.set_application_alias( 'testeapexei' );
end;
/
@f19815.sql
quit;