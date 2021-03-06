&НаКлиенте
Перем ГиперСсылкаВводаТекст;


&НаКлиенте
Процедура КомандаОК(Команда)
	Формула = ТелоФормулы.ПолучитьТекст();
	
	Если ПустаяСтрока(Формула) Тогда
		Формула = ГиперСсылкаВводаТекст;
	Иначе 
		Если Не ПроверитьФормулу() Тогда
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	Структура = Новый Структура;
	Структура.Вставить("Формула", Формула);
	Структура.Вставить("Вкладка", ЭтаФорма.Параметры.Ключ);
	
	ОповеститьОВыборе(Структура);
КонецПроцедуры


&НаСервере
Функция ПроверитьФормулу()
	ПредставленияФормулы = ТаблицаАргументы.Выгрузить(, "Представление").ВыгрузитьКолонку("Представление");
	
	КриптоМодуль = KPI_ОбщегоНазначенияСервер.ПолучитьКриптоМодуль();
	ФормулаКорректна = КриптоМодуль.ПроверитьФормулу(ТелоФормулы.ПолучитьТекст(), ПредставленияФормулы);
	 
	Возврат ФормулаКорректна;
КонецФункции


&НаКлиенте
Процедура Команда1(Команда)
	ТелоФормулы.УстановитьТекст(ТелоФормулы.ПолучитьТекст() + "1");
КонецПроцедуры


&НаКлиенте
Процедура Команда2(Команда)
	ТелоФормулы.УстановитьТекст(ТелоФормулы.ПолучитьТекст() + "2");
КонецПроцедуры


&НаКлиенте
Процедура Команда3(Команда)
	ТелоФормулы.УстановитьТекст(ТелоФормулы.ПолучитьТекст() + "3");
КонецПроцедуры


&НаКлиенте
Процедура Команда4(Команда)
	ТелоФормулы.УстановитьТекст(ТелоФормулы.ПолучитьТекст() + "4");
КонецПроцедуры


&НаКлиенте
Процедура Команда5(Команда)
	ТелоФормулы.УстановитьТекст(ТелоФормулы.ПолучитьТекст() + "5");
КонецПроцедуры


&НаКлиенте
Процедура Команда6(Команда)
	ТелоФормулы.УстановитьТекст(ТелоФормулы.ПолучитьТекст() + "6");
КонецПроцедуры


&НаКлиенте
Процедура Команда7(Команда)
	ТелоФормулы.УстановитьТекст(ТелоФормулы.ПолучитьТекст() + "7");
КонецПроцедуры


&НаКлиенте
Процедура Команда8(Команда)
	ТелоФормулы.УстановитьТекст(ТелоФормулы.ПолучитьТекст() + "8");
КонецПроцедуры


&НаКлиенте
Процедура Команда9(Команда)
	ТелоФормулы.УстановитьТекст(ТелоФормулы.ПолучитьТекст() + "9");
КонецПроцедуры


&НаКлиенте
Процедура Команда0(Команда)
	ТелоФормулы.УстановитьТекст(ТелоФормулы.ПолучитьТекст() + "0");
КонецПроцедуры


&НаКлиенте
Процедура КомандаТочка(Команда)
	ТелоФормулы.УстановитьТекст(ТелоФормулы.ПолучитьТекст() + ".");
КонецПроцедуры


&НаКлиенте
Процедура КомандаЗапятая(Команда)
	ТелоФормулы.УстановитьТекст(ТелоФормулы.ПолучитьТекст() + ",");
КонецПроцедуры


&НаКлиенте
Процедура КомандаПлюс(Команда)
	ТелоФормулы.УстановитьТекст(ТелоФормулы.ПолучитьТекст() + "+");
КонецПроцедуры


&НаКлиенте
Процедура КомандаМинус(Команда)
	ТелоФормулы.УстановитьТекст(ТелоФормулы.ПолучитьТекст() + "-");
КонецПроцедуры


&НаКлиенте
Процедура КомандаУмножить(Команда)
	ТелоФормулы.УстановитьТекст(ТелоФормулы.ПолучитьТекст() + "*");
КонецПроцедуры


&НаКлиенте
Процедура КомандаРазделить(Команда)
	ТелоФормулы.УстановитьТекст(ТелоФормулы.ПолучитьТекст() + "/");
КонецПроцедуры


&НаКлиенте
Процедура КомандаСкобкаЛевая(Команда)
	ТелоФормулы.УстановитьТекст(ТелоФормулы.ПолучитьТекст() + "(");
КонецПроцедуры


&НаКлиенте
Процедура КомандаСкобкаПравая(Команда)
	ТелоФормулы.УстановитьТекст(ТелоФормулы.ПолучитьТекст() + ")");
КонецПроцедуры


&НаКлиенте
Процедура КомандаСтеретьСимвол(Команда)
	Стр = ТелоФормулы.ПолучитьТекст();
	
	Если Прав(Стр, 1) = "]" Тогда
		Пока Прав(Стр, 1) <> "[" Цикл
			ТелоФормулы.УстановитьТекст(Лев(Стр, СтрДлина(Стр)-1));
			Стр = ТелоФормулы.ПолучитьТекст();
		КонецЦикла;
	КонецЕсли;
	
	ТелоФормулы.УстановитьТекст(Лев(Стр, СтрДлина(Стр)-1));
КонецПроцедуры


&НаКлиенте
Процедура КомандаСтеретьВсе(Команда)
	ТелоФормулы.Очистить();
КонецПроцедуры


&НаКлиенте
Процедура ТаблицаАргументыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	ТелоФормулы.УстановитьТекст(ТелоФормулы.ПолучитьТекст() + "[" + Элемент.ТекущиеДанные.Представление + "]");
КонецПроцедуры


&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Владелец = ЭтаФорма.ВладелецФормы;
	
	Если НЕ ТипЗнч(Владелец) = Тип("УправляемаяФорма") Тогда
		Возврат;
	КонецЕсли;
	
	Если Владелец.Модифицированность Тогда
		Если Вопрос("Для возможности редактирования формулы необходимо записать измененные данные текущей формы.
			|Записать?",РежимДиалогаВопрос.ДаНет,,КодВозвратаДиалога.Да)=КодВозвратаДиалога.Да Тогда
			
			Если Владелец.ПодчиненныеЭлементы.ГруппаСтраницы.ТекущаяСтраница.Имя = "ГруппаФормулаФакта" Тогда
				Если Владелец.Объект.ФормулаСписокФакт = ГиперСсылкаВводаТекст Тогда
					Владелец.Объект.ФормулаСписокФакт = Неопределено;
					Владелец.Записать();
					Владелец.Объект.ФормулаСписокФакт = ГиперСсылкаВводаТекст;
				КонецЕсли;
			КонецЕсли;
			
			Если Владелец.ПодчиненныеЭлементы.ГруппаСтраницы.ТекущаяСтраница.Имя = "ГруппаФормулаПлана" Тогда
				Если Владелец.Объект.ФормулаСписокПлан = ГиперСсылкаВводаТекст Тогда
					Владелец.Объект.ФормулаСписокПлан = Неопределено;
					Владелец.Записать();
					Владелец.Объект.ФормулаСписокПлан = ГиперСсылкаВводаТекст;
				КонецЕсли;
			КонецЕсли;
				
			//Владелец.Записать();
		Иначе
			Отказ = Истина;
		КонецЕсли;
	КонецЕсли;
	
	
	
	Если ЭтаФорма.Параметры.Ключ = "Факт" Тогда
		Если Владелец.Объект.ФормулаСписокФакт = ГиперСсылкаВводаТекст Тогда
			ТелоФормулы.Очистить();
		Иначе 
			ТелоФормулы.УстановитьТекст(Владелец.Объект.ФормулаСписокФакт);
		КонецЕсли;
		
		Для каждого Стр Из Владелец.Объект.ФормулаФакта Цикл
			ТЗ = ЭтаФорма.ТаблицаАргументы;
			
			НоваяСтрока = ТЗ.Добавить(); 
			НоваяСтрока["Представление"] = Стр.Представление; 
			НоваяСтрока["ЦелевойПоказатель"] = Стр.ЦелевойПоказатель;
		КонецЦикла;
	КонецЕсли;
	
	Если ЭтаФорма.Параметры.Ключ = "План" Тогда
		Если Владелец.Объект.ФормулаСписокПлан = ГиперСсылкаВводаТекст Тогда
			ТелоФормулы.Очистить();
		Иначе 
			ТелоФормулы.УстановитьТекст(Владелец.Объект.ФормулаСписокПлан);
		КонецЕсли;
		
		Для каждого Стр Из Владелец.Объект.ФормулаПлана Цикл
			ТЗ = ЭтаФорма.ТаблицаАргументы;
			
			НоваяСтрока = ТЗ.Добавить(); 
			НоваяСтрока["Представление"] = Стр.Представление; 
			НоваяСтрока["ЦелевойПоказатель"] = Стр.ЦелевойПоказатель;
		КонецЦикла;
	КонецЕсли;

КонецПроцедуры




ГиперСсылкаВводаТекст = "Введите формулу";
