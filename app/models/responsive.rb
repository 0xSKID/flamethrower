class Responsive < Person

  def lost!
    becomes!(Lost)
    save
  end

  def dated!
    becomes!(Dated)
    save
  end
end
