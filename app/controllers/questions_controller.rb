class QuestionsController < ApplicationController

  def answer
    question_id = params[:question_id]
    answer = params[:score]

    user_answer = answer_to_score(answer)
    if user_answer
      # match_score = 100 - (0.7*20 + 0.3*Math.abs(candidate_answer - user_answer))
      match_score = (86 - 0.3*(-50 - user_answer).abs).to_i
    end

    respond_to do |format|
      format.js {
        if user_answer
          render :json => {:success => { :score => match_score }}
        else
          render :json => {:errors => ['Please answer the question']}
        end
      }
      format.html {
        redirect_to "/questions/#{question_id}"
      }
    end
  end

  protected
  
  def answer_to_score(answer)
    case answer
    when 'sd'; -50
    when 'd'; -25
    when 'n'; 0
    when 'a'; 25
    when 'sa'; 50
    else nil
    end
  end
end
