@CLASS
calendar


@get_name_month[idmonth;param]
$result[^if(def $param){$b_months.$idmonth}{$c_months.$idmonth}]


####################################################
# возвращаем из даты SQL строку вида 23 января 2007
@PrintFormatDate[sdate]
$result[${sdate.day} ^self.get_name_month[${sdate.month}] ${sdate.year}]


@getNowSqlDate[]
$date_now[^date::now[]]  
${date_now.year}-${date_now.month}-${date_now.day}


@init[] 
$c_months[
	$.1[января]
	$.2[февраля]
	$.3[марта]
	$.4[апреля]
	$.5[мая]
	$.6[июня]
	$.7[июля]
	$.8[августа]
	$.9[сентября]
	$.10[октября]
	$.11[ноября]
	$.12[декабря]
]
$b_months[
	$.1[Январь]
	$.2[Февраль]
	$.3[Март]
	$.4[Апрель]
	$.5[Май]
	$.6[Июнь]
	$.7[Июль]
	$.8[Август]
	$.9[Сентябрь]
	$.10[Октябрь]
	$.11[Ноябрь]
	$.12[Декабрь]
]


@show_form[]
^styles_newsr[]
^calendar[]


###############################################################
@styles_newsr[]
<style>
.calendar_left {
	border: solid 1px #b0b0b0;
	font-family: Tahoma, Verdana;
	font-size: 11^;
	line-height: 14px;
}
.calendar_months, .calendar_days {
	border-right: none;
	font-family: Tahoma, Verdana;
	font-size: 11^;
	line-height: 14px;
	color: #737373;
}
.calendar_months {
	margin-top: 5;
	font-size: 11^;
}
.calendar_days td {
	text-align: center;
	font-size: 11^;
}
.calendar_right {
	border: solid 1px #b0b0b0;
	padding: 3px;
	font-size: 11^;
}
.calendar_current {
	color: #C59010;
	font-size: 11^;
}
.calendar_black {
	color: black;
	padding: 0 2 0 2;
	width: 14%;
}
.weekend {
	color: Maroon;
}
</style>






###############################################################
@calendar[]

$now[^date::now[]]
^if(def $form:idnews){
	$thisNews[^table::sql{select date_news from news where id='$form:idnews'}]
	$dt[^date::create[$thisNews.date_news]]
	$c_day[$dt.day]
	$c_month[$dt.month]
	$c_year[$dt.year]
}{
	^if(def $form:month && def $form:year){
		$c_month[$form:month]
		$c_year[$form:year]
		^if(def $form:day){
			$c_day[$form:day]
		}
	}{
		$c_month[$now.month]
		$c_year[$now.year]
	}
}
$calend[^date:calendar[rus]($c_year;$c_month)]
<p nowrap align="center" style="font-size: 17^; font-family: Tahoma^; color: #003399^; margin: 0 0 4 0">
^if(def $c_day){
	^eval($c_day)
}
^if(def $c_month){
	^if(def $c_day){
		$c_months.$c_month
	}{
		$b_months.$c_month
	}
}
$c_year
</p>
<p align="center">
<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center" class="calendar_left" style="padding: 0 6 0 3">
			<p align="center">
			<table width="140px" border="0" cellpadding="0" cellspacing="0" class="calendar_months">
				<tr>
					<td align="center" style="font-size: 18^; color: #003399^; padding-bottom: 6">^if(def $c_year){$c_year}{$now.year}</td>
				</tr>
				<tr>
					<td align="center">
						<nobr>
						^if(^hasPrev[] eq yes){
	 						<a href="?day=1&month=1&year=^eval(${c_year}-1)"><img src="/classes/i/calend/left.gif" width="28" height="10" border="0"/></a>
						}{
							<img src="/classes/i/calend/left-none.gif" width="28" height="10" border="0"/>
						}
						^if(^hasNext[] eq yes){
							<a href="?day=1&month=1&year=^eval(${c_year}+1)"><img src="/classes/i/calend/right.gif" width="28" height="10" border="0"/></a>
						}{
							<img src="/classes/i/calend/right-none.gif" width="28" height="10" border="0"/>
						}
 						</nobr>
					</td>
				</tr>
				<tr>
					<td align="center">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="calendar_days">
							^for[i](1;12){
								^if($i % 6 == 1 ){
									<tr>
								}
 								<td style="padding: 5 3 0 3">
									^if(^isThisYear[] eq yes){
#										Мы в календаре на текущий год
										^if($i <= $now.month){
											<a href="?year=$c_year&month=$i&day=1" ^if( ^eval($c_month) == $i ){class="calendar_current"}>^i.format[%02d]</a>
										}{
											^i.format[%02d]
										}
									}{
										<a href="?year=$c_year&month=$i&day=1" ^if( ^eval($c_month) == $i ){class="calendar_current"}>^i.format[%02d]</a>
									}
								</td>
								^if($i % 6 == 0){
									</tr>
								}
							}
 						</table>
					</td>
				</tr>
			</table>
			</p>
		</td>
	</tr>
	<tr height="34">
		<td><img src="/classes/i/calend/calen-center2.gif" height="34" width="153" /></td>
	</tr>
	<tr>
		<td class="calendar_right">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="calendar_days">
				<tr>
					<td class="calendar_black">пн</td>
					<td class="calendar_black">вт</td>
					<td class="calendar_black">ср</td>
					<td class="calendar_black">чт</td>
					<td class="calendar_black">пт</td>
					<td class="calendar_black">сб</td>
					<td class="calendar_black">вс</td>
				</tr>
				^calend.menu{
					<tr>
					^for[j](0;6){
						<td style="padding-top: 4">
							^if(def $calend.$j){
								^if((^isThisYear[] eq yes) && (^isThisMonth[] eq yes)){
#									Мы в календаре на текущий месяц текущего года
									^if($calend.$j <= $now.day){
										^if($j!=5 && $j!=6){
											<a href="?year=$c_year&month=$c_month&day=$calend.$j&idpar=$form:idpar" ^if( def $c_day && (^eval($c_day)==$calend.$j) ){class="calendar_current"}>$calend.$j</a>
										}{
											<a href="?year=$c_year&month=$c_month&day=$calend.$j&idpar=$form:idpar" ^if( def $c_day && (^eval($c_day)==$calend.$j) ){class="calendar_current"}{class="weekend"}>$calend.$j</a>
										}
									}{
										$calend.$j
									}
								}{
									^if($j!=5 && $j!=6){
										<a href="?year=$c_year&month=$c_month&day=$calend.$j" ^if(def $c_day && (^eval($c_day)==$calend.$j)){class="calendar_current"}>$calend.$j</a>
									}{
										<a href="?year=$c_year&month=$c_month&day=$calend.$j" ^if(def $c_day && (^eval($c_day)==$calend.$j)){class="calendar_current"}{class="weekend"}>$calend.$j</a>
									}
								}
							}{
								&nbsp^;
							}
						</td>
					}
					</tr>
				}
			</table>
		</td>
	</tr>
</table>
<p>







##############################################################################
@isThisYear[]
^if( ^eval($now.year) == ^eval($c_year) ){
	$result[yes]
}{
	$result[no]
}





##############################################################################
@isThisMonth[]
^if( ^eval($now.month) == ^eval($c_month) ){
	$result[yes]
}{
	$result[no]
}





##############################################################################
@hasPrev[]
$h_year(^eval($c_year))
$prev(^eval($h_year-1))
^MAIN:dbconnect[$newsTotal[^int:sql{select count(id) from news where date_news>='${prev}-01-01' and date_news<'${h_year}-01-01'}]]
^if($newsTotal > 0){
	$result[yes]
}{
	$result[no]
}





##############################################################################
@hasNext[][h_year]
$h_year(^eval($c_year))
^if($h_year < $now.year){
	$result[yes]
}{
	$result[no]
}
