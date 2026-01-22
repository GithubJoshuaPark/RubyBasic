# typed: strict
require 'sorbet-runtime'
require 'json'
require_relative '../utils/Utils'

class JsonStore
  extend T::Sig
  include Utils

  sig { params(filename: String).void }
  def initialize(filename)
    log "Initializing JsonStore with filename: #{filename}"
    @filename = T.let(filename, String)
  end

  # Load data from file
  # Returns: Array of Hashes
  sig { returns(T::Array[T::Hash[Symbol, T.untyped]]) }
  def load
    log "Loading data from #{@filename}"
    return [] unless File.exist?(@filename)

    file_content = File.read(@filename)
    return [] if file_content.strip.empty?

    begin
      parsed_data = JSON.parse(file_content, symbolize_names: true)
      T.cast(parsed_data, T::Array[T::Hash[Symbol, T.untyped]])
    rescue JSON::ParserError
      log "Failed to parse JSON from #{@filename} (empty file)"
      []
    ensure
      log "Loaded data from #{@filename}"
    end
  end

  # Save data to file
  # Params: data (Array of Hashes)
  sig { params(data: T::Array[T::Hash[Symbol, T.untyped]]).void }
  def save(data)
    log "Saving data to #{@filename}"
    dirname = File.dirname(@filename)
    Dir.mkdir(dirname) unless Dir.exist?(dirname)

    # Write data to file
    # JSON.pretty_generate(data) makes it readable (indented)
    File.write(@filename, JSON.pretty_generate(data))
  end
end

