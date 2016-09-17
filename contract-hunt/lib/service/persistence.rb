# encoding: utf-8

class Log
  def self.path
    "/var/matched_contracts.yml"
  end

  def self.load
    hash = YAML::load(File.read(self.path))
    raise unless hash.respond_to?(:[])
    self.new(hash)
  rescue
    self.new(Hash.new)
  end

  attr_reader :hash
  def initialize(hash)
    @hash = hash
  end

  def [](base_url)
    @hash[base_url] ||= Array.new
  end

  def save
    File.open(self.class.path, "w") do |file|
      file.puts(@hash.to_yaml)
    end
  end
end
