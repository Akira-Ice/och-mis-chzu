const Login = () => import('@/pages/Login')
const Register = () => import('@/pages/Register')
const Home = () => import('@/pages/Home')
const News = () => import('@/pages/News')
const Hall = () => import('@/pages/Hall')
const Personal = () => import('@/pages/Personal')
const Manage = () => import('@/pages/Manage')
const Comment = () => import('@/pages/Comment')
const NewsAdd = () => import('@/pages/NewsAdd')

export default [
  {
    path: '/login',
    name: 'Login',
    component: Login
  }, {
    path: '/register',
    name: 'Register',
    component: Register
  }, {
    path: '/home',
    name: 'Home',
    component: Home,
    children: [{
      path: '/news',
      name: 'News',
      component: News
    }, {
      path: '/hall',
      name: 'Hall',
      component: Hall
    }, {
      path: '/personal',
      name: 'Personal',
      component: Personal
    }, {
      path: '/manage',
      name: 'Manage',
      component: Manage
    }, {
      path: '/comment',
      name: 'Comment',
      component: Comment
    }, {
      path: '/newsadd',
      name: 'NewsAdd',
      component: NewsAdd
    }]
  }
  , {
    path: '*',
    redirect: "/login",
  }
]