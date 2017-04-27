//Процедура вывода сообщения пользователю
//Параметры:
// ТекстСообщения     - тип строка
// Отказ              - тип булево
// Заголовок          - тип строка
// Статус             - статус сообщения
// ВызыватьИсключение - тип Булево, признак вызова исключения
//Возвращаемое значение:
// нет
Процедура СообщитьОбОшибке(Знач ТекстСообщения, Отказ = Ложь, Заголовок = "", Знач Статус = Неопределено, ВызыватьИсключение = Истина) Экспорт

	Если Статус = Неопределено Тогда
		Статус = СтатусСообщения.Важное;
	КонецЕсли;

	ТекстСообщения = СформироватьТекстСообщения(ТекстСообщения);
	Отказ = Истина;

	#Если ВнешнееСоединение Тогда

		Если ВызыватьИсключение Тогда
			Если ЗначениеЗаполнено(Заголовок) Тогда
				ТекстСообщения = Заголовок + Символы.ПС + ТекстСообщения;
				Заголовок = "";
			КонецЕсли;

			ВызватьИсключение (ТекстСообщения);
		КонецЕсли;

	#Иначе

		Если ЗначениеЗаполнено(Заголовок) Тогда
			Сообщить(Заголовок);
			Заголовок = "";
		КонецЕсли;

		Сообщить(ТекстСообщения, Статус);

	#КонецЕсли

КонецПроцедуры // СообщитьОбОшибке()

// Функция убирает из текста сообщения служебную информацию
//
// Параметры
//  ТекстСообщения, Строка, исходный текст сообщения//
// Возвращаемое значение:
//   Строка
//
Функция СформироватьТекстСообщения(Знач ТекстСообщения)

	НачалоСлужебногоСообщения    = Найти(ТекстСообщения, "{");
	ОкончаниеСлужебногоСообщения = Найти(ТекстСообщения, "}:");

	Если ОкончаниеСлужебногоСообщения > 0
		И НачалоСлужебногоСообщения > 0
		И НачалоСлужебногоСообщения < ОкончаниеСлужебногоСообщения Тогда

		ТекстСообщения = Лев(ТекстСообщения, (НачалоСлужебногоСообщения - 1)) +
		                 Сред(ТекстСообщения, (ОкончаниеСлужебногоСообщения + 2));

	КонецЕсли;

	Возврат СокрЛП(ТекстСообщения);

КонецФункции // ()

//Функция возрашает количество дней в месяце
//Параметры
//	Дата - тип дата
//Возвращаемое значение
//	КоличествоДнейМесяца - тип число
Функция КоличествоДнейМесяца(Дата) Экспорт
	
	НачалоМесяца         = НачалоМесяца(Дата);
	КонецМесяца          = КонецМесяца(Дата);
	КоличествоДнейМесяца = (КонецМесяца - НачалоМесяца+1)/86400;
	
	Возврат КоличествоДнейМесяца;
	
КонецФункции

//Функция получает дату в следующем периоде планирования
//Параметры:
//	Дата          - тип дата, дата из периода планирования
//	Период        - тип ПеречислениеСсылка.KPI_ПериодичностьПланирования, периодичность планирования
//	КолВоПериодов - тип число, количество периодов на которое сдвигается дата
//Возвращаемое значение
// Дата из следующего периода, тип дата
Функция ПолучитьДатуВСледующемПериоде(Знач Дат, Период, КолВоПериодов) Экспорт
	
	Если Период = ПредопределенноеЗначение("Перечисление.KPI_ПериодичностьПланирования.День") Тогда
		Дат = Дат + (86400 * КолВоПериодов);
	ИначеЕсли Период = ПредопределенноеЗначение("Перечисление.KPI_ПериодичностьПланирования.Неделя") Тогда
		Дат = Дат + (86400 * 7 * КолВоПериодов);
	ИначеЕсли Период = ПредопределенноеЗначение("Перечисление.KPI_ПериодичностьПланирования.Месяц") Тогда
		Дат = ДобавитьМесяц(Дат, 1 * КолВоПериодов);
	ИначеЕсли Период = ПредопределенноеЗначение("Перечисление.KPI_ПериодичностьПланирования.Квартал") Тогда
		Дат = ДобавитьМесяц(Дат, 3 * КолВоПериодов);
	ИначеЕсли Период = ПредопределенноеЗначение("Перечисление.KPI_ПериодичностьПланирования.Полугодие") Тогда
		Дат = ДобавитьМесяц(Дат, 6 * КолВоПериодов);
	ИначеЕсли Период = ПредопределенноеЗначение("Перечисление.KPI_ПериодичностьПланирования.Год") Тогда
		Дат = ДобавитьМесяц(Дат, 12 * КолВоПериодов);
	ИначеЕсли Не ЗначениеЗаполнено(Дат) Тогда 	
		Дат = ТекущаяДата();
	ИначеЕсли Период = ПредопределенноеЗначение("Перечисление.KPI_ПериодичностьПланирования.ПустаяСсылка") Тогда
		Дат = Дат;
	КонецЕсли;
	
	Возврат Дат;
	
КонецФункции

//Функция получает дату в преддыдущем периоде планирования
//Параметры:
//	Дата          - тип дата, дата из периода планирования
//	Период        - тип ПеречислениеСсылка.KPI_ПериодичностьПланирования, периодичность планирования
//	КолВоПериодов - тип число, количество периодов на которое сдвигается дата
//Возвращаемое значение
// Дата из следующего периода, тип дата
Функция ПолучитьДатуВПредыдущемПериоде(Знач Дат, Период, КолВоПериодов) Экспорт
	
	Если Период = ПредопределенноеЗначение("Перечисление.KPI_ПериодичностьПланирования.День") Тогда
		Дат = Дат - (86400 * КолВоПериодов);
	ИначеЕсли Период = ПредопределенноеЗначение("Перечисление.KPI_ПериодичностьПланирования.Неделя") Тогда
		Дат = Дат - (86400 * 7 * КолВоПериодов);
	ИначеЕсли Период = ПредопределенноеЗначение("Перечисление.KPI_ПериодичностьПланирования.Месяц") Тогда
		Дат = ДобавитьМесяц(Дат, -1 * КолВоПериодов);
	ИначеЕсли Период = ПредопределенноеЗначение("Перечисление.KPI_ПериодичностьПланирования.Квартал") Тогда
		Дат = ДобавитьМесяц(Дат, -3 * КолВоПериодов);
	ИначеЕсли Период = ПредопределенноеЗначение("Перечисление.KPI_ПериодичностьПланирования.Полугодие") Тогда
		Дат = ДобавитьМесяц(Дат, -6 * КолВоПериодов);
	ИначеЕсли Период = ПредопределенноеЗначение("Перечисление.KPI_ПериодичностьПланирования.Год") Тогда
		Дат = ДобавитьМесяц(Дат, -12 * КолВоПериодов);
	ИначеЕсли Не ЗначениеЗаполнено(Дат) Тогда 	
		Дат = ТекущаяДата();
	ИначеЕсли Период = ПредопределенноеЗначение("Перечисление.KPI_ПериодичностьПланирования.ПустаяСсылка") Тогда
		Дат = Дат;
	КонецЕсли;
	
	Возврат Дат;
	
КонецФункции

//Удаляет элемент отбора динамического списка
//
//Параметры:
//Список  - обрабатываемый динамический список,
//ИмяПоля - имя поля компоновки, отбор по которому нужно удалить
//
Процедура УдалитьЭлементОтбораСписка(Список, ИмяПоля) Экспорт
	
	ЭлементыДляУдаления = Новый Массив;
	
	Если Тип("ДинамическийСписок") = ТипЗнч(Список) Тогда
		Отбор = Список.Отбор;
	Иначе 
		Отбор = Список;
	КонецЕсли;
	
	ЭлементыОтбора = Отбор.Элементы;
	ПолеКомпоновки = Новый ПолеКомпоновкиДанных(ИмяПоля);
	Для Каждого ЭлементОтбора Из ЭлементыОтбора Цикл
		Если ТипЗнч(ЭлементОтбора) = Тип("ЭлементОтбораКомпоновкиДанных")
			И ЭлементОтбора.ЛевоеЗначение = ПолеКомпоновки Тогда
			ЭлементыДляУдаления.Добавить(ЭлементОтбора);
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого ЭлементОтбораДляУдаления Из ЭлементыДляУдаления Цикл
		ЭлементыОтбора.Удалить(ЭлементОтбораДляУдаления);
	КонецЦикла;
	
КонецПроцедуры // УдалитьЭлементОтбораСписка()

//Устанавливает элемент отбор динамического списка
//
//Параметры:
//Список			- обрабатываемый динамический список,
//ИмяПоля			- имя поля компоновки, отбор по которому нужно установить,
//ВидСравнения		- вид сравнения отбора, по умолчанию - Равно,
//ПравоеЗначение 	- значение отбора
//
Процедура УстановитьЭлементОтбораСписка(Список, ИмяПоля, ПравоеЗначение, ВидСравнения = Неопределено, Представление = "") Экспорт
	
	Если Тип("ДинамическийСписок") = ТипЗнч(Список) Тогда
		Отбор = Список.Отбор;
	Иначе 
		Отбор = Список;
	КонецЕсли;
	
	ЭлементОтбора = Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбора.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных(ИмяПоля);	
	ЭлементОтбора.ВидСравнения   = ?(ВидСравнения = Неопределено, ВидСравненияКомпоновкиДанных.Равно, ВидСравнения);
	ЭлементОтбора.Использование  = Истина;
	ЭлементОтбора.ПравоеЗначение = ПравоеЗначение;
	ЭлементОтбора.Представление  = Представление;
	
КонецПроцедуры // УстановитьЭлементОтбораСписка()

//Изменяет элемент отбора динамического списка
//
//Параметры:
//Список         - обрабатываемый динамический список,
//ИмяПоля        - имя поля компоновки, отбор по которому нужно установить,
//ВидСравнения   - вид сравнения отбора, по умолчанию - Равно,
//ПравоеЗначение - значение отбора,
//Установить     - признак необходимости установить отбор
//
Процедура ИзменитьЭлементОтбораСписка(Список, ИмяПоля, ПравоеЗначение = Неопределено, Установить = Ложь, ВидСравнения = Неопределено) Экспорт
	
	УдалитьЭлементОтбораСписка(Список, ИмяПоля);
	
	Если Установить Тогда
		УстановитьЭлементОтбораСписка(Список, ИмяПоля, ПравоеЗначение, ВидСравнения);
	КонецЕсли;
	
КонецПроцедуры // ИзменитьЭлементОтбораСписка()