require 'spec_helper'
 
res_type_name = :netapp_export
res_type = Puppet::Type.type(res_type_name)
res_name = '/vol/v_test/q_test'

describe res_type do

  let(:provider) {
    prov = stub 'provider'
    prov.stubs(:name).returns(res_type_name)
    prov
  }
  let(:res_type) {
    val = res_type
    val.stubs(:defaultprovider).returns provider
    val
  }
  let(:resource) {
    res_type.new({:name => res_name})
  }

  it 'should have :name be its namevar' do
    res_type.key_attributes.should == [:name]
  end

  # Simple parameter tests
  parameter_tests = {
    :name => {
      :valid	=> ["/vol/v_volume/q_volume", "/vol/v_test/q_test"],
      :invalid 	=> ["test","/vol/v_volume/q_volume#"],
      :default 	=> "/vol/v_test/q_test", 
    },
    :persistent => {
      :valid 	=> [:true, :false],
      :invalid	=> "test",
      :default 	=> :true,
    },
    :path => {
      :valid	=> ["/vol/v_volume/q_volume", "/vol/v_test/q_test"],
      :invalid 	=> ["test","/vol/v_volume/q_volume#"],
      :default 	=> "/vol/v_test/q_test",
    }
  }
  it_should_behave_like "a puppet type", parameter_tests, :netapp_export, res_name

end
