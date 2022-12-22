defmodule Backend.Services.TaskQueries do
  alias Backend.Repo
  alias Backend.Schema.Task

  def get_task_by_id(task_id) do
    Repo.get(Task, task_id)
  end

  def update_task_status(task_id) do
    task = get_task_by_id(task_id)

    task
    |> Task.update_changeset(%{
      is_complete: not task.is_complete,
      completed_at: DateTime.utc_now()
    })
    |> Repo.update()
  end
end
