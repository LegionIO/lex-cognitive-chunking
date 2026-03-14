# frozen_string_literal: true

require 'securerandom'
require 'legion/extensions/cognitive_chunking/version'
require 'legion/extensions/cognitive_chunking/helpers/constants'
require 'legion/extensions/cognitive_chunking/helpers/information_item'
require 'legion/extensions/cognitive_chunking/helpers/chunk'
require 'legion/extensions/cognitive_chunking/helpers/chunking_engine'
require 'legion/extensions/cognitive_chunking/runners/cognitive_chunking'

module Legion
  module Extensions
    module CognitiveChunking
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
