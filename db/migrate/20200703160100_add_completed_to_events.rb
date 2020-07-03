class AddCompletedToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :completed, :boolean, default: false, index: true
  end
end
