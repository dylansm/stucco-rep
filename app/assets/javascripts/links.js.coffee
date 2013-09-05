$ ->
  $share_link = $(".navwrapper li.mobile-share > a")
  if CFB.touch
    $share_link.on("touchstart", (e) -> mobile_share_link(e))
  else
    $share_link.on("click", (e) -> mobile_share_link(e))

  mobile_share_link = (e) ->
    if $("span.admin", $share_link).length > 0
      location.href = "/admin/links"
    else
      e.preventDefault()
      $(e.target).parent().toggleClass("active")
