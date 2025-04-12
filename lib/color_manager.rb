class ColorManager
  def self.options(type: nil)
    return black_people if type == :black
    return white_people if type == :white
    {
      skin: (black_people[:skin] + white_people[:skin]).uniq,
      eye: (black_people[:eye] + white_people[:eye]).uniq,
      hair: (black_people[:hair] + white_people[:hair]).uniq,
    }
  end

  def self.parse(colors)
    {
      silhouette: {
        skin: colors[:skin],
        shirt: colors[:shirt]
      },
      nose:       "#000000",
      mouth:      "#000000",
      eye:        colors[:eye],
      eye_brow:   colors[:hair],
      hair:       colors[:hair],
      beard:      colors[:hair]
    }
  end

  
  def self.black_people
    {
      skin: [
        '#c68642', # caramelo médio
        '#b07d56', # marrom claro quente
        '#a9746e', # marrom rosado médio
        '#8d5524', # marrom clássico
        '#7c4f35'  # marrom avermelhado
      ],
      eye: [
        '#4b2e19', # castanho escuro
        '#5c4033', # castanho médio
        '#7b5e57', # castanho claro
        '#c19a6b', # mel
        '#a86b32'  # âmbar dourado
      ],
      hair: [
        '#5c4033', # castanho escuro neutro
        '#6b4c3b', # castanho quente
        '#4a3221', # marrom médio natural
        '#3b2f2f', # castanho profundo com brilho
        '#7b5e57'  # marrom claro suave
      ]
    }
  end

  def self.white_people
    {
      skin: [
        '#f1c27d', # claro natural
        '#ffdbac', # mais rosado
        '#eac086', # neutro/bege
        '#fff0d5'  # quase branco
      ],
      eye: [
        '#a2c8f2', # azul claro
        '#436fa1', # azul escuro
        '#a0d6b4', # verde claro
        '#7a9e7e', # verde musgo
        '#c19a6b', # mel / âmbar
        '#a86b32', # castanho claro
        '#4b2e19', # castanho escuro
        '#cfd8dc', # cinza claro
        '#9eb4c1'  # cinza azulado
      ],
      hair: [
        '#f8f1d0', # loiro platinado
        '#f0d29c', # loiro claro
        '#d1a054', # loiro escuro
        '#a56b3d', # castanho claro
        '#6b4423', # castanho médio
        '#3e2c1c', # castanho escuro
        '#1c1c1c', # preto natural
        '#c65f29', # ruivo claro
        '#8b3e2f', # ruivo escuro
        '#c0c0c0', # grisalho claro
        '#8a8a8a'  # grisalho escuro
      ]
    }
  end
end