create procedure [dbo].[ДобавлениеАбонента]
@IdАбонента bigint,
@Фамилия nvarchar(50),
@Имя nvarchar(50),
@Отчество nvarchar(50),
@Адресс nvarchar(50)
as
Begin
Insert into Абоненты(IdАбонента,Фамилия,Имя,Отчество,Адресс)
Values(@IdАбонента,@Фамилия,@Имя,@Отчество,@Адресс)
end