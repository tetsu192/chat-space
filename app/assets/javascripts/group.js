$(function(){

//インクリメンタルサーチで一致したユーザーが表示される処理

  function listUsers(user) {
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">${user.name}</p>
                  <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</a>
                </div>`
    $('#user-search-result').append(html);
  };

  $('#user-search-field').on('keyup', function(){
    var input = $('#user-search-field').val();
    var href = window.location.href;

    $.ajax({
      type: 'GET',
      url: href,
      data: { keyword: input },
      dataType: 'json'
    })

    .done(function(users) {
      $('#user-search-result').empty();
      users.forEach(function(user){
        listUsers(user);
      });
    })
    .fail(function(){
      alert('ユーザーを表示できません');
    })
  });

//「追加」ボタンを押したときにリストから消える処理

  function addUser(user_name, user_id) {
    var html = `<div class='chat-group-user clearfix js-chat-member' id='chat-group-user-8'>
                  <input name='group[user_ids][]' type='hidden' value='${user_id}'>
                  <p class='chat-group-user__name'>${user_name}</p>
                  <a class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</a>
                </div>`
    $('#chat-member').append(html);
  };

  $(document).on('click', '.user-search-add', (function(){
    var user_name = $(this).data('user-name');
    var user_id = $(this).data('user-id');
    $(this).parent().remove();
    addUser(user_name, user_id);
  }));

//「削除」ボタンを押したときにメンバーから消える処理

  $(document).on('click', '.user-search-remove', function(){
    $(this).parent().remove();
  });
});
