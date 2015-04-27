get "/" do
  @email = nil
  erb :index
end

get '/users/new' do
  @user = User.new
  erb :sign_up
end

post '/users' do
  @user = User.new params[:user]
  if @user.save
    session[:user_id] = @user.id
    redirect '/'
  else
    erb :sign_up
  end
end

post '/sessions' do
  @email = params[:email]
  user = User.authenticate(@email, params[:password])
  if user
    session[:user_id] = user.id
    redirect "/users/#{user.id}"
  else
    @error = "Invalid email or password."
    erb :index
  end
end

delete '/sessions/:id' do
  return 401 unless params[:id].to_i == session[:user_id].to_i
  session.clear
  200
end
