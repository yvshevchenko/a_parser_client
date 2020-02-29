require "a_parser_client/version"
require "a_parser_client/api"

module AParserClient
	class Error < StandardError; end

	class Control
		attr_reader :tasks

		def initialize(api_driver)
			if api_driver
				unless api_driver.alive?
					raise "API driver should be alive to take control of parser."
				end

				@tasks = fetch_tasks				
			else
				raise "No API driver provided."
			end

		end

		def fetch_tasks
			data = api_driver.get_tasks_list
			data['data'] ? data['data'] : []
		end
	end
end
