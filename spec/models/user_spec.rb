require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', photo: 'https://unsplash.com/photos', bio: 'Teacher from Mexico.') }
  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'bio should be present' do
    subject.bio = nil
    expect(subject).to_not be_valid
  end

  it 'photo should be present' do
    subject.photo = nil
    expect(subject).to_not be_valid
  end

  it 'name should not be short' do
    subject.name = 'k'
    expect(subject).to_not be_valid
  end

  it 'bio should not be short' do
    subject.bio = 'k'
    expect(subject).to_not be_valid
  end

  it 'post counter should be integer' do
    subject.post_counter = 'number'
    expect(subject).to_not be_valid
  end

  it 'post counter should be greater than zero' do
    subject.post_counter = '-1'
    expect(subject).to_not be_valid
  end

  it 'post counter should be equal to zero' do
    subject.post_counter = 0
    expect(subject).to be_valid
  end

  it 'post counter should be greather than zero' do
    subject.post_counter = 2
    expect(subject).to be_valid
  end

  describe 'Should test recent post method' do
    before do
      4.times do |post_number|
        Post.create(author_id: subject.id, title: "this is the post #{post_number}")
      end
    end

    it 'User should have three recent posts' do
      expect(subject.recent_posts).to eq(subject.posts.last(3))
    end
  end
end
