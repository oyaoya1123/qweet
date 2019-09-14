module QuestionsHelper

  def show_category(instance)
    categorys = instance.categorys.all
    html_text = ''
    categorys.each do |category|
      html_text += link_to "#{category.name} ", "/categorys/#{category.id}/questions"
    end
    return html_text.html_safe
  end

  def edit_link(instance)
    link_to 'edit', edit_question_path(instance), method: 'get'
  end

  def delete_link(instance)
    link_to 'delete', "/questions/#{instance.id}", method: 'delete'
  end

  def show_link(instance)
    link_to 'answer', question_path(instance), method: 'get'
  end

  def buttons_link(instance)
    if @path.is('questions#index', 'questions#search')
      content_tag(:ul, class: 'functions-btns__btn') do
        if current_user_has?(instance)
          concat content_tag(:li, edit_link(instance), class: 'functions-btns__btn__edit')
          concat content_tag(:li, delete_link(instance), class: 'functions-btns__btn__delete')
        end
        if user_signed_in?
          concat content_tag(:li, show_link(instance), class: 'functions-btns__btn__show')
        end
      end
    end
  end

end
