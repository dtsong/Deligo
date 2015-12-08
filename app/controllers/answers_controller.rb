class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)
    @answer.answerer_id = current_user.id
    related_answer_option = AnswerOption.where("id = ?", answer_params[:answer_option_id]).first
    question_id = related_answer_option.question
    question = Question.where("id = ?", question_id).first
    creator = User.find_by_id(question.creator_id)
    creator_number = creator.phone_number
    #creator_number = "+1" + creator.phone_number #need country code
    message = current_user.name + "just answered your question " +" \"" + question.question_text + "\""
    respond_to do |format|
      if @answer.save
        # if creator_number
        #   TextNotification.send_text(creator_number, message)
        # end
        if question.next
          format.html { redirect_to answering_question_path(question.next) }
        else
          format.html{ redirect_to root_path}
          # format.html { redirect_to @answer, notice: 'Answer was successfully created.' }
          # format.json { render action: 'show', status: :created, location: @answer }
        end
      else
        format.html { render action: 'new' }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:answerer_id, :comments, :picture_url, :answer_option_id)
    end
end
