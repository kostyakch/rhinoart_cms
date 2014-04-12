// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs

//= require acme/bootstrap
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.ru.js
//= require acme/jquery.cookie
//= require acme/jquery.masonry.min

// require gallery_images

//= require_tree .
//= require_self


$(function(){
	if($('#content').height() > $('#sidebar-left2').height()) {
		//$('#sidebar-left2').height( $('#content').height() + 40);
	} else {
		//$('#content').height( $('#sidebar-left2').height() - 40);
	}	

	
})


