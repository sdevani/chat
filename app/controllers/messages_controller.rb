require 'streamer/sse'
class MessagesController < ApplicationController
	include ActionController::Live

   def index
	   @message = Message.new
	   @messages = Message.all
   end

   def create
	   @m = Message.new(message_params)
	   if @m.save
		   redirect_to root_url
	   else
		   render :index
	   end
   end

  def stream
	  response.headers['Content-Type'] = 'text/event-stream'
	  sse = Streamer::SSE.new(response.stream)

	  redis = Redis.new
	  Thread.new {
		  redis.subscribe('messages.create') do |on|
			  on.message do |event, data|
				  sse.write(data, event: 'messages.create')
			  end
		  end
	  }
	  render nothing: true
  rescue IOError
	  # Client disconnected
  ensure
	  redis.quit
	  sse.close
  end


  def comment
	  response.headers['Content-Type'] = 'text/javascript'
	  @message = params.require(:message).permit(:name, :content)
	  $redis.publish('messages.create', @message.to_json)
=begin
	  start_serve do |sse_client|
		  sse_client.send_sse sse
		  sse_client.send_sse_hash data: "Shehzan"
	  end
=end
  end

  private
  def sse(object, options = {})
	  (options.map{|k,v| "#{k}: #{v}" } << "data: #{JSON.dump object}".join("\n") + "\n\n")
  end

  def message_params
	  params.require(:message).permit(:from_user, :text)
  end

end
