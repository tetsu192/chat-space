$(function(){
    function buildHTML(message) {
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
