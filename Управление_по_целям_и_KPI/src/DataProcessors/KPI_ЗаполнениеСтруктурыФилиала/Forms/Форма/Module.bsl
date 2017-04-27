
&НаКлиенте
Процедура СоздатьСтруктуруФилиала(Команда)
	
	СоздатьСтруктуруКомпанииНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура СоздатьСтруктуруКомпанииНаСервере()
	
	Дерево = РеквизитФормыВЗначение("ДеревоКомпании");
	ЕстьОшибки = Ложь;
	
	ЕстьПользовательАдминистратор = Ложь;
	ЕстьПользовательКадровик      = Ложь;
	
	НачатьТранзакцию(); 
	Попытка	
		СформироватьДокументНазначения(Дерево.Строки,НачалоДня(ТекущаяДата()));		
	Исключение
		ЕстьОшибки = Истина;
	КонецПопытки;
		
	Если Не ЕстьПользовательАдминистратор Тогда
		ЕстьОшибки = Истина;
		KPI_ИнтерфейсКлиентСервер.СообщитьОбОшибке("Не указан пользователь с административными правами.");
	КонецЕсли;
	
	Если Не ЕстьПользовательКадровик Тогда 
		ЕстьОшибки = Истина;
		KPI_ИнтерфейсКлиентСервер.СообщитьОбОшибке("Не указан пользователь с правами кадровика.");
	КонецЕсли;
		
	Если ЕстьОшибки Тогда
		ОтменитьТранзакцию();
		KPI_ИнтерфейсКлиентСервер.СообщитьОбОшибке("Не удалось сформировать структуру компании.");	
	Иначе
		ЗафиксироватьТранзакцию();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура СформироватьДокументНазначения(СтрокиДерева,ДатаСтаршегоДокумента,РодительСтруктуры = Неопределено)
	
	Если НЕ СтрокиДерева.Количество() Тогда
		Возврат;
	КонецЕсли;
	
	ПриказНазначения      = Документы.KPI_ПриказОНазначенииНаДолжность.СоздатьДокумент();
	ДатаСтаршегоДокумента = ДатаСтаршегоДокумента + 1;
	ПриказНазначения.Дата = ДатаСтаршегоДокумента;
	
	Для Каждого Стр из СтрокиДерева Цикл
		
		СтруктураКомпании              = Справочники.KPI_СтруктураКомпании.СоздатьЭлемент();
		СтруктураКомпании.Филиал       = ЭтаФорма.Филиал;
		СтруктураКомпании.Должность    = Стр.Должность;
		СтруктураКомпании.Родитель     = РодительСтруктуры;
		РольПользователь = СтруктураКомпании.РолиОбъектаУправления.Добавить();
		РольПользователь.Имя = "KPI_Пользователь";
		Если НЕ Стр.ОсновнаяРоль = РольПользователь.Имя И ЗначениеЗаполнено(Стр.ОсновнаяРоль) Тогда
			ОсновнаяРоль = СтруктураКомпании.РолиОбъектаУправления.Добавить();
			ОсновнаяРоль.Имя = Стр.ОсновнаяРоль;
		КонецЕсли;
		
		Если Стр.ОсновнаяРоль = "KPI_Администратор" Тогда
			ЕстьПользовательАдминистратор = Истина;
		ИначеЕсли Стр.ОсновнаяРоль = "KPI_Кадровик" Тогда
			ЕстьПользовательКадровик = Истина;
		ИначеЕсли Стр.ОсновнаяРоль = "ПолныеПрава" Тогда
			ЕстьПользовательАдминистратор = Истина;
			ЕстьПользовательКадровик      = Истина;
		КонецЕсли;
		
		СтруктураКомпании.Записать();
		
		СтрокаНазначения = ПриказНазначения.Сотрудники.Добавить();
		СтрокаНазначения.ФизЛицо = Стр.ФизЛицо;
		СтрокаНазначения.СтруктураКомпании = СтруктураКомпании.Ссылка;
		СтрокаНазначения.ГрафикРаботы = Стр.ГрафикРаботы;
		СтрокаНазначения.Квалификация = Стр.Квалификация;
		
		СформироватьДокументНазначения(Стр.Строки,ДатаСтаршегоДокумента,СтруктураКомпании.Ссылка)
		
	КонецЦикла;
	
	ПриказНазначения.ЗаполнитьПлановыеНачисления();
	ПриказНазначения.Записать(РежимЗаписиДокумента.Проведение);
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоКомпанииОсновнаяРольНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СписокРолей = KPI_ИнтерфейсВызовСервера.РолиKPI();
	ВыбраннаяРоль = СписокРолей.ВыбратьЭлемент();
	Если НЕ ВыбраннаяРоль = Неопределено Тогда
		Элементы.ДеревоКомпании.ТекущиеДанные.ОсновнаяРоль = ВыбраннаяРоль.Значение;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("ПервоначальноеЗаполнение") Тогда
		Заголовок = "Первоначальное заполнение филиала";
		ЕстьПользовательПолныеПрава = Ложь;
		РольПолныеПрава    = Метаданные.Роли.ПолныеПрава;
		ВсеПользователи = ПользователиИнформационнойБазы.ПолучитьПользователей();
		Для Каждого ПользовательИБ из ВсеПользователи Цикл
			Если ПользовательИБ.Роли.Содержит(РольПолныеПрава) Тогда
				 ЕстьПользовательПолныеПрава = Истина;
			КонецЕсли;
		КонецЦикла;
		
		Если Не ЕстьПользовательПолныеПрава Тогда
			Отказ = Истина;
		КонецЕсли;
		
	Иначе 
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры
