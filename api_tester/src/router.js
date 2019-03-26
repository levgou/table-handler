import Vue from 'vue'
import Router from 'vue-router'
import SettingsPage from './components/Settings.vue'
import CommPane from './components/CommPane.vue'
import Home from './components/Home.vue'

Vue.use(Router)


export default new Router({
  routes : [
    { path: '/', component: Home },
    { path: '/settings', component: SettingsPage },
    { path: '/comm', component: CommPane },
  ]
})
