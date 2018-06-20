1) Скопировать класс sync.p в папку /classes (в старых CMS /class)
2) Скопировать в папку /manage папку /api/news
3) В файле /manage/api/news/auto.p поменять значение переменной $newsPageId на id страницы новостей конкретного сайта
4) Заменить файл /manage/textext/modules/news/gallery_add.html (в старых CMS /manage/news/gallery_add.html)
5) Проверить в этом файле путь к классу NConvert.p (в старых CMS: /class/, в новых - /classes/)