require_relative '../spec_helper'

require_relative '../../lib/helpers/git'

RSpec.describe Git do
  describe '#repository?' do
    it 'Returns true for current repository' do
      expect(Git.repository?('.')).to(eq(true))
    end
  end
end
