
&НаКлиенте
Процедура РучнаяКорректировкаПриИзменении(Элемент)
	Сообщить("При ручной корректировке не гарантируется корректность собранных фактов");
	Элементы.РучнаяКорректировка.Доступность = Ложь;
	Элементы.ФактыСоСбора.ТолькоПросмотр = Ложь;
	Элементы.ФактыСоСбора.ПоложениеКоманднойПанели = ПоложениеКоманднойПанелиЭлементаФормы.Авто;
КонецПроцедуры


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(Параметры.Факты) Тогда
		ЗначениеВДанныеФормы(Параметры.Факты, ФактыСоСбора);
		ЗначениеВДанныеФормы(Параметры.ЦП, ЦелевыеПоказатели);
		ЗначениеВДанныеФормы(Параметры.ТЗПараметры, ПараметрыЗапроса);
	Иначе 
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры


&НаКлиенте
Процедура ВвестиФакты(Команда)
	Если ФактыСоСбора.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ВсеЗаполнено = Истина;
	Для каждого Стр Из ФактыСоСбора Цикл
		Если Не ЗначениеЗаполнено(Стр.Сотрудник) Или Не ЗначениеЗаполнено(Стр.Период) Или Не ЗначениеЗаполнено(Стр.Факт) Тогда
			ВсеЗаполнено = Ложь;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Если Не ВсеЗаполнено Тогда
		Если Не РучнаяКорректировка Тогда
			Сообщить("Включите ручную корректировку и обязательно заполните все значения в полях ""Сотрудник"", ""Период"" и ""Факт""");
		Иначе 
			Сообщить("Обязательно нужно заполнить все значения в полях ""Сотрудник"", ""Период"" и ""Факт""");
		КонецЕсли;
		
		Возврат;
	КонецЕсли;
	
	
	KPI_ОбщегоНазначенияСервер.ЗаписатьФактыВРегистр(Новый Структура("ТЗПараметры, ТЗФакты, ЦП, Автомат", ПараметрыЗапроса, ФактыСоСбора, ЦелевыеПоказатели, Не РучнаяКорректировка));
	
	ЭтаФорма.Закрыть();
КонецПроцедуры


&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Элементы.ФактыСоСбора.ПоложениеКоманднойПанели = ПоложениеКоманднойПанелиЭлементаФормы.Нет;
КонецПроцедуры


