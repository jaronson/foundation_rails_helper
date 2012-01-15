require "spec_helper"

describe "FoundationRailsHelper::FormHelper" do
  include FoundationRailsSpecHelper

  before do
    mock_everything
  end

  it 'should have FoundationRailsHelper::FormHelper as default buidler' do
    form_for(@author) do |builder|
      builder.class.should == FoundationRailsHelper::FormBuilder
    end    
  end

  describe "input generators" do
    it "should generate text_field input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.text_field(:login)
        node.should have_css('label[for="author_login"]', :text => "Login")
        node.should have_css('input.medium.input-text.placeholder[type="text"][name="author[login]"]')
        node.find_field('author_login').value.should == @author.login
      end    
    end
  
    it "should generate password_field input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.password_field(:password)
        node.should have_css('label[for="author_password"]', :text => "Password")
        node.should have_css('input.medium.input-text.placeholder[type="password"][name="author[password]"]')
        node.find_field('author_password').value.should be_nil
      end    
    end
  
    it "should generate email_field input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.email_field(:email)
        node.should have_css('label[for="author_email"]', :text => "Email")
        node.should have_css('input.medium.input-text.placeholder[type="email"][name="author[email]"]')
        node.find_field('author_email').value.should == @author.email
      end    
    end

    it "should generate text_area input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.text_area(:description)
        node.should have_css('label[for="author_description"]', :text => "Description")
        node.should have_css('textarea.medium.input-text.placeholder[name="author[description]"]')
        node.find_field('author_description').value.should == @author.description
      end    
    end
  
    it "should generate file_field input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.file_field(:avatar)
        node.should have_css('label[for="author_avatar"]', :text => "Avatar")
        node.should have_css('input.medium.input-text.placeholder[type="file"][name="author[avatar]"]')
        node.find_field('author_avatar').value.should  be_nil
      end    
    end
  
    it "should generate date_select input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.date_select(:birthdate)
        node.should have_css('label[for="author_birthdate"]', :text => "Birthdate")
        %w(1 2 3).each {|i| node.should     have_css("select.medium.input-text.placeholder[name='author[birthdate(#{i}i)]']") }
        node.should have_css('select#author_birthdate_1i option[selected="selected"][value="1969"]')
        node.should have_css('select#author_birthdate_2i option[selected="selected"][value="6"]')
        node.should have_css('select#author_birthdate_3i option[selected="selected"][value="18"]')
        %w(4 5).each   {|i| node.should_not have_css("select.medium.input-text.placeholder[name='author[birthdate(#{i}i)]']") }
      end    
    end
  end
  
  describe "errors generator" do
    it "should not display errors" do
      form_for(@author) do |builder|
        node = Capybara.string builder.text_field(:login)
        node.should_not have_css('small.error')
      end
    end
    it "should display errors" do
      form_for(@author) do |builder|
        @author.stub!(:errors).and_return({:login => ['required']})
        node = Capybara.string builder.text_field(:login)
        node.should have_css('small.error', :text => "required")
      end
    end
  end
end