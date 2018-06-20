################################################################################
@CLASS
captcha
################################################################################
@create[]
################################################################################
@auto[]
$self.classVersion[1.0]
$self.classBuildDate[04.05.2017]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[captcha]
$self.classDescription[Класс для работы Капчи]
$self.classModuleDescription[Капча]
$self.classHistory[
	<p align="justify">
		<strong><u>Версия $self.classVersion ($self.classBuildDate):</u></strong>
		<ol>
			<li>Создан класс <strong>${self.className}.p</strong> ($self.classDescription) для работы с капчей.</li>
		</ol>
	</p>
]
# Таблица "Комментарии"
$self.captchaTable[
	$.name[control_image]
	$.file[control_image.table]
]

# Путь к капче
$self.captchaPath[/modules/captcha/]
$self.defaultParams[
	$.width(80)
	$.height(35)
	$.bgcolor[ffffff]
]
################################################################################
@GetClassInfo[]
$result[
	$.version[$self.classVersion]
	$.build_date[$self.classBuildDate]
	$.developer[$self.classDeveloper]
	$.module_name[$self.className]
	$.module_description[$self.classModuleDescription]
	$.history[$self.classHistory]
]
################################################################################
@GetCaptcha[params]
^if(def $params.bgcolor){$bgcolor($params.bgcolor)}{$bgcolor[$self.defaultParams.bgcolor]}
^try{
	$now[^date::now[]]
	$expiration_date[^date::create($now+12/24)]
	$answer[^eval(^math:random(8999)+1000)]
	^void:sql{INSERT INTO $self.captchaTable.name (answer, expiration) VALUES ('$answer', '^expiration_date.sql-string[]')}
	$answerId(^int:sql{SELECT id FROM $self.captchaTable.name WHERE answer=$answer AND expiration='^expiration_date.sql-string[]'})
	^void:sql{DELETE FROM $self.captchaTable.name WHERE expiration<'^now.sql-string[]'}
	$result[
		$.error(false)
		$.answerId($answerId)
		$.imagePath[${self.captchaPath}?bgcolor=$bgcolor&c=$answerId]
	]
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.exception[$exception]
		$.text[Ошибка генерации CAPTCHA]
	]
}
################################################################################
@GetAnswer[id]
$result[^string:sql{SELECT answer FROM $self.captchaTable.name WHERE id=$id}[$.default[]]]
################################################################################
@CheckAnswer[answerId;answer]
$dbAnswer(^int:sql{SELECT answer FROM $self.captchaTable.name WHERE id='$answerId'}[$.default(-1)])
^if($dbAnswer>-1){^void:sql{DELETE FROM $self.captchaTable.name WHERE id='$answerId'}}
^if(def $answer && $answer==$dbAnswer){
	$result(true)
}{
	$result(false)
}
################################################################################