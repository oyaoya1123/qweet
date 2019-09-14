$(function(){
  function buildHTML(question){
    var html = `<div class='question'>
                  <div class='container'>
                    <div class='container__upper-info'>
                      <div class='container__upper-info__title'>
                        ${question.title}
                      </div>
                      <div class='container__upper-info__questioner'>
                        ${question.user_name}
                      </div>
                    </div>
                    <div class='container__category-info'>
                      ここにカテゴリを表示
                    </div>
                    <div class='container__middle-info'>
                      <p class='container__middle-info__text'>
                      ${question.content}
                      </p>
                    </div>
                    <div class='functions-btns'>
                      ここにボタンを表示
                    </div>
                  </div>
                </div>`
    return html;
  }
  function buildHTML_category(question){
    //html = ''
    //question.categorys.forEach(function(category){
    //  var html = html + `<a href="/categorys/${category.id}/questions">${category.name} </a>`
    //});
    //return html;
  }
  $("#search__query").on("keyup", function(){
    var input = $("#search__query").val();
    $.ajax({
      type: 'GET',
      url: '/questions/search',
      data: { keyword: input },
      dataType: 'json',
    })
    .done(function(questions) {
      $(".content-left").empty();
      console.log(questions);
      if (questions.length !== 0) {
        questions.forEach(function(question){
          //var category_html = buildHTML_category(question);
          var html = buildHTML(question);
          $(".content-left").append(html);
        });
      }
      else {
      }
    })
    .fail(function() {
      //alert('error');
    })
  })
})