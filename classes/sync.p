################################################################################
@CLASS
sync
################################################################################
@auto[]
$self.classVersion[1.22]
$self.classBuildDate[27.01.2016]
$self.classDeveloper[������� ����� ���������]
$self.className[sync]
$self.classDescription[����� ������ ������������� ������]
$self.classModuleDescription[������������� ������]
$self.classHistory[
	<p align="justify">
		<strong><u>������ ${self.classVersion} ($self.classBuildDate):</u></strong>
		<ol>
			<li>��������� ������� <font color="red">sitesCmsUsersTable</font>, ���������� ������ ������������� ��� CMS.</li>
			<li>��������� ������� <font color="red">^@GetUsersInfo</font>[], ������������ ���������� � ������������� CMS.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>������ 1.21 (06.12.2015):</u></strong>
		<ol>
			<li>��������� ������� <font color="red">sitesCmsModulesTable</font>, ���������� ������ ������� CMS.</li>
			<li>��������� ������� <font color="red">sitesCmsListTable</font>, ���������� ������ ������ � �������� �� CMS.</li>
			<li>��������� ������� <font color="red">^@GetModulesInfo</font>[], ������������ ���������� � ������� CMS.</li>
			<li>��������� ������� <font color="red">^@GetSavedCMSVersion</font>[siteName], ������������ ���������� � ������ CMS ����� <strong>siteName</strong> � ����.</li>
			<li>��������� ������� <font color="red">^@UpdateCMSVersion</font>[siteName^;cmsVersion], ���������� (��� �����������) ���������� � ����� <strong>siteName</strong> � ������ ��� CMS <strong>cmsVersion</strong> � ����.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>������ 1.2 (03.12.2015):</u></strong>
		<ol>
			<li>��������� ������� <font color="red">^@UpdateModuleVersion</font>[params], ����������� ���������� � ������ � ����.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>������ 1.1 (08.12.2013):</u></strong>
		<ol>
			<li>��������� ���������� <font color="red">syncFolder</font>, ���������� ���� � ������ �������������.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>������ 1.0 (17.11.2013):</u></strong>
		<ol>
			<li>������ ����� ��� ������ "������������� ������".</li>
		</ol>
	</p>
]
# ------------------------------------------------------------------------------
$self.syncTable[
	$.name[sync]
	$.file[sync.table]
]
# ------------------------------------------------------------------------------
$self.sitesCmsModulesTable[
	$.name[sites_cms_modules]
	$.file[sites_cms_modules.table]
]
# ------------------------------------------------------------------------------
$self.sitesCmsUsersTable[
	$.name[sites_cms_users]
	$.file[sites_cms_users.table]
]
# ------------------------------------------------------------------------------
$self.sitesCmsListTable[
	$.name[sites_cms_list]
	$.file[sites_cms_list.table]
]
# ------------------------------------------------------------------------------
$self.syncFolder[http://www.bryansk.in/CMS]
$self.syncFile[${self.syncFolder}/sync.html]

$self.apiFolder[/manage/api]
$self.newsFolder[/news]
$self.newsSyncFile[${self.apiFolder}${self.newsFolder}/newsAdd.html]
$self.newsImagesSyncFile[${self.apiFolder}${self.newsFolder}/newsImagesAdd.html]
$self.newsImagesGetFile[${self.apiFolder}${self.newsFolder}/newsImagesGet.html]
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
@GetSites[]
$result[^table::sql{SELECT * FROM $self.syncTable.name ORDER BY site}]
################################################################################
@GetSitesFromServer[]
$result[^table::load[$self.syncFile]]
################################################################################
@addSiteToSync[site;syncVersion;description]
$result[^void:sql{INSERT INTO $self.syncTable.name (site, syncVersion, description) VALUES ('$site', '$syncVersion', '$description')}]
################################################################################
@CreateNewsOnSite[newsId;siteName]
^try{
 $answer[^file::load[text;http://${siteName}${self.newsSyncFile}?site=${env:SERVER_NAME}&newsId=$newsId]]
 $result($answer.text)
}{
 $exception.handled(1)
 ^try{
  $answer[^file::load[text;http://www.${siteName}${self.newsSyncFile}?site=${env:SERVER_NAME}&newsId=$newsId]]
  $result($answer.text)
 }{$exception.handled(1) $result(-1)}
}
################################################################################
@LoadImagesToNews[newsId;siteName;remoteNewsId]
^try{
 $answer[^file::load[text;http://${siteName}${self.newsImagesSyncFile}?site=${env:SERVER_NAME}&newsId=$newsId&existNewsId=$remoteNewsId]]
 $result($answer.text)
}{
 $exception.handled(1)
 ^try{
  $answer[^file::load[text;http://www.${siteName}${self.newsImagesSyncFile}?site=${env:SERVER_NAME}&newsId=$newsId&existNewsId=$remoteNewsId]]
  $result($answer.text)
 }{$exception.handled(1) $result(-1)}
}
################################################################################
@GetModulesInfo[]
^if(!def $block_id){$block_id($self.blockId)}
$modules[^table::sql{SELECT id, name, version, site FROM $self.sitesCmsModulesTable.name}]
^if(def $modules){
	$fields[^table::sql{SHOW COLUMNS FROM $self.sitesCmsModulesTable.name WHERE Field != 'id'}]
# ������ XML-��������
	$document[^xdoc::create[modules]]
# ��������� ��� ������
	^modules.menu{
# ������ ��� module
		$moduleNode[^document.createElement[module]]
 ����������� ��� id
		^moduleNode.setAttribute[id;$modules.id]
# ��������� ��� ���� ��������
		^fields.menu{
# ������ ��� ���������
			$parameterNode[^document.createElement[$fields.Field]]
# ��������� �������� ���������
			$addedNode[^parameterNode.appendChild[^document.createTextNode[$modules.[$fields.Field]]]]
# ��������� ��� ���������
			$addedNode[^moduleNode.appendChild[$parameterNode]]
		}
# ��������� ��� module
		$addedNode[^document.documentElement.appendChild[$moduleNode]]
	}
# ������� ���������
	$result[^document.string[$.indent[yes]]]
}{$result[^hash::create[]]}
################################################################################
@GetUsersInfo[]
^if(!def $block_id){$block_id($self.blockId)}
$users[^table::sql{SELECT id, login, password, name, level, to_delete FROM $self.sitesCmsUsersTable.name}]
^if(def $users){
	$fields[^table::sql{SHOW COLUMNS FROM $self.sitesCmsUsersTable.name WHERE Field != 'id'}]
# ������ XML-��������
	$document[^xdoc::create[users]]
# ��������� ��� ������
	^users.menu{
# ������ ��� module
		$moduleNode[^document.createElement[user]]
 ����������� ��� id
		^moduleNode.setAttribute[id;$users.id]
# ��������� ��� ���� ��������
		^fields.menu{
# ������ ��� ���������
			$parameterNode[^document.createElement[$fields.Field]]
# ��������� �������� ���������
			$addedNode[^parameterNode.appendChild[^document.createTextNode[$users.[$fields.Field]]]]
# ��������� ��� ���������
			$addedNode[^moduleNode.appendChild[$parameterNode]]
		}
# ��������� ��� module
		$addedNode[^document.documentElement.appendChild[$moduleNode]]
	}
# ������� ���������
	$result[^document.string[$.indent[yes]]]
}{$result[^hash::create[]]}
################################################################################
@UpdateModuleVersion[params]
^if(def $params.module && def $params.version && def $params.site){
	^try{
		^if(^int:sql{SELECT COUNT(id) FROM $self.sitesCmsModulesTable.name WHERE name="$params.module"}){
			^void:sql{UPDATE $self.sitesCmsModulesTable.name SET version="$params.version", site="$params.site" WHERE name="$params.module"}
		}{
			^void:sql{INSERT INTO $self.sitesCmsModulesTable.name (name, version, site) VALUES ("$params.module", "$params.version", "$params.site")}
		}
		$result(1)
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@GetSavedCMSVersion[siteName]
^if(def $siteName){
	^try{
		$result(^double:sql{SELECT cms_version FROM $self.sitesCmsListTable.name WHERE site="$siteName"}[$.default(0)])
	}{
		$exception.handled(true)
		$result(-2)
	}
}{
	$result(-1)
}
################################################################################
@UpdateCMSVersion[siteName;cmsVersion]
^if(def $siteName && def $cmsVersion){
	^try{
		^if(^int:sql{SELECT COUNT(id) FROM $self.sitesCmsListTable.name WHERE site="$siteName"}){
			^void:sql{UPDATE $self.sitesCmsListTable.name SET cms_version="$cmsVersion", update_date=NOW() WHERE site="$siteName"}
		}{
			^void:sql{INSERT INTO $self.sitesCmsListTable.name (site, cms_version, update_date) VALUES ("$siteName", "$cmsVersion", NOW())}
		}
		$result(1)
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################