
&НаКлиенте
Процедура СотрудникНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ОбъектУправления = KPI_ОбщегоНазначения.ОбработкаВыбораПолучитьСтруктуруКомпанииНаДату(ТекущаяДата(), ЭтаФорма, СтандартнаяОбработка, Истина, ?(ЗначениеЗаполнено(Запись.Сотрудник), KPI_ОбщегоНазначенияСервер.ПолучитьСтруктуруКомпанииПоСотруднику(Запись.Сотрудник), Неопределено));
	
	Если Не ОбъектУправления = Неопределено Тогда
		Запись.Сотрудник = ОбъектУправления.Сотрудник;
	КонецЕсли;
КонецПроцедуры
