//Функция получает виды дней графика
//Параметры:
// ГрафикРаботы - тип СправочникСсылка.KPI_ГрафикиРаботы
//Возвращаемое значение:
// Выборка видов дней - тип ВыбораИзРезультатаЗапроса
Функция ВидыДнейГрафика(ГрафикРаботы) Экспорт
	
	Год = ГрафикРаботы.Год;
	Если НЕ ЗначениеЗаполнено(Год) Тогда 	
		Год = Год(ТекущаяДата());
	КонецЕсли;
	
	НачалоПериода = Дата(Формат(Год,"ЧГ=" )+ "0101");
	КонецПериода  = Дата(Формат(Год,"ЧГ=") + "1231");

	
	ТекстЗапроса =  "ВЫБРАТЬ
	|	ПраздничныеДни.Дата,
	|	НАЧАЛОПЕРИОДА(ПраздничныеДни.Дата, МЕСЯЦ) КАК НачалоМесяца,
	|	ПраздничныеДни.ВидДня
	|ИЗ
	|	РегистрСведений.KPI_ГрафикиРабот КАК ПраздничныеДни
	|ГДЕ
	|	ПраздничныеДни.ГрафикРаботы = &ГрафикРаботы
	|	И ПраздничныеДни.Дата МЕЖДУ &НачалоПериода И &КонецПериода
	|
	|УПОРЯДОЧИТЬ ПО
	|	ПраздничныеДни.Дата
	|ИТОГИ ПО
	|	НачалоМесяца";
	
	Запрос = Новый Запрос(ТекстЗапроса);
	
	Запрос.УстановитьПараметр("НачалоПериода"  ,НачалоПериода);
	Запрос.УстановитьПараметр("КонецПериода"   ,КонецПериода);
	Запрос.УстановитьПараметр("ГрафикРаботы"   ,ГрафикРаботы); 
	
	ВыборкаМесяцев = Запрос.Выполнить().Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	
	Возврат ВыборкаМесяцев;
	
	
КонецФункции

//Функция праздничные дни года
//Параметры:
// Год - тип Число
//Возвращаемое значение:
// Выборка видов дней - тип ВыбораИзРезультатаЗапроса
Функция ПраздничныеДни(Год) Экспорт
	
	ТекстЗапроса = "ВЫБРАТЬ
	|	ПраздничныеДни.Дата,
	|	ПраздничныеДни.ВидДня
	|ИЗ
	|	РегистрСведений.KPI_ГрафикиРабот КАК ПраздничныеДни
	|ГДЕ
	|	ПраздничныеДни.ГрафикРаботы = ЗНАЧЕНИЕ(Справочник.KPI_ГрафикиРабот.ПустаяСсылка)
	|	И ПраздничныеДни.Дата МЕЖДУ &НачалоПериода И &КонецПериода
	|
	|УПОРЯДОЧИТЬ ПО
	|	ПраздничныеДни.Дата";
	
	Запрос = Новый Запрос(ТекстЗапроса);
	
	Если НЕ ЗначениеЗаполнено(Год) Тогда 	
		Год = Год(ТекущаяДата());
	КонецЕсли;
	НачалоПериода = Дата(Формат(Год,"ЧГ=" )+ "0101");
	КонецПериода  = Дата(Формат(Год,"ЧГ=") + "1231");
	
	Запрос.УстановитьПараметр("НачалоПериода",НачалоПериода);
	Запрос.УстановитьПараметр("КонецПериода" ,КонецПериода);
	Возврат Запрос.Выполнить().Выбрать();
	
КонецФункции
