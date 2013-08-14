$ ->
  $share_link = $(".navwrapper li.mobile-share > a")
  if CFB.touch
    $share_link.on("touchstart", (e) -> mobile_share_link(e))
  else
    $share_link.on("click", (e) -> mobile_share_link(e))

  mobile_share_link = (e) ->
    unless parseInt $("body").attr("data-user-id"), 10
      $alert_el = $(".rightwrapper.flash .alert.hidden:not('.notify-only')")
      $alert_el.parent().removeClass("hidden")
      $alert_el.removeClass("hidden")
      $alert_el.text("You need to sign in before continuing.")
      $('div.pagewrapper').toggleClass('nav-active')
      return
    e.preventDefault()
    $(e.target).parent().toggleClass("active")
