require('spec_helper')

describe('Client') do
  describe('#==') do
    it('is the same client if the name and stylist ID is the same') do
      stylist = Stylist.new(:name => "John Smith", :phone =>'312-867-5309', :id => nil)
      client1 = Client.new(:name => "Mary Jane", :phone => "987-789-1011", :stylist_id => stylist.id())
      client2 = Client.new(:name => "Mary Jane", :phone => "987-789-1011", :stylist_id => stylist.id())
      expect(client1).to(eq(client2))
    end
  end
end
