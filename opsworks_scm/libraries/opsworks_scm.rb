require "uri"

module OpsWorks
  module SCM
    module S3
      def self.parse_uri(uri)
        uri = URI.parse(uri)
        Chef::Log.info "uri: #{uri}"

        uri_path_components = uri.path.split("/").reject{|p| p.empty?}
        Chef::Log.info "uri_path_components: #{uri_path_components}"

        virtual_host_match = uri.host.match(/\A((.+)\.)?s3(?:-(?:ap|eu|sa|us)-.+-\d)?\.amazonaws\.com/i)
        Chef::Log.info "virtual_host_match: #{virtual_host_match}"

        bucket = uri_path_components[0]
        remote_path = uri_path_components[1..-1].join("/")
        
        [bucket, remote_path]
      end
    end
  end
end
