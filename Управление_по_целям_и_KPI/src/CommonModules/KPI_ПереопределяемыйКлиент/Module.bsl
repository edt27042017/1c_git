//Функция для открытия формы календаря
//Параметры:
// нет
//Возвращаемое значение:
// нет
Процедура ОткрытьФормуКалендаря() Экспорт
	
	Если KPI_ПереопределяемыйСервер.ИнтегрированныйФункционал() Тогда
		ОткрытьФорму("Справочник.ПроизводственныеКалендари.ФормаСписка");
	Иначе 
		ОткрытьФорму("РегистрСведений.KPI_ГрафикиРабот.Форма.ПраздничныеДни");
	КонецЕсли;
	
КонецПроцедуры