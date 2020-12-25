import Vue from 'vue'
import App from './App.vue'

Vue.config.productionTip = false
import router from './router'

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import BootstrapVue from "bootstrap-vue";

Vue.use(BootstrapVue);

import {library} from '@fortawesome/fontawesome-svg-core'
import {faBars, faExternalLinkAlt} from '@fortawesome/free-solid-svg-icons'
import {FontAwesomeIcon} from '@fortawesome/vue-fontawesome'

Vue.config.productionTip = false;
Vue.use(BootstrapVue);

library.add(faBars)
library.add(faExternalLinkAlt)
Vue.component('font-awesome-icon', FontAwesomeIcon)
export const EventBus = new Vue();

new Vue({
    router,
    render: h => h(App),
}).$mount('#app')
