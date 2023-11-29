class CreateStashes < ActiveRecord::Migration[7.1]
  def change
    create_table :stashes do |t|
      t.string :uuid, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
