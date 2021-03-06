
&НаКлиенте
Процедура ДвиженияKPI_ФактыФильтрАналитикНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ТекущиеДанные = Элементы.ДвиженияKPI_Факты.ТекущиеДанные;	
	ЦП            = ТекущиеДанные.ЦелевойПоказатель;
	КлючАналитики = ТекущиеДанные.КлючАналитики;
	//НаименованиеФильтраАналитик = ТекущиеДанные.НазваниеФильтраАналитик;	
	KPI_ИнтерфейсКлиент.НачалоВыбораАналитик(ЦП,КлючАналитики,,Элемент,СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ДвиженияKPI_ФактыФильтрАналитикОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	СтандартнаяОбработка        = Ложь;
	ТекущиеДанные               = Элементы.ДвиженияKPI_Факты.ТекущиеДанные;
	ТекущиеДанные.КлючАналитики = ВыбранноеЗначение.КлючАналитики; 
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ОбновитьПредставленияСтруктурыКомпании();
КонецПроцедуры


&НаКлиенте
Процедура ДатаПриИзменении(Элемент)
	ОбновитьПредставленияСтруктурыКомпании();
КонецПроцедуры


&НаКлиенте
Процедура ОбновитьПредставленияСтруктурыКомпании()
	Для каждого Стр Из Объект.Движения.KPI_Факты Цикл
		Стр.СтруктураКомпанииПредставление = KPI_ОбщегоНазначенияСервер.ПолучитьПредставлениеПоСтруктуреКомпанииНаДату(Стр.СтруктураКомпании, Объект.Дата);
	КонецЦикла;
КонецПроцедуры


&НаКлиенте
Процедура ДвиженияKPI_ФактыСтруктураКомпанииПредставлениеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
		ОбъектУправления = KPI_ОбщегоНазначения.ОбработкаВыбораПолучитьСтруктуруКомпанииНаДату(Объект.Дата, ЭтаФорма, СтандартнаяОбработка, , ТекущийЭлемент.ТекущиеДанные.СтруктураКомпании);
	
	Если Не ОбъектУправления = Неопределено Тогда
		ТекущийЭлемент.ТекущиеДанные.СтруктураКомпании = ОбъектУправления.СтруктураКомпании;
		ТекущийЭлемент.ТекущиеДанные.СтруктураКомпанииПредставление = ОбъектУправления.СтруктураКомпанииПредставление;
	КонецЕсли;
КонецПроцедуры


&НаКлиенте
Процедура ДвиженияKPI_ФактыСтруктураКомпанииПредставлениеОчистка(Элемент, СтандартнаяОбработка)
	ТекущийЭлемент.ТекущиеДанные.СтруктураКомпании = Неопределено;
КонецПроцедуры


&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	ОбновитьПредставленияСтруктурыКомпании();
КонецПроцедуры
