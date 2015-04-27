get '/users/:id' do
  @user = User.find(session[:user_id])
  @surveys = @user.surveys
  @surveys.each do |survey|
  puts survey
  end
  erb :"users/show"
end

get '/surveys' do
  @user = current_user
  @surveys = Survey.all
  erb :"surveys/index"
end

get '/surveys/create' do
  erb :"surveys/create"
end


post '/surveys' do
  if params[:title]
    my_survey = Survey.create(title: params[:title], creator_id: current_user.id)
  else
    my_question = Question.create(prompt: params[:prompt], survey_id: Survey.all.last.id)
    Choice.create(answer: params[:choice_1], question_id: my_question.id)
    Choice.create(answer: params[:choice_2], question_id: my_question.id)
    Choice.create(answer: params[:choice_3], question_id: my_question.id)
    Choice.create(answer: params[:choice_4], question_id: my_question.id)
  end
end

get '/surveys/:id/edit' do
@survey = Survey.find(params[:id])
  if @survey
    @questions = @survey.questions
  erb :edit_survey
  else
    redirect "/surveys/index.html"
  end
end

put '/surveys/:id/update' do
  survey = Survey.find(params[:id])
  survey.update_attributes(title: params[:title])
  survey.questions.each do |question|
    question.update_attributes(id: question.id, prompt: params["question_#{question.id}"])
    question.choices.each do |choice|
      choice.update_attributes(id: choice.id, answer: params["choice_#{choice.id}"])
    end
  end
  redirect "/surveys/index.html"
end

delete '/surveys/:id/delete' do
  @survey = Survey.find(params[:id])
  @survey.destroy
  redirect "/surveys/index.html"
end

get '/surveys/:id/results' do
  @survey = Survey.find(params[:id])
  erb :"surveys/results"
end

get '/surveys/:id' do
  @survey = Survey.find(params[:id])
  if @survey
    erb :"surveys/show"
  else
    redirect "/surveys/index.html"
  end
end

post '/surveys/:id' do
  survey = Survey.find(params[:id])
  completion = Completion.new(user_id: session[:user_id], survey_id: survey.id)
  if completion.save
    survey.questions.each do |question|
      Response.create(completion_id: completion.id, choice_id: params[question.prompt])
    end
    redirect "/surveys/#{survey.id}/results"
  else
    @error = "Please answer each question in the survey."
    erb :"surveys/show"
  end
end


