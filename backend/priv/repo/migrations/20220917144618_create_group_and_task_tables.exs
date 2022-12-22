defmodule Backend.Repo.Migrations.CreateGroupAndTaskTables do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:groups) do
      add(:name, :string)
    end

    create_if_not_exists table(:tasks) do
      add(:name, :string)

      add(
        :group_id,
        references(:groups, column: :id, type: :integer, on_delete: :delete_all)
      )

      add(:is_complete, :boolean, default: false)

      add(:completed_at, :utc_datetime, null: true)
    end

    create_if_not_exists table(:task_dependent_tasks) do
      add(:task_id, references(:tasks, column: :id, type: :integer, on_delete: :delete_all))

      add(
        :dependent_task_id,
        references(:tasks, column: :id, type: :integer, on_delete: :delete_all)
      )

    end
  end

  def down do
    drop(table(:task_dependent_tasks))
    drop(table(:tasks))
    drop(table(:groups))
  end
end
