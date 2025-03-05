'use client';
import { invoke } from "@tauri-apps/api/core";
import { useState } from 'react';

export default function Home() {

  const [name, setName] = useState('');
  const [greetMessage, setGreetMesssage] = useState('');

  return (
    <div className="">
      <form className="row" id="greet-form" onSubmit={async e => {
        e.preventDefault();
        const msg = await invoke("greet", { name: name }) as string;
        setGreetMesssage(msg);
      }}>
        <input id="greet-input" placeholder="Enter a name..." onChange={e => {
          setName(e.target.value);
        }} />
        <button type="submit">Greet</button>
      </form>
      <p id="greet-msg">{greetMessage}</p>
    </div>
  );
}
