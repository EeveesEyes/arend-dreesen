import Vue from 'vue'
import Router from 'vue-router'
import Home from "@/components/Home";
import Imprint from "@/components/Imprint";
import Poem from "@/components/content/poem";

Vue.use(Router);

export default new Router({
    mode: 'history',
    base: process.env.BASE_URL,
    routes: [
        {
            path: '/',
            name: 'app',
            redirect: {name: 'home'}
        },
        {
            path: '/home',
            name: 'home',
            component: Home
        },
        {
            path: '/imprint',
            name: 'imprint',
            component: Imprint
        },
        {
            path: '/poem/:title',
            name: 'poem',
            component: Poem
        }
    ]
})