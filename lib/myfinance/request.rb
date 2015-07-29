module Myfinance
  class Request

    def initialize(args)
      @args = args
    end

    def run
      request.run
      request.response
    end

    private

    attr_reader :args

    def request
      @request ||= Typhoeus::Request.new(args[:url], options)
    end

    def options
      {
        method:           args[:method],
        params:           args[:params],
        body:             body,
        headers:          headers,
        accept_encoding:  "gzip"
      }.reject {|k,v| v.nil?}
    end

    def headers
      headers = args.fetch(:headers) { {} }

      {
        "Accept"         => "application/json",
        "Content-Type"   => "application/json",
        "User-Agent"     => args[:user_agent],
        "Authorization" => "Basic #{args[:authorization_hash]}"
      }.merge(headers)
    end

    def body
      body = args[:body]
      body = MultiJson.dump(body) if body.is_a?(Hash)
      body
    end

  end
end
