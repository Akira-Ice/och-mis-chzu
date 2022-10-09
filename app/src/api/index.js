import requests from "./request";
export const reqLogin = (data) => requests({
  url: '/och/tologin',
  method: 'post',
  data
})
export const reqReguser = (data) => requests({
  url: '/och/reguser',
  method: 'post',
  data
})
export const reqCarpool = () => requests({
  url: '/och-carpool/selectListCarpool',
  method: 'get',
})
export const reqAddCar = (data) => requests({
  url: '/och-carpool/saveCarpool',
  method: 'post',
  data
})
export const reqAcceptCar = (id,username) => requests({
  url: `/och-carpool/acceptCarpool?id=${id}&username=${username}`,
  method: 'post',
})
export const reqDelCar = (data) => requests({
  url: `/och-carpool/deleteCarpool?id=${data}`,
  method: 'post',
})
export const reqCarPollByUsername1 = (username) => requests({
  url: `/och-carpool/selectCarpoolByUsername1?username=${username}`,
  method: 'get',
})
export const reqCarPollByUsername2 = (username) => requests({
  url: `/och-carpool/selectCarpoolByUsername2?username=${username}`,
  method: 'get',
})
export const reqGetListNews = () => requests({
  url: `/och-news/selectListNews`,
  method: 'get',
})
export const reqAddNews = (data) => requests({
  url: `/och-news/saveNews`,
  method: 'post',
  data
})
export const reqGetUserList = () => requests({
  url: `/och/selectAllUserList`,
  method: 'get',
})
export const reqUpdateUserById = (data) => requests({
  url: `/och/updateUserById`,
  method: 'post',
  data
})
export const reqDeleteCarpool = (id) => requests({
  url: `/och-carpool/deleteCarpool?id=${id}`,
  method: 'post',
})
export const reqDeleteOrderByUser = (id,username) => requests({
  url: `/och-carpool/deleteOrderByUser?id=${id}&username=${username}`,
  method: 'post',
})
export const reqDeleteComment = (id) => requests({
  url: `/och-discuss/deleteDiscuss?id=${id}`,
  method: 'post',
})
export const reqSaveComment = (data) => requests({
  url: `/och-discuss/saveDiscuss`,
  method: 'post',
  data
})
export const reqGetCommentList = (id) => requests({
  url: `/och-discuss/selectListDiscussByCid?id=${id}`,
  method: 'get',
})
export const reqGetUserListByCid = (id) => requests({
  url: `/och-carpool/selectUserByCid?id=${id}`,
  method: 'get',
})
