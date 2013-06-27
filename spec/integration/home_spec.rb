require File.expand_path('../../spec_helper', __FILE__)

describe 'home page', :type => :feature do
  
  it 'should show images of cats if clicked on the link "Cats"' do
    visit "/"
    click_link 'cats'
    page.should have_content("Cats")
  end

end