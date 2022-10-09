module.exports = {
  //关闭eslint
  lintOnSave: false,
  devServer: {
    proxy: {
      '/': {
        target: 'http://localhost:8090',
        changeOrigin:true,
        pathRewrite: {
          '^/api': ''
        }
      }
    },
  }
}