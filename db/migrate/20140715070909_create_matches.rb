class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.datetime :started_at
      t.references :team, index: true

      t.timestamps
    end
  end
end
