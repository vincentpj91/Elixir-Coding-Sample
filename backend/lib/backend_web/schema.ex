defmodule BackendWeb.Schema do
  use Absinthe.Schema
  alias Backend.Resolver.{Group, Task}

  object :task do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:is_complete, non_null(:boolean))
    field(:completed_at, :string)
    field(:dependencies, non_null(list_of(:task)))
  end

  object :group do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:tasks, non_null(list_of(:task)))
  end

  mutation do
    @desc "Update task status"
    field :update_task, type: :group do
      arg(:task_id, non_null(:id))
      resolve(&Task.update_task_status/2)
    end
  end

  query do
    @desc "Get all groups"
    field :all_groups, non_null(list_of(non_null(:group))) do
      resolve(&Group.get_all_groups/3)
    end

    @desc "Get group details"
    field :group_details, non_null(:group) do
      arg(:group_id, non_null(:id))
      resolve(&Group.get_group_details/3)
    end
  end

  # defp all_tasks_resolver(_, _, _) do
  #   bank = %{
  #     id: 1,
  #     group: "Purchases",
  #     task: "Go to the bank",
  #     dependencies: [],
  #     completed_at: nil
  #   }

  #   hammer = %{
  #     id: 2,
  #     group: "Purchases",
  #     task: "Buy hammer",
  #     dependencies: [
  #       bank
  #     ],
  #     completed_at: nil
  #   }

  #   wood = %{
  #     id: 3,
  #     group: "Purchases",
  #     task: "Buy wood",
  #     dependencies: [
  #       bank
  #     ],
  #     completed_at: nil
  #   }

  #   nails = %{
  #     id: 4,
  #     group: "Purchases",
  #     task: "Buy nails",
  #     dependencies: [
  #       bank
  #     ],
  #     completed_at: nil
  #   }

  #   paint = %{
  #     id: 5,
  #     group: "Purchases",
  #     task: "Buy paint",
  #     dependencies: [
  #       bank
  #     ],
  #     completed_at: nil
  #   }

  #   fasten = %{
  #     id: 6,
  #     group: "Build Airplane",
  #     task: "Hammer nails into wood",
  #     dependencies: [
  #       hammer,
  #       wood,
  #       nails
  #     ],
  #     completed_at: nil
  #   }

  #   wings = %{
  #     id: 7,
  #     group: "Build Airplane",
  #     task: "Paint wings",
  #     dependencies: [
  #       paint,
  #       fasten
  #     ],
  #     completed_at: nil
  #   }

  #   snack = %{
  #     id: 8,
  #     group: "Build Airplane",
  #     task: "Have a snack",
  #     dependencies: [],
  #     completed_at: nil
  #   }

  #   result = 

  #   {:ok, [bank, hammer, wood, nails, paint, fasten, wings, snack]}
  #   {:ok, Task |> Repo.all() }
  # end
end
