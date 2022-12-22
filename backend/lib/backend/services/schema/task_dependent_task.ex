defmodule Backend.Schema.TaskDependentTask do
  use Ecto.Schema

  alias Backend.Schema.Task

  schema "task_dependent_tasks" do
    field(:task_id, :integer)
    # field(:dependent_task_id, :integer)

    belongs_to(:dependent_task, Task,
      foreign_key: :dependent_task_id,
      references: :id
    )
  end
end
