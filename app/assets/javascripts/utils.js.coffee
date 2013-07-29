module = (name) ->
  window[name] = window[name] or {}

module "CFB"

if window.Touch || "ontouchstart" in document.documentElement
  CFB.touch = true

CFB.Utils = class Utils

CFB.Utils.html = (text) ->
  # line breaks
  text = text.replace(/\n(\n|\r)/g, "</p><p>")
  # links
  url_re = /(http[s]?:\/\/(www\.)?|ftp:\/\/(www\.)?|www\.){1}([0-9A-Za-z-\.@:%_\+~#=]+)+((\.[a-zA-Z]{2,3})+)(\/(.)*)?(\?(.)*)?/g
  url_match = text.match(url_re)
  _.each(url_match, (url) ->
    protocol_re = /^http:\/\//
    if protocol_re.test(url)
      full_url = url
    else
      full_url = "http://#{url}"

    anchor_re = new RegExp("[^/>']#{CFB.Utils.escape_regexp(url)}", 'g')
    text = text.replace(anchor_re, " <a href='#{full_url}' target='_blank'>#{url}</a>")
  )

  text

CFB.Utils.escape_regexp = (text) ->
  text.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&")

CFB.Utils.non_modal_ui = ->
  if CFB.touch
    $(document.documentElement).unbind("touchstart").bind "touchstart", (e) ->
      hide_non_modals(e)
  else
    $(document.documentElement).unbind("click").bind("click", (e) ->
      hide_non_modals(e)
    )
  hide_non_modals = (e) ->
    unless $(e.target).closest(".non-modal").length > 0
      $(".non-modal").removeClass("non-modal")

CFB.Utils.append_count = (data, type_str) ->
  # type_str = Like or Comment
  type_plural = type_str.toLowerCase() + "s"
  type_singular = type_str.toLowerCase()
  num = data[type_plural].length
  $post = $(".post[data-id='#{data.id}']")
  $link = $(".#{type_singular}-link", $post)
  $link_text = $("span.link-text", $link)
  if num > 0
    user_ids = _.pluck(data[type_plural], 'user_id')
    if _.contains(user_ids, @user_id)
      $link.addClass("authored")
    else
      $link.removeClass("authored")
    $link_text.html("#{type_str} (#{num_comments})")
  else
    $link.removeClass("authored")
    $link_text.html("#{type_str}")

$ ->
  ua = window.navigator.userAgent.toLowerCase()
  if ua.indexOf("msie") > -1
    ieVersionRE = /msie (\d+)/
    match = ua.match(ieVersionRE)
    if match
      v = match[1]
      if v >= 9
        $(document.documentElement).addClass("ie"+v)
      else
        $(document.documentElement).addClass("lt-ie9")
