require 'rails_helper'

feature "parking", :type => :feature do

  scenario "guest parking" do
    # Step 1
    visit "/"
    # save_and_open_page

    expect(page).to have_content("一般費率")

    # Step 2
    click_button "開始計費"

    # Step 3:
    click_button "結束計費"

    # Step 4: 看到費用畫面
    expect(page).to have_content("¥2.00")
  end

end