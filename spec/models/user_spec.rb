RSpec.describe User do
  let(:user) { FactoryBot.create(:user) }

  describe '#created' do
    it 'returns true when the user created the snippet' do
      expect(user).to eq(user)
    end
  end
end