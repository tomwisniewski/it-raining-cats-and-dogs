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

end

describe 'User' do

  let(:user) { User.new } # like setup in mini::test
  it "should return a full name" do
    user.firstname = 'Dario'
    user.surname = "D'Aprile"
    # user.full_name.should be("Dario D'Aprile")
    expect(user.full_name).to eq("Dario D'Aprile")
  end
end

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