alias Backend.Schema.{Group, Task, TaskDependentTask}
alias Backend.Repo

Repo.insert_all(Group, [%{name: "Group1"}, %{name: "Group2"}])
Repo.insert_all(Task, [%{name: "Task1", group_id: 1}, %{name: "Task2", group_id: 1}, %{name: "Task3", group_id: 1}, %{name: "Task4", group_id: 2}, %{name: "Task5", group_id: 2}, %{name: "Task6", group_id: 2}, %{name: "Task7", group_id: 2}])
Repo.insert_all(TaskDependentTask, [%{task_id: 1, dependent_task_id: 2}, %{task_id: 3, dependent_task_id: 1}, %{task_id: 4, dependent_task_id: 5}, %{task_id: 6, dependent_task_id: 7}, %{task_id: 6, dependent_task_id: 5}])


# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Backend.Repo.insert!(%Backend.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
