<template>
  <div class="container">
    <p>大学生网约车信息管理系统</p>
    <div class="box">
      <div class="item">
        <span>用户名</span
        ><el-input v-model="username" placeholder="请输入用户名"></el-input>
      </div>
      <div class="item">
        <span>密码&nbsp&nbsp&nbsp</span
        ><el-input
          v-model="password"
          placeholder="请输入密码"
          show-password
          @keyup.enter.native = "Login"
        ></el-input>
      </div>
      <div class="item">
        <el-button type="primary" plain @click="Register">注册</el-button>
        <el-button type="primary" plain @click="Login">登录</el-button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "AppIndex",

  data() {
    return {
      username: "",
      password: "",
    };
  },

  mounted() {
    this.username = this.$route.params.username || this.username;
  },

  methods: {
    msg(message, type) {
      this.$message({
        message,
        type,
        duration: 1500
      });
    },
    async Login() {
      try {
        const { username, password } = this;
        if (username == "" || password == "") {
          let message = username == "" ? "用户名不能为空" : "密码不能为空"
          this.msg(message, "error");
          return;
        }
        await this.$store.dispatch("Login", { username, password });
        this.msg("登录成功", "success");
        this.$router.push("/home");
      } catch (error) {
        this.msg(error, "error");
      }
    },
    Register() {
      this.$router.push({
        name: "Register",
      });
    },
  },
};
</script>

<style lang="less" scoped>
.container {
  animation-duration: 0.8s;
  width: 100%;
  height: 100%;
  position: absolute;
  background: url("~@/assets/cool-background.png") no-repeat;
  background-size: 100% 100%;
  p {
    font-size: 44px;
    position: absolute;
    top: 50px;
    left: 50%;
    transform: translateX(-50%);
  }
  .box {
    width: 400px;
    height: 300px;
    position: absolute;
    left: 50%;
    top: 50%;
    padding: 40px;
    transform: translate(-50%, -50%);
    border-radius: 50px;
    background: linear-gradient(145deg, #eef8ff, #e1f2ff);
    box-shadow: 10px 10px 40px #e9f3ff;
    display: flex;
    flex-direction: column;
    justify-content: center;

    .item {
      display: flex;
      flex-direction: row;
      justify-content: center;
      padding: 10px;
      &:last-child {
        justify-content: center;
        margin-top: 30px;
      }
      .el-input {
        margin-left: 20px;
        width: 60%;
      }
      span {
        line-height: 40px;
        font-size: 16px;
        font-weight: bold;
      }
    }
  }
}
</style>
