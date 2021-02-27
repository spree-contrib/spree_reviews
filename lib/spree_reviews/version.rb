module SpreeReviews
  module_function

  # Returns the version of the currently loaded SpreeReviews as a
  # <tt>Gem::Version</tt>.
  def version
    Gem::Version.new VERSION::STRING
  end

  module VERSION
    MAJOR = 4
    MINOR = 0
    TINY  = 0

    STRING = [MAJOR, MINOR, TINY].compact.join('.')
  end
end
