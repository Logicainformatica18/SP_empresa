use lsm
create procedure sp_registry_detail_insert(
@id_registry int,
@id_student int
)
as
begin
	insert into registro_detalle(registroid,estudianteid,fec_reg,fec_mod)
	values(@id_registry,@id_student,getdate(),getdate());
	-- @@identity captura el codigo generado en la anterior consulta (insert)
	--
	declare @id_registry_detail int =@@identity;
		insert into notas(registro_detalleId) values (@id_registry_detail);
	-- 
	declare @date datetime = getdate();
	declare @date_end datetime = DATEADD(week,12,getdate());
	while (@date < @date_end)
	begin
	INSERT INTO asistencia(registro_detalleId,[fecha])
	values (@id_registry_detail,@date);
	set @date =DATEADD(week,1,@date)
	end

	
end

execute sp_registry_detail_insert 1,1
exec sp_registry_detail_insert 1,1
select * from assistance

