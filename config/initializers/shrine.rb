require "shrine"
require "shrine/storage/file_system"

# "/home/sard/projects/aws"
if  Rails.env.test?
  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new
  }
elsif Rails.env.development?
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
    store: Shrine::Storage::FileSystem.new("public", prefix: "uploads")
  }
elsif Rails.env.production?
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
    store: Shrine::Storage::FileSystem.new("public", prefix: "uploads", host: "https://resiudicata.net")
  }
end


Shrine.plugin :activerecord           # loads Active Record integration
Shrine.plugin :cached_attachment_data # enables retaining cached file across form redisplays
Shrine.plugin :restore_cached_data    # extracts metadata for assigned cached files
Shrine.plugin :validation_helpers
Shrine.plugin :validation
Shrine.plugin :derivatives, create_on_promote: true
Shrine.plugin :upload_endpoint
