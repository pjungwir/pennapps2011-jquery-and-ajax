// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function show_errors(errors) {
  return $.map(errors, function(elem, i) {
    return '<li>' + elem + '</li>';
  }).join("\n");
}

$(function() {
  $.ajaxSetup({dataType: 'json'});

  $('a.answer-link').click(function(event) {
    event.preventDefault();
    $('a.answer-link', $(this).parent()).removeClass('selected');
    $(this).addClass('selected');
    $.ajax({
      url: $(this).attr('href'),
      type: 'POST',
      success: function(data, status, xhr) {
        if (data.success) {
          $('#overall-match-score').html(data.success.score);
        } else {
          $('ul#notices').html(show_errors(data.errors));
        }
      },
      error: function(xhr, status, exception) {
        var msg = exception ? exception.message : '';
        $('ul#notices').html(show_errors(
          [status + ': ' + msg]
        ));
      }
    });
    return false;
  });
});
