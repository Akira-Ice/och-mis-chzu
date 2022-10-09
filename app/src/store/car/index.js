import { reqCarpool, reqAddCar, reqAcceptCar, reqDelCar, reqCarPollByUsername1, reqCarPollByUsername2 } from '@/api'

const state = {
  carPoll: []
};

const mutations = {
  SETCARPOLL(state, carPool) {
    state.carPoll = carPool;
  }
};

const actions = {
  async getCarPoll({ commit }, params) {
    let res,res2;
    if (params) {
      res = await reqCarPollByUsername1(params);
      res2 = await reqCarPollByUsername2(params);
      res.data.push(...res2.data);
      console.log(res)
    } else {
      res = await reqCarpool();
    }
    if (res.status == 200) {
      commit('SETCARPOLL', res.data);
      return 'ok';
    } else {
      return Promise.reject(new Error(res.msg));
    }
  },
  async addCar({ commit }, params) {
    let res = await reqAddCar(params);
    if (res.status == 200) {
      return 'ok';
    } else {
      return Promise.reject(new Error(res.msg));
    }
  },
  async acceptCar({ commit }, params) {
    let res = await reqAcceptCar(params.id, params.username);
    if (res.status === 200 && res.data === true) {
      return 'ok';
    } else {
      return Promise.reject(new Error("您已经拼过该订单！"));
    }
  },
  async DelCar({ commit }, params) {
    let res = await reqDelCar(params);
    if (res.status == 200) {
      return 'ok';
    } else {
      return Promise.reject(new Error(res.msg));
    }
  },
};
const getters = {

};
export default {
  state, mutations, actions, getters
}