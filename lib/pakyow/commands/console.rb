require "pakyow/commands/console_methods"

module Pakyow
  module Commands
    class Console
      def initialize(environment: ENV['RACK_ENV'] || Config.app.default_environment)
        ENV['RACK_ENV'] = environment.to_s
      end

      def run
        load_app
        App.stage(ENV['RACK_ENV'])
        ARGV.clear

        require "irb"
        Config.app.console_object::ExtendCommandBundle.include(ConsoleMethods)
        Config.app.console_object.start
      end

      private

      def load_app
        $LOAD_PATH.unshift(Dir.pwd)
        require 'app/setup'
      end
    end
  end
end
