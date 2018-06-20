################################################################################
@CLASS
exchange
################################################################################
@auto[]
$self.classVersion[1.0]
$self.classBuildDate[10.10.2017]
$self.classDeveloper[������� ����� ���������]
$self.className[exchange]
$self.classDescription[���� �����]
$self.classModuleDescription[���� �����]
$self.classHistory[
	<p align="justify">
		<strong><u>������ $self.classVersion ($self.classBuildDate):</u></strong>
		<ol>
			<li>������ ����� ${self.className}.</li>
		</ol>
	</p>
]
#----------------------------- ������� ���������� ------------------------------
# ������� "���� �����"
$self.exchangeRateTable[
	$.name[exchange_rate]
	$.file[exchange_rate.table]
]
# �������� ������� ����
$self.now[^date::now[]]
$self.date[^date::now(^if($self.now.hour>18){1}{0})]
# ���� XML
$self.xmlFile[http://cbr.ru/scripts/XML_daily.asp?date_req=^self.date.day.format[%02d]/^self.date.month.format[%02d]/$self.date.year]
################################################################################
@create[]
# �������� ���� ���������� ���������� �� ��
^try{
	$value[^string:sql{SELECT MAX(date) FROM $self.exchangeRateTable.name}]
}{
	$exception.handled(true)
	$res[^void:sql{TRUNCATE TABLE $self.exchangeRateTable.name}]
}
^if(def $value){
	$bd_date[^date::create[$value]]
}
# ���� ������� ���� ������ ���������� �� ��
^if( !def $value || $self.now >= $bd_date ){
# ������� �������� ���� �����
	^try{
# ��������� XML � ������ �����
		$dailyExchange[^xdoc::load[$self.xmlFile]]
# ������� ���������� �������
		$res[^void:sql{TRUNCATE TABLE $self.exchangeRateTable.name}]
# �������� ���� ����� �����
		$e_date[^dailyExchange.selectString[string(/ValCurs/@Date)]]
# ��������� ���� �� ����, ����� � ���
		$params[^e_date.split[.;lh]]
# ��������� ���� ��� SQL
		$e_date[${params.2}-${params.1}-${params.0}]
# �������� ������ �����
		$list[^dailyExchange.select[/ValCurs/Valute]]
# ��������� ������ ������
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
# ���������� ���� ������� ������ ������������ �����
^if($mainCurrency ne 'RUB'){
	$mainExchangeRubRate(^self.GetCurrencyRate[$mainCurrency])
}{
	$mainExchangeRubRate(1)
}
# ���������� ���� �������������� ������ ������������ �����
^if(def $transferCurrency){
	^if($transferCurrency ne 'RUB'){
		$transferExchangeRubRate(^self.GetCurrencyRate[$transferCurrency])
	}{
		$transferExchangeRubRate(1)
	}
}
# ���������� ����������� ��������������� ���� �� ������ $mainCurrency � ������ $transferCurrency
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