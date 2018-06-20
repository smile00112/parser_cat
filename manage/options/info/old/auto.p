################################################################################
@auto[]
^use[site.p;$.replace(true)]
^connect[$site:connectString]{
	^use[system.p]
	$this[^system::create[]]
#	^cms.SetCurrentModule[info]
}
################################################################################
@UserCheck[]
$errors(0)
<table border="0" cellpadding="5">
^this.users.good.menu{
 ^if(!^this.GetCmsUserByLogin[$this.users.good.login]){<tr><td>Пользователь <font color="red"><strong>$this.users.good.fio</strong></font> не зарегистрирован в системе.</td><td><a href="">Установить</a></td></tr>^errors.inc[]}
 ^if(^this.GetCmsUserByLogin[$this.users.bad.login]){<tr><td>Пользователь <font color="red"><strong>$this.users.bad.fio</strong></font> не зарегистрирован в системе.</td><td><a href="">Установить</a></td></tr>^errors.inc[]}
}
^this.users.bad.menu{
 ^if(^this.GetCmsUserByLogin[$this.users.bad.login]){<tr><td>Пользователь <font color="red"><strong>$this.users.bad.fio</strong></font> зарегистрирован в системе.</td><td><a href="">Удалить</a></td></tr>^errors.inc[]}
}
^if($errors<1){<tr><td colspan="2"><font color="green"><strong>Проблем с пользователями не найдено</strong></font>}
</table>
################################################################################
@IntegrityCheck[]
<table border="0" cellspacing="1" cellpadding="5" bgcolor="#999999">
 <tr class="tH">
  <td>
   Директории
  </td>
  <td>
   Файлы
  </td>
  <td>
   Пользователи
  </td>
 </tr>
 <tr class="tN">
  <td>
   $flag(false)
   ^this.folders.menu{
    ^if(!-d "$this.folders.folder"){<p><font color="red"><strong>Папка "$this.folders.folder" - "$this.folders.description" не найдена!!!</strong></font></p> $flag(true)}
   }
   ^if(!$flag){<p><font color="green"><strong>Базовые директории найдены!!!</strong></font></p>}
  </td>
  <td>
   $flag(false)
   ^this.files.menu{
    ^if(!-f "$this.files.file"){<p><font color="red"><strong>Файл "$this.files.file" - "$this.files.description" не найден!!!</strong></font></p> $flag(true)}
   }
   ^if(!$flag){<p><font color="green"><strong>Базовые файлы найдены!!!</strong></font></p>}
  </td>
  <td>
   ^UserCheck[]
  </td>
 </tr>
</table>
################################################################################
@SeoAttributesCheck[]
<hr>
$content[^textext:GetModulePathByName[content]]
$clean_attributes[^this.GetAllCleanPagesAttributes[]]
^if(def $clean_attributes){
 <p><font color="red"><strong>SEO-атрибуты заполнены не на всех страницах!!!</strong></font></p>
 <table border="0" cellspacing="1" cellpadding="5" bgcolor="#999999">
  <tr class="tH">
   <td>
    Название страницы
   </td>
   <td>
    Родитель
   </td>
   <td>
    TITLE
   </td>
   <td>
    KEYWORDS
   </td>
   <td>
    DESCRIPTION
   </td>
  </tr> 
  ^clean_attributes.menu{
  <tr class="tN">
   <td>  
    <a href="/manage/$content/?contentid=$clean_attributes.id" alt="Перейти в наполнение" title="Перейти в наполнение">$clean_attributes.name</a>
   </td>
   <td>
    $clean_attributes.parent
   </td>
   <td>
    $clean_attributes.head
   </td>
   <td>
    $clean_attributes.keywords
   </td>
   <td>
    $clean_attributes.descript
   </td>
  </tr>
  }
 <table>
}{
 <p><font color="green"><strong>SEO-атрибуты на всех страницах заполнены!!!</strong></font></p>
}
################################################################################
@UrlCheck[]
<hr>
$structure[^textext:GetModulePathByName[structure]]
$clean_uri[^this.GetAllCleanPagesUri[]]
^if(def $clean_uri){
 <p><font color="red"><strong>Пути заполнены не на всех страницах!!!</strong></font></p>
 <table border="0" cellspacing="1" cellpadding="5" bgcolor="#999999">
  <tr class="tH">
   <td>
    Название страницы
   </td>
   <td>
    Родитель
   </td>
  </tr> 
  ^clean_uri.menu{
  <tr class="tN">
   <td>  
    <a href="/manage/$structure/#zap$clean_uri.id" alt="Перейти к странице" title="Перейти к странице">$clean_uri.name</a>
   </td>
   <td>
    $clean_uri.parent
   </td>
  </tr>
  }
 <table>
}{
 <p><font color="green"><strong>Пути на всех страницах заполнены!!!</strong></font></p>
}
################################################################################