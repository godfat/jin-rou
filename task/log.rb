
module JinRou
  module_function
  def log_each
    Dir.glob(JinRou.expand("log/*.log")).each{ |file|
      yield(file)
    }
  end

  def log_clear
    log_each{ |file| File.open(file, 'w').close }
  end

  def log_gzip
    log_each{ |file|
      if respond_to?(:sh)
        sh("gzip #{file}")
      else
        system("gzip #{file}")
      end
    }
  end
end
