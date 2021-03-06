// Серия используемых ключей
Функция Серия() Экспорт
	Возврат "E649";
КонецФункции

// Тип контроля лицензий
Функция ТолькоНаличиеКлюча() Экспорт
	// Если проверяем только наличие ключа, без ограничения 
	// доступа по количеству лицензий
	
	Возврат Истина; 
	
	//Возврат Ложь;
КонецФункции

// Подключение компоненты СЛК. Для отладки реализована загрузка из 
// файла на диске - в реальной работе рекомендуется использовать загрузку 
// из макета
Процедура ПодключитьКомпоненту() Экспорт
	
	Если НЕ ПодключитьВнешнююКомпоненту("ОбщийМакет.KPI_КомпонентаСЛК", "Licence") Тогда
		СисИнфо = Новый СистемнаяИнформация;
		ВызватьИсключение "Ошибка подключения компоненты СЛК " + СисИнфо.ТипПлатформы;
	КонецЕсли;
	
	////
	//// Для отладки загрузка из файла
	////
	//КаталогКомпоненты = "d:\Projects\Licence\v2.0\";
	//
	//СисИнфо = Новый СистемнаяИнформация;
	//Если СисИнфо.ТипПлатформы = ТипПлатформы.Windows_x86 Тогда
	//	Компонента = "LicenceAddIn.dll";
	//ИначеЕсли СисИнфо.ТипПлатформы = ТипПлатформы.Windows_x86_64 Тогда
	//	Компонента = "LicenceAddIn64.dll";
	//Иначе
	//	ВызватьИсключение "Платформа " + СисИнфо.ТипПлатформы + " не поддерживается"; // Пока только Windows
	//КонецЕсли;
	//
	//Если НЕ ПодключитьВнешнююКомпоненту(КаталогКомпоненты + Компонента, "Licence", ТипВнешнейКомпоненты.Native) Тогда
	//	ВызватьИсключение "Ошибка подключения компоненты СЛК " + СисИнфо.ТипПлатформы;
	//КонецЕсли;
КонецПроцедуры

// Получение менеджера защищенных объектов СЛК
Функция МенеджерОбъектов(Режим = Ложь) Экспорт
	// Пытаемся получить сохраненный ранее объект
	Попытка
		МенеджерОбъектов = ПолучитьИзВременногоХранилища(ПараметрыСеанса.KPI_МенеджерОбъектов);
	Исключение
		МенеджерОбъектов = Неопределено;
	КонецПопытки;
	
	
	// Если не получили (первое создание или истек период) создаем новый
	Если МенеджерОбъектов = Неопределено Тогда
		ПодключитьКомпоненту();
		//
		// Создание объекта компоненты 
		МенеджерЛицензий = Новый("AddIn.Licence.LicenceExtension20");
		
		// Установка параметров сервера СЛК вручную
		//Константы.KPI_АдресСервераСЛК.Установить("###.###.###.###");
		//Константы.KPI_ПортСервераСЛК.Установить(#####);
		
		// Запуск
		МенеджерЛицензий.ОкноУстановкиСвязи = Ложь;
		МенеджерЛицензий.ПараметрыСвязи = "host=" + Константы.KPI_АдресСервераСЛК.Получить() + ";port=" + Формат(Константы.KPI_ПортСервераСЛК.Получить(), "ЧГ=");
		
		Если НЕ МенеджерЛицензий.Запуск("E649") Тогда
			//ВызватьИсключение МенеджерЛицензий.ПолучитьОписаниеОшибки();
			Возврат Неопределено;
		КонецЕсли;
		
		// Создание менеджера объектов
		Попытка
			МенеджерОбъектов = ВнешниеОбработки.Создать(МенеджерЛицензий.МенеджерОбъектов, Режим);
			МенеджерОбъектов.УстановитьМенеджерЛицензий(МенеджерЛицензий);
		Исключение
			ВызватьИсключение "Ошибка создания менеджера объектов СЛК: " + ОписаниеОшибки();
		КонецПопытки;
		
		Попытка
			// Помещаем менеджер объектов в хранилище и	запоминаем ссылку в параметре сеанса
			ПараметрыСеанса.KPI_МенеджерОбъектов = ПоместитьВоВременноеХранилище(МенеджерОбъектов, Новый УникальныйИдентификатор());
		Исключение
		КонецПопытки;
	
	КонецЕсли; // МенеджерОбъектов = Неопределено
	
	Возврат МенеджерОбъектов;
КонецФункции

// Возвращает значение истина, если система успешно запущена
Функция ЗапускСистемыЗащиты() Экспорт
	//ПодключитьКомпоненту();
	//
	//// Создание объекта компоненты 
	//МенеджерЛицензий = Новый("AddIn.Licence.LicenceExtension20");
	//
	//// Запуск
	//МенеджерЛицензий.ОкноУстановкиСвязи = Ложь;
	//МенеджерЛицензий.ПараметрыСвязи = "host=" + Константы.KPI_АдресСервераСЛК.Получить() + ";port=" + Строка(Формат(Константы.KPI_ПортСервераСЛК.Получить(), "ЧГ="));
	//
	//Если Не МенеджерЛицензий.Запуск("E649") Тогда
	//	Возврат Ложь;
	//Иначе
	//	Возврат Истина;
	//КонецЕсли;
КонецФункции

// Возвращает значение истина, если ключ защиты присутствует
Функция НаличиеКлючаЗащиты() Экспорт 
	Менеджер = МенеджерОбъектов();
	
	Если Менеджер = Неопределено Тогда
		Возврат Новый Структура("Ключ, ОписаниеОшибки", Ложь, "Не найден сервер СЛК.");
	КонецЕсли;
	
	Попытка
		Менеджер.ПроверитьЛицензиюСеанса(ТолькоНаличиеКлюча());
		Возврат Новый Структура("Ключ, ОписаниеОшибки", Истина, "");
	Исключение
		//Сообщить(Менеджер.ПолучитьОписаниеОшибки());
		Возврат Новый Структура("Ключ, ОписаниеОшибки", Ложь, "Не найден аппаратный ключ защиты на сервере СЛК.");
	КонецПопытки;
КонецФункции

// Возврат версии компоненты СЛК
Функция Версия() Экспорт
	ПодключитьКомпоненту();
	МенеджерЛицензий = Новый("AddIn.Licence.LicenceExtension20");
	
	СисИнфо = Новый СистемнаяИнформация;
	Возврат МенеджерЛицензий.Версия + " (" + СисИнфо.ТипПлатформы + ")";
КонецФункции

// Информация о текущем сеансе работы
Функция ДанныеСеанса() Экспорт
	НомерСеанса = НомерСеансаИнформационнойБазы();
	
	Сеансы = ПолучитьСеансыИнформационнойБазы();
	Для Каждого С Из Сеансы Цикл
		Если С.НомерСеанса = НомерСеанса Тогда
			Сеанс = С;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Строка(Сеанс.НомерСеанса) + "," + Сеанс.ИмяКомпьютера + "," + Сеанс.ИмяПриложения + "," + Сеанс.Пользователь;
КонецФункции

// Запуск СЛК
Процедура Запуск() Экспорт
	Менеджер = МенеджерОбъектов();
	Менеджер.ПроверитьЛицензиюСеанса(ТолькоНаличиеКлюча());
	
	// Загрузка данных из общего макета
	Менеджер.ЗагрузитьИзОбщегоМакета(Метаданные.ОбщиеМакеты.KPI_ДанныеСЛК);
	// Возможна загрузка как по объекту описания метаданных, так и по имени макета:
	//Менеджер.ЗагрузитьИзОбщегоМакета("KPI_ДанныеСЛК");
КонецПроцедуры

// Проверка лицензии сеанса
Процедура ПроверитьЛицензию() Экспорт
	МенеджерОбъектов().ПроверитьЛицензиюСеанса(ТолькоНаличиеКлюча());
КонецПроцедуры

// Отладочная информация
Функция ПолучитьОтладочнуюСтроку() Экспорт
	Возврат МенеджерОбъектов().ПолучитьОтладочнуюСтроку();
КонецФункции

// Создание объекта по его имени в файле данных
Функция СоздатьОбъект(Имя) Экспорт
	Возврат МенеджерОбъектов().СоздатьОбъект(Имя);
КонецФункции

//  Получение значений лицензионных параметров
Функция ПолучитьЗначениеПараметра(Имя) Экспорт
	Возврат МенеджерОбъектов().ПолучитьЗначениеПараметра(Имя);
КонецФункции

// Чтение памяти ключа защиты
Функция ПрочитатьПамятьКлюча(Пароль) Экспорт
	Возврат МенеджерОбъектов().ПрочитатьПамятьКлюча(Пароль);
КонецФункции

// Запись памяти ключа защиты
Процедура ЗаписатьПамятьКлюча(Пароль, Данные) Экспорт
	МенеджерОбъектов().ЗаписатьПамятьКлюча(Пароль, Данные);
КонецПроцедуры

// Установка паролей на память ключа
Процедура УстановитьПаролиНаПамятьКлюча(НаЧтениеСтарый, НаЗаписьСтарый, НаЧтениеНовый, НаЗаписьНовый) Экспорт
	МенеджерОбъектов().УстановитьПаролиНаПамятьКлюча(НаЧтениеСтарый, НаЗаписьСтарый, НаЧтениеНовый, НаЗаписьНовый);
КонецПроцедуры

// Обнуление памяти ключа защиты и сброс паролей
Процедура ОбнулитьПамятьКлюча() Экспорт
	МенеджерОбъектов().ОбнулитьПамятьКлюча();
КонецПроцедуры

// Получение списка ключей на сервере СЛК
Функция ПолучитьСписокКлючей() Экспорт
	Возврат МенеджерОбъектов().ПолучитьСписокКлючей();
КонецФункции

// Получение общего количество лицензий на сервере СЛК
Функция ПолучитьОбщееКоличествоЛицензий() Экспорт
	Возврат МенеджерОбъектов().ПолучитьОбщееКоличествоЛицензий();
КонецФункции

// Получение номера ключа, лицензию которого занял сеанс
Функция ПолучитьНомерКлюча() Экспорт
	Возврат МенеджерОбъектов().ПолучитьНомерКлюча();
КонецФункции

//Процедура сообщает количество лицензции СЛК
//Параметры:
// нет
Процедура ПолучитьКолВоЛицензийСОбработки() Экспорт
	Если ПараметрыСеанса.KPI_РежимЗащиты Тогда
		Лицензии = KPI_МодульСЛК.СоздатьОбъект("KPI_Лицензии");
	Иначе 
		Лицензии = Обработки.KPI_Лицензии.Создать();
	КонецЕсли;
	
	Лицензии.СообщитьКолВоЛицензий();
КонецПроцедуры

//Процедура задает параметры сервера СЛК
// IP-адрес сервера
// Порт сервера СЛК
//Параметры:
// нет
Процедура УстановитьКоординатыСервераСЛК(Структ) Экспорт 
	Константы.KPI_АдресСервераСЛК.Установить(Структ.Хост);
	Константы.KPI_ПортСервераСЛК.Установить(Структ.Порт);
КонецПроцедуры

//Процедура выводит параметры сервера СЛК
//Параметры:
// нет
Процедура ПрочитатьКоординатыСервераСЛК() Экспорт 
	Сообщить(Константы.KPI_АдресСервераСЛК.Получить() + ":" + Формат(Константы.KPI_ПортСервераСЛК.Получить(), "ЧГ="));
КонецПроцедуры

//Функция возвращает адрес менеджера защиищенных обработок
//Параметры:
// нет
//Возвращаемое значение:
// Менеджер объектов
Функция ПолучитьАдресМенеджера() Экспорт 
	Возврат ПараметрыСеанса.KPI_МенеджерОбъектов;
КонецФункции

// Получение полного имени объекта для доступа к формам
Функция ПолучитьПолноеИмяЗащищенногоОбъекта(Имя) Экспорт  
	Объект = СоздатьОбъект(Имя);
	Возврат Объект.Метаданные().ПолноеИмя();
КонецФункции


