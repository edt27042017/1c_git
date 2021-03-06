&НаКлиенте
Процедура Выбрать(Команда)
	ПередатьЗначение();
КонецПроцедуры

&НаКлиенте
Процедура СписокПолейВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	ПередатьЗначение();
КонецПроцедуры

&НаКлиенте
Процедура ПередатьЗначение()
	Если Элементы.СписокПолей.ТекущиеДанные <> Неопределено Тогда 
		ОповеститьОВыборе(Новый Структура("Реквизит, ЗначениеРеквизита", Параметры.Реквизит, Элементы.СписокПолей.ТекущиеДанные.Поле));
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Для каждого Стр Из Параметры.СЗ Цикл
		НовСтр = СписокПолей.Добавить();
		НовСтр.Поле = Стр.Значение;
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Если Параметры.Реквизит = "ДатаНачала" Или Параметры.Реквизит = "ДатаОкончания" Тогда
		Элементы.СписокПолейПоле.Заголовок = "Параметр";
		ЭтаФорма.Заголовок = "Форма выбора параметра";
	КонецЕсли;
КонецПроцедуры

