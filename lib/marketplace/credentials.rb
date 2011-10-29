module Marketplace
  class Credentials
    attr_accessor :merchant, :markeplace, :aws_access_key_id, :secret_key

    def initialize(options={})
      self.merchant          = options[:merchant]
      self.marketplace       = options[:marketplace]
      self.aws_access_key_id = options[:aws_access_key_id]
      self.secret_key        = options[:secret_key]
    end
    
    def self.load
      new(read_from_file)
    end

    def self.read_from_file
      YAML.load_file(File.join('config', 'credentials.yml'))
    end
  end
end
