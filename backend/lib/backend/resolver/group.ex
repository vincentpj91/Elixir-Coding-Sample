defmodule Backend.Resolver.Group do
  alias Backend.Services.GroupQueries

  @spec get_all_groups(map, map, map) :: tuple
  def get_group_details(_, %{group_id: group_id}, _) do
    get_group_details(group_id)
  end

  @spec get_group_details(integer) :: tuple
  def get_group_details(group_id) do
    group = GroupQueries.get_group_details(group_id) |> format_group()
    {:ok, group}
  end

  @spec get_all_groups(map, map, map) :: tuple
  def get_all_groups(_, _, _) do
    groups = GroupQueries.get_all_groups() |> Enum.map(fn group -> format_group(group) end)
    {:ok, groups}
  end

  @spec format_group(map) :: map
  defp format_group(%{id: id, name: name, tasks: tasks}) do
    %{id: id, name: name, tasks: Enum.map(tasks, fn task -> format_task(task) end)}
  end

  @spec format_task(map) :: map
  defp format_task(%{
         id: id,
         name: name,
         completed_at: completed_at,
         dependencies: dependencies,
         is_complete: is_complete
       }) do
    %{
      id: id,
      name: name,
      is_complete: is_complete,
      completed_at: completed_at,
      dependencies:
        case dependencies do
          [_ | _] ->
            Enum.map(dependencies, fn task -> format_task(task.dependent_task) end)

          _ ->
            []
        end
    }
  end
end
