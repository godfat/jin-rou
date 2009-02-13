
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))

module JinRou
  module_function
  def root
    # why expand_path would fail due to chdir?
    # so save correct result for the first time
    @root ||= File.expand_path(File.dirname(__FILE__))
  end
  def expand relative_path
    "#{root}/#{relative_path}"
  end
  def file_read relative_path
    File.read(JinRou.expand(relative_path))
  end
  def yaml_load relative_path
    YAML.load(JinRou.file_read(relative_path))
  end
end
