
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	//Вставить содержимое обработчика.
	ПараметрыФормы = Новый Структура("РежимРасшифровки");
	//ОткрытьФорму("ОбщаяФорма.", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно);
	
	KPI_ИнтерфейсКлиент.ОткрытьФормуЗащищенногоОбъекта("KPI_ПроформаПлановИФактов","Форма",ПараметрыФормы);
	
КонецПроцедуры
