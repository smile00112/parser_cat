################################################################################
@CLASS
geo
################################################################################
@auto[]
$self.serviceUrl[http://ipgeobase.ru:7020/geo?ip=]
################################################################################
@main[]
$self.info[^self.GetCityByIp[$env:REMOTE_ADDR]]
################################################################################
@GetCityByIp[ip]
^if(def $ip){
	^try{
		$info[^xdoc::load[${self.serviceUrl}${ip}]]
		$node[^info.selectSingle[/ip-answer/ip]]
		$result[
			$.ip[$ip]
			$.inetnum[^node.selectString[string(inetnum)]]
			$.country[^node.selectString[string(country)]]
			$.city[^node.selectString[string(city)]]
			$.region[^node.selectString[string(region)]]
			$.district[^node.selectString[string(district)]]
			$.lat[^node.selectString[string(lat)]]
			$.lng[^node.selectString[string(lng)]]
			$.error[
				$.code(0)
				$.text[Ошибок не найдено]
			]
		]
	}{
		$exception.handled(true)
		$result[
			$.error[
				$.code(-1)
				$.text[Ошибка при определении]
			]
		]
	}
}{
	$result[
		$.error[
			$.code(-2)
			$.text[Не передан IP-адрес]
		]
	]
}
################################################################################