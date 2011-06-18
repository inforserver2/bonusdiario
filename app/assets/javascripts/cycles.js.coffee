jQuery ->

  $('.cycle img').hover ->
    $(this).next('p').toggleClass('legend')
  
  $('div.CycleUserInfo').each ->
    token = $(this).attr('id')
    $(this).load("/office/cycles/"+token+"/info")

