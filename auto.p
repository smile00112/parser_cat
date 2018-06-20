################################################################################
@include[file][_fd]
# Оператор @include[]. В случае отсутствия файла НЕ ВЫЗЫВАЕТ
# фатальной ошибки, а только выводит предупреждение.
#
^if(-f $file){
	$_fd[^file::load[text;$file]]
	$result[^process[$caller.self]{^taint[as-is][$_fd.text]}[$.file[$file]]]
}{
	$result[^process[$caller.self]{<br><font color="red"><b>Warning! Оператор ^^#5einclude[$file] не нашел файл!</b></font><br>}]
}
################################################################################
@auto[]
$cf[^file:fullpath[./]]
$parts[^cf.split[/;lh]]
$CLASS_PATH[^table::create{path
/classes
/classes/modules
/classes/modules/social
/${parts.1}/classes/
}]
################################################################################
@main[]
^connect[$site:connectString]{
	$site[^site::create[]]
	^if(!$site.design){
		^head[]
		^body[]
	}{$response:refresh[$.value(0)$.url[/design/]]}
}
##############################################################################
@head[]
################################################################################
@ShowTemplate[filename;params]
^if(-f "$filename"){
	^try{
		^if(!def $params){$params[^hash::create[]]}
		^if(!def $params.context){$params.context[$caller.self]}
		$t[^file::load[text;$filename]]
		$result[^process[$params.context]{^taint[as-is][$t.text]}][$.file[$t]]
	}{
		$exception.handled(true)
		^ShowException[$exception]
	}
}{
	$result[<h1>Шаблон $filename не найден</h1>]
}
################################################################################
@ShowException[exception]
<h1 align="center">Ошибка загрузки шаблона</h1>
<p align="center">Функция: <strong>$exception.source</strong>, ошибка: <strong>$exception.comment</strong></p>
<p align="center">Файл: <strong>$exception.file</strong>, строка: <strong>$exception.lineno</strong></p>
#^var_dump[$exception]
################################################################################
@body_init[]
################################################################################
@body[]
^body_init[]
^if($site.block==1 && $site.currentPage.id>0){
	$response:refresh[$.value(0)$.url[/errors/block/]]
}{
	^if($site.currentPage.id==$site.mainPageId){
		^if(-f '/${site.templateFolder}/main.html'){$tmplName[main]}{$tmplName[index]}
		^ShowTemplate[/${site.templateFolder}/${tmplName}.html]
	}{
		^if(-f "/${site.templateFolder}/index_${site.currentPage.id}.html"){
			^ShowTemplate[/${site.templateFolder}/index_${site.currentPage.id}.html]
		}{
			^if(-f "/${site.templateFolder}/index_${site.currentPage.parent}.html"){
				^ShowTemplate[/${site.templateFolder}/index_${site.currentPage.parent}.html]
			}{
				^if(def $form:print && $form:print eq yes){
					^ShowTemplate[/${site.templateFolder}/print.html]
				}{
					^if(-f "/${site.templateFolder}/${site.currentPage.class}.html"){
						^ShowTemplate[/${site.templateFolder}/${site.currentPage.class}.html]
					}{
						^ShowTemplate[/${site.templateFolder}/index.html]
					}
				}
			}
		}
	}
}
################################################################################
@text[]
^try{
	$module[^text_extended::init[$site.currentPage.id]]
	^module.show[]
}{
	$exception.handled(true)
	^ShowException[$exception]
}
################################################################################
@unhandled_exception[exception;stack]
^try{
	^mail:send[
		$.from[admin@${env:SERVER_NAME}]
		$.to[info@websun-com.ru]
		$.subject[$env:SERVER_NAME - Ошибка]
		$.html{
			<title>UNHANDLED EXCEPTION (root)</title>
			<body bgcolor=white>
			<font color=black>
			<pre>^untaint[html]{$exception.comment}</pre>
			^if(def $exception.source){
				<b>$exception.source</b><br />
				<pre>^untaint[html]{$exception.file^($exception.lineno^)}</pre>
			}
			^if(def $exception.type){exception.type=$exception.type}
			^if($stack){
				<hr />
				^stack.menu{
					<tt>$stack.name</tt> $stack.file^($stack.lineno^)<br />
				}
			}
		}
	]
}{
	$exception.handled(true)
}
^if($form:debug eq "master" || -f "/nocopy.z"){
	^unhandled_exception_debug[$exception;$stack]
}{
	^if($exception.type eq "file.missing"){
		<h1>Файл не найден!</h1>
	}{
		<h1>Ошибка: $exception.type</h1>
	}
}
################################################################################
@var_dump[variable;nested][nextNested]
^if(!def $nested){$nested(0)}
^switch[$variable.CLASS_NAME]{
	^case[string]{$answerDump[($variable.CLASS_NAME) $variable]}
	^case[bool]{$answerDump[($variable.CLASS_NAME) ^if($variable){true}{false}]}
	^case[table]{
		$answerDump[
		<style>
			.var_dump_table{
				margin-left: 20px^;
			}
			.var_dump_table td{
				text-align: center^;
				padding: 5px^;
			}
			.var_dump_table tr:first-child td{
				font-weight: bold^;
			}
		</style>
		]
		$columns[^variable.columns[]]
		$answerDump[${answerDump}($variable.CLASS_NAME) ^[<table class="var_dump_table"><tr>]
		^columns.menu{
			$answerDump[${answerDump}<td>$columns.column</td>]
		}
		$answerDump[$answerDump</tr><tr>]
		^variable.menu{
			^columns.menu{
				$answerDump[${answerDump}<td>$variable.[$columns.column]</td>]
			}
			$answerDump[$answerDump</tr><tr>]
		}
		$answerDump[$answerDump</tr></table>^]]
	}
	^case[hash]{
		$nextNested(^eval($nested+1))
		$answerDump[($variable.CLASS_NAME) ^[]
		^variable.foreach[key;value]{
			$answerDump[$answerDump<br><span style="padding-left: ^eval(($nested+1)*20)px^;"></span>$key -> ^var_dump[$value;$nextNested]]
		}
		$answerDump[$answerDump<br><span style="padding-left: ^eval($nested*20)px^;"></span>^]]
	}
	^case[site]{
		$nextNested(^eval($nested+1))
		$answerDump[($variable.CLASS_NAME) ^[]
		$variable[^reflection:fields[$variable.CLASS]]
		^variable.foreach[key;value]{
			$answerDump[$answerDump<br><span style="padding-left: ^eval(($nested+1)*20)px^;"></span>$key -> ^var_dump[$value;$nextNested]]
		}
		$answerDump[$answerDump<br><span style="padding-left: ^eval($nested*20)px^;"></span>^]]
	}
	^case[file]{
		$fileHash[
			$.name[$variable.name]
			$.size($variable.size)
			$.status($variable.status)
			$.mode[$variable.mode]
			$.SERVER[$variable.SERVER]
			$.DATE[$variable.DATE]
			$.content-type[$variable.content-type]
			$.text[$variable.text]
		]
		^if(def $variable.cdate){$fileHash.cdate[$variable.cdate]}
		^if(def $variable.mdate){$fileHash.mdate[$variable.mdate]}
		^if(def $variable.adate){$fileHash.adate[$variable.adate]}
		^if(def $variable.stderr){$fileHash.stderr[$variable.stderr]}
		^if(def $variable.tables){$fileHash.tables[$variable.tables]}
		^var_dump[$fileHash]
	}
	^case[DEFAULT]{
		$answerDump[Неизвестный класс <strong>$variable.CLASS_NAME</strong>: ^var_dump[^reflection:fields[$variable]]]
	}
}
$result[$answerDump]
################################################################################
@autouse[className]
^use[${className}.p;$.replace(true)]
################################################################################
@explode[separator;string][answer]
$parts[^string.split[$separator]]
$answer[^hash::create[]]
$counter(0)
^parts.menu{
	^if(def $parts.piece){
		^counter.inc[]
		$answer.[$counter][$parts.piece]
	}
}
$result[$answer]
################################################################################
#@postprocess[body]
#$body
#^use[Erusage.p]
#^Erusage:log[$.sFile[/cgi-bin/erusage.log]]
################################################################################
@htmlToString[string]
$string[^string.match[[\r\n]|(?:<).*?(?:>)][g]{ }]
$string[^string.match[(\.|:)(\S)][g]{$match.1 $match.2}]
$rep[^table::create{from	to
&nbsp^;
'	"
}]
$string[^string.replace[$rep]]
$result[^string.trim[]]
################################################################################
@str_replace[string;params]
^if(def $string && $params.CLASS_NAME eq 'hash'){
	$replaceData[from	to]
	^params.foreach[key;value]{
		$replaceData[${replaceData}^#0A$key	$value]
	}
	$result[^string.replace[^table::create{$replaceData}]]
}{
	$result[]
}
################################################################################
@EditLink[link;params]
^if(def $link){
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.domain){$params.domain[$site:domain]}
	$domainPos(^link.pos[$params.domain])
	^if($domainPos>-1){
		$link[^link.mid(^eval($domainPos+^params.domain.length[]))]
	}
	$result[$link]
}{
	^throw[
		$.type[missing.link]
		$.source[^@EditLink]
		$.comment[Не передана ссылка]
	]
}
################################################################################
#	Склонение числительных
@decline[number;suffix]
^if($number > 10 && (($number % 100) \ 10) == 1){
	$result[$suffix.2]
}{
	^switch($number % 10){
		^case(1){$result[$suffix.0]}
		^case(2;3;4){$result[$suffix.1]}
		^case(5;6;7;8;9;0){$result[$suffix.2]}
	}
}
################################################################################
@CutString[string;limit;dots]
# Если нужно ставить точки, то на 3 символа больше режем
^if(def $dots){$dot_count(3)}{$dot_count(0)}
# Если строка и лимит не менее 3-х символов
^if(^string.length[]>^eval($limit+$dot_count) && $limit>3){
# Убираем пробелы с концов строки
	$string[^string.trim[]]
# Высчитываем, сколько нужно обрезать
	$cut_count(^eval($limit-$dot_count+1))
# Обрезаем строку
	$res[^string.left($cut_count)]
# Получаем последний символ получившейся строки
	$char[^res.right(1)]
# Если он является пробелом
	^if($char eq ' '){
# Убираем его
		$res[^res.trim[]]
	}{
# Инициализируем счётчик
		$counter(^res.length[])
# Инициализируем позицию пробелом
		$pos(-1)
# Ищем первый справа пробел
		^while($pos==-1){
# Уменьшаем счётчик
			^counter.dec[]
# Ищем пробел
			$pos(^res.pos[ ]($counter))
		}
# Обрезаем строку до пробела
		$res[^res.left($pos)]
	}
# Если нужно, то ставим точки
	^if(def $dots){$result[${res}...]}{$result[$res]}
}{
	$result[$string]
}
################################################################################