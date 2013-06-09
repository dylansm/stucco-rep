$ ->
  $('.delete-user').each ->
    id = $(this).attr("data-id")
    $tr = $(this).closest('tr')
    $(this).click ->
      if confirm "Are you sure you want to delete this user?"
        $.ajaxSetup
          beforeSend: (xhr) ->
            token = $('meta[name="csrf-token"]').attr('content');
            if token
              xhr.setRequestHeader('X-CSRF-Token', token);
        $.ajax
          url: "/users/#{id}",
          type: 'post',
          dataType: 'json',
          data: {"_method": "delete"},
          success: (data, textStatus, xhr) ->
            $tr.hide()
          error: (response) ->
            console.log response

  #TODO Refactor this into one function?
  $('.suspend-user').each ->
    id = $(this).attr("data-id")
    $tr = $(this).closest('tr')
    $(this).click ->
      if confirm "Are you sure you want to suspend this user?"
        $.ajaxSetup
          beforeSend: (xhr) ->
            token = $('meta[name="csrf-token"]').attr('content');
            if token
              xhr.setRequestHeader('X-CSRF-Token', token);
        $.ajax
          url: "/users/#{id}/suspend",
          type: 'post',
          dataType: 'json',
          data: {"_method": "put"},
          success: (data, textStatus, xhr) ->
            $tr.addClass("suspended")
          error: (response) ->
            console.log response
