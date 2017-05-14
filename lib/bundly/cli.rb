require "thor"

module Bundly
  class CLI < Thor
    class_option "--yaml", type: :string, desc: "Yaml file name to list gems", default: "gems.yaml"

    desc "setup", "Setup your Bundly for your project"
    option "--init", type: :string, desc: "File name to put Bundly initialization code", default: "lib/bundly.rb"
    def setup
      template = Pathname(__dir__) + "template.rb.erb"
      init_script = Pathname(options[:init])

      unless init_script.parent.directory?
        puts "No directory for init script: #{init_script}"
        puts "> mkdir #{init_script.parent}"
        exit
      end

      init_script.open("w") do |io|
        io.write Erubis::Eruby.new(template.read).result
      end

      yaml_path = Pathname(options[:yaml])
      yaml_path.write("") unless yaml_path.file?

      puts "1. Add the following line in your Gemfile to load gems from #{yaml_path}:"
      puts
      puts "require_relative '#{init_script}'"
      puts "gems File.join(__dir__, '#{yaml_path}')"
      puts
      puts "2. Declare your dependencies in #{yaml_path} like:"
      puts
      puts "- name: thor"
      puts "  version: ~> 0.1.0"
      puts "  git: https://github.com/rails/rails.git"
      puts "  branch: foobarbaz"
      puts "  tag: 9edd6f54315fbf29bdce4c662329f620ded0badf"
      puts
    end

    desc "gem GEM PARAMETERS...", "Set gem parameters"
    def gem(gem, *params)
      yaml_path = Pathname(options[:yaml])
      content = YAML.load(yaml_path.read)

      if content.is_a?(Array)
        gem_hash = content.find {|hash| hash["name"] == gem }

        if gem_hash
          params.map {|param| param.split(/=/, 2) }.each do |(key, value)|
            if value.size > 0
              gem_hash[key] = value
            else
              gem_hash.delete key
            end
          end
        else
          puts "Could not find gem: #{gem}"
        end
      end

      yaml_path.write(YAML.dump(content))
    end
  end
end
