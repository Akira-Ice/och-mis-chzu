<template>
  <el-card shadow="hover" class="container">
    <div class="title">个人中心</div>
    <div class="new">
      <h1>发布拼车</h1>
      <div class="cards">
        <el-card shadow="hover" class="card"
          ><div class="newForm">
            <el-date-picker
              v-model="newCar.ctime"
              type="datetime"
              placeholder="选择日期时间"
              value-format="yyyy-MM-dd HH:mm:ss"
              style="width: 650px"
            >
            </el-date-picker>
            <el-input
              v-model="newCar.place"
              placeholder="请输入行程：乐彩城-苏宁广场"
            ></el-input>
            <el-input
              v-model="newCar.total"
              placeholder="请输入拼车人数"
            ></el-input>
            <el-button type="primary" @click="addCar">发布拼车</el-button>
          </div>
        </el-card>
      </div>
    </div>
    <div class="now">
      <h1>正在进行</h1>
      <div class="cards">
        <el-card shadow="never" class="card">
          <div class="content header">
            <span>发起时间</span>
            <span>出发地</span>
            <span>目的地</span>
            <span>拼车状态</span>
            <span>操作</span>
          </div>
        </el-card>
        <el-card
          shadow="hover"
          class="card"
          v-for="(car, index) in carPolling"
          :key="car.cid"
        >
          <div class="content">
            <span>{{ car.ctime }}</span>
            <span
              ><i class="el-icon-location posF"></i
              >{{ car.place.split("-")[0] }}</span
            >
            <span
              ><i class="el-icon-location posT"></i
              >{{ car.place.split("-")[1] }}</span
            >
            <span @click="getUserListByCid(car)"
              ><el-tag
                :type="!car.status ? 'success' : 'danger'"
                effect="dark"
                class="tag"
              >
                {{ !car.status ? "空闲" : "已满" }}
              </el-tag></span
            >
            <span>
              <el-button type="warning" @click="delCar(car)"
                >取消拼车</el-button
              ></span
            >
          </div>
        </el-card>
      </div>
    </div>
    <div class="pass">
      <h1>拼车历史</h1>
      <div class="cards">
        <el-card
          shadow="hover"
          class="card"
          v-for="car in carPolled"
          :key="car.cid"
          ><div class="content">
            <span>{{ car.ctime }}</span>
            <span
              ><i class="el-icon-location posF"></i
              >{{ car.place.split("-")[0] }}</span
            >
            <span
              ><i class="el-icon-location posT"></i
              >{{ car.place.split("-")[1] }}</span
            >

            <span> <el-tag type="success">拼车成功</el-tag></span>
            <span>
              <el-button type="primary" plain @click="toComment(car)"
                >评论</el-button
              ></span
            >
          </div></el-card
        >
      </div>
    </div>
  </el-card>
</template>

<script>
import {
  reqDeleteCarpool,
  reqDeleteOrderByUser,
  reqGetUserListByCid,
} from "@/api";
export default {
  name: "Personal",

  data() {
    return {
      carPoll: [],
      username: "",
      newCar: {
        ctime: "",
        place: "",
        total: undefined,
        username: "",
        status: 0,
      },
      userList: [],
    };
  },

  mounted() {
    this.username =
      this.$parent.userInfo.username ||
      this.$store.state.user.userInfo.username;
    this.getCarPoll();
    this.carPoll.sort((a, b) => {
      return a.status - b.status;
    });
  },

  methods: {
    msg(message, type) {
      this.$message({
        message,
        type,
        duration: 1500,
      });
    },
    async getUserListByCid(car) {
      let res = await reqGetUserListByCid(car.id);
      let str = "",
        k = 1;
      str = `<strong>发起人：${car.username}</strong><br>`;
      if (res.status == 200) {
        console.log(res.data);
        for (let user of res.data) {
          str += `<strong>参与人${k++}：${
            user.nickname
          }</strong>  <strong>手机号：${user.phone}</strong><br>`;
        }
      }

      this.$alert(str, "拼车列表", {
        dangerouslyUseHTMLString: true,
        closeOnClickModal: true,
      });
    },
    toComment(car) {
      localStorage.setItem("car", JSON.stringify(car));
      this.$router.push({
        name: "Comment",
        params: { car },
      });
    },
    async getCarPoll() {
      try {
        await this.$store.dispatch("getCarPoll", this.username);
        this.carPoll = this.$store.state.car.carPoll || [];
      } catch (error) {
        this.msg(error.message, "error");
      }
    },
    async addCar() {
      this.newCar.username = this.username;
      let newCar = this.newCar;
      if (newCar.ctime == "" || newCar.place == "" || newCar.total == "") {
        let message =
          newCar.ctime == ""
            ? "日期不能为空"
            : newCar.place == ""
            ? "位置信息不能为空"
            : "总人数不能为空";
        this.msg(message, "error");
        return;
      }
      // dispath 'addCar'
      try {
        await this.$store.dispatch("addCar", this.newCar);
        this.newCar = {};
        this.getCarPoll();
        this.msg("添加成功", "success");
      } catch (error) {
        this.msg(error.message, "error");
      }
    },
    async delCar(car) {
      let res;
      console.log(car, this.username);
      if (car.username != this.username) {
        console.log(1);
        res = await reqDeleteOrderByUser(car.id, this.username);
      } else {
        console.log(2);
        res = await reqDeleteCarpool(car.id);
      }
      console.log(res);
      if (res.status == 200 && res.data == true) {
        this.msg("取消成功", "success");
        this.getCarPoll();
      } else {
        this.msg("取消失败", "error");
      }
    },
  },
  computed: {
    carPolled() {
      return this.carPoll.filter((item) => item.status == 1);
    },
    carPolling() {
      return this.carPoll.filter((item) => item.status == 0);
    },
  },
};
</script>

<style lang="less" scoped>
.flex {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
}
.container {
  height: fit-content;
  .title {
    font-size: 40px;
    font-weight: 300;
    text-align: center;
    padding: 20px;
  }
  h1 {
    width: fit-content;
    padding-left: 10px;
    border-style: solid;
    border-left-width: 5px;
    border-color: #46affb;
    border-top: none;
    border-right: none;
    border-bottom: none;
  }
  .pass,
  .now,
  .new {
    margin-bottom: 30px;
    .cards {
      margin-top: 10px;
      .card {
        margin-bottom: 10px;
        padding: 10px 0px;
        .content {
          .flex();
          span {
            flex: 1;
            flex-grow: 1;
            font-size: 18px;
            text-align: center;
          }
          .posF {
            color: rgb(112, 233, 132);
          }
          .posT {
            color: rgb(255, 178, 91);
          }
        }
        .newForm {
          .flex();
        }
      }
      .newForm {
        display: flex;
        flex-direction: row;
      }
    }
  }
}
</style>
