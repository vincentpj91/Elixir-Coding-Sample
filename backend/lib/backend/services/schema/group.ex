defmodule Backend.Schema.Group do
  use Ecto.Schema

  alias Backend.Schema.Task

  schema "groups" do
    field(:name, :string)

    has_many(:tasks, Task,
      foreign_key: :group_id,
      references: :id
    )
  end
end
