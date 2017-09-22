document.addEventListener('turbolinks:load', ->
  $('.card-title span:contains(low)').addClass("badge-info")
  $('.card-title span:contains(medium)').addClass("badge-warning")
  $('.card-title span:contains(high)').addClass("badge-danger")

  $('.card-title span.status:contains(1)').addClass("badge-success")
  $('.card-title span.status:contains(1)').text("Done")
  $('.card-title span.status:contains(0)').text("")
)
