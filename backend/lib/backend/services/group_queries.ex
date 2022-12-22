defmodule Backend.Services.GroupQueries do
  import Ecto.Query
  alias Backend.Repo
  alias Backend.Schema.Group

  def get_all_groups() do
    from(group in Group,
      order_by: group.name,
      preload: [tasks: [dependencies: [:dependent_task]]]
    )
    |> Repo.all()
  end

  def get_group_details(group_id) do
    Repo.get(Group, group_id)
    |> Repo.preload(tasks: [dependencies: [:dependent_task]])
  end
end
