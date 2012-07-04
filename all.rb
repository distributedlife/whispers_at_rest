require 'bundler/setup'
require 'sinatra'
require 'graphite_graph'
require 'graphite_storage'

def whisper_root
	"/media/extended/whisper/stats"
end

def metric_root
	whisper_root
end

def timers_root
	"#{whisper_root}/timers"
end

def get_and_format_from_path root, sub
	s = Dir["#{root}#{sub}/**/*.*"].sort.map{|e| e.gsub(root, '').gsub('.wsp', '').gsub('/','.')}

	s.map {|e| e[1..-1]}
end

def data sub = ""
	a = get_and_format_from_path metric_root, sub 
	b = get_and_format_from_path timers_root, sub

	a | b
end

#list all the available metrics
get '/' do
	haml :metrics, :locals => {:content  => data}
end

get '/:company' do
	filter = "/#{params[:company]}"
	haml :metrics, :locals => {:content  => data(filter)}
end

get '/:company/:product' do
	filter = "/#{params[:company]}/#{params[:product]}"
	haml :metrics, :locals => {:content  => data(filter)}
end

get '/:company/:product/:environment' do
	filter = "/#{params[:company]}/#{params[:product]}/#{params[:environment]}"
	haml :metrics, :locals => {:content  => data(filter)}
end

get '/:company/:product/:environment/:release' do
	filter = "/#{params[:company]}/#{params[:product]}/#{params[:environment]}/#{params[:release]}"
	haml :metrics, :locals => {:content  => data(filter)}
end
