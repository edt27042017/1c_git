
&НаКлиенте
Процедура ЗаполнитьИнтервалыШкалы(Команда)
	
	ПараметрыЗаполнения = Новый Структура;
	ПараметрыЗаполнения.Вставить("НижнийПорог"          ,ЭтаФорма.НижнийПорогШкалы);
	ПараметрыЗаполнения.Вставить("ВерхнийПорог"         ,ЭтаФорма.ВерхнийПорогШкалы);
	ПараметрыЗаполнения.Вставить("Интервал"             ,ЭтаФорма.Интервал);
	ПараметрыЗаполнения.Вставить("МинимальноеЗначение"  ,ЭтаФорма.МинимальноеЗначение);
	ПараметрыЗаполнения.Вставить("МаксимальноеЗначение" ,ЭтаФорма.МаксимальноеЗначение);
	
	ОповеститьОВыборе(ПараметрыЗаполнения);
	
КонецПроцедуры
