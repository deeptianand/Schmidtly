get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/url' do
  @url = Url.create(full_url: params[:url])
  erb :short_url
end

get "/:short_url" do
  url = Url.find_by_short_url(params[:short_url])
  visits = url.counter
  visits += 1
  url.update_attributes({:counter => visits})
  redirect url.full_url
end
