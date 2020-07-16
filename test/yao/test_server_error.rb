class TestServerError < Test::Unit::TestCase
  def test_detects_error_with_env
    env = Faraday::Env.new
    env.status = 404
    env.body = {"itemNotFound"=>{"message"=>"Image not found.", "code"=>404}}

    error = Yao::ServerError.detect(env)
    assert { error.is_a? Yao::ItemNotFound }
    assert { error.env.is_a? Faraday::Env }
    assert { error.status == 404 }
    assert { error.env.body["itemNotFound"]["message"] == "Image not found." }
  end

  def test_anyway_returns_error
    env = Faraday::Env.new
    env.status = 599
    env.body = "<html>Not found.</html>"

    error = Yao::ServerError.detect(env)
    assert { error.is_a? Yao::ServerError }
    assert { error.env.is_a? Faraday::Env }
    assert { error.status == 599 }
    assert { error.message == "Something is wrong. - \"<html>Not found.</html>\"" }
  end
end
