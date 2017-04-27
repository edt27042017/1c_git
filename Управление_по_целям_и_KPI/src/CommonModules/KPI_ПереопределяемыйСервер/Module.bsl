//Функция получения признака интегрированности решения 
//Параметры:
// нет
//Возвращаемое значение:
// нет
Функция ИнтегрированныйФункционал() Экспорт
	
	Возврат Ложь;
	
КонецФункции

//Функция для получения типа производственного календаря
//Параметры:
// нет
//Возвращаемое значение:
// нет
Функция ТипСправочникаПроизводственныйКалендарь() Экспорт
	
	Возврат "СправочникСсылка.ПроизводственныеКалендари";
	
КонецФункции

//Функция для заполнения графика работ по производственному календарю
//Параметры:
// нет
//Возвращаемое значение:
// нет
Процедура ЗаполнитьГрафикПоДаннымПроизводственногоКалендаря(График) Экспорт 
	
	ПроизводственныйКалендарь = График.ПроизводственныйКалендарь; 
	Год                       = График.Год;
		
	//заполним ячейки часами
	НаборЗаписей = РегистрыСведений.ДанныеПроизводственногоКалендаря.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.ПроизводственныйКалендарь.Использование = Истина;
	НаборЗаписей.Отбор.ПроизводственныйКалендарь.ВидСравнения  = ВидСравнения.Равно;
	НаборЗаписей.Отбор.ПроизводственныйКалендарь.Значение      = ПроизводственныйКалендарь;
	НаборЗаписей.Отбор.Год.Использование                       = Истина;
	НаборЗаписей.Отбор.Год.ВидСравнения                        = ВидСравнения.Равно;
	НаборЗаписей.Отбор.Год.Значение                            = Год;
	НаборЗаписей.Прочитать();
	
	Для каждого Запись Из НаборЗаписей Цикл
		ДатаЗаписи = Запись.Дата;
		СтрГрафика = График.ДанныеГрафика.Получить(Месяц(ДатаЗаписи) - 1);
		
		Если Запись.ВидДня = Перечисления.ВидыДнейПроизводственногоКалендаря.Рабочий Тогда 
			СтрГрафика["Часов" + Строка(День(ДатаЗаписи))] = График.РабочихЧасовВДне;
		ИначеЕсли Запись.ВидДня = Перечисления.ВидыДнейПроизводственногоКалендаря.Предпраздничный Тогда
			СтрГрафика["Часов" + Строка(День(ДатаЗаписи))] = График.РабочихЧасовВДне - 1;
		ИначеЕсли Запись.ВидДня = Перечисления.ВидыДнейПроизводственногоКалендаря.Суббота
			Или Запись.ВидДня = Перечисления.ВидыДнейПроизводственногоКалендаря.Воскресенье
			Или Запись.ВидДня = Перечисления.ВидыДнейПроизводственногоКалендаря.Праздник Тогда       
			СтрГрафика["Часов" + Строка(День(ДатаЗаписи))] = 0;
		КонецЕсли;
	КонецЦикла;
			
КонецПроцедуры