CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."PRODUTIVO_WEBSOCKET" 
  after update on produtivo  
  for each row  
declare 
  v_em_atividade number; 
begin 
  select count(*) 
    into v_em_atividade 
    from ATIVIDADE A 
   where ((:new.ATIVIDADE = 'S' and A.STATUS = 1 and A.SEP_ID = :new.ID) 
       or (:new.ATIVIDADE = 'C' and A.STATUS = 3 and A.CONF_ID = :new.ID) 
  ); 
     
  if :old.status = 1 and :new.status = 0 and v_em_atividade = 0 then 
    ws_notify_api.do_rest_notify_user( 
      i_userid   => to_char(:old.id), 
      i_room     => 'private', 
      i_type     => 'warn', 
      i_title    => 'My test title', 
      i_message  => 'My test message content...' 
    ); 
  end if; 
end produtivo_aud; 
 

/
ALTER TRIGGER "WMS"."PRODUTIVO_WEBSOCKET" ENABLE;