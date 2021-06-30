CREATE OR REPLACE EDITIONABLE FUNCTION "WMS"."F_SEC2TIME" (vSec number, vMask varchar2 DEFAULT 'HH24:MI:SS') 
   RETURN varchar2 
IS 
h number; 
m number; 
s number; 
t varchar2(8); 
 
BEGIN 
if vSec is not null then 
  h := trunc(vSec/3600); 
  m := trunc(mod(vSec,3600)/60); 
  s := mod(mod(vSec,3600),60); 
  if vMask = 'HH24:MI' then 
    t := LPAD(to_char(h),2,'0')|| ':' || LPAD(to_char(m),2,'0'); 
  elsif vMask = 'HH24:MI:SS' then 
    t := LPAD(to_char(h),2,'0')|| ':' || LPAD(to_char(m),2,'0') || ':' || LPAD(to_char(s),2,'0'); 
  end if; 
else 
  t := null; 
end if; 
return t; 
END f_sec2time; 
/