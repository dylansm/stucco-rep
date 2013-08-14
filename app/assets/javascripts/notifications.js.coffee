$ ->
  $("#all_students").each ->
    $form = $(this).parent()
    $(".btn.cancel").on("click", -> CFB.Utils.reset_chosen($form))
    $(this).on("change", ->
      if $(this).is(':checked')
        $(".notification_users").addClass("hidden")
        CFB.Utils.reset_chosen($form)
      else
        $(".notification_users").removeClass("hidden")
    )

  if CFB.touch
    $("a.delete-notification").on("touchstart", (e) => admin_delete_notification(e))
    $("a.alert-close").on("touchstart", (e) => user_dismiss_notification(e))
  else
    $("a.delete-notification").on("click", (e) => admin_delete_notification(e))
    $("a.alert-close").on("click", (e) => user_dismiss_notification(e))

  admin_delete_notification = (e) ->
    e.preventDefault()
    $notification = $(e.target).closest(".notification")
    id = $notification.attr("data-id")
    $.ajax
      url: "/admin/notifications/#{id}",
      type: 'post',
      dataType: 'json',
      data: {"_method": "delete"},
      success: (data, textStatus, xhr) =>
        remove_notification($notification)
      error: (response) ->
        console.log response

  remove_notification = ($notification) ->
    $notification = $notification.parent()
    $notification.fadeOut 'slow', ->
      $notification.detach()
    
  user_dismiss_notification = (e) ->
    e.preventDefault()
    $notification = $(e.target).closest(".notification")
    id = $notification.attr("data-id")
    $.ajax
      url: "/dismiss-notification/#{id}",
      type: 'post',
      dataType: 'json',
      data: { "_method", "patch" },
      success: (data, textStatus, xhr) =>
        remove_notification($notification)
      error: (response) ->
        console.log response

