require_relative '../spec_helper'

require './lib/helpers/git.rb'

RSpec.describe Git do
  describe '#repository?' do
    it 'Returns true for current repository' do
      expect(Git.repository?('.')).to(eq(true))
    end
  end
end
