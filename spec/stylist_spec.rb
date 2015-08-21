require('spec_helper')

describe(Stylist) do 

  describe('.all') do
    it('initially returns and empty array') do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a stylist to the database') do
      stylist = Stylist.new({:name => "River", :id => nil})
      stylist.save()
      expect(Stylist.all()).to(eq([stylist]))
    end
  end

  describe('#==') do
    it('is the same stylist if the name and id are the same') do
      stylist = Stylist.new({:name => "River", :id => nil})
      stylist2 = Stylist.new({:name => "River", :id => nil})
      expect(stylist).to(eq(stylist2))
    end
  end

  describe('#update') do
    it('updates the name of the stylist') do
      stylist = Stylist.new({:name => "River", :id => nil})
      stylist.save()
      stylist.update({:name => "River Tam"})
      expect(stylist.name()).to(eq("River Tam"))
    end
  end

  describe('#delete') do
    it('deletes a stylist from the database') do
      stylist = Stylist.new({:name => "River", :id => nil})
      stylist.save()
      stylist.delete()
      expect(Stylist.all()).to(eq([]))
    end
  end

end 