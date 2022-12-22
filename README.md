
## Coding Challenge

The coding challenge revolves around building a task list. Tasks belong to groups and can have
dependencies on one another (i.e. if task X depends on task Y, task X cannot be completed until
task Y is completed). The challenge includes 3 components:

* Build React-based UI
* Design database schemas to store todo's using Ecto
* Implement GraphQL resolver logic in elixir

### Build React-based UI

The UI consists of 2 screens:

* **Overview**: Displays a list of all the groups along with their completion status. Clicking on 
  a group should render the detail screen.

* **Detail**: Displays a list of all the tasks in the selected group and allows the user to toggle 
  the completion status of unlocked tasks.

Some things to keep in mind:

* Locked tasks cannot have their completion status toggled
* Tasks remain locked until all of their dependencies have been completed
* Marking a task as incomplete should lock the corresponding tasks for which it is a dependency

### Implement schema modules and context

Implement the corresponding schema modules for each new table designed in the previous step (structs or emedded schemas are permittable, as well, depending on your database implementation). Typespecs with Dialyzer are definitely favored.

Write a context that manage's your todo's and interacts with the repo. Please be wary of naming and director structure conventions.

### Implement GraphQL schemas & resolver

Build a schema using Absinthe's schema notation to dictate object and input object structures. Please include queries and mutations for managing todo's from you UI.

The backend implementation has a stub implementation for the all todo's resolver. Replace this stub with an actual resolver that calls to the context that you implemented in the previous step.

## Getting Started

### Backend
Depending on your environment you might have to fist have to install all dependencies to run the elixir backend. Please see the [phoenix getting started documentation](https://hexdocs.pm/phoenix/installation.html) for more details.
Once you have all needed dependencies installed start the server by standing in the _/backend_ folder and run:

```
mix phx.server
```

### Frontend
To get started, clone this repo to your local machine. Next you'll want to install the dependencies
and fire up the app:

```
yarn install
yarn start
```

At this point, the app should be running in development mode and any local modifications you make
will be automatically detected and result in the app to reload.

