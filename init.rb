
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))

module JinRou
  def self.expand relative_path
    # why expand_path would fail due to chdir?
    # so save correct result for the first time
    @base ||= File.expand_path(File.dirname(__FILE__))
    "#{@base}/#{relative_path}"
  end
  def self.file_read relative_path
    File.read(JinRou.expand(relative_path))
  end
  def self.yaml_load relative_path
    YAML.load(JinRou.file_read(relative_path))
  end
end
