# frozen_string_literal: true

require 'a_parser_client/version'
require 'a_parser_client/api'

module AParserClient
  class Error < StandardError; end

  class Control
    attr_reader :tasks, :driver

    def initialize(api_driver)
      @driver = api_driver

      raise 'No API driver provided.' unless @driver

      raise 'API driver should be alive to take control of parser.' unless @driver.alive?

      @tasks = fetch_tasks
    end

    def fetch_tasks
      data = @driver.get_tasks_list
      data['data'] || []
    end
  end
end
