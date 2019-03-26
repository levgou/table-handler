import Vue from "vue";
import Vuex from "vuex";

import "./plugins/vuetify";
import App from "./App.vue";
import router from "./router";
import Vuetify from "vuetify";
import VuexPersist from "vuex-persist";

import "vuetify/dist/vuetify.min.css"; // Ensure you are using css-loader

import VueLocalStorage from "vue-localstorage";

import { dummyMessages } from "@/data_store.json";
import { dummyMessageContents } from "@/data_store.json";

Vue.config.productionTip = false;

Vue.use(Vuex);
Vue.use(Vuetify);
Vue.use(VueLocalStorage);

const vuexPersist = new VuexPersist({
  key: "api-tester",
  storage: localStorage,
  reducer: state => ({
    socketMessages: state.socketMessages,
    socketMessageContents: state.socketMessageContents
  })
});

const store = new Vuex.Store({
  strict: true,
  state: {
    socketMessages: null,
    socketMessageContents: null,
    isSocketConnected: false,
    socketMsgsQueue: []
  },
  mutations: {
    setMessages(state, messages) {
      state.socketMessages = messages;
    },
    setMessageContetns(state, contents) {
      state.socketMessageContents = contents;
    },
    setSockConnectionStatus(state, status) {
      state.isSocketConnected = status;
    },
    appendMsgQueue(state, newMsg) {
      state.socketMsgsQueue.push(newMsg);
    },
    clearMsgQueue(state) {
      state.socketMsgsQueue = [];
    }
  },
  plugins: [vuexPersist.plugin]
});

function loadCorrectDataTypes() {
  return;
}

function loadDummyValues() {
  console.log("No data in local storage - loading dummy values");
  let _dummyMessages = dummyMessages;
  let _dummyMessageContents = dummyMessageContents;

  store.commit("setMessages", _dummyMessages);
  store.commit("setMessageContetns", _dummyMessageContents);
}

if (!store.state.socketMessages) {
  loadDummyValues();
} else {
  loadCorrectDataTypes();
}

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount("#app");
