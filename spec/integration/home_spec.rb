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
    page.should have_no_selector("form")
  end

  it "should show the search_form if user is logged in" do
    user = User.new
    user.first_name = "Dario"
    user.last_name = "D'Aprile"
    user.email = "dario@gmail.com"
    user.password = "tomtom"
    visit "/signup"
    fill_in "first_name", :with => user.first_name
    fill_in "last_name", :with => user.last_name
    fill_in "email", :with => user.email
    fill_in "password", :with => user.password
    click_button "Sign Up"
    visit '/'
    page.should have_selector("form")
  end

   it "should show the first_name if user is logged in" do
    user = User.new
    user.first_name = "Dario"
    user.last_name = "D'Aprile"
    user.email = "dario@gmail.com"
    user.password = "tomtom"
    visit "/signup"
    fill_in "first_name", :with => user.first_name
    fill_in "last_name", :with => user.last_name
    fill_in "email", :with => user.email
    fill_in "password", :with => user.password
    click_button "Sign Up"
    visit '/'
    page.should have_content("Dario")
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

# class UserTest < Minitest::Case

#   def setup
#     @user = User.new
#   end

#   def test_should_return_a_full_name
#     @user.first_name = 'Dario'
#     @user.last_name = "D'Aprile"
#     assert_equal "Dario D'Aprile", @user.full_name
#   end

# end