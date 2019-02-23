class Model
  attr_reader :projects, :orgs

  def read_projects(data_dir)
    puts "Reading projects..."
    @projects = {}
    Dir.entries(data_dir).sort.each do |entry|
      next if !entry.end_with?(".yaml") || entry.start_with?("_")

      yaml = YAML.load_file(File.join(data_dir, entry))
      puts "  #{yaml["project_name"]}"

      org = yaml["organization"]
      if org && org != "none" && !@orgs.has_key?(org)
        STDERR.puts "    Unknown organization key '#{org}'"
      end

      @projects[File.basename(entry, ".yaml")] = yaml
    end
  end

  def read_orgs(data_dir)
    puts "Reading organizations..."
    @orgs = {}
    dir = File.join(data_dir, "orgs")
    Dir.entries(dir).sort.each do |entry|
      next if !entry.end_with?(".yaml") || entry.start_with?("_")

      yaml = YAML.load_file(File.join(dir, entry))
      puts "  #{yaml["name"]}"

      @orgs[File.basename(entry, ".yaml")] = yaml
    end
  end

  def read(data_dir)
    read_orgs(data_dir)
    read_projects(data_dir)
  end

  def code_of_conducts
    result = {}
    projects.each do |_, project|
      url = project["code_of_conduct_url"]
      if url != "none" && url != "?"
        result[project["project_name"]] = url
      end
    end
    result
  end

  def trademark_policies
    result = {}
    projects.each do |_, project|
      url = project["trademark_policy_url"]
      if url != "none" && url != "?"
        result[project["project_name"]] = url
      end
    end
    result
  end
end
