require('spec_helper')

describe(Client) do

  describe('.all') do
    it('returns an empty array intially') do
      expect(Client.all()).to(eq([]))
    end
  end

   describe('#save') do
  it('saves a client to the database') do
    client = Client.new({:name => "Tyrone", :id => nil, :stylist_id => nil})
    client.save()
    expect(Client.all()).to(eq([client]))
  end
 end

  describe('#==') do
    it('is the same client if the name and id are the same') do
      client = Client.new({:name => "Tyrone", :id => nil, :stylist_id => nil})
      client2 = Client.new({:name => "Tyrone", :id => nil, :stylist_id => nil})
      expect(client).to(eq(client2))
    end
  end

  describe('.find') do
    it('finds a client using its id') do
      client =Client.new({:name => "River", :id => nil})
      client.save()
      client2 = Client.new({:name => "Simon", :id => nil})
      client2.save()
      expect(Client.find(client.id())).to(eq(client))
    end
  end
 
 describe('#update') do
  it('updates the name of the client') do
    client = Client.new({:name => "Tyrone", :id => nil, :stylist_id => nil})
    client.save()
    client.update({:name => "Tyrone Gonzalez"})
    expect(client.name()).to(eq("Tyrone Gonzalez"))
  end
 end

 describe('#delete') do
  it('deletes a client from the database') do
    client = Client.new({:name => "Tyrone", :id => nil, :stylist_id => nil})
    client.save()
    client.delete()
    expect(Client.all()).to(eq([]))
  end
 end
end