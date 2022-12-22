import React from 'react';
import Groups from './components/groups'
import GroupDetails from './components/group_details'




const App = () => {
  let currentGroup = window.location.href.split("/").pop();
  let renderData;
  if(currentGroup == "") {
    renderData = <Groups/>
  } else {
    renderData = <GroupDetails/>

  }
  
  return (
    <React.Fragment>
      {renderData}
    </React.Fragment>
  )
}

export default App
