require('spec_helper')

describe('Client') do
  describe('#==') do
    it('is the same client if the name and stylist ID is the same') do
      stylist = Stylist.new({:name => "John Smith", :phone =>'312-867-5309', :id => nil})
      client1 = Client.new({:name => "Mary Jane", :phone => "987-789-1011", :stylist_id => stylist.id()})
      client2 = Client.new({:name => "Mary Jane", :phone => "987-789-1011", :stylist_id => stylist.id()})
      expect(client1).to(eq(client2))
    end
  end

  describe('.all') do
    it('starts as an empty array of clients') do
      expect(Client.all()).to(eq([]))
    end
  end

  describe('#name') do
    it('tells you client name') do
      stylist = Stylist.new({:name => "John Smith", :phone =>'312-867-5309', :id => nil})
      client = Client.new({:name => "Mary Jane", :phone => "987-789-1011", :stylist_id => stylist.id()})
      expect(client.name()).to(eq("Mary Jane"))
    end
  end

  describe('#stylist_id') do
    it('lets you read the stylist ID out') do
      stylist = Stylist.new({:name => "John Smith", :phone =>'312-867-5309', :id => nil})
      client = Client.new({:name => "Mary Jane", :phone => "987-789-1011", :stylist_id => stylist.id()})
      expect(client.stylist_id()).to(eq(stylist.id()))
    end
  end

  describe('#save') do
    it('saves the client to an array of clients') do
      stylist = Stylist.new({:name => "John Smith", :phone =>'312-867-5309', :id => nil})
      client = Client.new({:name => "Mary Jane", :phone => "987-789-1011", :stylist_id => stylist.id(), :id=> nil})
      client.save()
      expect(Client.all()).to(eq([client]))
    end
  end

end
