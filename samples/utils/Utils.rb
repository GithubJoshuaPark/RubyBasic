# typed: false
# 1. Module Definition (Mixin)
# Modules cannot be instantiated (no .new), but can be included in classes.
module Utils
  extend self
  def log(message)
    puts "[LOG] #{Time.now.strftime('%H:%M:%S')} #{message}\n\n"
  end

  def getOneIconRandomlyAmong20Icons
    icons = [
      "🚀", "🌟", "🐱", "🐶", "🦊", "🍉", "🍓", "🌈", "🔥", "💧",
      "🍀", "🍎", "🦄", "⚽", "🏀", "🎸", "🎲", "🧩", "⏰", "💡",
      "✈️", "🏰", "🎡", "🎠", "🎨", "🎭", "🎩", "👑", "💍", "💎",
      "🔮", "🎁", "🎈", "🎉", "🕯️", "🗝️", "🔔", "🎵", "🎶", "🎹"
    ]
    icons.sample
  end
end
