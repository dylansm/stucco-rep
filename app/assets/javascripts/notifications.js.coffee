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
