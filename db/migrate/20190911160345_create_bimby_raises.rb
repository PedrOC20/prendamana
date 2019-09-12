class CreateBimbyRaises < ActiveRecord::Migration[5.2]
  def change
    create_table :bimby_raises do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
