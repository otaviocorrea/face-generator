require "chunky_png"
require_relative "asset_manager"

class FaceAssembler
  ASSETS_BASE_PATH = "assets/old_school_bmp"

  # Cor que será substituída (cor original do asset que deve ser tingida)
  BASE_COLOR_TO_REPLACE = ChunkyPNG::Color.rgb(128, 128, 128) # ex: cinza médio nos assets

  # Cor de fundo a ser removida (branco puro)
  BACKGROUND_COLOR = ChunkyPNG::Color.rgb(255, 255, 255)

  def self.generate(parts:, colors:)
    @parts = parts
    @colors = colors

    width  = 150  # ajuste conforme o tamanho dos seus assets
    height = 150

    final = ChunkyPNG::Image.new(width, height, ChunkyPNG::Color::TRANSPARENT)

    @parts.each do |type, id|
      next if id.nil?
      asset = edit_asset(type, id)
      final.compose!(asset[0], asset[1], asset[2])
    end

    final
  end

  def self.edit_asset(type, id)
    file = AssetManager.asset(type, id)
    
    img = ChunkyPNG::Image.from_file(file.path)
    if @colors[type].is_a?(Hash)
      new_obj = {}
      AssetManager.base_colors[type].keys.each do |color_key|
        new_obj[ChunkyPNG::Color.from_hex(AssetManager.base_colors[type][color_key])] = @colors[type][color_key] ? ChunkyPNG::Color.from_hex(@colors[type][color_key]) : new_obj[ChunkyPNG::Color.from_hex(AssetManager.base_colors[type][color_key])]
      end

      img = recolor_multiple(img, new_obj)
    else
      tmp_type = type
      tmp_type = :eye if type == :eye_right || type == :eye_left
      base_color = AssetManager.base_colors[tmp_type]
      unless base_color.nil?
        color = ChunkyPNG::Color.from_hex(base_color)
        img = recolor(img, from: color, to: ChunkyPNG::Color.from_hex(@colors[tmp_type]))
      end
    end
  
    img = remove_background(img)

    # 🔧 Posicione aqui se os assets não forem alinhados perfeitamente
    x_offset = AssetManager.offsets[type][:x]
    y_offset = AssetManager.offsets[type][:y]

    [img, x_offset, y_offset]
  end

  def self.recolor(image, from:, to:)
    image.pixels.map! do |pixel|
      ChunkyPNG::Color.rgb(ChunkyPNG::Color.r(to), ChunkyPNG::Color.g(to), ChunkyPNG::Color.b(to)) if pixel == from
      pixel == from ? to : pixel
    end
    image
  end

  def self.recolor_multiple(image, substitutions)
    image.height.times do |y|
      image.row(y).each_with_index do |pixel, x|
        new_pixel = substitutions[pixel] || pixel
        image[x, y] = new_pixel
      end
    end
    image
  end

  def self.remove_background(image)
    image.pixels.map! do |pixel|
      pixel == BACKGROUND_COLOR ? ChunkyPNG::Color::TRANSPARENT : pixel
    end
    image
  end
end