require 'rspec'

describe MetaCommit::Extension::RubySupport do
  it "has a version number" do
    expect(MetaCommit::Extension::RubySupport::VERSION).not_to be nil
  end
end
