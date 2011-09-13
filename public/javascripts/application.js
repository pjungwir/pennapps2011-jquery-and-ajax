// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function show_errors(errors) {
  return $.map(errors, function(elem, i) {
    return '<li>' + elem + '</li>';
  }).join("\n");
}

function euclidean_distance(x1, y1, x2, y2) {
  var tmp = Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2);
  return Math.sqrt(tmp);
}

function fibonacci(n) {
  // Optimization of fibonacci(n-2) + fibonacci(n-1)
  var results = [1, 1];
  var _fib = function(n) {
    if (!results[n]) {
      results[n] = _fib(n-2) + _fib(n-1);
    }
    return results[n];
  }
  return _fib(n);
}

function Dog(theName) {
  this.name = theName;

  this.speak = function() {
    alert(this.name + ' says "Woof!"');
  }
  
  this.fetch = function() {
    // ...
  }
}

function prev_slide() {
  var loc = $('a.prev-slide-link').attr('href');
  if (loc) {
    window.location = loc;
  }
}

function next_slide() {
  var loc = $('a.next-slide-link').attr('href');
  if (loc) {
    window.location = loc;
  }
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

  SyntaxHighlighter.all();

  $('button.euclid').click(function(event) {
    event.preventDefault();
    alert(euclidean_distance(2, 2, 5, 6));
    return false;
  });

  $('button.fib').click(function(event) {
    event.preventDefault();
    alert(fibonacci(25));
    return false;
  });

  $('button.fido').click(function(event) {
    var fido = new Dog("Fido");
    fido.speak();
  });

  $(document).keyup(function(event) {
    if (event.which == 39) {
      // left arrow
      next_slide();
    } else if (event.which == 37) {
      // right arrow
      prev_slide();
    }
  });
});
