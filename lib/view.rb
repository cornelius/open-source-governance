class View
  attr_accessor :projects, :project

  def render_index(view_dir, output_dir)
    template = File.read(File.join(view_dir, "index.html.haml"))

    layout_engine = Haml::Engine.new(template)

    output_path = File.join(output_dir, "index.html")
    File.open output_path, "w" do |file|
      file.puts layout_engine.render(binding)
    end
  end

  def render_projects(view_dir, output_dir)
    projects.each do |name, project|
      @project = project
      render_project(view_dir, output_dir, name)
    end
  end

  def render_project(view_dir, output_dir, name)
    template = File.read(File.join(view_dir, "project.html.haml"))

    layout_engine = Haml::Engine.new(template)

    output_path = File.join(output_dir, "#{name}.html")
    File.open output_path, "w" do |file|
      file.puts layout_engine.render(binding)
    end
  end

  def pretty_attribute(attribute)
    words = attribute.split("_")
    words.map { |word| word.capitalize }.join(" ")
  end

  def link_up(text)
    if text.is_a?(String) && text.start_with?("http")
      "<a href='#{text}'>#{text.gsub(/^https:\/\//,"")}</a>"
    else
      text
    end
  end
end
