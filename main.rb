require "bundler/setup"
require "byebug"
require_relative "lib/asset_manager"
require_relative "lib/color_manager"
require_relative "lib/face_assembler"

Dir.mkdir("_output") unless Dir.exist?("_output")

def random_create(quantity: 1)
  quantity.times.each do |i|
    people_type = [:white, :black].sample
    
    parts = AssetManager.parse({
      silhouette: AssetManager.options[:silhouette].sample,
      nose:       AssetManager.options[:nose].sample,
      mouth:      AssetManager.options[:mouth].sample,
      eye:        AssetManager.options[:eye].sample,
      eye_brow:   AssetManager.options[:eye_brow].sample,
      hair:       AssetManager.options[:hair].sample,
      beard:      AssetManager.options[:beard].sample,
    })

    colors = ColorManager.parse({
      skin:  ColorManager.options(type: people_type)[:skin].sample, 
      shirt: "#00008B", 
      eye:   ColorManager.options(type: people_type)[:eye].sample,
      hair:  ColorManager.options(type: people_type)[:hair].sample,
    })
    
    image = FaceAssembler.generate(parts: parts, colors: colors)
    image.save("_output/#{output_name(parts, colors)}")
  end
end

def output_name(parts, colors)
  name = "P-"
  name += "#{parts[:silhouette]}_"
  name += "#{parts[:nose]}_"
  name += "#{parts[:mouth]}_"
  name += "#{parts[:eye_right]}-#{parts[:eye_left]}_"
  name += "#{parts[:eye_brow]}_"
  name += "#{parts[:hair]|| 'nil'}_"
  name += "#{parts[:beard] || 'nil'}_"
  name += "C-"
  name += "#{colors[:silhouette][:shirt]}_"
  name += "#{colors[:silhouette][:skin]}_"
  name += "#{colors[:eye_right]}-#{colors[:eye_left]}_"
  name += "#{colors[:eye_brow]}_"
  name += "#{colors[:hair] || 'nil'}_"
  name += "#{colors[:beard] || 'nil'}"
  name += ".png"
end

quantity = ARGV[0]&.to_i || 1
random_create(quantity: quantity)