import group from '../public/group.svg'
import { gql, useQuery} from '@apollo/client'

const query = gql`
query {
    allGroups {
      id
      name
      tasks {
        id
        name
        isComplete
        completedAt
      }
    }
}
`

export default function Groups(props) {
    const {data} = useQuery(query)
    const allGroups = (data && data.allGroups) ? data.allGroups : [];
    const groups = allGroups.map((groupData, index) => {
        const completedTasks = groupData.tasks.filter((task) => {
            return task.isComplete;
        }).length;
        return <div>
            <hr/>
            <h3
            onClick={() => { window.location = groupData.id}} 
            key={index}>
            <img src={group} className="Group-logo" alt="logo" />
            {groupData.name}
            </h3>
            <span>{completedTasks} of {groupData.tasks.length} tasks complete</span>
            <hr/>
        </div> 
        
    });
    return <>
    <h2>Things to Do</h2>
    {groups}
    </>
}
