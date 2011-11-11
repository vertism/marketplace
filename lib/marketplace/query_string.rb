module Marketplace
  require 'cgi'
  require 'active_support/core_ext'

  class QueryString
    attr_accessor :path

    def initialize(path, parameters)
      self.parameters = parameters
      self.path = path
      raise Marketplace::Exceptions::QueryStringArgumentError unless parameters.present?
    end

    def parameters=(value)
      @parameters ||= value
        .merge(timestamp.to_params)
        .merge(credentials.to_params)
        .merge(Marketplace::Signature.to_params)
        .merge(AWSAccessKeyId: credentials.aws_access_key_id)
    end

    def parameters
      @parameters
    end

    def sorted_parameters
      @sorted_parameters ||= Hash[@parameters.map do |k,v|
        [camelize(k),v]
      end.sort]
    end

    def to_canonical
      CGI.escape(("?" + sorted_parameters.to_query))
    end

    def to_hash
      @sorted_parameters.merge("Signature" => signature.sign!)
    end

    private
    def camelize(name)
      name.to_s.camelize.gsub(" ", "")
    end

    def credentials
      Marketplace::Credentials.instance
    end

    def timestamp
      Marketplace::Timestamp
    end

    def signature
      Signature.new(path, to_canonical)
    end
  end
end
