Create procedure [dbo].[УдалениеАбонентов]
@IdАбонента bigint
as
Begin
select *
from Абоненты
delete from Абоненты
Where @IdАбонента = IdАбонента
end
