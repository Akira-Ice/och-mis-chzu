import axios from "axios";
import nprogress from "nprogress";
import "nprogress/nprogress.css";
import {setItem,getItem,removeItem} from '@/util/token'

const requests = axios.create({
  baseURL: "/",
  timeout: 5000
})

//请求拦截器
requests.interceptors.request.use((config) => {
  let token = getItem('TOKEN');
  if (token) {
    config.headers.token = token;
  }
  nprogress.start()
  return config
})

//响应拦截器
requests.interceptors.response.use((res) => {
  nprogress.done()
  return res.data
}, (error) => {
  console.log(error)
  return Promise.reject(new Error("faild"))
})

export default requests;