&НаКлиенте
Перем ТекДанные, ФлагИзмененияПрав, МассивСтруктур, ТекущееДерево;


&НаСервере
Процедура ОбновитьДеревоПравДоступа()
	Дерево = РеквизитФормыВЗначение("ПраваДоступа");
	
	Дерево.Строки.Очистить();
	
	
	// Права на планы
	Планы = Дерево.Строки.Добавить();
	Планы.Представление = "Планы";
	Планы.Картинка = 5;
	
	Право = Планы.Строки.Добавить();
	Право.Представление = "Просмотр"; 
	Право.ВидПрава = Перечисления.KPI_ВидыПравДоступа.ПланыПросмотр;
	Право.Картинка = 0;
	
	Право = Планы.Строки.Добавить();
	Право.Представление = "Редактирование"; 
	Право.ВидПрава = Перечисления.KPI_ВидыПравДоступа.ПланыРедактирование;
	Право.Картинка = 1;
	
	Право = Планы.Строки.Добавить();
	Право.Представление = "Утверждение"; 
	Право.ВидПрава = Перечисления.KPI_ВидыПравДоступа.ПланыУтверждение;
	Право.Картинка = 2;
	
	Право = Планы.Строки.Добавить();
	Право.Представление = "Отмена утверждения"; 
	Право.ВидПрава = Перечисления.KPI_ВидыПравДоступа.ПланыОтменаУтверждения;
	Право.Картинка = 3;
	
	// Права на смарт задачи
	СмартЗадачи = Дерево.Строки.Добавить();
	СмартЗадачи.Представление = "Смарт задачи";
	СмартЗадачи.Картинка = 6;
	
	Право = СмартЗадачи.Строки.Добавить();
	Право.Представление = "Просмотр"; 
	Право.ВидПрава = Перечисления.KPI_ВидыПравДоступа.СмартЗадачиПросмотр;
	Право.Картинка = 0;
	
	Право = СмартЗадачи.Строки.Добавить();
	Право.Представление = "Редактирование"; 
	Право.ВидПрава = Перечисления.KPI_ВидыПравДоступа.СмартЗадачиРедактирование;
	Право.Картинка = 1;
	
	Право = СмартЗадачи.Строки.Добавить();
	Право.Представление = "Утверждение"; 
	Право.ВидПрава = Перечисления.KPI_ВидыПравДоступа.СмартЗадачиУтверждение;
	Право.Картинка = 2;
	
	Право = СмартЗадачи.Строки.Добавить();
	Право.Представление = "Выполнение"; 
	Право.ВидПрава = Перечисления.KPI_ВидыПравДоступа.СмартЗадачиВыполнение;
	Право.Картинка = 2;
	
	Право = СмартЗадачи.Строки.Добавить();
	Право.Представление = "Проверка выполнения"; 
	Право.ВидПрава = Перечисления.KPI_ВидыПравДоступа.СмартЗадачиПроверка;
	Право.Картинка = 2;
	
	// Права на стандарты
	Стандарты = Дерево.Строки.Добавить();
	Стандарты.Представление = "Стандарты";
	Стандарты.Картинка = 7;
	
	Право = Стандарты.Строки.Добавить();
	Право.Представление = "Просмотр"; 
	Право.ВидПрава = Перечисления.KPI_ВидыПравДоступа.СтандартыПросмотр;
	Право.Картинка = 0;
	
	Право = Стандарты.Строки.Добавить();
	Право.Представление = "Редактирование"; 
	Право.ВидПрава = Перечисления.KPI_ВидыПравДоступа.СтандартыРедактирование;
	Право.Картинка = 1;
	
	Право = Стандарты.Строки.Добавить();
	Право.Представление = "Проставление оценки"; 
	Право.ВидПрава = Перечисления.KPI_ВидыПравДоступа.СтандартыПроставлениеОценки;
	Право.Картинка = 4;
	
	// Права на целевые показатели
	Показатели = Дерево.Строки.Добавить();
	Показатели.Представление = "Целевые показатели";
	Показатели.Картинка = 8;
	
	Право = Показатели.Строки.Добавить();
	Право.Представление = "Использование"; 
	Право.ВидПрава = Перечисления.KPI_ВидыПравДоступа.ЦелевыеПоказателиИспользование;
	Право.Картинка = 0;
	
	// Права на премию
	Премия = Дерево.Строки.Добавить();
	Премия.Представление = "Премия";
	Премия.Картинка = 9;
	
	Право = Премия.Строки.Добавить();
	Право.Представление = "Просмотр"; 
	Право.ВидПрава = Перечисления.KPI_ВидыПравДоступа.ПремияПросмотр;
	Право.Картинка = 0;
	
	Право = Премия.Строки.Добавить();
	Право.Представление = "Редактирование"; 
	Право.ВидПрава = Перечисления.KPI_ВидыПравДоступа.ПремияРедактирование;
	Право.Картинка = 1;
	
	Право = Премия.Строки.Добавить();
	Право.Представление = "Утверждение"; 
	Право.ВидПрава = Перечисления.KPI_ВидыПравДоступа.ПремияУтверждение;
	Право.Картинка = 2;
	
	
	ЗначениеВРеквизитФормы(Дерево, "ПраваДоступа");
КонецПроцедуры


&НаКлиенте
Процедура РаскрытьВсеУровниДерева(ДанныеФормыДерево, СтрЭлем)
	КоллекцияСтрок = ДанныеФормыДерево.ПолучитьЭлементы();
	
	Для Каждого стр Из КоллекцияСтрок Цикл
		Идентификатор = стр.ПолучитьИдентификатор();
		Элементы[СтрЭлем].Развернуть(Идентификатор, Истина);
	КонецЦикла;	
КонецПроцедуры	


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ОбновитьДеревоПравДоступа();
КонецПроцедуры


&НаКлиенте
Процедура ПриОткрытии(Отказ)
	РаскрытьВсеУровниДерева(ПраваДоступа, "ПраваДоступа");
КонецПроцедуры


&НаКлиенте
Процедура ПраваДоступаПриАктивизацииСтроки(Элемент)
	Если ЗначениеЗаполнено(Получатель) И ТекДанные <> Неопределено И ЗначениеЗаполнено(ТекДанные.ВидПрава) И ФлагИзмененияПрав Тогда
		ЗаписатьПрава(ТекДанные.ВидПрава, Получатель, МассивСтруктур, ТекущееДерево);
	КонецЕсли;
	
	ТекДанные = Элементы.ПраваДоступа.ТекущиеДанные;
	ФлагИзмененияПрав = Ложь;
	МассивСтруктур.Очистить();
	
	Если Элементы.ПраваДоступа.ТекущиеДанные.ВидПрава <> ПолучитьПравоДоступаЦП().ВидПраваЦП Тогда
		ТекущееДерево = "Адресаты";
	Иначе
		ТекущееДерево = "ЦелевыеПоказатели";
	КонецЕсли;
	
	
	ОбновитьПолеРедактированияПрав();
КонецПроцедуры


&НаКлиенте
Процедура ПолучательПриИзменении(Элемент)
	ОбновитьПолеРедактированияПрав();
КонецПроцедуры


&НаКлиенте
Процедура ОбновитьПолеРедактированияПрав()
	ДоступностьНастройки = ЗначениеЗаполнено(Получатель) И Элементы.ПраваДоступа.ТекущаяСтрока <> Неопределено
	И ЗначениеЗаполнено(Элементы.ПраваДоступа.ТекущиеДанные.ВидПрава);
	
	Элементы.ГруппаПраваяТаблицы.Видимость = ДоступностьНастройки;
	
	ВидПрава = Элементы.ПраваДоступа.ТекущиеДанные.ВидПрава;
	
	
	Если Доступность Тогда
		
		Если Элементы.ПраваДоступа.ТекущиеДанные.ВидПрава <> ПолучитьПравоДоступаЦП().ВидПраваЦП Тогда
			ОбновитьДеревоАдресатов(Получатель, ВидПрава);
			РаскрытьВсеУровниДерева(Адресаты, "Адресаты");
			Элементы.Адресаты.Видимость = Доступность;
			Элементы.ЦелевыеПоказатели.Видимость = Не Доступность;
		Иначе
			ОбновитьДеревоПоказателей(Получатель, ВидПрава);
			РаскрытьВсеУровниДерева(ЦелевыеПоказатели, "ЦелевыеПоказатели");
			Элементы.Адресаты.Видимость = Не Доступность;
			Элементы.ЦелевыеПоказатели.Видимость = Доступность;
		КонецЕсли;
	Иначе
		Элементы.Адресаты.Видимость = Не Доступность;
		Элементы.ЦелевыеПоказатели.Видимость = Не Доступность;
	КонецЕсли;
КонецПроцедуры


&НаСервере
Процедура ОбновитьДеревоАдресатов(Получатель, Право)
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	KPI_СтруктураКомпанииСрезПоследних.СтруктураКомпании,
	|	KPI_СтруктураКомпанииСрезПоследних.Сотрудник,
	|	ЕСТЬNULL(KPI_СтруктураКомпанииСрезПоследних.СтруктураКомпании.Должность.Наименование, """") + "" ("" + ЕСТЬNULL(KPI_СтруктураКомпанииСрезПоследних.Сотрудник.ФизическоеЛицо.Наименование, """") + "")"" + ЕСТЬNULL("" *("" + KPI_СтруктураКомпанииСрезПоследних.Сотрудник.Квалификация.Наименование + "")"", """") КАК Представление,
	|	ВидыПрав.Адресат,
	|	ВидыПрав.Значение
	|ПОМЕСТИТЬ ВТ
	|ИЗ
	|	РегистрСведений.KPI_СтруктураКомпании.СрезПоследних(&Дата, НЕ СтруктураУдалена) КАК KPI_СтруктураКомпанииСрезПоследних
	|		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ
	|			KPI_ПраваДоступа.Адресат КАК Адресат,
	|			KPI_ПраваДоступа.Разрешить КАК Значение
	|		ИЗ
	|			РегистрСведений.KPI_ПраваДоступа КАК KPI_ПраваДоступа
	|		ГДЕ
	|			KPI_ПраваДоступа.Получатель = &Получатель
	|			И KPI_ПраваДоступа.ВидПраваДоступа = &ВидПраваДоступа) КАК ВидыПрав
	|		ПО KPI_СтруктураКомпанииСрезПоследних.СтруктураКомпании = ВидыПрав.Адресат
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ.Представление КАК Представление,
	|	ВТ.СтруктураКомпании КАК Адресат,
	|	ЕСТЬNULL(ВТ.Значение, ЛОЖЬ) КАК Разрешить,
	|	ВТ.СтруктураКомпании КАК СтруктураКомпании
	|ИЗ
	|	ВТ КАК ВТ
	|
	|УПОРЯДОЧИТЬ ПО
	|	СтруктураКомпании ИЕРАРХИЯ";
	
	Запрос.УстановитьПараметр("Дата", ТекущаяДата());
	Запрос.УстановитьПараметр("Получатель", Получатель);
	Запрос.УстановитьПараметр("ВидПраваДоступа", Право);
	//Запрос.УстановитьПараметр("ИспИерархию", Константы.ПрименятьРасширеннуюИерархию.Получить());
	Запрос.УстановитьПараметр("ИспИерархию", Истина);

	
	Результат = Запрос.Выполнить();
	
	
	Дерево = РеквизитФормыВЗначение("Адресаты");
	Дерево = Результат.Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкамСИерархией);
	ЗначениеВРеквизитФормы(Дерево, "Адресаты");
КонецПроцедуры


&НаСервере
Процедура ОбновитьДеревоПоказателей(Получатель, Право)
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	KPI_ЦелевыеПоказатели.Ссылка КАК Адресат,
	|	ЕСТЬNULL(ВидыПрав.Значение, ЛОЖЬ) КАК Разрешить
	|ИЗ
	|	Справочник.KPI_ЦелевыеПоказатели КАК KPI_ЦелевыеПоказатели
	|		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ
	|			KPI_ПраваДоступа.Адресат КАК Адресат,
	|			KPI_ПраваДоступа.Разрешить КАК Значение
	|		ИЗ
	|			РегистрСведений.KPI_ПраваДоступа КАК KPI_ПраваДоступа
	|		ГДЕ
	|			KPI_ПраваДоступа.Получатель = &Получатель
	|			И KPI_ПраваДоступа.ВидПраваДоступа = &ВидПраваДоступа) КАК ВидыПрав
	|		ПО KPI_ЦелевыеПоказатели.Ссылка = ВидыПрав.Адресат
	|
	|УПОРЯДОЧИТЬ ПО
	|	Адресат ИЕРАРХИЯ УБЫВ";
	
	Запрос.УстановитьПараметр("Получатель", Получатель);
	Запрос.УстановитьПараметр("ВидПраваДоступа", Право);
	
	Результат = Запрос.Выполнить();
	
	
	Дерево = РеквизитФормыВЗначение("ЦелевыеПоказатели");
	Дерево = Результат.Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкамСИерархией);
	ЗначениеВРеквизитФормы(Дерево, "ЦелевыеПоказатели");
КонецПроцедуры


&НаСервереБезКонтекста
Функция ПолучитьПравоДоступаЦП()
	Возврат Новый Структура("ВидПраваЦП", Перечисления.KPI_ВидыПравДоступа.ЦелевыеПоказателиИспользование);
КонецФункции


&НаКлиенте
Процедура ПолучательНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ОбъектУправления = KPI_ОбщегоНазначения.ОбработкаВыбораПолучитьСтруктуруКомпанииНаДату(ТекущаяДата(), , СтандартнаяОбработка, , Получатель);
	
	Если Не ОбъектУправления = Неопределено Тогда
		Получатель = ОбъектУправления.СтруктураКомпании;
		ПолучательПредставление = ОбъектУправления.СтруктураКомпанииПредставление;
	КонецЕсли;
	
	ПолучательПриИзменении(Элементы.Получатель);
КонецПроцедуры


&НаКлиенте
Процедура ПолучательОчистка(Элемент, СтандартнаяОбработка)
	Получатель = Неопределено;
КонецПроцедуры


&НаКлиенте
Процедура СнятьВсеОтметки(Команда)
	МассивСтруктур.Очистить();
	
	Если Элементы.Адресаты.Видимость Тогда 
		ВыставитьФлаги(Адресаты, Ложь);
	ИначеЕсли Элементы.ЦелевыеПоказатели.Видимость Тогда 
		ВыставитьФлаги(ЦелевыеПоказатели, Ложь);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Получатель) И ТекДанные <> Неопределено И ЗначениеЗаполнено(ТекДанные.ВидПрава) Тогда
		ЗаписатьПрава(ТекДанные.ВидПрава, Получатель, МассивСтруктур, ТекущееДерево);
	КонецЕсли;
КонецПроцедуры


&НаКлиенте
Процедура ОтметитьВсе(Команда)
	МассивСтруктур.Очистить();
	
	Если Элементы.Адресаты.Видимость Тогда 
		ВыставитьФлаги(Адресаты, Истина);
	ИначеЕсли Элементы.ЦелевыеПоказатели.Видимость Тогда 
		ВыставитьФлаги(ЦелевыеПоказатели, Истина, Истина);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Получатель) И ТекДанные <> Неопределено И ЗначениеЗаполнено(ТекДанные.ВидПрава) Тогда
		ЗаписатьПрава(ТекДанные.ВидПрава, Получатель, МассивСтруктур, ТекущееДерево);
	КонецЕсли;
КонецПроцедуры


&НаКлиенте
Процедура ВыставитьФлаги(Ветка, ЗначениеФлага, НеОтмечатьГруппы = Ложь)
	КоллекцияСтрок = Ветка.ПолучитьЭлементы();
	Для Каждого Стр Из КоллекцияСтрок Цикл
		
		Стр.Разрешить = ЗначениеФлага;
		
		Если НеОтмечатьГруппы Тогда
			Если ЭтоГруппаЦП(Стр.Адресат) Тогда
				Стр.Разрешить = Ложь;
			КонецЕсли;
		КонецЕсли;
		
		МассивСтруктур.Добавить(Стр.ПолучитьИдентификатор());
		
		ВыставитьФлаги(Стр, ЗначениеФлага);
	КонецЦикла;
КонецПроцедуры


&НаСервере
Процедура ЗаписатьПрава(ВидПраваДоступа, ПолучательСтруктура, МассивСтруктур, ТекущееДерево)
	
	НачатьТранзакцию();
	
	Для каждого Ид Из МассивСтруктур Цикл
		
		Если ТекущееДерево = "Адресаты" Тогда
			Стр = Адресаты.НайтиПоИдентификатору(Ид);
		ИначеЕсли ТекущееДерево = "ЦелевыеПоказатели" Тогда
			Стр = ЦелевыеПоказатели.НайтиПоИдентификатору(Ид);
		КонецЕсли;
		
		Запись = РегистрыСведений.KPI_ПраваДоступа.СоздатьМенеджерЗаписи();                       
		Запись.Адресат = Стр.Адресат;
		Запись.Получатель = ПолучательСтруктура;
		Запись.ВидПраваДоступа = ВидПраваДоступа;
		Запись.Прочитать();
		
		Если Запись.Выбран() Тогда
			Если Не Стр.Разрешить Тогда
				Запись.Удалить();
			Иначе 
				Запись.Разрешить = Истина;
				Запись.Записать();
			КонецЕсли;
		Иначе 
			Если Стр.Разрешить Тогда
				Запись.Адресат = Стр.Адресат;
				Запись.Получатель = ПолучательСтруктура;
				Запись.ВидПраваДоступа = ВидПраваДоступа;
				Запись.Разрешить = Истина;
				Запись.Записать();
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
	ЗафиксироватьТранзакцию();
	
КонецПроцедуры


&НаКлиенте
Процедура АдресатыРазрешитьПриИзменении(Элемент)
	ДействиеПриОтметке(Элементы.Адресаты);
КонецПроцедуры


&НаКлиенте
Процедура ЦелевыеПоказателиРазрешитьПриИзменении(Элемент)
	Если ЭтоГруппаЦП(Элементы.ЦелевыеПоказатели.ТекущиеДанные.Адресат) Тогда
		Элементы.ЦелевыеПоказатели.ТекущиеДанные.Разрешить = Ложь;
		Сообщить("Для группы нельзя устанавливать разрешение");
		Возврат;
	КонецЕсли;
	
	ДействиеПриОтметке(Элементы.ЦелевыеПоказатели);
КонецПроцедуры


&НаКлиенте
Процедура ДействиеПриОтметке(КонкретныйЭлемент)
	ФлагИзмененияПрав = Истина;
	
	ИД = КонкретныйЭлемент.ТекущиеДанные.ПолучитьИдентификатор();
	
	Если МассивСтруктур.Найти(ИД) = Неопределено Тогда
		МассивСтруктур.Добавить(ИД);
	КонецЕсли;
КонецПроцедуры


&НаСервереБезКонтекста
Функция ЭтоГруппаЦП(ЦП)
	Возврат ЦП.ЭтоГруппа;
КонецФункции





ТекДанные = Неопределено;
ФлагИзмененияПрав = Ложь;
МассивСтруктур = Новый Массив;
ТекущееДерево = Неопределено;
