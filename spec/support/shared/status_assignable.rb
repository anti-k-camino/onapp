RSpec.shared_examples_for 'SelfAssignable' do

  it 'should return right Status instance' do
    expect(Status.send(res[:method])).to eq res[:result]
  end
 
end