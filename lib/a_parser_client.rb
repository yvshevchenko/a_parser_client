require "a_parser_client/version"

module AParserClient
  class Error < StandardError; end
  # Your code goes here...

  class API
  	require "json"
  	require "open-uri"
  	require "net/http"

  	attr :api_url, :api_password, :alive

  	def initialize(api_url, api_password)
  		@api_url = api_url
  		@api_password = api_password	
  		@alive = self.alive?
  	end

	def ping_a_parser
		request = {
			password: @api_pass, 
			action: 'ping'
		}
		do_it request
	end

	#updates alive status
	def alive?
		@alive = ping_a_parser ? true : false
	end  	


	def get_task_list(completed=false)
		request = {
			password: @api_password, 
			action: 'getTasksList',
			data: {completed: completed ? 1 : 0}
		}
		do_it request
	end

		private # internal use only

	def do_it(request)
		request_body = request.to_json
		response = send_request(request_body)
		return response		
	end

	def send_request(request)
		uri = URI @api_url

			req = Net::HTTP::Post.new uri
			req.body = (request)
			req.content_type = 'text/plain; charset=UTF-8'

			begin
				res = Net::HTTP.start(uri.hostname, uri.port) {|http|
				  http.request(req)
				}
			rescue Exception => e
				puts "Send request error: #{e}"
			end

			if res
			  response = JSON.parse res.body
			else
			  nil
			end
	end			
  	
  	
  end
end
