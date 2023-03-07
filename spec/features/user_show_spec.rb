require 'rails_helper'

RSpec.describe 'UserShow', type: :feature do
  before :each do
    @user_one = User.create(name: 'Selma', photo: 'https://avatars.githubusercontent.com/u/61165443?s=400&u=390894ffec3dbb185885f2366dfaff1309c5b355&v=4',
                            bio: 'Full-Stack Developer from Namibia', posts_counter: 2)

    @user_two = User.create(name: 'Ernest', photo: 'https://avatars.githubusercontent.com/u/92553079?v=4',
                            bio: 'Web Developer from Kenya', posts_counter: 3)

    @first_post = Post.create(author: @user_one, title: 'Hello', text: 'This is my first post', comments_counter: 3,
                              likes_counter: 2)

    @second_post = Post.create(author: @user_one, title: 'Second', text: 'This is my second post', comments_counter: 1,
                               likes_counter: 2)

    @third_post = Post.create(author: @user_one, title: 'Third', text: 'This is my third post', comments_counter: 2,
                              likes_counter: 1)

    @user_posts = @user_one.posts
  end

  describe 'Show page features' do
    before :each do
      visit user_path(@user_one)
    end

    it "should show the user's profile picture" do
      expect(page).to have_css("img[src*='#{@user_one.photo}']")
    end

    it "should show the user's name" do
      expect(page).to have_content(@user_one.name)
    end

    it 'should show the number of posts of each user' do
      expect(page).to have_content("Number of Posts: #{@user_one.posts_counter}")
    end

    it "should show the user's bio" do
      expect(page).to have_content(@user_one.bio)
    end

    it "should show the user's first three posts" do
      @user_one.most_recent_posts.each do |post|
        expect(page).to have_content("Post #{post.title}")
        expect(page).to have_content(post.text)
      end
    end

    it "should show a button to see all user's posts" do
      expect(page).to have_link('See all posts')
    end

    it "should redirect to the user's posts index page when the 'See all posts' button is clicked" do
      click_link('See all posts')
      expect(page).to have_current_path(user_posts_path(@user_one))
    end
  end
end
