$(function() {
  function buildHTML(message){
      var insertImage = '';
      if (message.image.url) {
        insertImage = `<img src="${ message.image.url }">`
      }
      var html = `<div class="message" data-message-id="${message.id}">
                  <div class="info">
                    <div class="info__user-name">${ message.user_name }
                    </div>
                    <div class="info__date">${ message.date }</div>
                  </div>
                  <div class="message__text">
                    <p class="text__content">${ message.text }</p>
                    <img src="${ insertImage }">
                  </div>
                </div>`;
      return html;
  }
  $('#new_message').on('submit', function(e) {
    e.preventDefault();
    var fd = new FormData(this)
    $.ajax({
      url: window.location.href,
      type: 'POST',
      dataType: 'json',
      data: fd,
      processData: false,
      contentType: false
    })
    .done(function(data) {
      var html = buildHTML(data);
      $('.chat__messages').append(html);
      $('.message-form__text').val('');
      $('.message-form__image').val('');
      $('.message-form__submit').removeAttr('disabled');
      $('.chat__messages').animate({scrollTop: $('.chat__messages')[0].scrollHeight}, 'fast');
    })
    .fail(function(data) {
      alert("error");
      $('.message-form__submit').removeAttr('disabled');
    });
  });
});
