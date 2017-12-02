

class Song

  def initialize(name, style, lyrics)
    @name = name.downcase
    @style = style.downcase
    @lyrics = lyrics.downcase
  end


  def check_name
    return @name
  end


  def check_style
    return @style
  end


  def read_lyrics
    return @lyrics
  end


end
