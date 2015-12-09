require "rails_helper"
RSpec.describe Review do
  it { should validate_presence_of(:room) }
end