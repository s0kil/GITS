# Thanks To: https://github.com/JuanitoFatas/git-remote-parser

module Gits
  # Parses Git Remote URL
  class Parser
    # Parsed Result
    class Result
      attr_reader :protocol, :username, :host, :owner, :repo, :html_url

      def initialize(options)
        @protocol = options[:protocol]
        @username = options[:username]
        @host = options[:host]
        @owner = options[:owner]
        @repo = options[:repo]
        @html_url = options[:html_url]
      end

      def to_h
        {
          protocol: protocol,
          username: username,
          host: host,
          owner: owner,
          repo: repo,
          html_url: html_url
        }
      end
    end

    REGEXP = %r{
      (?<protocol>(http://|https://|git://|ssh://))*
      (?<username>[^@]+@)*
      (?<host>[^/]+)
      [/:]
      (?<owner>[^/]+)
      /
      (?<repo>[^/.]+)
    }x.freeze

    def parse(remote_uri)
      if (matched = remote_uri.match(REGEXP))
        Result.new({
                     protocol: matched[:protocol],
                     username: matched[:username]&.delete('@'),
                     host: matched[:host],
                     owner: matched[:owner],
                     repo: matched[:repo],
                     html_url: File.join("https://#{matched[:host]}", matched[:owner], matched[:repo])
                   })
      end
    end
  end
end
