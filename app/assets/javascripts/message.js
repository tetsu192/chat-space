$(function() {
  function buildHTML(message){
    var html = `<div class="message">
                  <div class="info">
                    <div class="info__user-name">${ message.user_name }
                    </div>
                    <div class="info__date">${ message.date }</div>
                  </div>
                  <div class="message__text">
                    <p class="text__content">${ message.text }</p>
                  </div>`
    return html
  }
  $('#new_message').on('submit', function(e) {
    e.preventDefault();
    var fd = new FormData(this);
    var href = window.location.href
    $.ajax({
      url: href,
      type: 'POST',
      dataType: 'json',
      data: fd,
      processData: false,
      contentType: false
    })
    .done(function(data) {
      var html = buildHTML(data);
      $('.chat__messages').append(html)
      $('.message-form__text').val('')
      $('.chat__messages').animate({scrollTop: $('.chat__messages')[0].scrollHeight}, 'fast');

    })
    .fail(function(data) {
      alert("error");
    });
  });
});
