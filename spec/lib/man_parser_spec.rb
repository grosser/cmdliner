require 'spec/spec_helper'

describe ManParser do
  describe :parse do
    it "finds the description" do
      d = ManParser.parse('ls')[:description]
      d.should =~ /^List  information  about  the FILEs /
      d.should be_end_with('problems, 2 if serious trouble.')
      d.should_not include('-a, --all')
      d.should_not include('do not ignore entries starting with')
      d.should_not include("      ")
    end

    describe 'options' do
      it "finds all options" do
        d = ManParser.parse('ls')[:options]
        d.size.should == 60
      end

      it "extracts the name" do
        d = ManParser.parse('ls')[:options]
        d.first[:name].should == 'a'
      end

      it "extracts the alias" do
        d = ManParser.parse('ls')[:options]
        d.first[:alias].should == 'all'
      end

      it "extracts the description" do
        d = ManParser.parse('ls')[:options]
        d.first[:description].should == 'do not ignore entries starting with .'
      end
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