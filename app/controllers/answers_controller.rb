class AnswersController < ApplicationController
  before_action :set_answer, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # GET /answers/new
  def new
    @answer = Answer.new(question_id: params[:question_id])
  end

  # GET /answers/1/edit
  def edit
    
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    respond_to do |format|
      if @answer.save
        format.html { redirect_to question_path(@answer.question), notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { redirect_to question_path(@answer.question), notice: 'Unable to submit answer at the moment.'}
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer, notice: 'answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
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
      params.require(:answer).permit(:question_id, :content)
    end
    
    def require_same_user
      if (current_user != @answer.user || !current_user.admin?)
        respond_to do |format|
          format.html { redirect_to question_path(@answer.question), notice: "You do not have access to modify this answer"}
          format.json { render json: @answer.errors, status: :unprocessable_entity }
        end
      end
    end
end
