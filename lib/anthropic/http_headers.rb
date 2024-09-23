module Anthropic
  module HTTPHeaders
    def add_headers(headers)
      @extra_headers = extra_headers.merge(headers.transform_keys(&:to_s))
    end

    private

    def headers
      if @gcp
        gcp_headers
      else
        anthropic_headers.merge(extra_headers)
      end
    end

    def gcp_headers
      {
        "Content-Type" => "application/json; charset=utf-8",
        "Authorization" => "Bearer #{@access_token}"
      }
    end

    def anthropic_headers
      {
        "x-api-key" => @access_token,
        "anthropic-version" => @anthropic_version,
        "Content-Type" => "application/json"
      }
    end

    # def azure_headers
    #   {
    #     "Content-Type" => "application/json",
    #     "api-key" => @access_token
    #   }
    # end

    def extra_headers
      @extra_headers ||= {}
    end
  end
end
