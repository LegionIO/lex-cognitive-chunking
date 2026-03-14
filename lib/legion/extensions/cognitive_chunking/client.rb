# frozen_string_literal: true

require 'legion/extensions/cognitive_chunking/runners/cognitive_chunking'

module Legion
  module Extensions
    module CognitiveChunking
      class Client
        include Runners::CognitiveChunking

        def initialize(**)
          @chunking_engine = Helpers::ChunkingEngine.new
        end
      end
    end
  end
end
