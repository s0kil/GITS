# frozen_string_literal: true

# TODO: Parse URL or Local repo
# TODO: If online repo, download in tmp dir and add to config
# TODO: search the dir
# TODO: when re-opening the app, provide options for searching previous repositories

require 'tmpdir'
require 'cli/ui'

require_relative './gits/parser'
require_relative './gits/search'

require_relative './helpers/git'

# Gits Module
module Gits
  def self.initialize
    @repositories = []
    @search_client = Gits::Search.new

    working_dir = Dir.pwd
    @repositories.push(working_dir) if Git.repository?(working_dir)
  end

  def self.repository_prompt
    @selected_repository =
      CLI::UI.ask(
        'What Git repository do you want to search?',
        default: @repositories.first,
        is_file: true
      )
  end

  def self.clone_selected_repository
    if @selected_repository != @repositories.first ||
       !Git.repository?(@selected_repository)

      git_remote = Gits::Parser.new.parse(@selected_repository)

      # /tmp/gits/git_repo_owner/git_repo_name
      repo_dir = File.join(Dir.tmpdir, 'gits', git_remote.owner, git_remote.repo)

      unless Dir.exist?(repo_dir)
        FileUtils.mkdir_p(repo_dir) # Recursively Create Directories
        puts "Downloading: #{git_remote.html_url} -> #{repo_dir}"
        Git.clone(git_remote.html_url, repo_dir)
      end

      @selected_repository = repo_dir
    end
  end

  def self.search_query_prompt
    @search_query =
      CLI::UI.ask('Search query:')
  end

  def self.search_results
    @search_client.search(@selected_repository, @search_query)
  end
end
