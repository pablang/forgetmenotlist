require 'rails_helper'

RSpec.describe 'home/index.html.erb', type: :view do
  it 'has basic layout: header' do
    render
    expect(rendered).to have_content('FORGET ME NOT')
  end

  it 'has basic layout: form - text field, and submit button' do
    render
    expect(rendered).to have_field('text')
    expect(rendered).to have_button('Add')
  end
end
