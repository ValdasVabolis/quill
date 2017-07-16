// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require turbolinks
//= require_tree .


/* global $*/

var show_hide_alert = function() {
  var el = $('.alert');
  el.addClass('shown');
  setTimeout(function() {
    el.removeClass('shown');
  }, 3000);

};

$(function() {
  show_hide_alert();

  $.each(['up', 'down'], function(i, o) {
    $(document).on('click', "button.post-vote-" + o, function() {
      var el = $(this).closest(".post-votes");
      var id = el.data("id");
      var url = "/users/posts/" + id + "/vote/" + o;
      return $.ajax({
        type: "POST",
        url: url,
        dataType: 'json',
        success: function(data) {
          console.log('yes');
          el.replaceWith(data.partial);
          return false;
        },
        error: function(data) {
          console.log('no');
          return false;
        }
      });
    });
  });
});
