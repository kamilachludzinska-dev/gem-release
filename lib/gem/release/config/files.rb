require 'yaml'
require_relative '../helper/hash'

module Gem
  module Release
    class Config
      class Files
        include Helper::Hash

        FOLDERS = %w[./ ~/]
        FILES = %w[.gem_release/config.yml .gem_release.yml]

        def load
          return {} unless path
          symbolize_keys(YAML.load_file(path) || {})
        end

        private

          def path
            @path ||= paths.first
          end

          def paths
            paths = combine_paths.map { |path| File.expand_path(path) }
            paths.select { |path| File.exist?(path) }
          end

          def combine_paths
            FOLDERS.product(FILES).map do |folder, file|
              File.join(folder, file)
            end
          end
      end
    end
  end
end
