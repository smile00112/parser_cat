################################################################################
@CLASS
sitemap
################################################################################
@auto[]
$self.classVersion[1.0]
$self.classBuildDate[06.09.2017]
$self.classDeveloper[������� ����� ���������]
$self.className[sitemap]
$self.classDescription[����� ������ "����� �����"]
$self.classModuleDescription[����� �����]
$self.classHistory[
	<p align="justify">
		<strong><u>������ $self.classVersion ($self.classBuildDate):</u></strong>
		<ol>
			<li>������ ����� ��� ������ "$self.classModuleDescription"</li>
		</ol>
	</p>
]
# ���� � �������
$self.folders[
	$.main[/$self.className]
]
# ��������� ������
$self.settings[
	$.template[]
]
################################################################################
@create[blockId]
$self.blockId($blockId)
$self.pageId(^textext:GetPageIdByBlockId[$self.blockId])
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
@Show[params]
^use[${site:templateFolder}$self.folders.main/sitemap.html]
$sitemap[^site:GetPages[;;a,b]]
^try{^ShowSitemapTemplate[$sitemap]}{^site:Catch[$exception;<h1>������ �������� �������!</h1>]}
################################################################################