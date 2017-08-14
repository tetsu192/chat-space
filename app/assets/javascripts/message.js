$(function() {
  $('#new_message').on('submit', function(e) {
    e.preventDefault();
    var group_id = $('.group_id').val();
    var fd = new FormData($('#new_message').get(0));
    fd.append('text', $('message-form__text').val());
    console.log(fd)

    $.ajax({
      url: '/groups/27/messages.json',
      type: 'POST',
      dataType: 'json',
      data: fd,
      processData: false,
      contentType: false
    })
    .done(function(data) {
      console.log("success");
    })
    .fail(function() {
      console.log("error");
    })
    .always(function() {
      console.log("complete");
    });

  });
});
