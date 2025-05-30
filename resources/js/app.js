import './bootstrap';
import '../css/app.css';
import 'v-calendar/style.css';

import { createApp, h } from 'vue';
import { createInertiaApp } from '@inertiajs/vue3';
import { resolvePageComponent } from 'laravel-vite-plugin/inertia-helpers';
import { ZiggyVue } from '../../vendor/tightenco/ziggy';
import PrimeVue from 'primevue/config';
import Lara from '@primevue/themes/lara';
import Tooltip from 'primevue/tooltip';
import VCalendar from 'v-calendar';

const appName = import.meta.env.VITE_APP_NAME || 'Laravel';

createInertiaApp({
    title: (title) => `${title} - ${appName}`,
    // title: (title) => `${appName}`,
    resolve: (name) => resolvePageComponent(`./Pages/${name}.vue`, import.meta.glob('./Pages/**/*.vue')),
    setup({ el, App, props, plugin }) {
        return createApp({ render: () => h(App, props) })
            .use(plugin)
            .use(ZiggyVue)
            .use(PrimeVue, { theme: {
                preset: Lara,
                options: {
                    darkModeSelector: 'false',
                }
            } })
            .directive('tooltip', Tooltip)
            .use(VCalendar, {})
            .mount(el);
    },
    progress: {
        color: '#4B5563',
    },
});
