class VisitorsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @questions = Question.all
  end
end
