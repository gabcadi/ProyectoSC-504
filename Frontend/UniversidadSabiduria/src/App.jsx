import Header from './components/Header'
import { useState, useEffect } from 'react'
import axios from 'axios'

function App() {
  const [data, setData] = useState([])

  useEffect(() => {
    axios('http://localhost:5000/getAllEstudiantes').then(response=>{
      if(response.status === 200) {
        console.log(response.data);
        setData(response.data)
      }
    })
    .catch(err=>{

    })
  }, [])

  return (
    <>
      <p>Bienvenido a la Universidad de la Sabiduría</p>
      {
        data.length > 0 && data.map((item, index) =>
          <>
          <div key={index}>{item}</div> <br />
          </>
        )
      }
    </>
  )
}

export default App
