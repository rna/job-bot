class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.integer :source_id
      t.string :technology
      t.string :source
      t.string :link

      t.timestamps
    end
  end
end
