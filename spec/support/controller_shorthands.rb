def it_redirects(what=nil)
  if what
    if what == :back
      it_redirects_to request.env["HTTP_REFERER"]
    else
      it_redirects_to what
    end
  else
    response.should be_redirect
  end
end

def it_redirects_to(what)
  what = send(what.class.to_s.underscore+'_path',what) if what.kind_of? ActiveRecord::Base
  response.should redirect_to(what)
end

def it_renders(what)
  response.should render_template(what.to_s)
end

def it_has_flash(what,content=nil)
  case content
  when nil then flash[what].should_not be_blank
  when Regexp then flash[what].should =~ content
  else flash[what].should == content.to_s
  end
end
alias :it_flashes :it_has_flash

def it_assigns(what,to=nil)
  if to
    assigns[what].should == to
  else
    assigns[what].should_not be_blank
  end
end