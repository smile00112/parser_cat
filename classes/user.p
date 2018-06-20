################################################################################
@CLASS
user
################################################################################
@auto[]
$self.classVersion[1.04]
$self.classBuildDate[04.04.2018]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[accounts]
$self.classDescription[Класс модуля "Аккаунты"]
$self.classModuleDescription[Аккаунты]
$self.classHistory[
	<p align="justify">
		<strong><u>Версия $self.classVersion ($self.classBuildDate):</u></strong>
		<ol>
			<li>В функции <font color="red">^@ShowUserAccount</font>[params], заменён параметр <strong>user</strong> на параметр <strong>params</strong> и контекст вызова шаблона.</li>
			<li>Добавлена функция <font color="red">^@ShowTemplate</font>[template^;params], которая сохраняет значение <strong>value</strong> поля <strong>field</strong> для пользователя <strong>id</strong>.</li>
			<li>Удалена функция <font color="red">^@ShowLastRegUsers[usersCount]</font>, так как теперь можно использовать ^@ShowTemplate для вызова <strong>lastRegUsersForm.html</strong>.</li>
			<li>Удалена функция <font color="red">^@ShowUserWall[userId]</font>, так как теперь можно использовать ^@ShowTemplate для вызова <strong>userWallForm.html</strong>.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.03 (17.01.2018):</u></strong>
		<ol>
			<li>В функцию <font color="red">^@ShowRegistrationForm</font>[params], добавлен параметр <strong>params</strong> (пока для передачи шаблона при оформлении заказа).</li>
			<li>Убрана переменная <strong>self</strong>, которая передавалась в функции вывода шаблонов.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.02 (17.06.2017):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@UpdateUserField</font>[id^;field^;value], которая сохраняет значение <strong>value</strong> поля <strong>field</strong> для пользователя <strong>id</strong>.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.02 (17.06.2017):</u></strong>
			<li>Все пути помещены в переменную <font color="red">^$self.folders</font>.</li>
			<li>Удалена функция <font color="red">^@SearchUsersByFio[search]</font>, так как теперь нет поля <strong>fio</strong>.</li>
			<li>Удалена функция <font color="red">^@GetUserNameById[id]</font>.</li>
	</p>
	<p align="justify">
		<strong><u>Версия 1.01 (24.03.2017):</u></strong>
		<ol>
			<li>Переделана функция <font color="red">^@GetUsers</font>[params]. Теперь она получает только 1 параметр <strong>params</strong> и при ошибке возвращает хэш.</li>
			<li>Добавлена переменная <font color="red">^$self.perPage</font>, которая отвечает за количество аккаунтов на странице.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.0 (24.03.2017):</u></strong>
		<ol>
			<li>Создан класс для работы с аккаунтами</li>
		</ol>
	</p>
]
# Таблица "Пользователи"
$self.usersTable[
	$.name[auth_accounts]
	$.file[auth_accounts.table]
]
# Таблица "Сообщения пользователей"
$self.messagesTable[
	$.name[messages]
	$.file[messages.table]
]
# Таблица "Галерея пользователей"
$self.imagesTable[
	$.name[user_gallery]
	$.file[user_gallery.table]
]
# Таблица "Галерея пользователей"
$self.blogTable[
	$.name[blog]
	$.file[blog.table]
]
# Пути к пользовательским папкам
$self.folders[
	$.template[/user]
	$.main[/modules/user]
	$.user[
# Пути к аватаркам
		$.avatars[
			$.source[/images/user/avatars/src]
			$.big[/images/user/avatars/big]
			$.small[/images/user/avatars/small]
		]
# Пути к изображениям пользователя
		$.images[
			$.source[/images/user/images/src]
			$.big[/images/user/images/big]
			$.small[/images/user/images/small]
		]
		$.blogImages[/images/user/blog]
		$.files[/user/files]
		$.registration[/modules/registration]
		$.account[/modules/user/account]
		$.messages[/modules/user/messages]
		$.videos[/modules/user/videos]
		$.blog[/modules/user/blog]
		$.content[/modules/user/content]
		$.comments[/modules/user/comments]
		$.settings[/modules/user/settings]
		$.orders[/modules/user/orders]
		$.works[/modules/user/works]
	]
	$.search[${self.folders.main}/search]
]
# Ширина аватарок
$self.avatarsWidth[
	$.small(200)
	$.big(800)
]
# Ширина изображений
$self.imagesWidth[
	$.small(220)
	$.big(800)
]
# Соотношение сторон изображения
$self.imagesAspectRatio(^eval(800/600))
$self.perPage(50)
################################################################################
@create[]
$self.auth[^auth::create[]]
$self.oImg[^NConvert::create[$.sScriptPath[/cgi-bin/]$.sScriptName[nconvert]]]
# Данные о пользователе
$user_info[^self.auth.getUserByID[$self.auth.session.user_id]]
$self.isRegUser(^if(def $user_info){1}{0})
$self.tableColumns[^site:GetTableColumns[$self.usersTable.name]]
^self.tableColumns.menu{
	$self.[$self.tableColumns.Field][$user_info.[$self.tableColumns.Field]]
}
# Видеоматериалы
$self.videos[^video::create[]]
# ------------------------------------------------------------------------------
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
@ImageResize[src;dest;w;h;sFormat]
$params[
	$.bKeepRatio[1]
	$.sResizeType[decr]
]
^if(def $w && def $h){
	^self.oImg.resize[$src;$dest;$w;$h;$params]
}{
	^if(def $w){
		^self.oImg.resize[$src;$dest;$w;99999;$params]
	}{
		^self.oImg.resize[$src;$dest;99999;$h;$params]
	}
}
################################################################################
@ShowUserInfoLink[service;text]
$rep[^table::create{from	to
www.
twitter.com/
facebook.com/
profile.php?id=
vkontakte.ru/
vk.com/
odnoklassniki.ru/
my.mail.ru/
^#page=
/mail/
^#!/
/?
}]

^switch[$service]{
	^case[user_skype]{$result[<a href="skype:$text?call">$text</a>]}
	^case[user_facebook]{$id[^text.replace[$rep]] $result[<a href="http://facebook.com/profile.php?id=$id" target="_blank">$id</a>]}
	^case[user_vkontakte]{$id[^text.replace[$rep]] $result[<a href="http://vk.com/$id" target="_blank">$id</a>]}
	^case[user_odnoklassniki]{$id[^text.replace[$rep]] $result[<a href="http://odnoklassniki.ru/$id" target="_blank">$id</a>]}
	^case[user_mailru]{$id[^text.replace[$rep]] $result[<a href="http://my.mail.ru/mail/$id" target="_blank">$id</a>]}
	^case[user_twitter]{$id[^text.replace[$rep]] $result[<a href="http://twitter.com/$id" target="_blank">$id</a>]}
	^case[site]{$result[<a href="http://$text" target="_blank">$text</a>]}
	^case[DEFAULT]{$result[$text]}
}
################################################################################
@ShowTemplate[template;params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.folder){$params.folder[${site:templateFolder}$self.folders.template/]}
^include[${params.folder}${template}]
^try{
	^self.ShowTemplate[$params]
}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
################################################################################
# Удалить и использовать ShowTemplate
@ShowAuthForm[]
^use[${site:templateFolder}${self.folders.template}/authForm.html]
^try{^ShowAuthFormTemplate[]}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
################################################################################
# Удалить и использовать ShowTemplate
@ShowUserProfile[user]
^use[${site:templateFolder}$self.folders.template/userProfileForm.html]
^try{^ShowUserProfileTemplate[$user]}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
################################################################################
# Удалить и использовать ShowTemplate
@ShowUserAccount[params]
^include[${site:templateFolder}$self.folders.template/userAccountForm.html]
^try{
	^self.ShowUserAccountTemplate[$params]
}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
################################################################################
# Удалить и использовать ShowTemplate
@ShowRegistrationForm[params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.template){$params.template[regForm.html]}
^use[${site:templateFolder}${self.folders.template}/${params.template}]
^try{^ShowRegFormTemplate[$params]}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
################################################################################
@GetCountNotReadMessages[userId]
$result[^int:sql{SELECT COUNT(*) FROM $self.messagesTable.name WHERE u_to='$userId' AND flag_read='0'}]
################################################################################
@GetProfileImages[userId;limitCount]
^if(!def $limitCount){$limitCount(-1)}
$result[^table::sql{SELECT * FROM $self.imagesTable.name WHERE user_id='$userId' ORDER BY id DESC}[$.limit($limitCount)]]
################################################################################
@GetCountAllUsers[]
$result[^int:sql{SELECT COUNT(*) FROM $self.usersTable.name}]
################################################################################
@GetAllUserMessages[userId]
$result[^table::sql{SELECT * FROM $self.messagesTable.name WHERE u_to='$userId' OR u_from='$userId' ORDER BY date_msg DESC}]
################################################################################
@GetAllUserLastMessages[userId]
$result[^table::sql{SELECT * FROM $self.messagesTable.name WHERE date_msg IN (SELECT MAX(date_msg) FROM $self.messagesTable.name WHERE u_to=$userId OR u_from=$userId GROUP BY u_to+u_from) ORDER BY date_msg DESC}]
################################################################################
@GetUsers[params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[create_date]}
	^if(!def $params.orderType){$params.orderType[ASC]}
	^if(!def $params.offsetCount){$params.offsetCount(0)}
	^if(!def $params.limitCount){$params.limitCount(-1)}
	^if($params.count){
		$fieldsSQL[COUNT(*)]
		$orderSQL[]
	}{
		$fieldsSQL[*]
		$orderSQL[ORDER BY $params.order $params.orderType]
	}
	$sql[
		SELECT $fieldsSQL
		FROM $self.usersTable.name
		WHERE 1=1
			^if(def $params.userId){AND id IN ($params.userId)}
			^if(def $params.block){AND block='$params.block'}
	]
	^if($params.count){
		$result(^int:sql{$sql $orderSQL}[$.default(0)])
	}{
		$result[^table::sql{$sql $orderSQL}[$.limit($params.limitCount)$.offset($params.offsetCount)]]
	}
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Ошибка выполнения]
		$.exception[$exception]
	]
}
################################################################################
@GetUserImagePath[id]
$result[^string:sql{SELECT path FROM $self.imagesTable.name WHERE user_id='$self.user_id' AND id='$id'}[$.default{}]]
################################################################################
@DelImage[id]
$ImagePath[^self.GetUserImagePath[$id]]
^if(def $ImagePath){
	$tmp[^file:delete[${self.sourceImagesFolder}/$self.user_id/${ImagePath}]]
	$tmp[^file:delete[${self.bigImagesFolder}/$self.user_id/${ImagePath}]]
	$tmp[^file:delete[${self.smallImagesFolder}/$self.user_id/${ImagePath}]]
	$result[^void:sql{DELETE FROM $self.imagesTable.name WHERE id='$id'}]
}{
	$result[-1]
}
################################################################################
@AddImage[image;description]
$unique[^math:uuid[]]
$ext[^file:justext[$image.name]]
$filename[${unique}.${ext}]
$source[${self.sourceImagesFolder}/$self.user_id/${filename}]
$big[${self.bigImagesFolder}/$self.user_id/${filename}]
$small[${self.smallImagesFolder}/$self.user_id/${filename}]
$tmp[^image.save[binary;$source]]
$tmp[^self.ImageResize[$source;$big;$self.bigImagesWidth;99999]]
$tmp[^self.ImageResize[$source;$small;$self.smallImagesWidth;99999]]
$result[^void:sql{INSERT INTO $self.imagesTable.name (user_id, path, descript) VALUES ('$self.user_id', '$filename','$description')}]
################################################################################
@DelAvatar[]
$source[${self.sourceAvatarsFolder}/${self.user_id}.$self.avatarExt]
$big[${self.bigAvatarsFolder}/${self.user_id}.$self.avatarExt]
$normal[${self.normalAvatarsFolder}/${self.user_id}.$self.avatarExt]
$small[${self.smallAvatarsFolder}/${self.user_id}.$self.avatarExt]
$error(0)
^if(-f $source){$tmp[^file:delete[$source]]}{$error(-1)}
^if(-f $big){$tmp[^file:delete[$big]]}{$error(-1)}
^if(-f $normal){$tmp[^file:delete[$normal]]}{$error(-1)}
^if(-f $small){$tmp[^file:delete[$small]]}{$error(-1)}
$result($error)
################################################################################
@AddAvatar[image]
$newImageExt[^file:justext[$image.name]]
$newImageExt[^newImageExt.lower[]]
$source[${self.sourceAvatarsFolder}/${self.user_id}.$newImageExt]
$big[${self.bigAvatarsFolder}/${self.user_id}.$newImageExt]
$small[${self.smallAvatarsFolder}/${self.user_id}.$newImageExt]
$tmp[^image.save[binary;$source]]
$tmp[^self.ImageResize[$source;$big;$self.bigAvatarsWidth;99999]]
$tmp[^self.ImageResize[$source;$small;$self.smallAvatarsWidth;99999]]
$result(0)
################################################################################
@GetCountDialogMessages[id]
$result(^int:sql{SELECT COUNT(*) FROM $self.messagesTable.name WHERE (u_to='$id' AND u_from='$self.user_id') OR (u_from='$id' AND u_to='$self.user_id')})
################################################################################
@GetDialogMessages[id;order;orderType]
^if(!def $order){$order[date_msg]}
^if(!def $orderType){$orderType[ASC]}
$result[^table::sql{SELECT * FROM $self.messagesTable.name WHERE (u_to='$id' AND u_from='$self.user_id') OR (u_from='$id' AND u_to='$self.user_id') ORDER BY $order $orderType}]
################################################################################
@SetReadedFlag[id]
$result[^void:sql{UPDATE $self.messagesTable.name SET flag_read=1 WHERE id=$id}]
################################################################################
@AddMessage[user_to;message]
$result[^void:sql{INSERT INTO $self.messagesTable.name (u_from, u_to, body, date_msg) VALUES ('$self.user_id', '$user_to', '$message', '^site:currentDate.sql-string[]')}]
################################################################################
@GetAllBlogPostsByUserId[id;order;orderType]
^if(!def $order){$order[dt]}
^if(!def $orderType){$orderType[ASC]}
$result[^table::sql{SELECT * FROM $self.blogTable.name WHERE user_id='$id' ORDER BY $order $orderType}]
################################################################################
@GetBlogPostById[id]
$result[^table::sql{SELECT * FROM $self.blogTable.name WHERE user_id='$self.user_id' AND id='$id'}]
################################################################################
@InsertPostToBlog[head;body;full_text]
$result[^void:sql{INSERT INTO $self.blogTable.name (dt, head, body, full_text, is_hidden, user_id) values ('^site:currentDate.sql-string[]', '$head', '$body', '$full_text', '0', '$self.user_id')}]
################################################################################
@GetHiddenValueFromBlogPostById[id]
$result[^int:sql{SELECT is_hidden FROM $self.blogTable.name WHERE id='$id'}]
################################################################################
@UpdateBlogPostById[id;head;body;full_text;ch_hide]
$hidden(^self.GetHiddenValueFromBlogPostById[$id])
^if(def $ch_hide){^if($hidden==0){$hidden(1)}{$hidden(0)}}
$result[^void:sql{UPDATE $self.blogTable.name SET ^if(def $head){head='$head',} ^if(def $body){body='$body',} ^if(def $full_text){full_text='$full_text',} is_hidden=$hidden WHERE id='$id' AND user_id='$self.user_id'}]
################################################################################
@GetBlogLastPosts[order;orderType]
^if(!def $order){$order[dt]}
^if(!def $orderType){$orderType[ASC]}
$result[^table::sql{SELECT * FROM $self.blogTable.name WHERE dt IN (SELECT MAX(dt) FROM $self.blogTable.name GROUP BY user_id) ORDER BY $order $orderType}]
################################################################################
@GetAvatarFromURL[src;user_id]
^if(!def $user_id){$user_id($self.id)}
^curl:options[$.library[libcurl.so.4]]
# Загружаем аватарку
^try{
	$newImageExt[^file:justext[$src]]
	$source[${self.folders.user.avatars.source}/${user_id}.${newImageExt}]
	$big[${self.folders.user.avatars.big}/${user_id}.${newImageExt}]
	$small[${self.folders.user.avatars.small}/${user_id}.${newImageExt}]
	$avatara[^curl:load[
		$.mode[binary]
		$.url[^taint[as-is][$src]]
		$.timeout(60)
	]]
# Сохраняем аватарку
	$tmp[^avatara.save[binary;$source]]
	$tmp[^self.ImageResize[$source;$big;$self.avatarsWidth.big]]
	$tmp[^self.ImageResize[$source;$small;$self.avatarsWidth.small]]
	^void:sql{UPDATE $self.usersTable.name SET avatar='${user_id}.${newImageExt}' WHERE id=$user_id}
	$result[
		$.error(false)
		$.text[Аватарка сохранена]
	]
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Ошибка выполнения функции]
	]
}
################################################################################
@UpdateUserField[id;field;value]
^try{
	^void:sql{UPDATE $self.usersTable.name SET $field='$value' WHERE id=$id}
	$result[
		$.error(false)
		$.text[Значение поля '$field' сохранено]
	]
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Ошибка выполнения функции]
		$.exception[$exception]
	]
}
################################################################################