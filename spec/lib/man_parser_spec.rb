require 'spec/spec_helper'

describe ManParser do
  describe :parse do
    it "finds the description" do
      d = ManParser.parse('ls')[:description]
      d.should be_start_with('List information about the FILEs (the c')
      d.should be_end_with('problems, 2 if serious trouble.')
      d.should_not include('-a, --all')
      d.should_not include('do not ignore entries starting with')
      d.should_not include("      ")
    end
  end

  describe :start_of_option? do
    {
      '   -1'=>true,
      '   -a'=>true,
      '   -X'=>true,
      '   -a, --all'=>true,
      '   '=>false,
      'asdas a -asd, --asd'=>false,
      '---------'=>false,
      '  --------- '=>false,
      '   asdadas'=>false
    }.each do |line, success|
      it "recognises #{line} -- #{success}" do
        ManParser.send(:start_of_option?, line).should == success
      end
    end
  end
end