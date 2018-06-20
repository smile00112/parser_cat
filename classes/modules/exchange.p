################################################################################
@CLASS
exchange
################################################################################
@auto[]
$self.classVersion[1.0]
$self.classBuildDate[10.10.2017]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[exchange]
$self.classDescription[Курс валют]
$self.classModuleDescription[Курс валют]
$self.classHistory[
	<p align="justify">
		<strong><u>Версия $self.classVersion ($self.classBuildDate):</u></strong>
		<ol>
			<li>Создан класс ${self.className}.</li>
		</ol>
	</p>
]
#----------------------------- Рабочие переменные ------------------------------
# Таблица "Курс валют"
$self.exchangeRateTable[
	$.name[exchange_rate]
	$.file[exchange_rate.table]
]
# Получаем текущую дату
$self.now[^date::now[]]
$self.date[^date::now(^if($self.now.hour>18){1}{0})]
# Файл XML
$self.xmlFile[http://cbr.ru/scripts/XML_daily.asp?date_req=^self.date.day.format[%02d]/^self.date.month.format[%02d]/$self.date.year]
################################################################################
@create[]
# Получаем дату последнего обновления из БД
^try{
	$value[^string:sql{SELECT MAX(date) FROM $self.exchangeRateTable.name}]
}{
	$exception.handled(true)
	$res[^void:sql{TRUNCATE TABLE $self.exchangeRateTable.name}]
}
^if(def $value){
	$bd_date[^date::create[$value]]
}
# Если текущая дата больше полученной из БД
^if( !def $value || $self.now >= $bd_date ){
# Пробуем обновить курс валют
	^try{
# Загружаем XML с курсом валют
		$dailyExchange[^xdoc::load[$self.xmlFile]]
# Очищаем содержимое таблицы
		$res[^void:sql{TRUNCATE TABLE $self.exchangeRateTable.name}]
# Получаем дату курса валют
		$e_date[^dailyExchange.selectString[string(/ValCurs/@Date)]]
# Разбираем дату на день, месяц и год
		$params[^e_date.split[.;lh]]
# Формируем дату для SQL
		$e_date[${params.2}-${params.1}-${params.0}]
# Получаем список валют
		$list[^dailyExchange.select[/ValCurs/Valute]]
# Пробегаем каждую валюту
		^for[i](0;$list-1){
			$value[^list.$i.selectString[string(Value)]]
			$value(^value.replace[,;.])
			$res[^void:sql{
				INSERT INTO $self.exchangeRateTable.name
					(valute_id, num_code, char_code, nominal, name, value, date)
				VALUES
					(
						'^list.$i.getAttribute[ID]',
						^list.$i.selectString[string(NumCode)],
						'^list.$i.selectString[string(CharCode)]',
						^list.$i.selectString[string(Nominal)],
						'^list.$i.selectString[string(Name)]',
						$value,
						'$e_date'
					)
			}]
		}
	}{
		$exception.handled(true)
	}
}
################################################################################
@GetConvertingCoefficient[mainCurrency;transferCurrency]
^if(!def $mainCurrency){$mainCurrency[USD]}{$mainCurrency[$mainCurrency]}
^if(!def $transferCurrency){$transferCurrency[RUB]}{$transferCurrency[$transferCurrency]}
# Определяем курс главной валюты относительно рубля
^if($mainCurrency ne 'RUB'){
	$mainExchangeRubRate(^self.GetCurrencyRate[$mainCurrency])
}{
	$mainExchangeRubRate(1)
}
# Определяем курс конвертируемой валюты относительно рубля
^if(def $transferCurrency){
	^if($transferCurrency ne 'RUB'){
		$transferExchangeRubRate(^self.GetCurrencyRate[$transferCurrency])
	}{
		$transferExchangeRubRate(1)
	}
}
# Определяем коэффициент конвертирования цены из валюты $mainCurrency в валюту $transferCurrency
$result(^eval($mainExchangeRubRate/$transferExchangeRubRate))
################################################################################
@GetCurrencyRate[charCode]
$currency[^table::sql{SELECT nominal, value AS rate FROM $self.exchangeRateTable.name WHERE char_code="$charCode"}]
$result(^eval($currency.rate/$currency.nominal))
################################################################################
@ConvertPrice[mainCurrency;transferCurrency;value;count]
^if(!def $count){$count(2)}
$new_price(^eval($value * ^self.GetConvertingCoefficient[$mainCurrency;$transferCurrency]))
$result(^new_price.format[%.${count}f])
################################################################################