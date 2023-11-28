class CreateStashes < ActiveRecord::Migration[7.1]
  def change
    create_table :stashes do |t|
      t.timestamps
    end
  end
end
