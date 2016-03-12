$(function(){
    var $window = $(window).on('resize', function(){
    var wWidth  = $(window).width();
  if(wWidth <=660){
      $('#warning').css("margin-top","-10px");
      $('#capsule').css("width","20em");
      $('#redirect ').text("Homepage");
      if(wWidth <= 520){
        $('h1').css("font-size","1000%");
        if(wWidth <= 376){
            $('h1').css("font-size","800%");
            $('#capsule').css("width","17em");
        }
        else{
            $('h1').css("font-size","1000%");
            $('#capsule').css("width","20em");
        }
      }
      else{
        $('h1').css("font-size","1500%");
      }
  }else{
      $('h1').css("font-size","1200%");
      $('#warning').css("margin-top","-30px");
      $('#capsule').css("width","40em");
      $('#redirect ').text("Go back to the homepage");
  }}).trigger('resize');
});
