
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("НаименованиеПанели","Портал сотрудника");
		
	KPI_ИнтерфейсКлиент.ОткрытьФормуЗащищенногоОбъекта("KPI_ПанельВиджетов","Форма",ПараметрыФормы,,Новый УникальныйИдентификатор);
	
КонецПроцедуры
