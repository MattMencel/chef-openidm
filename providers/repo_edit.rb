require 'json'

action :edit_connection do
  if @current_resource.exists
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  else
    converge_by("Modify #{@new_resource.key} in #{@new_resource}") do
      edit_connection
    end
  end
end

action :edit_explicit_mapping do
  if @current_resource.exists
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  else
    converge_by("Modify #{@new_resource.key} in #{@new_resource}") do
      edit_explicit_mapping
    end
  end
end

def load_current_resource
  @current_resource = Chef::Resource::OpenidmRepoEdit.new(@new_resource.path)
  @current_resource.path(@new_resource.path)
  @current_resource.key(@new_resource.key)
  @current_resource.value(@new_resource.value)

  if value_exists?(@current_resource.path, @current_resource.key, @current_resource.value, @new_resource.value)
    @current_resource.exists = true
  end
end

def edit_connection
  lock(new_resource.path) do
    json_obj = JSON.load(::File.open(new_resource.path))
    json_obj['connection'][new_resource.key] = new_resource.value
    atomic_write(new_resource.path, new_resource.file + '.tmp', JSON.pretty_generate(json_obj))
  end
end

def edit_explicit_mapping
  lock(new_resource.path) do
    json_obj = JSON.load(::File.open(new_resource.path))
    json_obj['explicitMapping'][new_resource.key] = new_resource.value
    atomic_write(new_resource.path, new_resource.file + '.tmp', JSON.pretty_generate(json_obj))
  end
end

def atomic_write(path, temp_path, content)
  ::File.open(temp_path, 'w+') do |f|
    f.write(content)
  end
  ::FileUtils.mv(temp_path, path)
end

def lock(path)
  if ::File.exist?(path)
    ::File.open(path) do |file|
      file.flock(::File::LOCK_EX)

      yield

      file.flock(::File::LOCK_UN)
    end
  end

  # yield
  #
  # f.close
  #::File.open(path).flock(::File::LOCK_UN)
end

def value_exists?(path, key, _value, new_val)
  json_obj = JSON.load(::File.open(path))
  true if json_obj['connection'][key] == new_val
end
