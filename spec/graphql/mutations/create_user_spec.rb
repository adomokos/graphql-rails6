require 'rails_helper'

RSpec.describe Mutations::CreateUser do
  def perform(user: nil, **args)
    Mutations::CreateUser.new(object: nil, context: {}).resolve(args)
  end

  it 'can create a new user' do
    user = perform(
      name: 'Test User',
      auth_provider: {
        email: {
          email: 'email@example.com',
          password: '[omitted]'
        }
      }
    )

    expect(user).to be_persisted
    expect(user.name).to eq('Test User')
    expect(user.email).to eq('email@example.com')
  end
end
