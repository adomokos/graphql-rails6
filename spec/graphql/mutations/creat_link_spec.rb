require 'rails_helper'

RSpec.describe Mutations::CreateLink do
  def perform(user: nil, **args)
    Mutations::CreateLink.new(object: nil, context: {}).resolve(args)
  end

  it 'can create a new link' do
    link = perform(
      url: 'http://example.com',
      description: 'description',
    )

    expect(link).to be_persisted
  end
end
