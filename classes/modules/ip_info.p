################################################################################
@CLASS
ip_info
################################################################################
@auto[]
$self.serviceUrl[http://ipgeobase.ru:7020/geo?ip=]
$self.cities[^contacts:GetCities[]]
$self.currentIP[$env:REMOTE_ADDR]
$self.currentIPInfo[^self.GetIPInfo[$self.currentIP]]
################################################################################
@GetIPInfo[ip]
^if(def $ip){
	^try{
		$info[^xdoc::load[${self.serviceUrl}${ip}]]
		$node[^info.selectSingle[/ip-answer/ip]]
		$answer[
			$.ip[$ip]
			$.inetnum[^node.selectString[string(inetnum)]]
			$.country[^node.selectString[string(country)]]
			$.city[^node.selectString[string(city)]]
			$.region[^node.selectString[string(region)]]
			$.district[^node.selectString[string(district)]]
			$.lat[^node.selectString[string(lat)]]
			$.lng[^node.selectString[string(lng)]]
			$.error(false)
		]
		^if(^self.cities.locate[name;$answer.city]){
			$currentID($self.cities.id)
			$answer.cityInfo[^self.cities.select($self.cities.name eq $answer.city)]
		}
		$result[$answer]
	}{
		$exception.handled(true)
		$result[
			$.error(true)
			$.text[Ошибка при определении]
			$.exception[$exception]
		]
	}
}{
	$result[
		$.error(true)
		$.text[Не передан IP-адрес]
	]
}
################################################################################