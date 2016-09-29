RSpec.shared_examples_for 'Method' do

  it 'should not return' do 
    expect(Ticket.send(res[:method]).include?(res[:invalid])).to be_falsy     
  end

  it 'should return' do
    expect(Ticket.send(res[:method])).to eq res[:result]        
  end
end