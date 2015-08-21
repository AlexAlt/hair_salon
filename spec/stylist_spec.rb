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

  describe('#id') do
    it('sets the id when you save it') do
      stylist = Stylist.new({:name => "River", :id => nil})
      stylist.save()
      expect(stylist.id()).to(be_an_instance_of(Fixnum))
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

  describe('.find') do
    it('finds a stylist using its id') do
      stylist = Stylist.new({:name => "River", :id => nil})
      stylist.save()
      stylist2 = Stylist.new({:name => "Simon", :id => nil})
      stylist2.save()
      expect(Stylist.find(stylist.id())).to(eq(stylist))
    end
  end

  describe('#clients') do
    it('returns an array of clients for that stylist') do
      stylist = Stylist.new({:name => "River", :id => nil})
      stylist.save()
      expect(stylist.clients()).to(eq([]))
    end
  end

  describe('#add_client') do
    it('adds a client to a stylist') do
      stylist = Stylist.new({:name => "River", :id => nil})
      stylist.save()
      client = Client.new({:name => "Tyrone", :id => nil, :stylist_id => nil})
      client.save()
      stylist.add_client(client)
      expect(stylist.clients()).to(eq([client]))
    end
  end
end 