&НаКлиенте
Процедура СотрудникиСотрудникНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ОбъектУправления = KPI_ОбщегоНазначения.ОбработкаВыбораПолучитьСтруктуруКомпанииНаДату(Объект.Дата, ЭтаФорма, СтандартнаяОбработка, , ?(ЗначениеЗаполнено(ТекущийЭлемент.ТекущиеДанные.Сотрудник), KPI_ОбщегоНазначенияСервер.ПолучитьСтруктуруКомпанииПоСотруднику(ТекущийЭлемент.ТекущиеДанные.Сотрудник), Неопределено));
	
	Если Не ОбъектУправления = Неопределено Тогда
		ТекущийЭлемент.ТекущиеДанные.Сотрудник = ОбъектУправления.Сотрудник;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ДатаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	KPI_ОбщегоНазначения.ПроверитьВозможностьИзмененияДаты(Объект.Сотрудники, СтандартнаяОбработка);
	
КонецПроцедуры
	
