require 'rails_helper'

RSpec.describe Resolvers::LinksSearch do
  def find(args)
    ::Resolvers::LinksSearch.call(nil, args, nil)
  end

  # This should be handled with something like `factory_bot`
  def create_user
    User.create name: 'test', email: 'test@example.com', password: '123456'
  end

  def create_link(**attributes)
    Link.create! attributes.merge(user: create_user)
  end

  it 'can search for links' do
    create_link description: 'test1', url: 'http://test1.com'
    create_link description: 'test2', url: 'http://test2.com'
    create_link description: 'test3', url: 'http://test3.com'
    create_link description: 'test4', url: 'http://test4.com'

    result = find(
      filter: {
        description_contains: 'test1',
        OR: [{
          url_contains: 'test2',
          OR: [{
            url_contains: 'test3'
          }]
        }, {
          description_contains: 'test2'
        }]
      }
    )

    result_descriptions = result.map(&:description).sort
    expect(result_descriptions).to match_array(%w(test1 test2 test3))
  end
end
