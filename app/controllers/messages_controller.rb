require 'streamer/sse'
class MessagesController < ApplicationController
	include ActionController::Live

   def index
	   @message = Message.new
	   @messages = Message.all(order: "created_at desc", limit: 30)
   end

   def history
	   @message = Message.new
	   @messages = Message.paginate(page: params[:page], per_page: 30).order("created_at desc")
   end

   def create
	   @m = Message.new(message_params)
	   if @m.save
		   respond_to do |format|
		   	format.html { redirect_to root_url }
		   	format.js
		   end
	   else
		   respond_to do |format|
		   	format.html { render :index }
		   	format.js
		   end
	   end
   end

  def stream
	  @messages = Message.all(order: "created_at desc", limit: 30)
	  response.headers['Content-Type'] = 'text/event-stream'
	  sse = Streamer::SSE.new(response.stream)
	  sse.write(@messages.to_json)
=begin
	  redis = Redis.new
	  redis.subscribe('messages.create') do |on|
		  on.message do |event, data|
			  sse.write(data, event: 'messages.create')
		  end
	  end
=end
	  render nothing: true
  rescue IOError
	  # Client disconnected
  ensure
#	  redis.quit
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
