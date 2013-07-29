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

CFB.Utils.format_publish_date = (created_at) ->
  date = new Date(created_at)
  now = new Date()
  full = humanized_time_span(date, now)
  short = full.replace(/(\d+ .).+/, "$1").split(" ").join("")
  { full: full, short: short }


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
