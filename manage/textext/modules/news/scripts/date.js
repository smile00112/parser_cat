$(function(){
	$(".datepicker").datepicker({
			dateFormat : 'yy-mm-dd',
			monthNames: ['Января','Февраля','Марта','Апреля','Мая','Июня','Июля','Августа','Сентября','Октября','Ноября','Декабря'],
			dayNamesMin: ['Вс','Пн','Вт','Ср','Чт','Пт','Сб'],
			firstDay: 1,
			showAnim: 'slideDown',
			duration: 'slow'
	 });
});

$(function(){
	$(".timepicker").timepicker({
			hourText: 'Часы',
			minuteText: 'Минуты',
			showPeriodLabels: false
	});
});