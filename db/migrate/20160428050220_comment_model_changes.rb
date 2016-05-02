class CommentModelChanges < ActiveRecord::Migration
  def change
  	drop_table :comments
  	  create_table :comments do |t|
      t.string :content
      t.references :commentable, polymorphic: true, index: true
      t.belongs_to :user, index: true
      t.timestamps null: false
  end
  end
end
