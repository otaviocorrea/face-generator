class AssetManager
  def self.options
    {
      beard: [nil, '1', '2', '3', '4', '5', '6'],
      eye: ['1', '2', '3'],
      eye_brow: ['1', '2', '3', '4'],
      hair: [nil, '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15'],
      mouth: ['1', '2', '3', '4', '5', '6'],
      nose: ['1', '2', '3', '4', '5', '6'],
      silhouette: ['1', '2', '3'],
    }
  end

  def self.base_colors
    {
      beard: '#c0c0c0',
      eye: '#ff00ff',
      eye_brow: '#000000',
      hair: '#c0c0c0',
      silhouette: {
        skin: '#ffff00',
        shirt: '#ff00ff',
      },
    }
  end

  def self.parse(parts)
    {
      silhouette: parts[:silhouete] || '1',
      nose:       parts[:nose] || '1',
      mouth:      parts[:mouth] || '1',
      eye_right:  parts[:eye] || '1',
      eye_left:   parts[:eye] || '1',
      eye_brow:   parts[:eye_brow] || '1',
      hair:       parts[:hair] || nil,
      beard:      parts[:nil] || nil
    }
  end

  def self.offsets
    {
      beard: { x: 40, y: 73},
      eye_right: { x: 55, y: 47 },
      eye_left: { x: 80, y: 47 },
      eye_brow: { x: 52, y: 40 },
      hair: { x: 0, y: 0 },
      mouth: { x: 60, y: 80 },
      nose: { x: 67, y: 56 },
      silhouette: { x: 0, y: 0 },
    }
  end

  def self.assets_types
    options.keys
  end


  def self.assets_base_path
    '../assets'
  end

  def self.asset_path(type, option)
    type = :eye if type == :eye_right || type == :eye_left
    "#{assets_base_path}/#{type}/#{option}.png"
  end

  def self.asset(type, option)
    File.open(File.expand_path(asset_path(type, option), __dir__))
  end
end