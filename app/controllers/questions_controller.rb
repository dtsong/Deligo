class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :answering]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.where(["creator_id = ?", current_user.id])
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
    @users = User.all
  end

  # GET /questions/1/edit
  def edit
    @users = User.all
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.creator_id = current_user.id
    respond_to do |format|
      if @question.save
        # format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.html {redirect_to root_path, notice: 'Question was successfully created.'}
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end

  def answering
    @answer = Answer.new
    @questions = Question.open.not_creator(current_user.id)

    #check if question has already been answered, if so, redirect to homepage
    all_answered_question_id = Question.get_answered_question_id(current_user.id)

    respond_to do |format|
        if all_answered_question_id.include?(params[:id].to_i)
          format.html{redirect_to root_path}
        else
          format.html {render action: "answering"}
        end
    end
  end

  def answering_options_data
    target_question = Question.where("id = ?", params[:id])
    print target_question
  end
  
  #def close
   # @question = Question.where("id = ?", params[:id])
    #@question.change_open
    #@question.save!
    
    #redirect_to questions_path
    #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      print params
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:picture, :creator_id, :question_text, :allow_comments, :open, :ask_friends, :ask_public, :ask_group, answer_options_attributes: [:id, :option, :question_id, :_destroy], pictures_attributes: [:id, :picture_url, :question_id, :_destroy])
    end
end
