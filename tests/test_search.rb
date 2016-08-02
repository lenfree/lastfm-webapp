require File.expand_path './../test_helper.rb', __FILE__

class AppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_default
    get '/'
    assert last_response.body.include?("Search TOP music by Country")
  end

  def test_form_post
    post('/search', 'country_name': '')
    assert_equal("Parameter missing error", last_response.body)
  end

  def test_get_artist
    get('/search/artist', 'name': '')
    assert_equal("Parameter missing error", last_response.body)
  end
end
