Перем ГиперСсылкаВводаТекст;

Процедура ПриЗаписи(Отказ)
	Если Не ЭтотОбъект.ЭтоГруппа Тогда 
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ
		|	KPI_ЦелевыеПоказатели.Ссылка
		|ИЗ
		|	Справочник.KPI_ЦелевыеПоказатели КАК KPI_ЦелевыеПоказатели
		|ГДЕ
		|	KPI_ЦелевыеПоказатели.Ссылка <> ЗНАЧЕНИЕ(Справочник.KPI_ЦелевыеПоказатели.СмартЗадача)
		|			И KPI_ЦелевыеПоказатели.Ссылка <> ЗНАЧЕНИЕ(Справочник.KPI_ЦелевыеПоказатели.Стандарт)";
		
		Результат = Запрос.Выполнить();
		ТаблицаЦП = Результат.Выгрузить();
		
		
		Для каждого ЭлемЦП Из ТаблицаЦП Цикл
			Уровень = 1;
			
			ТаблЗнач = Новый ТаблицаЗначений;
			ТаблЗнач.Колонки.Добавить("Уровень");                                                     
			ТаблЗнач.Колонки.Добавить("ЦП");
			
			НовСтр = ТаблЗнач.Добавить();
			НовСтр.Уровень = Уровень;                                                                 
			НовСтр.ЦП = ЭтотОбъект;
			
			
			СтруктураПерекрестныхЦПДляПланов = ПолучитьЦПсЗацикленнойФормулой(ЭтотОбъект, ТаблЗнач, Уровень, "План");
			
			Если СтруктураПерекрестныхЦПДляПланов.Количество() <> 0 Тогда
				Если СтруктураПерекрестныхЦПДляПланов.ЦПродитель1 <> СтруктураПерекрестныхЦПДляПланов.ЦПродитель2 Тогда
					Сообщить("Целевой показатель """ + СтруктураПерекрестныхЦПДляПланов.ЦПподчиненный + """
					|входит в взаимозависимые формулы планов целевых показателей
					|""" + СтруктураПерекрестныхЦПДляПланов.ЦПродитель1 + """ и """ + СтруктураПерекрестныхЦПДляПланов.ЦПродитель2 + """");
				Иначе 
					Сообщить("Целевой показатель """ + СтруктураПерекрестныхЦПДляПланов.ЦПподчиненный + """
					|и целевой показатель """ + СтруктураПерекрестныхЦПДляПланов.ЦПродитель1 + """ 
					|в формулах планов ссылаются друг на друга");
				КонецЕсли;
				
				Если Не ЗначениеЗаполнено(ЭтотОбъект.ФормулаСписокПлан) Тогда
					ЭтотОбъект.ФормулаСписокПлан = ГиперСсылкаВводаТекст;
				КонецЕсли;
				
				Отказ = Истина;
				Возврат;
			КонецЕсли;
			
			
			СтруктураПерекрестныхЦПДляФактов = ПолучитьЦПсЗацикленнойФормулой(ЭтотОбъект, ТаблЗнач, Уровень, "Факт");
			
			Если СтруктураПерекрестныхЦПДляФактов.Количество() <> 0 Тогда
				Если СтруктураПерекрестныхЦПДляФактов.ЦПродитель1 <> СтруктураПерекрестныхЦПДляФактов.ЦПродитель2 Тогда
					Сообщить("Целевой показатель """ + СтруктураПерекрестныхЦПДляФактов.ЦПподчиненный + """
					|входит в взаимозависимые формулы фактов целевых показателей
					|""" + СтруктураПерекрестныхЦПДляФактов.ЦПродитель1 + """ и """ + СтруктураПерекрестныхЦПДляФактов.ЦПродитель2 + """");
				Иначе 
					Сообщить("Целевой показатель """ + СтруктураПерекрестныхЦПДляФактов.ЦПподчиненный + """
					|и целевой показатель """ + СтруктураПерекрестныхЦПДляФактов.ЦПродитель1 + """ 
					|в формулах фактов ссылаются друг на друга");
				КонецЕсли;
				
				Если Не ЗначениеЗаполнено(ЭтотОбъект.ФормулаСписокФакт) Тогда
					ЭтотОбъект.ФормулаСписокФакт = ГиперСсылкаВводаТекст;
				КонецЕсли;
				
				Отказ = Истина;
				Возврат;
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

//рекурсивная функция для проверки зацикливания формул
Функция ПолучитьЦПсЗацикленнойФормулой(ЦП, ТаблЗнач, Уровень, ПланФакт)
	СтруктураПерекрестныхЦП = Новый Структура;
	
	ТЗ = Новый ТаблицаЗначений;
	ТЗ.Колонки.Добавить("ЦП");
	ТЗ.Колонки.Добавить("Представление");
	
	Если ПланФакт = "План" Тогда
		Формула = ЦП.ФормулаСписокПлан;
		
		Для каждого Стр Из ЦП.ФормулаПлана Цикл
			НовСтр = ТЗ.Добавить();
			НовСтр.ЦП = Стр.ЦелевойПоказатель;
			НовСтр.Представление = Стр.Представление;
		КонецЦикла;
		
	ИначеЕсли ПланФакт = "Факт" Тогда
		Формула = ЦП.ФормулаСписокФакт;
		
		Для каждого Стр Из ЦП.ФормулаФакта Цикл
			НовСтр = ТЗ.Добавить();
			НовСтр.ЦП = Стр.ЦелевойПоказатель;
			НовСтр.Представление = Стр.Представление;
		КонецЦикла;
	КонецЕсли;
	
	
	//уберем из таблицы целевые показатели, которых нет в формуле
	н = 0;
	Пока н < ТЗ.Количество() Цикл
		Если Найти(Формула, "[" + СокрЛП(ТЗ.Получить(н).Представление) + "]") = 0 Тогда
			ТЗ.Удалить(н);
		Иначе 
			н = н + 1;	
		КонецЕсли;
	КонецЦикла;
	
	ТЗ.Колонки.Удалить(1);
    ТЗ.Свернуть("ЦП");
	
	
	Для п = 0 По ТЗ.Количество() - 1 Цикл
		Для к = 0 По ТаблЗнач.Количество() - 1 Цикл
			Если ТаблЗнач.Получить(к).ЦП = ТЗ.Получить(п).ЦП Тогда
				СтруктураПерекрестныхЦП.Вставить("ЦПподчиненный", ТЗ.Получить(п).ЦП);
				СтруктураПерекрестныхЦП.Вставить("ЦПродитель1", ЦП);
				СтруктураПерекрестныхЦП.Вставить("ЦПродитель2", ТаблЗнач.Получить(0).ЦП.Ссылка);
				Возврат СтруктураПерекрестныхЦП;
			КонецЕсли;
		КонецЦикла;
		
		Уровень = Уровень + 1;
		
		НовСтр = ТаблЗнач.Добавить();
		НовСтр.Уровень = Уровень;
		НовСтр.ЦП = ТЗ.Получить(п).ЦП;
		
		Если ПланФакт = "План" Тогда
			СтруктураПерекрестныхЦП = ПолучитьЦПсЗацикленнойФормулой(ТЗ.Получить(п).ЦП, ТаблЗнач, Уровень, "План");
		ИначеЕсли ПланФакт = "Факт" Тогда
			СтруктураПерекрестныхЦП = ПолучитьЦПсЗацикленнойФормулой(ТЗ.Получить(п).ЦП, ТаблЗнач, Уровень, "Факт");
		КонецЕсли;
		
		
		Если СтруктураПерекрестныхЦП.Количество() <> 0 Тогда 
			Возврат СтруктураПерекрестныхЦП;
		КонецЕсли;
		
		н = 0;
		Пока н < ТаблЗнач.Количество() Цикл
			Если ТаблЗнач.Получить(н).Уровень = Уровень Тогда
				ТаблЗнач.Удалить(н);
			Иначе 
				н = н + 1;	
			КонецЕсли;
		КонецЦикла;
		
		Уровень = Уровень - 1;
	КонецЦикла;	
	
	Возврат СтруктураПерекрестныхЦП;	
КонецФункции

ГиперСсылкаВводаТекст = "Введите формулу";
