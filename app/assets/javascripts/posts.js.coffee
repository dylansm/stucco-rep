$ ->
  $.ajaxSetup
    beforeSend: (xhr) ->
      token = $('meta[name="csrf-token"]').attr('content');
      if token
        xhr.setRequestHeader('X-CSRF-Token', token);

