defmodule Backend.Resolver.Task do
  alias Backend.Services.{TaskQueries}
  alias Backend.Resolver.Group

  @spec update_task_status(map, map) :: tuple
  def update_task_status(%{task_id: task_id}, _info) do
    with {:ok, task} <-
           TaskQueries.update_task_status(task_id) do
      Group.get_group_details(task.group_id)
    else
      {:error, error} ->
        {:error, error}
    end
  end
end
