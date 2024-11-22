class ImageUploader < Shrine
  # plugins and uploading logic
  plugin :upload_options, cache: { move: true }, store: { move: true }

  ALLOWED_TYPES  = %w[image/jpg image/jpeg image/png image/webp]
  MAX_SIZE       = 11*1024*1024 # 11 MB
  MAX_DIMENSIONS = [5000, 5000] # 5000x5000

  # File validations (requires `validation_helpers` plugin)
  Attacher.validate do
    validate_max_size MAX_SIZE
    validate_mime_type ALLOWED_TYPES
  end

  Attacher.derivatives do |original|
    magick = ImageProcessing::Vips.source(original)
    {
      small:  magick.resize_to_limit!(100, 100)
    }
  end

  def generate_location(io, record: nil, derivative: nil, **)
    return super unless record
    table  = record.class.table_name
    id     = record.id
    prefix = derivative || "original"
    "#{table}/#{id}/#{prefix}-#{super}"
  end
end