class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :authorId
      t.integer :postId
      t.string :text

      t.timestamps
    end
  end
end
