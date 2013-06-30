require File.expand_path('../../spec_helper', __FILE__)

describe 'home page', :type => :feature do

  it 'should show images of cats if clicked on the link "Cats"' do
    visit "/"
    click_link 'cats'
    page.should have_content("cats")
  end

  it 'should show images of dogs if clicked on the link "Dogs" ' do
    visit "/"
    click_link 'dogs'
    page.should have_content("dogs")
  end

  it "should not show the search_form if user isn't registered " do
    visit "/"
    page.should have_no_css('.search_form')
  end

  it "should show the search_form if user is logged in" do
    signup_user
    page.should have_css('.search_form')
  end

  it "should show the first_name if user is logged in" do
    signup_user
    page.should have_content("Dario")
  end

  it "should log the user in if they provide correct details" do
    signup_user
    click_link "Log Out"
    click_link 'Login'
    fill_in "email", :with => "dario@gmail.com"
    fill_in "password", :with => "tomtom"
    click_button "Login"
    page.should have_content("Dario")
  end

  it "should not log the user in if they provide incorrect details" do
    signup_user
    click_link "Log Out"
    click_link 'Login'
    fill_in "email", :with => "dario@gmail.com"
    fill_in "password", :with => "omtom"
    click_button "Login"
    page.should have_content("You're email and/or password is wrong.")
  end

  it "should log out the user" do
    signup_user
    click_link "Log Out"
    page.should have_no_content("Dario")
  end

end

describe 'signup', :type => :feature, :js => true do

  it "should not submit if the email is not in valid format" do
    user = User.new
    user.email = "tomtomtom"
    visit '/signup'
    fill_in "email", :with => user.email
    click_button "Sign Up"
    page.should have_content("Please enter a valid email")
  end

  it "should not submit if the password is too short" do
    user = User.new
    user.password = "tomt"
    visit '/signup'
    fill_in "email", :with => user.password
    click_button "Sign Up"
    page.should have_content("Your password must be a minimum of six character long")
  end

end

# describe 'User' do

#   let(:user) { User.new } # like setup in mini::test
#   it "should return a full name" do
#     user.firstname = 'Dario'
#     user.surname = "D'Aprile"
#     # user.full_name.should be("Dario D'Aprile")
#     expect(user.full_name).to eq("Dario D'Aprile")
#   end
# end

