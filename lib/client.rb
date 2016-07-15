class Client
attr_reader(:name, :phone, :stylist_id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @phone = attributes.fetch(:phone)
    @stylist_id = attributes.fetch(:stylist_id)
  end

  define_method(:==) do |another_client|
    self.name().==(another_client.name()).&(self.stylist_id().==(another_client.stylist_id()))
  end

end
