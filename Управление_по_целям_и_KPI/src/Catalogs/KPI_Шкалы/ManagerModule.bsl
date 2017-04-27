//Функция получает значение ресурса по шкале
//Параметры
// 	Шкала 			- тип СправочникСсылка.Шкалы
// 	Ресурс			- тип число, значение ресурса
//Возвращаемое значение
// 	ЗначениеПоШкале - тип число
Функция ЗначениеРесурсаЦелевогоПоказателяПоШкале(Шкала,Ресурс) Экспорт
	
	ЗначениеПоШкале = 0;
	ЗначениеНайдено = Ложь;
	
	Если Не ЗначениеЗаполнено(Шкала) Тогда
		Возврат Ресурс;
	КонецЕсли;
	
	Для Каждого Стр из Шкала.ИнтервалыШкалы Цикл
		Если  Стр.НижнийПорог <=Ресурс И Стр.ВерхнийПорог>Ресурс Тогда
			ЗначениеПоШкале =  Стр.Значение;
			ЗначениеНайдено = Истина;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Возврат ?(ЗначениеНайдено,ЗначениеПоШкале,Ресурс);
	
КонецФункции

//Функция рассчитывает значение показателя расчета
//Параметры:
// ИнтервалыШкалы       - тип ТабличнаяЧастьСправочника, задает интеравалы по которым строится график
// ПоказательНачисления - тип диаграмма, отстраиваемая диаграмма 
//Возвращаемое значение:
//  нет
Процедура ПостроитьГрафикШкалы(ИнтервалыШкалы,ДиаграммаШкалы) Экспорт
	
	ДиаграммаШкалы.Очистить();
	ДиаграммаШкалы.ТипДиаграммы = ТипДиаграммы.ГрафикПоШагам;
	ДиаграммаШкалы.ОтображатьЛегенду = Ложь;
	
	СерияДиаграммы = ДиаграммаШкалы.УстановитьСерию("Шкала");
	
	Если ИнтервалыШкалы.Количество() Тогда 
		ТочкаДиаграммы = ДиаграммаШкалы.УстановитьТочку(ИнтервалыШкалы[0].НижнийПорог);
		ДиаграммаШкалы.УстановитьЗначение(ТочкаДиаграммы,СерияДиаграммы,ИнтервалыШкалы[0].Значение);
		Для ДляНомерСтроки = 1 по ИнтервалыШкалы.Количество() -1 Цикл			
			
			ТочкаДиаграммы = ДиаграммаШкалы.УстановитьТочку(ИнтервалыШкалы[ДляНомерСтроки].НижнийПорог);
			ДиаграммаШкалы.УстановитьЗначение(ТочкаДиаграммы,СерияДиаграммы,ИнтервалыШкалы[ДляНомерСтроки-1].Значение);
			
			
		КонецЦикла;
		ТочкаДиаграммы = ДиаграммаШкалы.УстановитьТочку(ИнтервалыШкалы[ИнтервалыШкалы.Количество() -1].ВерхнийПорог);
		ДиаграммаШкалы.УстановитьЗначение(ТочкаДиаграммы,СерияДиаграммы,ИнтервалыШкалы[ИнтервалыШкалы.Количество() -1].Значение);
		
	КонецЕсли;
	
КонецПроцедуры
