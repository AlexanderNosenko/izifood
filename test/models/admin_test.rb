require "test_helper"

describe Admin do
  let(:admin) { Admin.new }

  it "must be valid" do
    value(admin).must_be :valid?
  end
end
