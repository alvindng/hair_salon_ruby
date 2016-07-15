require('spec_helper')

describe('Stylist') do
  describe('.all') do
    it('will start as an empty array') do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe('#==') do
    it('is the same stylist if they have the same name') do
      stylist1 = Stylist.new({:name => "John Smith", :phone =>'312-867-5309', :id => nil})
      stylist2 = Stylist.new({:name => "John Smith", :phone =>'312-867-5309', :id => nil})
      expect(stylist1).to(eq(stylist2))
    end
  end

  describe('#name') do
    it('tells you stylist name') do
      stylist = Stylist.new({:name => "John Smith", :phone =>'312-867-5309', :id => nil})
      expect(stylist.name()).to(eq("John Smith"))
    end
  end

  describe('#save') do
    it('saves the stylist to an array of stylists') do
      test_stylist = Stylist.new({:name => "John Smith", :phone =>'312-867-5309', :id => nil})
      test_stylist.save()
      expect(Stylist.all()).to(eq([test_stylist]))
    end
  end

  describe('#id') do
    it ("sets the ID when you save it") do
      test_stylist = Stylist.new({:name => "John Smith", :phone =>'312-867-5309', :id => nil})
      test_stylist.save()
      expect(test_stylist.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe(".find") do
    it("returns a stylist by their ID") do
      test_stylist1 = Stylist.new({:name => "John Smith", :phone =>'312-867-5309', :id => nil})
      test_stylist1.save()
      test_stylist2 = Stylist.new({:name => "Bob Jones", :phone =>'999-888-7777', :id => nil})
      test_stylist2.save()
      expect(Stylist.find(test_stylist2.id())).to(eq(test_stylist2))
    end
  end

  describe('#clients') do
    it('returns an array of clients for a stylist based on stylist ID') do
      test_stylist = Stylist.new({:name => "John Smith", :phone =>'312-867-5309', :id => nil})
      test_stylist.save()
      client1 = Client.new({:name => "Mary Jane", :phone => "987-789-1011", :stylist_id => test_stylist.id()})
      client1.save()
      client2 = Client.new({:name => "Doctor Watson", :phone => "444-555-2222", :stylist_id => test_stylist.id()})
      client2.save()
      expect(test_stylist.clients()).to(eq([client1,client2]))
    end
  end

  describe("#update") do
    it("lets you update stylists in the database") do
      stylist = Stylist.new({:name => "John Smith", :phone =>'312-867-5309', :id => nil})
      stylist.save()
      stylist.update({:name => "You Daman", :phone =>'982-090-1212', :id => nil})
      expect(stylist.name()).to(eq("You Daman"))
    end
  end

  describe("#delete") do
    it("lets you delete a stylist from the database") do
      test_stylist1 = Stylist.new({:name => "John Smith", :phone =>'312-867-5309', :id => nil})
      test_stylist1.save()
      test_stylist2 = Stylist.new({:name => "Bob Jones", :phone =>'999-888-7777', :id => nil})
      test_stylist2.save()
      test_stylist2.delete()
      expect(Stylist.all()).to(eq([test_stylist1]))
    end
  end
end
