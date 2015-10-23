require "uri"

module OpsWorks
  module SCM
    module S3
      def self.parse_uri(uri)
        uri = URI.parse(uri)
        
        uri_path_components = uri.path.split("/").reject{|p| p.empty?}
        
        virtual_host_match = uri.host.match(/\A((.+)\.)?s3(?:-(?:ap|eu|sa|us)-.+-\d)?\.amazonaws\.com/i)
        
        bucket = uri_path_components[0]
        remote_path = uri_path_components[1..-1].join("/")
        
        [virtual_host_match[0], bucket, remote_path]
      end
    end
  end
end
