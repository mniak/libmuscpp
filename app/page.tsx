'use client';
import { invoke } from "@tauri-apps/api/core";
import { useState } from 'react';

export default function Home() {

  const [name, setName] = useState('');
  const [greetMessage, setGreetMesssage] = useState('');

  return (
    <main className="container">
      <h1>Welcome to Tauri</h1>

      <div className="row">
        <a href="https://tauri.app" target="_blank">
          <img src="/tauri.svg" className="logo tauri" alt="Tauri logo" />
        </a>
        <a
          href="https://developer.mozilla.org/en-US/docs/Web/JavaScript"
          target="_blank"
        >
          <img
            src="/javascript.svg"
            className="logo vanilla"
            alt="JavaScript logo"
          />
        </a>
      </div>
      <p>Click on the Tauri logo to learn more about the framework</p>

      <form className="row" id="greet-form" onSubmit={async e => {
        e.preventDefault();
        const msg = await invoke("greet", { name: name }) as string;
        setGreetMesssage(msg);
      }}>
        <input id="greet-input" placeholder="Enter a name..." onChange={e => {
          setName(e.target.value);
        }} value={name}/>
        <button type="submit">Greet</button>
      </form>
      <p id="greet-msg">{greetMessage}</p>
    </main>
  );
}
