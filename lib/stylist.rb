class Stylist
  attr_reader(:name, :phone)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch('name')
    @phone = attributes.fetch('phone')
  end

  define_singleton_method(:all) do
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    stylists = []
    returned_stylists.each() do |stylist|
      name = stylist.fetch('name')
      phone = stylist.fetch('phone')
      stylists.push(Stylist.new({:name=> name, :phone => phone}))
    end
    stylists
  end


end
