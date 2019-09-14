$(function(){
  function buildHTML(answer){
    var html = `<div class='question'>
                  <div class='container'>
                    <div class='container__upper-info'>
                      <div class='container__upper-info__title'>
                        ajax回答
                      </div>
                      <div class='container__upper-info__questioner'>
                      ${answer.user_name}
                      </div>
                    </div>
                    <div class='container__middle-info'>
                      <p class='container__text'>
                      ${answer.response}
                      </p>
                    </div>
                    <div class='functions-btns'>
                      <ul class='functions-btns__btn'>
                        <li class='functions-btns__btn__edit'>
                          edit
                        </li>
                        <li class='functions-btns__btn__delete'>
                          delete
                        </li>
                      </ul>
                    </div>
                  </div>
                </div>`
    return html;
  }

  $('#new_answer').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    //console.log(formData);
    var url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      if (data.error_response=="") {
        $('.content-left').append(html)
      }
      $('#answer_response').val('')
      html = `<p>${data.error_response}</p>`
      $('.notification').html(html)
      console.log("OK")
      $("#button").prop("disabled", false);
    })
    .fail(function(){
      //alert('error');
      //var html = `<div><p>手打ちのメッセージ</p></div>`
      //$('.notification').append(html)
      console.log("ERROR")
      //location.reload();
      $("#button").prop("disabled", false);
    })
  })

  $(window).on('scroll resize', function(){
    var scroll = $(document).scrollTop();
    var width = $('.content-left').width();
    if(width<600){
      $('.content-right').addClass('left-content-mini-width');
    }
    else{
      $('.content-right').removeClass('left-content-mini-width');
    }
  })
})