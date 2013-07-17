$ ->
  $.ajaxSetup
    beforeSend: (xhr) ->
      token = $('meta[name="csrf-token"]').attr('content');
      if token
        xhr.setRequestHeader('X-CSRF-Token', token);

  $(".chzn-select").chosen()

  # choose program
  $("#user_current_program_id").chosen().change ->
    $(this).closest('form').submit()

  $('.delete-row, .remove-row').each ->
    path = $(this).attr("data-path")
    remove_only = ($(this).hasClass("remove-row"))
    if remove_only
      delete_confirm = $(this).closest('table').attr("data-remove-confirm")
      method = {"_method": "put"}
    else
      delete_confirm = $(this).closest('table').attr("data-delete-confirm")
      method = {"_method": "delete"}
    $tr = $(this).closest('tr')
    $(this).click ->
      if confirm delete_confirm
        $.ajax
          url: path,
          type: 'post',
          datatype: 'json',
          data: method,
          success: (data, textstatus, xhr) =>
            if data.deleted || data.removed
              $tr.hide()
              if remove_only
                add_existing_users()
            else
              alert data.message if data.message
          error: (response) ->
            console.log response
  
  add_existing_users = ->
    program_id = $("body").attr("data-program-id")
    if !!$("body").attr("data-admins")
      url = "/dashboard/admin/users/not-admin-in-program/#{program_id}"
    else
      url = "/dashboard/admin/users/not-in-program/#{program_id}"

    $.ajax
      url: url,
      type: 'get',
      dataType: 'json',
      success: (data, textStatus, xhr) =>
        tmpl = JST["user_select_options"]
        list_html = ''
        _.each(data, (user) ->
          name = "#{user.first_name} #{user.last_name}"
          id = user.id
          list_html += tmpl(id: id, name: name)
        )
        $list = $("#program_user_ids")
        $list.html(list_html)
        $list.trigger("liszt:updated");

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
      $link = $(this)
      if @text == reactivate
        if confirm reactivate_confirm
          $.ajax
            url: "/dashboard/admin/users/#{id}/reactivate",
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
            url: "/dashboard/admin/users/#{id}/suspend",
            type: 'post',
            dataType: 'json',
            data: {"_method": "put"},
            success: (data, textStatus, xhr) ->
              $tr.addClass("suspended")
              $link.text(reactivate)
            error: (response) ->
              console.log response
      return

  $('a.menu').click ->
    $('div.pagewrapper').toggleClass('nav-active')

  # $('.post-edit a.edit').click ->
  #   $(event.currentTarget).parent().toggleClass('edit-active')

  $('.post-edit a.edit').bind 'click', (event) =>
    $(event.currentTarget).parent().toggleClass('edit-active')

  # $('a.like-link').click ->
  #   $(event.currentTarget).toggleClass('liked')
  
  $('a.like-link').bind 'click', (event) =>
    $(event.currentTarget).toggleClass('liked')
  
  # new post js
  $('a.photo-upload-link').bind 'click', (event) =>
    $('a.photo-upload-link').toggleClass('selected')
    $('a.video-upload-link').removeClass('selected')
    
    $('.secondary-inputs').removeClass('choose-video')
    $('.secondary-inputs').toggleClass('choose-photo')
    
  $('a.video-upload-link').bind 'click', (event) =>
    $('a.video-upload-link').toggleClass('selected')
    $('a.photo-upload-link').removeClass('selected')
    
    $('.secondary-inputs').removeClass('choose-photo')
    $('.secondary-inputs').toggleClass('choose-video')
  
  $('a.mobile-new-post-toggle').bind 'click', (event) =>
    $('.new-post').toggleClass('mobile-new-post-active')
    
  # mobile-new-post-toggle  
    
    
    

