module Gits
  # Methods To Search Folder Recursively
  class Search
    require 'ripgrep'

    def initialize
      @rip_grep = Ripgrep::Client.new
    end

    def search(search_path, search_query)
      @rip_grep.exec search_query.to_s, path: search_path
    rescue Errno::ENOENT => _e
      puts 'Install ripgrep In Order For This Tool To Function'
      puts 'https://github.com/BurntSushi/ripgrep#installation'
      exit
    end
  end
end
