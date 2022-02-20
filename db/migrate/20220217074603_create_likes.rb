class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    unless table_exists? :likes
      create_table :likes do |t|

        t.timestamps
      end
    end
  end
end
