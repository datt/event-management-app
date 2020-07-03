class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :starttime
      t.datetime :endtime
      t.text :description
      t.boolean :allday, default: false
      t.belongs_to :creator, references: :users, index: true

      t.timestamps
    end
  end
end
