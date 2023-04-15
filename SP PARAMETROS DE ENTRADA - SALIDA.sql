

create procedure sp_promedio(
@n1 decimal(4,2),
@n2 decimal(4,2),
@rpta decimal(4,2) output
)
as
select @rpta = (@n1 + @n2)/2;

-- ejecucion
declare @var decimal(4,2);
execute sp_promedio 14,15,@var output
select @var;