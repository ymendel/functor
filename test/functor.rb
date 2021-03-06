require "#{File.dirname(__FILE__)}/helpers"

class Repeater
  attr_accessor :times
  include Functor::Method
  functor( :repeat, Integer ) { |x| x * @times }
  functor( :repeat, String ) { |s| [].fill( s, 0, @times ).join(' ') }
  functor( :repeat ) { nil }
end

describe "Dispatch on instance method should" do
  
  before do
    @r = Repeater.new
    @r.times = 5
  end
  
  specify "invoke different methods with object scope based on arguments" do
    @r.repeat( 5 ).should == 25
    @r.repeat( "-" ).should == '- - - - -'
    @r.repeat.should == nil
  end
  
  specify "raise an exception if there is no matching value" do
    lambda { @r.repeat( 7.3 ) }.should.raise(ArgumentError)
  end
end

  