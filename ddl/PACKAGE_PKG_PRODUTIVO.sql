CREATE OR REPLACE EDITIONABLE PACKAGE "WMS"."PKG_PRODUTIVO" as
procedure p_inativar_permanente(
  i_produtivo number
);
end;
/
CREATE OR REPLACE EDITIONABLE PACKAGE BODY "WMS"."PKG_PRODUTIVO" as
  procedure p_inativar_permanente(
    i_produtivo number
  ) as
  begin
    update PRODUTIVO
       set STATUS = -1
     where ID = i_produtivo
    ;
  end;
end;
/