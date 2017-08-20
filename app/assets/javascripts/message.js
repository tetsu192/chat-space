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
  var interval = setInterval(function() {
  if (window.location.href.match(/\/groups\/\d+\/messages/)) {
  $.ajax({
    url: location.href.json,
    dataType: 'json'
  })
  .done(function(data) {
    var id = $('.message:last').data('message-id');
    var insertHTML = '';
    data.messages.forEach(function(message) {
      if ( message.id > id || id == null ) {
        insertHTML += buildHTML(message);
      }
    });
    $('.chat__messages').append(insertHTML);
  })
  .fail(function(json) {
    alert('自動更新に失敗しました');
  });
  } else {
  clearInterval(interval);
  }} , 5 * 1000 );
});
