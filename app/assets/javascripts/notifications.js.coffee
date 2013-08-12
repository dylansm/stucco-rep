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
    $(".delete-notification").on("touchstart", (e) => delete_notification(e))
  else
    $(".delete-notification").on("click", (e) => delete_notification(e))

  delete_notification = (e) ->
    e.preventDefault()
    $notification = $(e.target).closest(".notification")
    id = $notification.attr("data-id")
    $.ajax
      url: "/admin/notifications/#{id}",
      type: 'post',
      dataType: 'json',
      data: {"_method": "delete"},
      success: (data, textStatus, xhr) =>
        console.log data
        remove_notification($notification)
      error: (response) ->
        console.log response

  remove_notification = ($notification) ->
    $notification.fadeOut 'slow', ->
      $notification.detach()
    
