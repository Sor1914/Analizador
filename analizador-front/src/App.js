import React, { useState } from 'react';
import './App.css';

function App() {
  const [texto, setTexto] = useState('');
  const [resultado, setResultado] = useState('');

  const analizar = async () => {
    const res = await fetch('http://localhost:8081/api/analizador', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ body: texto })
    });

    const data = await res.text(); // porque el backend devuelve texto plano
    setResultado(data);
  };

  return (
    <div className="container">
      <h1>Analizador Léxico y Sintáctico</h1>
      <textarea
        value={texto}
        onChange={(e) => setTexto(e.target.value)}
        placeholder="Escribe tu código aquí..."
      ></textarea>
      <button onClick={analizar}>Analizar</button>
  
      <h3>Resultado:</h3>
      <pre>{resultado}</pre>
    </div>
  );
  
}

export default App;
