class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :completion_id
      t.integer :choice_id
    end
  end
end
