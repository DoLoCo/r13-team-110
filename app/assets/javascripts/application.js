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
//= require vendor/pusher.min.js
//= require vendor/mustache
//= require vendor/bootstrap
//= require vendor/knockout
//= require collab/collab
//= require collab/utils
//= require collab/user
//= require collab/member
//= require collab/idea
//= require collab/theme
//= require_self

var pusher = new Pusher('7f70dfd913c343fdb4d3');

// Pusher Test
var channel = pusher.subscribe('test_channel');
channel.bind('my_event', function(data) {
  alert(data.message);
});

ko.applyBindings(Collab.viewModelLocator);