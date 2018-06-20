################################################################################
@CLASS
polls
################################################################################
@auto[]
$self.classVersion[1.0]
$self.classBuildDate[20.07.2017]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[polls]
$self.classDescription[Класс модуля опросов]
$self.classModuleDescription[Опросы]
$self.classHistory[
	<p align="justify">
		<strong><u>Версия $self.classVersion ($self.classBuildDate):</u></strong>
		<ol>
			<li>Создан класс для модуля "Галерея"</li>
		</ol>
	</p>
]
# Таблица "Опросы"
$self.pollsTable[
	$.name[polls]
	$.file[polls.table]
]
# Таблица "Ответы опросов"
$self.pollsAnswersTable[
	$.name[polls_answers]
	$.file[polls_answers.table]
]
# Хэш типов элементов
$self.elementTypes[
	$.0[
		$.title[Опрос]
		$.titleRE[Опроса]
		$.titleRM[Опросов]
		$.name[poll]
	]
	$.1[
		$.title[Ответ]
		$.titleRE[Ответа]
		$.titleRM[Ответов]
		$.name[answer]
	]
]
# Путь к шаблону
$self.pollsFolder[/$self.className]
# Настройки модуля
$self.settings[
	$.template[]
]
################################################################################
@create[]
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
@ShowPoll[params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.template){$params.template[poll.html]}
^if(!def $params.show){$params.show[sequence]}
^try{
	$poll[^self.GetElements[$params]]
	^use[${site:templateFolder}${self.pollsFolder}/${self.settings.template}${params.template}]
	^ShowPollTemplate[$poll]
}{
	^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]
}
################################################################################
@GetElements[params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[p.sortir]}
	^if(!def $params.orderType){$params.orderType[ASC]}
	^if(!def $params.offsetCount){$params.offsetCount(0)}
	^if(!def $params.limitCount){$params.limitCount(99999)}
	^if(def $params.show){
		^switch[$params.show]{
			^case[onePoll]{
				$params.visible(1)
				$params.type(0)
				$params.limitCount(1)
				$params.orderType[DESC]
				^if(!def $params.user_ip){$params.user_ip[$env:REMOTE_ADDR]}
				$sql[
					$.additional_fields[,a.user_ip, INET_NTOA(a.user_ip) AS user_ip_string]
					$.joins[LEFT JOIN $self.pollsAnswersTable.name AS a ON a.poll_id=p.id AND a.user_ip=INET_ATON('$params.user_ip')]
				]
			}
			^case[sequence]{
				$params.visible(1)
				$params.type(0)
				$params.limitCount(1)
				$params.orderType[DESC]
				^if(!def $params.user_ip){$params.user_ip[$env:REMOTE_ADDR]}
				$sql[
					$.where[ AND p.id NOT IN (SELECT poll_id FROM `polls_answers` WHERE user_ip=INET_ATON('$params.user_ip'))]
				]
			}
			^case[DEFAULT]{}
		}
	}
	$result[^table::sql{
		SELECT p.* $sql.additional_fields
		FROM $self.pollsTable.name AS p
		$sql.joins
		WHERE 1=1
					^if(def $params.pollIDs){ AND p.id IN ($params.pollIDs)}
					^if(def $params.parent){ AND p.parent=$params.parent}
					^if(def $params.type){ AND p.type=$params.type}
					^if(def $params.visible){ AND p.visible=$params.visible}
					^if(def $params.main){ AND p.main=$params.main}
					$sql.where
		ORDER BY $params.order $params.orderType
	}[$.limit($params.limitCount) $.offset($params.offsetCount)]]
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.exception[$exception]]
		$.text[Во время выполнения произошла ошибка]
	]
}
################################################################################
@SaveAnswer[pollId;answerId;params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	$params.user_ip[^inet:aton[^if(def $params.user_ip){$params.user_ip}{$env:REMOTE_ADDR}]]
	$query_fields[poll_id, answer_id]
	$query_values[${pollId}, ${answerId}]
	^params.foreach[key;value]{
		^if($value ne ''){
			$query_fields[${query_fields}, $key]
			$query_values[${query_values}, '$value']
		}
	}
	^void:sql{INSERT INTO $self.pollsAnswersTable.name ($query_fields) VALUES ($query_values)}
	$answer[
		$.error(false)
		$.text[Ответ сохранён]
	]
}{
	$exception.handled(true)
	$answer[
		$.error(true)
		$.text[Ошибка выполнения функции]
	]
}
$result[$answer]
################################################################################
@GetPollStatistic[poll_id]
^try{
	$answer[
		$.answers[^table::sql{
			SELECT a.answer_id, p.name, COUNT(*) AS answers_count
			FROM $self.pollsAnswersTable.name AS a
			LEFT JOIN $self.pollsTable.name AS p ON p.id=a.answer_id
			WHERE a.poll_id=$poll_id
			GROUP BY a.answer_id
		}]
		$.answersCount(0)
	]
	^answer.answers.menu{
		$answer.answersCount(^eval($answer.answersCount+$answer.answers.answers_count))
	}
	$answer.answers[^answer.answers.hash[answer_id]]
	$allAnswers[^self.GetElements[$.parent($poll_id)]]
	^allAnswers.menu{
		^if(!def $answer.answers.[$allAnswers.id]){
			$answer.answers.[$allAnswers.id][
				$.answer_id($allAnswers.id)
				$.name[$allAnswers.name]
				$.answers_count(0)
			]
		}
	}
	^answer.answers.foreach[key;value]{
		$value.answers_percent(^math:round($value.answers_count/$answer.answersCount*100))
	}
}{
	$exception.handled(true)
	$answer[
		$.error(true)
		$.debug[$exception]
		$.text[Ошибка выполнения функции]
	]
}
$result[$answer]
################################################################################