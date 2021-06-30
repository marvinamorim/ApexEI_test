CREATE OR REPLACE EDITIONABLE PACKAGE "WMS"."PKG_AUX" as

function test_func (
    p_arg1 in number )
    return varchar2;

end;
/