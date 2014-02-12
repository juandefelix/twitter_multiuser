class CreateTweetTable < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :status
      t.integer :user_id
    end
  end
end
