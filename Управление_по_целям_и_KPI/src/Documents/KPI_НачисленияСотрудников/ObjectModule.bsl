//Функция расчета вида начисления
//Параметры:
// Параметры расчета - тип структура
//Возвращаемое значение:
// Нет
Процедура РассчитатьНачисление(ПараметрыРасчета) Экспорт
	
	//Если НЕ ЗначениеЗаполнено(Ссылка) Тогда
	ЭтотОбъект.Записать(РежимЗаписиДокумента.Запись);
	//КонецЕсли;
	
	//SpM NB
	Движения.KPI_Начисления.Очистить();
	Движения.KPI_Начисления.Записать();
	//SpM NB...
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	KPI_НачисленияСотрудниковНачисления.Сотрудник,
	|	KPI_НачисленияСотрудниковНачисления.ВидНачисления,
	|	KPI_НачисленияСотрудниковНачисления.НачалоПериода,
	|	KPI_НачисленияСотрудниковНачисления.КонецПериода,
	|	KPI_НачисленияСотрудниковНачисления.Результат
	|ПОМЕСТИТЬ Документ
	|ИЗ
	|	Документ.KPI_НачисленияСотрудников.Начисления КАК KPI_НачисленияСотрудниковНачисления
	|ГДЕ
	|	KPI_НачисленияСотрудниковНачисления.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	&НачалоПериода КАК Период,
	|	KPI_ГрафикиРаботыСотрудниковСрезПоследних.Сотрудник,
	|	KPI_ГрафикиРаботыСотрудниковСрезПоследних.ГрафикРаботы
	|ПОМЕСТИТЬ ИзменениеГрафика
	|ИЗ
	|	РегистрСведений.KPI_ГрафикиРаботыСотрудников.СрезПоследних(
	|			&КонецПериода,
	|			Сотрудник В
	|				(ВЫБРАТЬ
	|					Документ.Сотрудник
	|				ИЗ
	|					Документ КАК Документ)) КАК KPI_ГрафикиРаботыСотрудниковСрезПоследних
	|
	|ОБЪЕДИНИТЬ
	|
	|ВЫБРАТЬ
	|	KPI_ГрафикиРаботыСотрудников.Период,
	|	KPI_ГрафикиРаботыСотрудников.Сотрудник,
	|	KPI_ГрафикиРаботыСотрудников.ГрафикРаботы
	|ИЗ
	|	РегистрСведений.KPI_ГрафикиРаботыСотрудников КАК KPI_ГрафикиРаботыСотрудников
	|ГДЕ
	|	KPI_ГрафикиРаботыСотрудников.Период > &НачалоПериода
	|	И KPI_ГрафикиРаботыСотрудников.Период <= &КонецПериода
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ИзменениеГрафика1.Сотрудник,
	|	ИзменениеГрафика1.ГрафикРаботы,
	|	ИзменениеГрафика1.Период КАК НачалоПериода,
	|	МИНИМУМ(ВЫБОР
	|			КОГДА ИзменениеГрафика2.Период ЕСТЬ NULL 
	|				ТОГДА &КонецПериода
	|			ИНАЧЕ ВЫБОР
	|					КОГДА ИзменениеГрафика2.Период > &КонецПериода
	|						ТОГДА &КонецПериода
	|					ИНАЧЕ ИзменениеГрафика2.Период
	|				КОНЕЦ
	|		КОНЕЦ) КАК КонецПериода,
	|	СУММА(KPI_ГрафикиРабот.Часы) КАК ЧасыПериодаНачисления
	|ПОМЕСТИТЬ ИсторияГрафиков
	|ИЗ
	|	ИзменениеГрафика КАК ИзменениеГрафика1
	|		ЛЕВОЕ СОЕДИНЕНИЕ ИзменениеГрафика КАК ИзменениеГрафика2
	|		ПО ИзменениеГрафика1.Период < ИзменениеГрафика2.Период
	|			И ИзменениеГрафика1.Сотрудник = ИзменениеГрафика2.Сотрудник
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.KPI_ГрафикиРабот КАК KPI_ГрафикиРабот
	|		ПО ИзменениеГрафика1.ГрафикРаботы = KPI_ГрафикиРабот.ГрафикРаботы
	|ГДЕ
	|	KPI_ГрафикиРабот.Дата МЕЖДУ &НачалоПериода И &КонецПериода
	|
	|СГРУППИРОВАТЬ ПО
	|	ИзменениеГрафика1.Сотрудник,
	|	ИзменениеГрафика1.ГрафикРаботы,
	|	ИзменениеГрафика1.Период
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВЫБОР
	|		КОГДА KPI_ПлановыеНачисления1.ДатаНачала < &НачалоПериода
	|			ТОГДА &НачалоПериода
	|		ИНАЧЕ KPI_ПлановыеНачисления1.ДатаНачала
	|	КОНЕЦ КАК НачалоПериода,
	|	МИНИМУМ(ВЫБОР
	|			КОГДА KPI_ПлановыеНачисления2.ДатаОкончания = ДАТАВРЕМЯ(1, 1, 1)
	|				ТОГДА &КонецПериода
	|			ИНАЧЕ KPI_ПлановыеНачисления2.ДатаОкончания
	|		КОНЕЦ) КАК КонецПериода,
	|	KPI_ПлановыеНачисления1.Сотрудник,
	|	KPI_ПлановыеНачисления1.Начисление,
	|	KPI_ПлановыеНачисления1.Сумма
	|ПОМЕСТИТЬ ПлановыеНачисления
	|ИЗ
	|	РегистрСведений.KPI_ПлановыеНачисления КАК KPI_ПлановыеНачисления1
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.KPI_ПлановыеНачисления КАК KPI_ПлановыеНачисления2
	|		ПО KPI_ПлановыеНачисления1.Сотрудник = KPI_ПлановыеНачисления2.Сотрудник
	|			И KPI_ПлановыеНачисления1.Начисление = KPI_ПлановыеНачисления2.Начисление
	|			И KPI_ПлановыеНачисления1.ДатаНачала < KPI_ПлановыеНачисления2.ДатаНачала
	|ГДЕ
	|	&УсловиеСотрудник
	|	И НЕ KPI_ПлановыеНачисления2.Начисление ЕСТЬ NULL 
	|
	|СГРУППИРОВАТЬ ПО
	|	ВЫБОР
	|		КОГДА KPI_ПлановыеНачисления1.ДатаНачала < &НачалоПериода
	|			ТОГДА &НачалоПериода
	|		ИНАЧЕ KPI_ПлановыеНачисления1.ДатаНачала
	|	КОНЕЦ,
	|	KPI_ПлановыеНачисления1.Сотрудник,
	|	KPI_ПлановыеНачисления1.Начисление,
	|	KPI_ПлановыеНачисления1.Сумма
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Документ.Сотрудник,
	|	Документ.ВидНачисления,
	|	ВЫБОР
	|		КОГДА ПлановыеНачисления.Начисление ЕСТЬ NULL 
	|			ТОГДА Документ.НачалоПериода
	|		ИНАЧЕ ПлановыеНачисления.НачалоПериода
	|	КОНЕЦ КАК НачалоПериода,
	|	ВЫБОР
	|		КОГДА ПлановыеНачисления.Начисление ЕСТЬ NULL 
	|			ТОГДА Документ.КонецПериода
	|		ИНАЧЕ ПлановыеНачисления.КонецПериода
	|	КОНЕЦ КАК КонецПериода,
	|	ВЫБОР
	|		КОГДА ПлановыеНачисления.Начисление ЕСТЬ NULL 
	|			ТОГДА Документ.Результат
	|		ИНАЧЕ ПлановыеНачисления.Сумма
	|	КОНЕЦ КАК СуммаНачисления
	|ПОМЕСТИТЬ ИсторияНачислений
	|ИЗ
	|	Документ КАК Документ
	|		ЛЕВОЕ СОЕДИНЕНИЕ ПлановыеНачисления КАК ПлановыеНачисления
	|		ПО Документ.ВидНачисления = ПлановыеНачисления.Начисление
	|			И Документ.Сотрудник = ПлановыеНачисления.Сотрудник
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ИсторияГрафиков.НачалоПериода,
	|	ИсторияГрафиков.Сотрудник КАК Сотрудник
	|ПОМЕСТИТЬ ВсеДатыИзменений
	|ИЗ
	|	ИсторияГрафиков КАК ИсторияГрафиков
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ИсторияГрафиков.КонецПериода,
	|	ИсторияГрафиков.Сотрудник
	|ИЗ
	|	ИсторияГрафиков КАК ИсторияГрафиков
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ИсторияНачислений.НачалоПериода,
	|	ИсторияНачислений.Сотрудник
	|ИЗ
	|	ИсторияНачислений КАК ИсторияНачислений
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ИсторияНачислений.КонецПериода,
	|	ИсторияНачислений.Сотрудник
	|ИЗ
	|	ИсторияНачислений КАК ИсторияНачислений
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВсеПериодыСотрудника1.Сотрудник,
	|	ВсеПериодыСотрудника1.НачалоПериода,
	|	МИНИМУМ(ВсеПериодыСотрудника2.НачалоПериода) КАК КонецПериода
	|ПОМЕСТИТЬ ВсеПериодыСотрудника
	|ИЗ
	|	ВсеДатыИзменений КАК ВсеПериодыСотрудника1
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВсеДатыИзменений КАК ВсеПериодыСотрудника2
	|		ПО ВсеПериодыСотрудника1.Сотрудник = ВсеПериодыСотрудника2.Сотрудник
	|			И ВсеПериодыСотрудника1.НачалоПериода < ВсеПериодыСотрудника2.НачалоПериода
	|ГДЕ
	|	НЕ ВсеПериодыСотрудника2.НачалоПериода ЕСТЬ NULL 
	|
	|СГРУППИРОВАТЬ ПО
	|	ВсеПериодыСотрудника1.Сотрудник,
	|	ВсеПериодыСотрудника1.НачалоПериода
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВсеПериодыСотрудника.Сотрудник,
	|	ВсеПериодыСотрудника.НачалоПериода,
	|	ВсеПериодыСотрудника.КонецПериода КАК КонецПериода,
	|	ИсторияГрафиков.ГрафикРаботы,
	|	ИсторияГрафиков.ЧасыПериодаНачисления
	|ПОМЕСТИТЬ ПериодыГрафики
	|ИЗ
	|	ИсторияГрафиков КАК ИсторияГрафиков
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВсеПериодыСотрудника КАК ВсеПериодыСотрудника
	|		ПО (ВЫБОР
	|				КОГДА ВсеПериодыСотрудника.НачалоПериода = ИсторияГрафиков.НачалоПериода
	|					ТОГДА ИСТИНА
	|				ИНАЧЕ ВЫБОР
	|						КОГДА ВсеПериодыСотрудника.КонецПериода <= ИсторияГрафиков.КонецПериода
	|							ТОГДА ИсторияГрафиков.КонецПериода = ВсеПериодыСотрудника.НачалоПериода
	|						ИНАЧЕ ЛОЖЬ
	|					КОНЕЦ
	|			КОНЕЦ)
	|			И ИсторияГрафиков.Сотрудник = ВсеПериодыСотрудника.Сотрудник,
	|	ИсторияНачислений КАК ИсторияНачислений
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПериодыГрафики.Сотрудник,
	|	ПериодыГрафики.ГрафикРаботы,
	|	ИсторияНачислений.ВидНачисления,
	|	ЕСТЬNULL(ИсторияНачислений.НачалоПериода, &НачалоПериода) КАК НачалоПериода,
	|	МИНИМУМ(ЕСТЬNULL(ИсторияНачислений.КонецПериода, &КонецПериода)) КАК КонецПериода,
	|	ИсторияНачислений.СуммаНачисления,
	|	ПериодыГрафики.ЧасыПериодаНачисления
	|ПОМЕСТИТЬ ПериодыНачислений
	|ИЗ
	|	ПериодыГрафики КАК ПериодыГрафики
	|		ЛЕВОЕ СОЕДИНЕНИЕ ИсторияНачислений КАК ИсторияНачислений
	|		ПО ПериодыГрафики.Сотрудник = ИсторияНачислений.Сотрудник
	|			И (ВЫБОР
	|				КОГДА ПериодыГрафики.НачалоПериода = ИсторияНачислений.НачалоПериода
	|					ТОГДА ИСТИНА
	|				ИНАЧЕ ВЫБОР
	|						КОГДА ПериодыГрафики.КонецПериода <= ИсторияНачислений.КонецПериода
	|							ТОГДА ПериодыГрафики.КонецПериода = ИсторияНачислений.НачалоПериода
	|						ИНАЧЕ ЛОЖЬ
	|					КОНЕЦ
	|			КОНЕЦ)
	|
	|СГРУППИРОВАТЬ ПО
	|	ПериодыГрафики.Сотрудник,
	|	ПериодыГрафики.ГрафикРаботы,
	|	ИсторияНачислений.ВидНачисления,
	|	ИсторияНачислений.СуммаНачисления,
	|	ПериодыГрафики.ЧасыПериодаНачисления,
	|	ЕСТЬNULL(ИсторияНачислений.НачалоПериода, &НачалоПериода)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПериодыНачислений.Сотрудник,
	|	ПериодыНачислений.ГрафикРаботы,
	|	ПериодыНачислений.ВидНачисления,
	|	ПериодыНачислений.НачалоПериода,
	|	СУММА(ВЫБОР
	|			КОГДА KPI_РабочееВремяСотрудников.Явка
	|					И KPI_РабочееВремяСотрудников.Часов <> 0
	|				ТОГДА 1
	|			ИНАЧЕ 0
	|		КОНЕЦ) КАК ОтработаноДней,
	|	СУММА(ЕСТЬNULL(KPI_РабочееВремяСотрудников.Часов, 0)) КАК ОтработаноЧасов,
	|	ПериодыНачислений.СуммаНачисления,
	|	ПериодыНачислений.ЧасыПериодаНачисления,
	|	ПериодыНачислений.КонецПериода
	|ИЗ
	|	ПериодыНачислений КАК ПериодыНачислений
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.KPI_РабочееВремяСотрудников КАК KPI_РабочееВремяСотрудников
	|		ПО ПериодыНачислений.Сотрудник = KPI_РабочееВремяСотрудников.Сотрудник
	|			И ПериодыНачислений.НачалоПериода < KPI_РабочееВремяСотрудников.Период
	|ГДЕ
	|	НЕ ПериодыНачислений.ВидНачисления ЕСТЬ NULL 
	|
	|СГРУППИРОВАТЬ ПО
	|	ПериодыНачислений.Сотрудник,
	|	ПериодыНачислений.ГрафикРаботы,
	|	ПериодыНачислений.ВидНачисления,
	|	ПериодыНачислений.НачалоПериода,
	|	ПериодыНачислений.СуммаНачисления,
	|	ПериодыНачислений.ЧасыПериодаНачисления,
	|	ПериодыНачислений.КонецПериода
	|
	|УПОРЯДОЧИТЬ ПО
	|	ПериодыНачислений.НачалоПериода";
				   
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса,"&УсловиеСотрудник","KPI_ПлановыеНачисления1.Сотрудник В (&Сотрудник)");
	Запрос = Новый Запрос(ТекстЗапроса);
	
	Запрос.УстановитьПараметр("ВидНачисления" ,ПараметрыРасчета.ВидНачисления);
	//Запрос.УстановитьПараметр("Сотрудник",ПараметрыРасчета.ОбъектУправления);
	Запрос.УстановитьПараметр("Сотрудник"     ,Начисления.ВыгрузитьКолонку("Сотрудник"));
	Запрос.УстановитьПараметр("НачалоПериода" ,НачалоМесяца(МесяцНачисления));
	Запрос.УстановитьПараметр("КонецПериода"  ,КонецМесяца(МесяцНачисления));
	Запрос.УстановитьПараметр("Ссылка"        ,Ссылка);
	
	ВыборкаПериодовНачислений = Запрос.Выполнить().Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	
	РасчетФиксированнойСуммой = Перечисления.KPI_ТипыРасчетаНачислений.ФиксированнойСуммой;
	
	// {Рарус menser 2017.04.27 тестовая доработка 
	//РасчетФиксированнойСуммой = Перечисления.KPI_ТипыРасчетаНачислений.Формула;
	
	ВидРасчета = ПолучитьЗначениеПоказателяСтрокой(ПараметрыРасчета);
	// }Рарус menser 2017.04.27
	
	Пока ВыборкаПериодовНачислений.Следующий() Цикл
		Движение              = Движения.KPI_Начисления.Добавить();
		Движение.ВидРасчета   = ВыборкаПериодовНачислений.ВидНачисления;
		Движение.Сотрудник    = ВыборкаПериодовНачислений.Сотрудник;
		Движение.ГрафикРаботы = ВыборкаПериодовНачислений.ГрафикРаботы;
		
		Движение.ПериодДействияНачало = ВыборкаПериодовНачислений.НачалоПериода;
	
		// {Рарус menser 2017.04.27 тестовая доработка 
		//Движение.ПериодДействияКонец  = ВыборкаПериодовНачислений.КонецПериода-1;
		Движение.ПериодДействияКонец  = ВыборкаПериодовНачислений.КонецПериода;	
		// }Рарус menser 2017.04.27
				
		Если ВыборкаПериодовНачислений.ВидНачисления.БазовыеВидыРасчета.Количество() Тогда
			КоличествоПериодовБазы        = ВыборкаПериодовНачислений.ВидНачисления.ПериодРасчетаБазы;

			Если КоличествоПериодовБазы > 0 Тогда
				НачалоБазовогоПериода = НачалоМесяца(ДобавитьМесяц(ВыборкаПериодовНачислений.НачалоПериода,-1*КоличествоПериодовБазы ));
				КонецБазовогоПериода  = КонецМесяца(ВыборкаПериодовНачислений.НачалоПериода);
			Иначе 
			    НачалоБазовогоПериода = НачалоМесяца(ДобавитьМесяц(ВыборкаПериодовНачислений.НачалоПериода,-2*КоличествоПериодовБазы ));
				КонецБазовогоПериода  = КонецМесяца(ДобавитьМесяц(ВыборкаПериодовНачислений.НачалоПериода,-1*КоличествоПериодовБазы));
			КонецЕсли;
			
			Движение.БазовыйПериодНачало  = НачалоБазовогоПериода;
			Движение.БазовыйПериодКонец   = КонецБазовогоПериода;
		КонецЕсли;
		
		Движение.ПериодРегистрации    = НачалоМесяца(МесяцНачисления);
		Движение.ОтработаноДней       = ВыборкаПериодовНачислений.ОтработаноДней;
		Движение.ОтработаноЧасов      = ВыборкаПериодовНачислений.ОтработаноЧасов;
		
		Если  ВыборкаПериодовНачислений.ВидНачисления.ТипРасчетаНачислений =  РасчетФиксированнойСуммой Тогда
			Если ВыборкаПериодовНачислений.ВидНачисления.УчитыватьОтработанноеВремя Тогда
				СтоимостьЧаса      = ВыборкаПериодовНачислений.СуммаНачисления /ВыборкаПериодовНачислений.ЧасыПериодаНачисления;
				Движение.Результат = ВыборкаПериодовНачислений.ОтработаноЧасов * СтоимостьЧаса;
			Иначе 
				Движение.Результат = ВыборкаПериодовНачислений.СуммаНачисления;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Движения.KPI_Начисления.Записать();
	
	РасчитатьНачисленияПоФормуле();
	
	//Подготовим расчитаные строки к загрузке
	РасчитанныеНачисления = Движения.KPI_Начисления.Выгрузить();
	РасчитанныеНачисления.Свернуть("ВидРасчета,Сотрудник","ОтработаноДней,ОтработаноЧасов,Результат");
	
	КритерийПоиска  = Новый Структура("ВидНачисления,Сотрудник");
	Для Каждого Стр из РасчитанныеНачисления Цикл
		КритерийПоиска.ВидНачисления    = Стр.ВидРасчета;
		КритерийПоиска.Сотрудник = Стр.Сотрудник;
		НайденныеСтроки = Начисления.НайтиСтроки(КритерийПоиска);	
		ЗаполнитьЗначенияСвойств(НайденныеСтроки[0],Стр);	
	КонецЦикла;
	
	Движения.KPI_Начисления.Очистить();
	Движения.Записать();
	
КонецПроцедуры

Процедура РасчитатьНачисленияПоФормуле()
	
	КритерийПоиска = Новый Структура("НомерСтроки");
	
	//ВидыНачислений = Движения.KPI_Начисления.Выгрузить();
	ВидыНачислений = Начисления.Выгрузить();
	//ВидыНачислений.Свернуть("ВидРасчета");
	ВидыНачислений.Свернуть("ВидНачисления");
	ОсновныеНачисления       = Новый Массив;
	ДополнительныеНачисления = Новый Массив;
	
	РасчетПоФормуле = Перечисления.KPI_ТипыРасчетаНачислений.Формула;
	Для Каждого ВидНачисления из ВидыНачислений Цикл
		Если ВидНачисления.ВидНачисления.ТипРасчетаНачислений = РасчетПоФормуле Тогда
			ДополнительныеНачисления.Добавить(ВидНачисления.ВидНачисления);
		Иначе 
			ОсновныеНачисления.Добавить(ВидНачисления.ВидНачисления);
		КонецЕсли;
	КонецЦикла;
	
	ТекстЗапроса = "ВЫБРАТЬ
	|	KPI_НачисленияБазаKPI_Начисления.НомерСтроки,
	|	KPI_НачисленияБазаKPI_Начисления.РезультатБаза
	|ИЗ
	|	РегистрРасчета.KPI_Начисления.БазаKPI_Начисления(&Изм, &Изм, , Регистратор = &Регистратор) КАК KPI_НачисленияБазаKPI_Начисления";
	
	Изм    = Новый Массив;
	Изм.Добавить("Сотрудник");
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("Изм"         , Изм);
	Запрос.УстановитьПараметр("Регистратор" , Ссылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	КонецПериодаНачислений = КонецМесяца(МесяцНачисления);
	НачалоПериода          = НачалоМесяца(МесяцНачисления);
	КонецПериода           = КонецПериодаНачислений;
	Сотрудники             = Начисления.ВыгрузитьКолонку("Сотрудник");
	ПланыФакты             = KPI_ОбщегоНазначенияСервер.ПолучитьПланыИФакты(КонецПериодаНачислений, НачалоПериода, КонецПериода, Периодичность, Сотрудники);
	АдресПланФакты         = ПоместитьВоВременноеХранилище(ПланыФакты);
	
	//Расчитаем дополнительные начисления
	Для Каждого Стр из Движения.KPI_Начисления Цикл
	
		Если ДополнительныеНачисления.Найти(Стр.ВидРасчета) = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		КритерийПоиска.НомерСтроки = Стр.НомерСтроки;
		
		Выборка.НайтиСледующий(КритерийПоиска);		
		
		РазмерБазы = Выборка.РезультатБаза;
		
		Стр.Результат = РассчитатьНачислениеПоФормуле(Стр, ПланыФакты, Периодичность, АдресПланФакты, РазмерБазы);
		
		Выборка.Сбросить();
		
	КонецЦикла;
	//
	
	Движения.KPI_Начисления.Записать(,Истина);
	
КонецПроцедуры

Функция РассчитатьНачислениеПоФормуле(СтрокаНачислений, ПланыФакты, Периодичность, АдресПланФакты, РазмерБазы)
	
	Начисленно               = 0;
	Сотрудник                = СтрокаНачислений.Сотрудник;
	ВидНачисления            = СтрокаНачислений.ВидРасчета;
	ФормулаРасчетаНачисления = ВидНачисления.ФормулаРасчета; //1.1
	
	//Разобьем формулу на части со шкалами
	ФормулыШкал = Новый СписокЗначений;
	
	Если Найти(ФормулаРасчетаНачисления, "<") Тогда
		
		Пока Истина Цикл
			ШкалаНачало = Найти(ФормулаРасчетаНачисления, "<");
			
			Если ШкалаНачало = 0 Тогда
				Прервать;
			Иначе 
				ШкалаКонец         = Найти(ФормулаРасчетаНачисления, ">");
				ФормулаСоШкалой    = Сред(ФормулаРасчетаНачисления, ШкалаНачало, ШкалаКонец - ШкалаНачало + 1);
				ШкалаКонец         = Найти(ФормулаСоШкалой, ">");
				Разделитель        = Найти(ФормулаСоШкалой, ";");
				ШкалаПредставление = Сред(ФормулаСоШкалой, 2, Разделитель - 2);
				ШкалаПредставление = СтрЗаменить(ШкалаПредставление, "[", "");
				ШкалаПредставление = СтрЗаменить(ШкалаПредставление, "]", "");

				Шкала              = ВидНачисления.ШкалыРасчета.Найти(ШкалаПредставление, "Представление").Шкала;
				
				Формула            = Сред(ФормулаСоШкалой, Разделитель + 1, ШкалаКонец - Разделитель - 1);
				
				ЗначениеФормулы = РассчитатьФормулуБезШкалы(Формула, СтрокаНачислений, ПланыФакты, Периодичность, АдресПланФакты, РазмерБазы);
				ЗначениеПоШкале = Справочники.KPI_Шкалы.ЗначениеРесурсаЦелевогоПоказателяПоШкале(Шкала, ЗначениеФормулы);
				ФормулаРасчетаНачисления = СтрЗаменить(ФормулаРасчетаНачисления, ФормулаСоШкалой, Формат(ЗначениеПоШкале, "ЧГ=;ЧН=0"));
			КонецЕсли;
		КонецЦикла;
		
	КонецЕсли;
	
	Возврат РассчитатьФормулуБезШкалы(ФормулаРасчетаНачисления, СтрокаНачислений, ПланыФакты, Периодичность, АдресПланФакты, РазмерБазы);
КонецФункции

Функция РассчитатьФормулуБезШкалы(Формула, СтрокаНачислений, ПланыФакты, Периодичность, АдресПланФакты, РазмерБазы)
	
	Сотрудник                = СтрокаНачислений.Сотрудник;
	ВидНачисления            = СтрокаНачислений.ВидРасчета;
	
	// Представления показателей расчета
	Для Каждого СтрокаПоказательНачисления Из ВидНачисления.ПоказателиРасчета Цикл   
		ПоказательНачисления     = СтрокаПоказательНачисления.ПоказательРасчета;	
		ПредставлениеПоказателяНачисления = "[ПР:"+СтрокаПоказательНачисления.Представление+"]"; //1.2
		
		Если Найти(Формула, ПредставлениеПоказателяНачисления) Тогда
			// Обработаем предопределенные показатели
			Если СтрокаПоказательНачисления.ПоказательРасчета = Справочники.KPI_ПоказателиРасчета.БазовыеНачисления Тогда
				ЗначениеПоказателяНачисления = РазмерБазы;	
			Иначе 
				ЗначениеПоказателяНачисления = Справочники.KPI_ПоказателиРасчета.ПолучитьЗначениеПоказателяНачисления(
					Сотрудник, ПоказательНачисления, ПланыФакты, АдресПланФакты);
			КонецЕсли;	
			
			ЗначениеПоказателяСтрокой = ПолучитьЗначениеПоказателяСтрокой(ЗначениеПоказателяНачисления);
			Формула = СтрЗаменить(Формула, ПредставлениеПоказателяНачисления, ЗначениеПоказателяСтрокой);
		КонецЕсли;
	КонецЦикла;
	
	// Представления целевых показателей
	Для Каждого СтрокаЦелевойПоказатель Из ВидНачисления.ЦелевыеПоказатели Цикл
		ПредставлениеЦелевогоПоказателя = "[ЦП:"+СтрокаЦелевойПоказатель.Представление+"]";
		
		Если Найти(Формула, ПредставлениеЦелевогоПоказателя) Тогда
			
			ЗначениеЦелевогоПоказателя = Справочники.KPI_ЦелевыеПоказатели.РассчитатьЗначениеЦелевогоПоказателя(
				СтрокаЦелевойПоказатель, Сотрудник, ПланыФакты, АдресПланФакты);
			
			ЗначениеПоказателяСтрокой = ПолучитьЗначениеПоказателяСтрокой(ЗначениеЦелевогоПоказателя);
			Формула = СтрЗаменить(Формула, ПредставлениеЦелевогоПоказателя, ЗначениеПоказателяСтрокой);
		КонецЕсли;
	КонецЦикла;
	
	//Подготовим строку к вычислению результата
	Формула = СтрЗаменить(Формула, ",", ".");
	Формула = СтрЗаменить(Формула, " ", "");
	
	Попытка
		Возврат Вычислить(Формула);
	Исключение
		Сообщить("Не удалось рассчитать формулу в строке "+СтрокаНачислений.НомерСтроки);
		Возврат 0;
	КонецПопытки;
	
КонецФункции

Функция ПолучитьЗначениеПоказателяСтрокой(ЗначениеПоказателя)
	
	ЗначениеПоказателяСтрокой = "";
	Если ЗначениеЗаполнено(ЗначениеПоказателя) Тогда
		ЗначениеПоказателяСтрокой = Формат(ЗначениеПоказателя, "ЧГ=");  
	Иначе 
		ЗначениеПоказателяСтрокой = "0";
	КонецЕсли;
	
	Возврат ЗначениеПоказателяСтрокой;
	
КонецФункции

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	Движения.KPI_Начисления.Записывать                      = Истина;
	Движения.KPI_Начисления.Записать();
	
	Для Каждого Начисление из Начисления Цикл
		
		Движение = Движения.KPI_Начисления.Добавить();
		Движение.Регистратор          = Ссылка                  ;
		Движение.ВидРасчета           = Начисление.ВидНачисления;
		Движение.Сотрудник            = Начисление.Сотрудник    ;
		Движение.ПериодДействияНачало = Начисление.НачалоПериода;
		Движение.ПериодДействияКонец  = Начисление.КонецПериода ;
		Движение.БазовыйПериодНачало  = Начисление.НачалоПериода;
		Движение.БазовыйПериодКонец   = Начисление.КонецПериода ;
		Движение.ПериодРегистрации    = Дата;
		Движение.Результат            = Начисление.Результат;
		Движение.Сторно               = Ложь                    ;
		
	КонецЦикла;
	
	
	
КонецПроцедуры

