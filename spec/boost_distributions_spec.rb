# frozen_string_literal: true

RSpec.describe BoostDistributions do
  it "has a version number" do
    expect(BoostDistributions::VERSION).not_to be nil
  end
  it "has a boost version number" do
    expect(BoostDistributions::BOOST_VERSION).not_to be nil
  end
end
