require 'sinatra'
require 'sinatra/reloader'
require 'cgi'

get '/:cmd' do
  command = CGI::unescape params[:cmd]
  puts "> #{command}"
  return eval(command).to_s
end
