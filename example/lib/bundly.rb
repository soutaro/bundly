require "yaml"

module Bundly
  VERSION = "0.1.0"

  def gems(file)
    YAML.load(Pathname(file).read).each do |gem|
      name = gem["name"]
      version = gem["version"]
      git = gem["git"]
      branch = gem["branch"]
      tag = gem["tag"]

      gem name, version, git: git, branch: branch, tag: tag
    end
  end
end

class Bundler::Dsl
  include Bundly
end
