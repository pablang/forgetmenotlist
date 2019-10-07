require 'rails_helper'

RSpec.describe 'api/items/_item', type: :view do
  let(:item) { FactoryBot.create :item }

  it 'renders item with text' do
    render partial: 'api/items/item', locals: { item: item }
    expect(rendered).to have_content(item.text)
  end

  it 'renders item with link to delete it' do
    render partial: 'api/items/item', locals: { item: item }
    expect(rendered).to have_link('Delete', exact: true, href: api_item_path(item))
  end

  it 'renders item with checkbox to check it - unchecked by default' do
    render partial: 'api/items/item', locals: { item: item }
    expect(rendered).to have_field('item_checked', checked: false)
  end

  it 'renders item with checkbox to check it - checked if item.checked?' do
    item = FactoryBot.create :item, checked: true
    render partial: 'api/items/item', locals: { item: item }
    expect(rendered).to have_field('item_checked', checked: true)
  end
end
