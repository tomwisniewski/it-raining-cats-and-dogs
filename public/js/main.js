$(document).ready(function(){

  $('.submit_button').click(function(){
    var email = $('#email').val();
    var first_name = $('#first_name').val();
    var last_name = $('#last_name').val();
    var password = $('#password').val();
    var emailRegex = /^([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})$/i
    var anyErrors = false;

    if (!email.match(emailRegex)) {
      $('.email_error').show();
      anyErrors = true;
    }

    if (first_name == '') {
      $('.first_name_error').show();
      anyErrors = true;
    }

    if (last_name == '') {
      $('.last_name_error').show();
      anyErrors = true;
    }

    if (password.length < 6) {
      $('.password_error').show();
      anyErrors = true;
    }

    if (anyErrors) return false;
    $(".signup_form").submit(); 
    return false;   
  })
});