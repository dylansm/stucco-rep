$ ->
  $share_link = $(".navwrapper li.mobile-share > a")
  if CFB.touch
    $share_link.on("touchstart", (e) -> mobile_share_link(e))
  else
    $share_link.on("click", (e) -> mobile_share_link(e))

  mobile_share_link = (e) ->
    e.preventDefault()
    $(e.target).parent().toggleClass("active")
