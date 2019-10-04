require 'rails_helper'

RSpec.describe Item, type: :model do
  it 'is not valid if it does not have parameters' do
    item = Item.new
    expect(item).to_not be_valid
  end

  it 'is not valid if it does not have text' do
    item = Item.new(text: nil)
    expect(item).to_not be_valid
  end

  it 'is valid when there is text' do
    item = Item.new(text: 'something in text field')
    expect(item).to be_valid
  end

  it 'is valid when item has text and is checked' do
    item = Item.new(text: 'something in text field', checked: true)
    expect(item).to be_valid
  end

  it 'updates the checked value when item is checked' do
    item = Item.new(text: 'something in text field')
    expect(item.checked?).to be false
    item.checked = true
    expect(item.checked?).to be true
  end
end
