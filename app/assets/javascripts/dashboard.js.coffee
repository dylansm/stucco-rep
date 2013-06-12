$ ->
  $('.delete-row').each ->
    path = $(this).attr("data-path")
    delete_confirm = $(this).closest('table').attr("data-delete-confirm")
    $tr = $(this).closest('tr')
    $(this).click ->
      if confirm delete_confirm
        $.ajaxSetup
          beforeSend: (xhr) ->
            token = $('meta[name="csrf-token"]').attr('content');
            if token
              xhr.setRequestHeader('X-CSRF-Token', token);
        $.ajax
          url: path,
          type: 'post',
          dataType: 'json',
          data: {"_method": "delete"},
          success: (data, textStatus, xhr) ->
            $tr.hide()
          error: (response) ->
            console.log response

  #TODO Refactor this into one function?
  $('.toggle-user').each ->
    id = $(this).attr("data-id")
    reactivate = $(this).closest('table').attr("data-reactivate")
    suspend = $(this).closest('table').attr("data-suspend")
    suspend_confirm = $(this).closest('table').attr("data-suspend-confirm")
    reactivate_confirm = $(this).closest('table').attr("data-reactivate-confirm")
    $tr = $(this).closest('tr')
    $(this).click ->
      $.ajaxSetup
        beforeSend: (xhr) ->
          token = $('meta[name="csrf-token"]').attr('content');
          if token
            xhr.setRequestHeader('X-CSRF-Token', token);
      $link = $(this)
      if @text == reactivate
        if confirm reactivate_confirm
          $.ajax
            url: "/users/#{id}/reactivate",
            type: 'post',
            dataType: 'json',
            data: {"_method": "put"},
            success: (data, textStatus, xhr) ->
              $tr.removeClass("suspended")
              $link.text(suspend)
            error: (response) ->
              console.log response
      else
        if confirm suspend_confirm
          $.ajax
            url: "/users/#{id}/suspend",
            type: 'post',
            dataType: 'json',
            data: {"_method": "put"},
            success: (data, textStatus, xhr) ->
              $tr.addClass("suspended")
              $link.text(reactivate)
            error: (response) ->
              console.log response
      return
