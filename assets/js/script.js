$(document).ready(function(){
    $('.search_select_box select').selectpicker();
})

$(".checkbox-input").click(function () {
    var value = $(this).is(":checked") ? "on" : "off";
    $(this)
    .closest("tr")      
    .find('input[class=hold]').val(value);
  });
 