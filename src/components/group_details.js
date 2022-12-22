import { gql, useMutation, useQuery, useLazyQuery } from '@apollo/client';
import { useState } from 'react';
import locked from '../public/locked.svg'

const UPDATE_TASK = gql`
  mutation UpdateTask($taskId: Integer!) {
    updateTask(taskId: $taskId) {
      id
      name
      tasks {
        id
        name
        isComplete
        completedAt
        dependencies{
          id
          isComplete
        }
      }
    }
  }
`;

const GET_TASK_DETAILS = gql`
query GroupDetails($groupId: Integer!) {
  groupDetails(groupId: $groupId) {
    id
    name
    tasks {
      id
      name
      isComplete
      completedAt
      dependencies{
        id
        isComplete
      }
    }
  }
}
`;

export default function GroupDetails(props) {
    let currentGroup = window.location.href.split("/").pop();
    const {data} = useQuery(GET_TASK_DETAILS, {variables: {groupId: currentGroup}})
    const [updateTaskStatus, { data: updateTask, loading, error }] = useMutation(UPDATE_TASK);
    if(updateTask) {
      console.log(updateTask);
    }
    
    const handleUpdateTask = (taskId) => {
          updateTaskStatus({variables: {taskId: taskId}});
    }
    let renderTasks;
    if(data) {
      renderTasks = <Task tasks={data.groupDetails.tasks} handleUpdateTask={handleUpdateTask}/>
    } else {
      
    }
    return <div>
     <h1>
      {data && data.groupDetails.name}
    </h1>
    <ul>{renderTasks}</ul>
      
</div> 

}

const Task = (props) => {
  const  tasks = props.tasks.map((task, index) => {
  let renderTask;
    renderTask = isTaskLocked(task)?<Unlockedtask task={task} key={index} handleUpdateTask={props.handleUpdateTask}/> : <LockedTask taskName={task.name}/>;    
    return renderTask;
});

return tasks;
  
}

const LockedTask = (props) => {
  return <li><img src={locked} className="Locked-Task" alt="logo" /><label>{props.taskName}</label></li>
}

const Unlockedtask = (props) => {

  return <li key={props.task.id}>
      <input 
        type="checkbox" 
        checked={props.task.isComplete} 
        onClick={()=> {props.handleUpdateTask(props.task.id)}}
        />
        <label>{props.task.name}</label>
  </li>
}

function isTaskLocked(task) {
  const completedTasks = task.dependencies.filter((dependency) => {
    return dependency.isComplete;
  }).length

  return completedTasks === task.dependencies.length
}