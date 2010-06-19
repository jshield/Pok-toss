require 'rubygems'
require 'sinatra'
require 'dm-core'
set :public, "./public"
enable :sessions
get '/' do   
  session["cointossed"] ||= 0 
  session["headcount"] ||= 0
  session["tailcount"] ||= 0
  html = "Pokémon coin toss v0.01"  
  html += "<br>Coins tossed this session: #{session['cointossed']}<br>#Heads: #{session['headcount']}<br>#Tails: #{session['tailcount']}"
  html += "<form action='/flip' method='post'><input name='num' value = '1' size = '1'><input type='submit' value='Flip coins'></form>"
  html += "<a href = '/clear'>Reset Session</a>"
  html  
end

get '/clear' do
  session["cointossed"] = 0 
  session["headcount"] = 0
  session["tailcount"] = 0
  html = "<a href ='/'>Back to main</a>"
end

post '/flip' do
  html = ""
  params[:num].to_i.times do 
    if rand(2) == 1
      result = "<img src = '/coins/munchlax.jpg'>"
      session["headcount"] += 1    
    else
      result = "<img src = '/coins/tails.jpg'>" 
      session["tailcount"] += 1
    end
    html += "<br>"+result
    session["cointossed"] += 1
  end
  html += "<br><a href ='/'>Back to main</a>"
  html
end