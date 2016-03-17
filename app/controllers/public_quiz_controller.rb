# Version 1.0
# Public Quiz Controller responsible for processing quiz attempts
# made by clients of the mobile apps
class PublicQuizController < ApplicationController
  # Set up session server side for the client
  # to attempt the quiz
  # Once session is setup, return quiz data
  def attempt_quiz
    tour_session = TourSession.where(passphrase: params[:id])
    return redirect_error_page(403) unless tour_session.exists?
    session[:tour_session] = tour_session.first.id
    @quiz_data = quiz_data(tour_session.first.tour.id)
    @quiz_data = @quiz_data.as_json
    @tour = Tour.find(tour_session.first.tour.id)
    api_response(@quiz_data)
  end

  # Process the answer for a given question
  def submit_question
    return render json: ['No Tour Session'] if session[:tour_session].nil?
    return render json: ['No answer'] if params[:answer].nil?
    answer = Answer.find(params[:answer][:id])
    question_id = params[:question][:id]
    analayse_answer(question_id, answer)
  end

  # Given a question id and the selected Answer
  # determine whether or not the answer is the correct one
  # return correct: true is the answer is correct
  # return correct: false otherwise
  def analayse_answer(question_id, answer)
    if answer.is_correct
      increment_question_correct(question_id)
      render json: { correct: true }
    else
      increment_question_wrong(question_id)
      answer = Answer.where(question_id: question_id, is_correct: true).first
      render json: { correct: false, answer: answer.as_json }
    end
    session[question_id.to_sym] = 'Answered'
  end

  # Return the correct answer to a given question
  def correct_answer(question_id)
    Answer.where(question_id: question_id, is_correct: true).first
  end

  # Invoked when a mobile client user has answered
  # the given question correctly
  # Increments the correctly_answered field for question by 1
  def increment_question_correct(question_id)
    if session[question_id.to_sym].nil?
      question = Question.find(question_id)
      current = question.correctly_answered
      question.update_attribute(:correctly_answered, current + 1)
    end
  end

  # Invoked when a mobile client user has answered
  # the given question incorrectly
  # Increments the incorrectly_answered field for question by 1
  def increment_question_wrong(question_id)
    if session[question_id.to_sym].nil?
      question = Question.find(question_id)
      current = question.wrongly_answered
      question.update_attribute(:wrongly_answered, current + 1)
    end
  end
end
