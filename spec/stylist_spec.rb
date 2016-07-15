require('spec_helper')

describe('Stylist') do
  describe('.all') do
    it('will start as an empty array') do
      expect(Stylist.all()).to(eq([]))
    end
  end
  
  describe('#==') do
    it('is the same stylist if they have the same name') do
      stylist1 = Stylist.new(:name => "John Smith", :phone =>'312-867-5309')
      stylist2 = Stylist.new(:name => "John Smith", :phone =>'312-867-5309')
      expect(stylist1).to(eq(stylist2))
    end
  end

end
