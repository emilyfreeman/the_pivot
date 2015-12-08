$(document).ready(function () {

  var $users = $('.user');

  $('#user_filter_username').keyup('change', function () {
    console.log(this.value)
    var currentName = this.value;
    $users.each(function (index, user) {
      $user = $(user);
      if ($user.data('username').includes(currentName)) {
        $user.show();
      }
      else {
        $user.hide();
      }
    });
  });

});
