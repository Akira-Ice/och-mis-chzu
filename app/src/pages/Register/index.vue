<template>
  <div class="container">
    <p>大学生网约车信息管理系统</p>
    <div class="box">
      <div class="item">
        <span>姓名&nbsp&nbsp&nbsp</span
        ><el-input v-model="nickname" placeholder="请输入姓名"></el-input>
      </div>
      <div class="item">
        <span>手机号</span
        ><el-input v-model="phone" placeholder="请输入手机号"></el-input>
      </div>
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
          @keyup.enter.native = "compeleteRe"
        ></el-input>
      </div>
      <div class="item">
        <el-button type="primary" plain @click="back">返回</el-button>
        <el-button type="primary" plain @click="compeleteRe"
          >立即注册</el-button
        >
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
      nickname: "",
      phone: ""
    };
  },

  mounted() {},

  methods: {
    msg(message, type) {
      this.$message({
        message,
        type,
        duration: 1500
      });
    },
    back() {
      this.$router.back();
    },
    async compeleteRe() {
      const { username, password, nickname } = this;
      if (username == "" || password == "" || nickname == "") {
        let message = !nickname
          ? "姓名不能为空"
          : !username
          ? "用户名不能为空"
          : "密码不能为空";
        this.msg(message, "error");
        return;
      }
      try {
        await this.$store.dispatch("Register", {
          username,
          password,
          nickname,
        });
        this.msg("注册成功", "success");
        this.$router.push({
          name: "Login",
          params: {
            username,
          },
        });
      } catch (error) {
        this.msg(error, "error");
      }
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
    height: 350px;
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
