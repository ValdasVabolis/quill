var Validation = (function($, m) {
  function Validator(config) {
    var o = config;
    var el = $(o.selector);
    var submit_btn = $(o.button)

    var subscribe = function() {
      el.on('keyup paste', 'input[type=text], textarea', on_change);
    };

    // TODO: validate the API
    var validate_config = function() {

    };

    var on_change = function(e) {
      var changed = $(this);
      var data = $.extend(true, el.serializeObject(), {
        model: o.model
      });
      submit_btn.prop('disabled', true);
      $.ajax({
        method: 'POST',
        url: o.endpoint,
        data: data
      }).done(function(response) {
        var async_error = el.find('.async-error');
        var errors = response.errors;
        var model_lower = o.model.toLowerCase();

        submit_btn.prop('disabled', response.n_errors > 0);
        submit_btn.closest('form').toggleClass('invalid', response.n_errors > 0);
        for(k in errors) {
          var input_name = model_lower + '[' + k + ']';
          var input = $('input[name="' + input_name + '"]');
          if(errors[k].length === 0) {
            input.prev('.async-error').remove();
          } else {
            var error_el = $('<div class="async-error"></div>');
            $.each(errors[k], function(i, err) {
              error_el.append('<p> * ' + err + '</p>')
            });
            if(input.parent().find('.async-error').length === 0) {
              input.before(error_el);
            } else {
              input.parent().find('.async-error').replaceWith(error_el);
            }
          }
        }
      });
    };

    var init = function() {
      validate_config();
      subscribe();
    };

    init();
  }

  return {
    init: function(config) {
      return new Validator(config);
    }
  };
}(jQuery));
$(document).on('turbolinks:load', function() {
  Validation.init({
    selector: '#form-question',
    model: 'Question',
    endpoint: '/validate',
    button: '#form-question input[type=submit]',
    validate: [
      'title',
      'body'
    ]
  });
});


