class View
  attr_accessor :model, :project, :org, :content

  def projects
    model.projects
  end

  def render_page(view_dir, output_dir, template, page)
    layout = File.read(File.join(view_dir, "layout.html.haml"))

    template = File.read(File.join(view_dir, "#{template}.html.haml"))

    template_engine = Haml::Engine.new(template)
    @content = template_engine.render(binding)

    layout_engine = Haml::Engine.new(layout)

    output_path = File.join(output_dir, "#{page}.html")
    File.open output_path, "w" do |file|
      file.puts layout_engine.render(binding)
    end
  end

  def render_index(view_dir, output_dir)
    render_page(view_dir, output_dir, "index", "index")
  end

  def render_projects(view_dir, output_dir)
    model.projects.each do |name, project|
      @project = project
      org = project["organization"]
      if org
        @org = model.orgs[org]
      else
        @org = nil
      end
      render_page(view_dir, output_dir, "project", name)
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
