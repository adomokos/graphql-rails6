require 'rails_helper'

RSpec.describe Mutations::SignInUser do
  def perform(user: nil, **args)
    Mutations::SignInUser.new(object: nil, context: {}).resolve(args)
  end

  def create_user
    User.create!(
      name: 'Test User',
      email: 'email@example.com',
      password: '[omitted]'
    )
  end

  it 'can sign in the user with success' do
    user = create_user

    result = perform(
      email: {
        email: user.email,
        password: user.password
      }
    )

    expect(result[:token]).to be_present
    expect(result[:user]).to eq(user)
  end

  it 'will fail with no credentials' do
    result = perform

    expect(result).to be_nil
  end

  it 'will fail with wrong email' do
    create_user
    result = perform(email: { email: 'wrong' })

    expect(result).to be_nil
  end

  it 'will fail with wrong password' do
    user = create_user
    result = perform(email: { email: user.email, password: 'wrong' })

    expect(result).to be_nil
  end
end
