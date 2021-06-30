CREATE OR REPLACE EDITIONABLE TRIGGER "WMS"."MOVIMENTACAO_T1" 
BEFORE
update on WMS."MOVIMENTACAO"
for each row
begin
if :new.status = 4 and :new.tipo = 'P' then
  update endereco
     set qtd_atual = qtd_atual - :new.qtd
   where id = :new.origem_id;
  update lote
     set sep_id = :new.abast_id,
         sep_start = sysdate,
         sep_end = sysdate,
         status = 2
   where id = :new.lote_id;
elsif :new.status = 4 and :new.tipo in ('R','D') then
  update endereco
     set qtd_atual = qtd_atual - :new.qtd
   where id = :new.origem_id;
  update endereco
     set qtd_atual = qtd_atual + :new.qtd
   where id = :new.destino_id;
elsif :new.status = 4 and :new.tipo in ('E') then
  update endereco
     set qtd_atual = :new.qtd
   where id = :new.destino_id;
end if;
end;

/
ALTER TRIGGER "WMS"."MOVIMENTACAO_T1" ENABLE;