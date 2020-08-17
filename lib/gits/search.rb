# frozen_string_literal: true

module Gits
  # Methods To Search Folder Recursively
  class Search
    require 'ripgrep'

    def initialize
      @rip_grep = Ripgrep::Client.new
    end

    def search(search_path, search_query)
      @rip_grep.exec search_query.to_s, path: search_path
    end
  end
end
