module AParserClient

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

	def ping
		request = {
			password: @api_pass, 
			action: 'ping'
		}
		do_it request
	end

	#updates alive status
	def alive?
		@alive = ping ? true : false
	end  


	def get_tasks_list(completed=false)
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
			action: 'getTaskState',
			data: {taskUid: task_id}
		}
		do_it request
	end

	def get_task_conf(task_id)
		request = {
			password: @api_password, 
			action: 'getTaskConf',
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


	def one_request(query, parser, preset='default', config_preset='default', options=[])
		request = {
			password: 	@api_password, 
			action: 	'oneRequest',
			data: {
				query: query,
				parser: parser, 
				configPreset: config_preset,
				preset: preset,
				options: options
			}
		}
		do_it request
	end

	def bulk_request(queries, parser, preset, config_preset, threads, raw_results, need_data, options)
		request = {
			password: 	@api_password, 
			action: 	'bulkRequest',
			data: {
				queries: queries,
				parser: parser, 
				configPreset: config_preset,
				preset: preset,
				threads: threads,
				rawResults: raw_results,
				needData: need_data,
				options: options
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

	def get_accounts_count
		request = {
			password: @api_password, 
			action: 'getAccountsCount',
			data: {}
		}
		do_it request		
	end


	def get_proxies
		request = {
			password: @api_password, 
			action: 'getProxies'
		}
		do_it request		
	end

	def update!
		request = {
			password: @api_password, 
			action: 'update',
			data: {}
		}
		do_it request		
	end	

	def get_task_results_file(task_id)
		request = {
			password: @api_password, 
			action: 'getTaskResultsFile',
			data: {taskUid: task_id}
		}
		do_it request
	end	

	def delete_task_results_file(task_id)
		request = {
			password: @api_password, 
			action: 'deleteTaskResultsFile',
			data: {taskUid: task_id}
		}
		do_it request
	end	

	def move_task(task_id, direction)
		request = {
			password: @api_password, 
			action: 'moveTask',
			data: {
				taskUid: task_id,
				toStatus: direction
			}
		}
		do_it request		
	end	

	def get_parser_info(parser_name)
		request = {
			password: @api_password, 
			action: 'getParserInfo',
			data: {
				parser: parser_name
			}
		}
		do_it request		
	end	


	def get_parser_preset(parser_name, preset_name)
		request = {
			password: @api_password, 
			action: 'getParserInfo',
			data: {
				parser: parser_name,
				reset: preset_name
			}
		}
		do_it request		
	end	


		private # internal use only

	def do_it(request)
		request_body = request.to_json
		send_request(request_body)
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
					JSON.parse res.body
				rescue JSON::ParserError => e
					raise "Not a JSON type response from the server #{@api_url}. Probably not an API endpoint."
				end
			else
			  nil
			end
	end			
  	
  	
  end


end