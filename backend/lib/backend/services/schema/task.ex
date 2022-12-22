defmodule Backend.Schema.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Backend.Schema.Task

  alias Backend.Schema.{Group, TaskDependentTask}

  schema "tasks" do
    field(:name, :string)
    field(:is_complete, :boolean)
    field(:completed_at, :utc_datetime)

    belongs_to(:group, Group,
      foreign_key: :group_id,
      references: :id
    )

    has_many(:dependencies, TaskDependentTask,
      foreign_key: :task_id,
      references: :id
    )
  end

  def update_changeset(%Task{} = task, attrs) do 
  task 
    |> cast(attrs, [
      :is_complete,
      :completed_at
    ])
    |> validate_required([:is_complete])
  end
end
