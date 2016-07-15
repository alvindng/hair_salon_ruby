require('spec_helper')

describe('Stylist') do
  describe('.all') do
    it('will start as an empty array') do
      expect(Stylist.all()).to(eq([]))
    end
  end


end
