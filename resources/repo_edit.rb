actions :edit_connection, :edit_explicit_mapping
default_action :edit

attribute :path, name_attribute: true, kind_of: String, required: true
attribute :key, kind_of: String
attribute :file, kind_of: String
attribute :value, kind_of: String

attr_accessor :exists
