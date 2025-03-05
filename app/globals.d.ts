import type TauriAPI from '@tauri-apps/api';
declare global {
    interface Window {
        __TAURI__: TauriAPI;
    }
}
export default global;