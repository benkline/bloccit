class CreateCommenters < ActiveRecord::Migration
  def change
    create_table :commenters do |t|
      t.references :comment, index: true
      t.references :commentable, polymorphic: true, index: true
      t.timestamps null: false
    end
    add_foreign_key :commenters, :comments
  end
end
