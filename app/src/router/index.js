import Vue from "vue";
import VueRouter from 'vue-router';
import routes from './routes';

Vue.use(VueRouter);

let originPush = VueRouter.prototype.push;
let originReplace = VueRouter.prototype.replace;

VueRouter.prototype.push = function (location, resole, reject) {
  if (resole && reject) {
    originPush.call(this, location, resole, reject);
  } else {
    originPush.call(this, location, () => { }, () => { });
  }
}

VueRouter.prototype.replace = function (location, resole, reject) {
  if (resole && reject) {
    originReplace.call(this, location, resole, reject);
  } else {
    originReplace.call(this, location, () => { }, () => { });
  }
}

let router = new VueRouter({
  routes,
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else {
      return { x: 0, y: 0 }
    }
  }
})

export default router;