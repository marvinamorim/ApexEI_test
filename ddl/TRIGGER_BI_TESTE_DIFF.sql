CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."BI_TESTE_DIFF" 
  before insert on "TESTE_DIFF"                
  for each row   
begin    
  if :NEW."C_NUMBER" is null then  
    select "TESTE_DIFF_SEQ".nextval into :NEW."C_NUMBER" from sys.dual;  
  end if;  
end; 
 

/
ALTER TRIGGER "WMS"."BI_TESTE_DIFF" ENABLE;