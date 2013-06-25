$(function(){
  var drop = $('.drop').detach();
  function create(){
    var clone = drop
      .clone()
      .appendTo('.container')
      .css('left', Math.random()*$(document).width()-20)
      .animate(
                {'top': $(document).height()-20},
                Math.random(1000)+500
               ,function(){
                 $(this).fadeOut(200,function(){$(this).remove();$('.state').text($('.container .drop').length+' Drops');}); 
               });
  }
  
  function makeRain(){
    for(var i=0; i<30; i++){
      setTimeout(create,Math.random()*700);
    }
  }
  setInterval(makeRain, 500);
});