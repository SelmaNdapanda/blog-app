require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { Comment.new(posts_id: '1', author_id: '3', text: 'Hi Selma!') }

  before { subject.save }

  it 'author id should be present' do
    subject.author_id = nil
    expect(subject).to_not be_valid
  end

  it 'post id should be present' do
    subject.posts_id = nil
    expect(subject).to_not be_valid
  end

  it 'text should be a string ' do
    subject.text = 123
    expect(subject).to_not be_valid
  end

  it 'text should be present' do
    subject.text = nil
    expect(subject).to_not be_valid
  end
end
