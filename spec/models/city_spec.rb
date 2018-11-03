require 'rails_helper'

describe City, type: :model do
  context 'Validations' do
    it { should validate_presence_of :rank }
    it { should validate_presence_of :name }
    it { should validate_presence_of :state }
    it { should validate_presence_of :growth }
    it { should validate_presence_of :population }
    it { should validate_presence_of :latitude }
    it { should validate_presence_of :longitude }
  end
end
