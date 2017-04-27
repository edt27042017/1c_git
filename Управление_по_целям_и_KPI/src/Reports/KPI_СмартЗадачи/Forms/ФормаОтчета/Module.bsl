
&НаКлиенте
Процедура ОбъектУправленияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Если Не ЗначениеЗаполнено(Отчет.КонецПериода) Тогда
		Сообщить("Не заполнен период");
		Возврат;
	КонецЕсли;
	
	ОбъектУправления = KPI_ОбщегоНазначения.ОбработкаВыбораПолучитьСтруктуруКомпанииНаДату(Отчет.КонецПериода, ЭтаФорма, СтандартнаяОбработка, , Отчет.ОбъектУправления);
	
	Если Не ОбъектУправления = Неопределено Тогда
		Отчет.ОбъектУправления          = ОбъектУправления.СтруктураКомпании;
		ОбъектУправленияПредставление   = ОбъектУправления.СтруктураКомпанииПредставление;
	КонецЕсли;
	
КонецПроцедуры
