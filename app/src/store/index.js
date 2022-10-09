import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

import user from "./user";
import car from "./car";

export default new Vuex.Store({
  modules: {
    user,car
  }
})