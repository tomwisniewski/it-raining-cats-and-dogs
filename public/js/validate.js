$(document).ready(function(){

  // $('.signup_form').validate({
  //   rules: {
  //     first_name: {
  //       required: true,
  //     },
  //     last_name: {
  //       required: true,
  //     },
  //     email: {
  //       required: true,
  //       email: true
  //     },
  //     password: {
  //       required: true,
  //       minlength: 6
  //     }
  //   }
  // });  

  $('.submit_button').click(function(){
    var email = $('#email').val();
    var first_name = $('#first_name').val();
    var last_name = $('#last_name').val();
    var password = $('#password').val();
    var emailRegex = /^([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})$/i
    var anyErrors = false;

    // Write some code to hide all elements
    $('.error').hide();

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