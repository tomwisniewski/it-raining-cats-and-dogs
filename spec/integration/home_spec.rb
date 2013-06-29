require File.expand_path('../../spec_helper', __FILE__)

describe 'home page', :type => :feature do

  it 'should show images of cats if clicked on the link "Cats"' do
    visit "/"
    click_link 'cats'
    page.should have_content("Cats")
  end

  it 'should show images of dogs if clicked on the link "Dogs" ' do
    visit "/"
    click_link 'dogs'
    page.should have_content("Dogs")
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

end

describe 'signup', :type => :feature, :js => true do

  it "should not submit if email is not in valid format" do
    user = User.new
    user.email = "tomtomtom"
    visit '/signup'
    fill_in "email", :with => user.email
    click_button "Sign Up"

    page.should have_content("Please enter a valid email")
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

