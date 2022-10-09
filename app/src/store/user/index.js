import { reqLogin, reqReguser } from "@/api";
import { setItem, getItem, removeItem } from '@/util/token'

const state = {
  token: getItem("TOKEN"),
  userInfo: JSON.parse(localStorage.getItem("userInfo")) || {},
};

const mutations = {
  SETUSERINFO(state, userInfo) {
    state.userInfo = userInfo;
  },
  SETUSERTOKEN(state, token) {
    state.token = token;
  },
  CLEAR(state) {
    state.token = '';
    state.userInfo = {};
    removeItem();
  }
};

const actions = {
  async Login({ commit }, params) {
    let res = await reqLogin(params)
    if (res.status == 200) {
      commit("SETUSERTOKEN", res.data.token);
      commit("SETUSERINFO", res.data);
      setItem('TOKEN',res.data.token);
      localStorage.setItem("userInfo", JSON.stringify(res.data));
      return 'ok';
    } else {
      return Promise.reject(new Error(res.msg));
    }
  },
  async Register({ commit }, params) {
    let res = await reqReguser(params)
    if (res.status == 200) {
      return 'ok';
    } else {
      return Promise.reject(new Error(res.msg));
    }
  },
  Clear({ commit }){
    commit('CLEAR');
  }
};
const getters = {

};
export default {
  state, mutations, actions, getters
}