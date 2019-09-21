class QuestionsController < ApplicationController

  before_action :set_category

  def index
    #csv出力用と一覧表示用のcategory_idがある
    @category = params[:csv_category_id] || params[:category_id]
    if @category
      @mycategory = Category.find(@category)
      @questions = @mycategory.questions.includes(:user).order("created_at DESC")
    else
      ##n+1問題解決のために色々試したが解決せず。
      #@questions = Question.all.order("created_at DESC")
      #以下の記述だとbulletでn+1問題が検出されない。この書き方でいいのかな
      @questions = Question.includes(:user).order("created_at DESC")
      #@questions = Question.includes(:user).includes(:categorys).order("created_at DESC")
      #@questions = Question.includes(:user).includes(:categorys).each{|question| p question.categorys.name}
      #@questions = Question.includes(:categorys).order("created_at DESC")
      #@questions = Question.includes(:user, {categorys: :question_categorys}).order("created_at DESC")
      #@questions = Question.includes(:user).includes(categorys: :question_categorys).order("created_at DESC")
      #binding.pry
    end
    respond_to do |format|
      format.html
      format.csv { send_data render_to_string, type: :csv, filename: "questions_category.csv" }
    end
  end

  def search
    @questions = Question.where('title LIKE(?)', "%#{params[:keyword]}%").order("created_at DESC")
    respond_to do |format|
      format.html {render action: :index}
      format.json
    end
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
    else
      if @question.content.blank?
        flash.now[:content] = '質問を入力してください。'
      end
      if @question.title.blank?
        flash.now[:title] = 'タイトルを入力してください。'
      end
      @questions = Question.all.order("created_at DESC")
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    question = Question.find(params[:id])
    question.update(question_params)
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
    @answers = @question.answers.all.includes(:user)
  end

  def set_category
    @categorys = Category.all
  end

  private
  def question_params
    #params.require(:question).permit(:title, :content, { :category_ids => [] }).merge(user_id: current_user.id)
    params.require(:question).permit(:title, :content, category_ids: [] ).merge(user_id: current_user.id)
  end

end
