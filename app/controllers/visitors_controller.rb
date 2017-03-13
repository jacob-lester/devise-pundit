class VisitorsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @questions = Question.order('created_at DESC')
  end
end
