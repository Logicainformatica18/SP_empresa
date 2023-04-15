Create database Edutec;
Use edutec;

Create Table [user] (
cod_user  smallint identity primary key,
[name] varchar(50),
Pass nvarchar(100) COLLATE Latin1_General_CS_AI NULL
);
go
-- 
insert into [user](name,pass)values
('anthony01','A01');
go
insert into [user](name,pass)values
('anthony03',ENCRYPTBYPASSPHRASE('1','1234'));
go
create procedure sp_user_login(
@name varchar(50),
@Pass nvarchar(100)
)
as
select cod_user,[name] from [user] where
[name] =@name and pass = @Pass;
go

Select [name], convert(Varchar(100),DECRYPTBYPASSPHRASE('1',Pass)) from [user];
select * from [user];
execute sp_user_login 'anthony01','A01';
/*
ALTER TABLE Login ALTER COLUMN Pass [nvarchar](8) COLLATE Latin1_General_CS_AI NULL
Select Name, convert(Varchar(100),DECRYPTBYPASSPHRASE('1',Pass)) from Login
go
*/
Create proc Pa_Ingreso( 
@name varchar(50),
@Pass varchar(100),
@Tipo varchar(30)
)
as
SELECT IdEmpleado from Empleado where    UserEmpleado=@Name and Pass = @Pass and  Cargo = @Tipo
go

Create table Alumno (
IdAlumno smallint Identity primary key,
ApeAlumno varchar(60),
NomAlumno varchar(60),
DirAlumno varchar(100),
TelAlumno varchar(9),
EmailAlumno varchar(100)
)
go
Create Procedure Pa_Alumno_Select
as
select IdAlumno, ApeAlumno, NomAlumno, DirAlumno, TelAlumno, EmailAlumno from Alumno
go

Create procedure Pa_Alumno_Insert
(
@ApeAlumno varchar(60),
@NomAlumno  varchar(60),
@DirAlumno varchar(100),
@TelAlumno varchar(9),
@EmailAlumno varchar(100)
)
as
insert into Alumno (
ApeAlumno,   NomAlumno, DirAlumno, TelAlumno, EmailAlumno)
Values(
@ApeAlumno , @NomAlumno, @DirAlumno, @TelAlumno, @EmailAlumno)
select @@IDENTITY as Id
Return
go

create procedure Pa_Alumno_Buscar
(@Campo int,
@Criterio varchar(150)
)
 as
 if @Campo=0
Begin
Select IdAlumno, ApeAlumno , NomAlumno, DirAlumno, TelAlumno, EmailAlumno
from Alumno where ApeAlumno like @Criterio + '%'
end
go

Create Procedure Pa_Alumno_Delete
(
@Id Int)
as 
delete from Alumno where IdAlumno= @Id
go

Create Procedure [dbo].[Pa_Alumno_Update]
(@Id int,
@ApeAlumno varchar(60),
@NomAlumno  varchar(60),
@DirAlumno varchar(100),
@TelAlumno varchar(9),
@EmailAlumno varchar(100)
)
as 
Update Alumno
Set ApeAlumno=@ApeAlumno , NomAlumno=@NomAlumno, DirAlumno=@DirAlumno, TelAlumno= @TelAlumno, EmailAlumno=@EmailAlumno
where IdAlumno= @Id

GO
------------------------------------------------------------------------------------------------------

Create table Tarifa (
IdTarifa smallint identity primary key,
PreTarifa numeric(10,2),
Descripción varchar(100)
)
go

Create Proc Pa_Tarifa_Select
as
select IdTarifa, PreTarifa, Descripción from Tarifa
go

Create Proc Pa_Tarifa_Insert
(
@PreTarifa numeric(10,2),
@Descripción varchar(100)
)
as
Insert into Tarifa (Pretarifa, Descripción)
values (
 @Pretarifa, @Descripción)
select @@Identity as Id
return
go

create proc Pa_Tarifa_Buscar
(@Campo int,
@Criterio varchar(150)
)
 as
 if @Campo=0
Begin
Select IdTarifa, PreTarifa, Descripción from Tarifa
 where PreTarifa like @Criterio + '%'
end
go

Create Proc Pa_Tarifa_Update
(
@PreTarifa numeric(10,2),
@Descripción varchar(100),
@Id int
)
as
Update Tarifa
Set PreTarifa=@PreTarifa, Descripción =@Descripción
where IdTarifa= @Id

GO

Create Proc Pa_Tarifa_Delete
(
@Id Int)
as 
delete from Tarifa where IdTarifa= @Id
go
------------------------------------------------------------------------------------------------------

create table Curso (
IdCurso smallint identity primary key,
Idtarifa smallint foreign key references Tarifa(IdTarifa),
NomCurso varchar(50)
)
go

Create Proc Pa_Curso_Select
as
select IdCurso, IdTarifa, NomCurso from Curso
go

Create proc Pa_Curso_Insert
(
@IdTarifa smallint,
@NomCurso varchar(50)
)
as
insert into Curso (  IdTarifa,NomCurso)
values (  @IdTarifa,@NomCurso)
select @@Identity as Id
return 
go

create proc Pa_Curso_Buscar
(@Campo int,
@Criterio varchar(150)
)
 as
 if @Campo=0
Begin
select IdCurso, IdTarifa, NomCurso from Curso
 where NomCurso like @Criterio + '%'
end
go

Create Proc Pa_Curso_Update
(
@IdTarifa smallint,
@NomCurso varchar(50),
@Id int
)
as
Update Curso
Set  NomCurso= @NomCurso 
where IdCurso= @Id

GO

Create Proc Pa_Curso_Delete
(
@Id Int)
as 
delete from Curso where IdCurso= @Id
go

Create table Parametro (
IdCampo smallint Identity primary key,
Contador numeric(10)
)
go

Insert into Parametro values (1)
go

Create Proc Pa_Parametro_Select
as
select IdCampo, Contador from Parametro
go

Create proc Pa_Parametro_Insert
(
@Contador numeric(10)
)
as
insert into Parametro ( Contador)
values (@Contador)
select @@identity as  Id
Return
go

create proc Pa_Parametro_Buscar
(@Campo int,
@Criterio varchar(150)
)
 as
 if @Campo=0
Begin
select IdCampo, Contador from Parametro
 where Contador like @Criterio + '%'
end
go

Create Proc Pa_Parametro_Update
(

@Contador numeric(10),
@Id int
)
as
Update Parametro
Set  Contador= @Contador
where IdCampo= @Id

GO

Create Proc Pa_Parametro_Delete
(
@Id Int)
as 
delete from Parametro where IdCampo= @Id
go
------------------------------------------------------------------------------------------------------------------


Create table Empleado (
IdEmpleado smallint identity primary key,
UserEmpleado varchar(50),
 Pass nvarchar(300) COLLATE Latin1_General_CS_AI NULL,
ApeEmpleado varchar(60),
NomEmpleado varchar(60),
Cargo varchar(40),
DirEmpleado varchar(80),
TelEmpleado varchar(9),
EmailEmpleado varchar(80)
)
go

Insert into Empleado Values ('anthony','casa','Cardenas Aquino','Anthony','Administrador','Mz t2 lote 1a Santa maria','4929485','anthony_rk_al_tlv@hotmail.com')
go

Create Proc Pa_Empleado_Select
as
select IdEmpleado, UserEmpleado, Pass, ApeEmpleado, NomEmpleado, Cargo, DirEmpleado, TelEmpleado, TelEmpleado, EmailEmpleado from Empleado
go

Create proc Pa_Empleado_Insert
(
@UserEmpleado varchar(50),
@Pass nvarchar(300),
@ApeEmpleado varchar(60),
@NomEmpleado Varchar(60),
@Cargo varchar(40),
@DirEmpleado varchar(80),
@TelEmpleado varchar(9),
@EmailEmpleado varchar(80)
)
as
insert into Empleado ( UserEmpleado, Pass, ApeEmpleado, NomEmpleado, Cargo, DirEmpleado,
TelEmpleado, EmailEmpleado)
values (@UserEmpleado, @Pass,  @ApeEmpleado,@NomEmpleado ,@Cargo,@DirEmpleado,@TelEmpleado,@EmailEmpleado
)
select @@IDENTITY as Id
return
go

create proc Pa_Empleado_Buscar
(@Campo int,
@Criterio varchar(150)
)
 as
 if @Campo=0
Begin
select IdEmpleado, UserEmpleado, Pass, ApeEmpleado, NomEmpleado, Cargo, DirEmpleado, TelEmpleado, TelEmpleado, EmailEmpleado from Empleado

 where NomEmpleado like @Criterio + '%'
end
go


Create Proc Pa_Empleado_Update
(
@UserEmpleado varchar(50),
@Pass nvarchar(300),
@ApeEmpleado varchar(60),
@NomEmpleado Varchar(60),
@Cargo varchar(40),
@DirEmpleado varchar(80),
@TelEmpleado varchar(9),
@EmailEmpleado varchar(80)
,
@Id int
)
as
Update Empleado
Set   UserEmpleado=@UserEmpleado, Pass=@Pass,  ApeEmpleado= @ApeEmpleado,NomEmpleado =@NomEmpleado,Cargo=@Cargo ,DirEmpleado=@DirEmpleado,TelEmpleado=@TelEmpleado,EmailEmpleado=@EmailEmpleado
where IdEmpleado= @Id

GO

Create Proc Pa_Empleado_Delete
(
@Id Int)
as 
delete from Empleado where IdEmpleado= @Id
go

-----------------------------------------------------------------------------
Create table Profesor (
IdProfesor smallint Identity primary key,
ApeProfesor varchar(60),
NomProfesor varchar(60),
DirProfesor varchar(80),
TelProfesor varchar(9),
EmailProfesor varchar(80)
)
go

Create Proc Pa_Profesor_Select
as
select IdProfesor, ApeProfesor, NomProfesor, DirProfesor, TelProfesor, EmailProfesor from Profesor
go

Create proc Pa_Profesor_Insert
(
@ApeProfesor varchar(60),
@NomProfesor varchar(60),
@DirProfesor varchar(80),
@TelProfesor varchar(9),
@EmailProfesor varchar(80)
)
as
Insert into Profesor (
ApeProfesor,
NomProfesor ,
DirProfesor ,
TelProfesor ,
EmailProfesor)
Values 
(
@ApeProfesor ,
@NomProfesor,
@DirProfesor,
@TelProfesor,
@EmailProfesor
)
select @@Identity as Id
Return
go

create proc Pa_Profesor_Buscar
(@Campo int,
@Criterio varchar(150)
)
 as
 if @Campo=0
Begin
select IdProfesor, ApeProfesor, NomProfesor, DirProfesor, TelProfesor, EmailProfesor from Profesor

 where ApeProfesor like @Criterio + '%'
end
go

Create Proc Pa_Profesor_Update
(
@ApeProfesor varchar(60),
@NomProfesor varchar(60),
@DirProfesor varchar(80),
@TelProfesor varchar(9),
@EmailProfesor varchar(80),
@Id int
)
as
Update Profesor
Set    ApeProfesor=@ApeProfesor, NomProfesor=@NomProfesor, DirProfesor=@DirProfesor, TelProfesor=@TelProfesor, EmailProfesor=@EmailProfesor
where IdProfesor= @Id

GO

Create Proc Pa_Profesor_Delete
(
@Id Int)
as 
delete from Profesor where IdProfesor= @Id
go
-----------------------------------------------------------------------------
Create table Ciclo (
IdCiclo smallint identity primary key,
FechInicio date,
FechFin date
)
go

Create Proc Pa_Ciclo_Select
as
Select IdCiclo, FechInicio, FechFin from Ciclo
go

Create Proc Pa_Ciclo_Insert
( @FechInicio date, @FechFin date)
as
insert into Ciclo (
 FechInicio, FechFin)
values
(@FechInicio , @FechFin )
select @@Identity as Id
Return
go


create proc Pa_Ciclo_Buscar
(@Campo int,
@Criterio varchar(150)
)
 as
 if @Campo=0
Begin
Select IdCiclo, FechInicio, FechFin from Ciclo

 where FechInicio like @Criterio + '%'
end
go

Create Proc Pa_Ciclo_Update
(
 @FechInicio date, @FechFin date,
@Id int
)
as
Update  Ciclo
Set   FechInicio=@FechInicio , FechFin=@FechFin
where IdCiclo= @Id

GO

Create Proc Pa_Ciclo_Delete
(
@Id Int)
as 
delete from Ciclo where IdCiclo= @Id
go

Create table CursoProgramado (
IdcursoProg smallint identity primary key,
IdCurso smallint foreign key references Curso(IdCurso),
 IdCiclo smallint foreign key references Ciclo(IdCiclo),
 IdProfesor smallint foreign key references Profesor(IdProfesor),
 Vacantes Numeric(10),
 PreCursoProg numeric(10,2),
 Horario varchar(50),
 Activo varchar(10),
 Matriculados numeric(10)
 )
 go


Create Proc Pa_CursoProgramado_Select
as
select IdcursoProg,IdCurso, IdCiclo, IdProfesor, Vacantes ,PreCursoProg, Horario, Activo, Matriculados from CursoPRogramado
go

Create Proc Pa_CursoProgramado_Insert
(
@IdCurso smallint,
@IdCiclo smallint ,
@IdProfesor smallint,
@Vacantes numeric(10),
@PreCursoProg numeric(10,2),
@Horario varchar(50),
@Activo varchar(10),
@Matriculados numeric(10)
)
as
insert into CursoProgramado
(IdCurso, IdCiclo, IdProfesor, Vacantes ,PreCursoProg, Horario, Activo, Matriculados)
values
(

@IdCurso ,
@IdCiclo  ,
@IdProfesor ,
@Vacantes,
@PreCursoProg ,
@Horario ,
@Activo ,
@Matriculados 
)
select @@Identity as Id
return
go

create proc Pa_CursoProgramado_Buscar
(@Campo int,
@Criterio varchar(150)
)
 as
 if @Campo=0
Begin
select IdcursoProg,IdCurso, IdCiclo, IdProfesor, Vacantes ,PreCursoProg, Horario, Activo, Matriculados from CursoPRogramado
 where Vacantes like @Criterio + '%'
end
go

Create Proc Pa_CursoProgramado_Update
(
@IdCurso smallint,
@IdCiclo smallint ,
@IdProfesor smallint,
@Vacantes numeric(10),
@PreCursoProg numeric(10,2),
@Horario varchar(50),
@Activo varchar(10),
@Matriculados numeric(10),
@Id int 
)
as
Update  CursoProgramado
Set   IdCurso=@IdCurso ,IdCiclo=@IdCiclo, IdProfesor=@IdProfesor, Vacantes=@Vacantes ,PreCursoProg=@PreCursoProg, Horario=@Horario, Activo=@Activo, Matriculados=@Matriculados 
where IdCursoProg= @Id

GO

Create Proc Pa_CursoProgramado_Delete
(
@Id Int)
as 
delete from CursoProgramado where IdcursoProg= @Id
go

Create table Matricula (
 IdcursoProg smallint foreign key references  CursoProgramado(IdcursoProg),
 IdAlumno smallint foreign key references Alumno(IdAlumno),
 FechMatricula date,
 ExaParcial Numeric(2),
 ExaFinal numeric(2),
 Promedio  as ((ExaParcial+ExaFinal)/2)
 
 )
 go

 Create Proc Pa_Matricula_Select
 as
 select IdCursoProg , IdAlumno, FechMatricula, ExaParcial, ExaFinal,Promedio  from Matricula
 go

 Create proc Pa_Matricula_Insert
 (@IdcursoProg smallint,
 @IdAlumno smallint,
 @FechMatricula date,
 @ExaParcial Numeric(2),
 @ExaFinal numeric(2)
 
 )
 as
 Insert into Matricula ( IdcursoProg,IdAlumno, FechMatricula, ExaParcial, ExaFinal)
 values
 ( @IdCursoProg,@IdAlumno, @FechMatricula, @ExaParcial, @ExaFinal)
 select @@Identity as Id
 return
 go

 create proc Pa_Matricula_Buscar
(@Campo int,
@Criterio varchar(150)
)
 as
 if @Campo=0
Begin
 select IdCursoProg , IdAlumno, FechMatricula, ExaParcial, ExaFinal from Matricula

 where FechMatricula like @Criterio + '%'
end
go

Create Proc Pa_Matricula_Update
(@IdCursoProg smallint,
 @IdAlumno smallint,
 @FechMatricula date,
 @ExaParcial Numeric(2),
 @ExaFinal numeric(2),
 
@Id int 
)
as
Update  Matricula
Set    IdcursoProg=@IdCursoProg, IdAlumno=@IdAlumno,  FechMatricula=@FechMatricula, ExaParcial=@ExaParcial, ExaFinal=@ExaFinal
where IdAlumno= @Id

GO

Create Proc Pa_Matricula_Delete
(
@Id Int)
as 
delete from Matricula where IdcursoProg= @Id
