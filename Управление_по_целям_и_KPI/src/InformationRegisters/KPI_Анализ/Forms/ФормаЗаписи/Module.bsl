
&НаКлиенте
Процедура ВвестиСЗ(Команда)
	
	ФормаСмартЗадачи = ПолучитьФорму("Документ.KPI_СмартЗадача.ФормаОбъекта");
	ДанныеФормы = ФормаСмартЗадачи.Объект;
	ЗаполнитьНаСервереФормуСЗ(ДанныеФормы, Запись.Корректировка, Параметры.ДатаДок, Параметры.Периодичность, Параметры.Сотрудник);
	КопироватьДанныеФормы(ДанныеФормы, ФормаСмартЗадачи.Объект);
	ФормаСмартЗадачи.ОткрытьМодально();
	
КонецПроцедуры


&НаСервереБезКонтекста
Процедура ЗаполнитьНаСервереФормуСЗ(НовыйОбъект, НаименованиеЗадачи, ДатаДок, Периодичность, Сотрудник)
	
	НовыйОбъект.НаименованиеЗадачи        = НаименованиеЗадачи;
	НовыйОбъект.Дата                      = ДатаДок;
	НовыйОбъект.ПериодичностьПланирования = Периодичность;
	НовыйОбъект.Сотрудник                 = Сотрудник;
	
КонецПроцедуры


&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	Запись.Основание             = Параметры.Основание;
	Запись.ЦелевойПоказатель     = Параметры.ЦелевойПоказатель;
	Запись.КлючАналитики         = Параметры.КлючАналитики;	
	Параметры.Модифицированность = ЭтаФорма.Модифицированность;
	
КонецПроцедуры

