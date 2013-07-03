module = (name) ->
  window[name] = window[name] or {}

module "CFB"

if window.Touch || "ontouchstart" in document.documentElement
  CFB.touch = true
