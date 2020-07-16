module RestfullyAccessibleStub
  def stub_get_request(url, resource_name)
    stub_request(:get, url)
      .with(
        headers: request_headers
      ).to_return(
        status: 200,
        body: %Q[{#{resource_name}: "dummy"}]
      )
  end

  def stub_get_request_with_json_response(url, body)
    stub_request(:get, url)
      .with(
        headers: request_headers
      ).to_return(
        status: 200,
        headers: {'Content-Type' => 'application/json'},
        body: body.class == String ? body : body.to_json
      )
  end

  def stub_get_request_not_found(url)
    stub_request(:get, url)
      .with(
        headers: request_headers
      ).to_return(
        status: 404,
        body: "itemNotFound"
      )
  end

  def stub_get_request_unauthorized(url)
    stub_request(:get, url)
      .with(
        headers: request_headers
      ).to_return(
        status: 401,
        body: "unauthorized"
      )
  end

  def request_headers
    {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>"Yao/#{Yao::VERSION} Faraday/#{Faraday::VERSION}"}
  end
end
