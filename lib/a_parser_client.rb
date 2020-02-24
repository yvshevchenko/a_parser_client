require "a_parser_client/version"

module AParserClient
  class Error < StandardError; end

  class API
  	require "json"
  	require "open-uri"
  	require "net/http"

  	attr :api_url, :api_password, :alive

  	def initialize(api_url, api_password)
  		if api_url =~ URI::regexp
	  		@api_url = api_url
	  		@api_password = api_password	
	  		@alive = self.alive?			
  		else
  			raise "Bad API URL provided."
  		end
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

	def get_task_state(task_id)
		request = {
			password: @api_password, 
			action: 'getTasksState',
			data: {taskUid: task_id}
		}
		do_it request
	end

	def get_task_conf(task_id)
		request = {
			password: @api_password, 
			action: 'getTasksConf',
			data: {taskUid: task_id}
		}
		do_it request
	end


	def get_info
		request = {
			password: 	@api_password, 
			action: 	'info',
		}
		do_it request
	end

	def add_task(task_type='text', queries_array=[], queries_file=nil, config, preset, parsers, result_file_name)
		request = {
			password: 	@api_password, 
			action: 	'addTask',
			data: {
				queriesFrom: task_type, 
				queries: (task_type == 'text' ? queries_array : queries_file),
				configPreset: config, 
				preset: preset, 
				parsers: parsers, 
				resultsFileName: result_file_name
			}
		}
		do_it request
	end

	def change_task_status(task_id, to_status)
		request = {
			password: @api_password, 
			action: 'changeTaskStatus',
			data: {
				taskUid: task_id,
				toStatus: to_status
			}
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
				begin
					response = JSON.parse res.body
				rescue JSON::ParserError => e
					raise "Not a JSON type response from the server #{@api_url}. Probably not an API endpoint."
				end
			else
			  nil
			end
	end			
  	
  	
  end
end
