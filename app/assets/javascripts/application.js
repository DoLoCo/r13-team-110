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
//= require jquery
//= require bootstrap
//= require_self

var Collab = Collab || {};

(function (utils, undefined) {
	var $doc = $(document);

	utils.callAjaxService = function (route, type, data) {
		$doc.css('cursor', 'wait');

		var srvcCall = $.ajax({
							'url': route,
							'type': type,
							'data': data
						});

		srvcCall.done(function () {
			$doc.css('cursor', 'default');
		}).fail(function (data) {
			alert(data);
		});

		return srvcCall;
	};

})(Collab.utils = Collab.utils || {});

(function (theme, undefined){
	var routes = {};
})(Collab.theme = Collab.theme || {});
