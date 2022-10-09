<template>
  <el-card shadow="hover" class="container">
    <div class="title">约车大厅</div>
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
      <el-card shadow="hover" class="card" v-for="car in carList" :key="car.cid"
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
          <span
            ><el-tag
              :type="!car.status ? 'success' : 'danger'"
              effect="dark"
              class="tag"
            >
              {{ !car.status ? "空闲" : "已满" }}
            </el-tag></span
          >
          <span>
            <el-button type="primary" @click="acceptCar(car)" :disabled="car.username == userInfo.username"
              >立即拼车</el-button
            ></span
          >
        </div></el-card
      >
    </div>
  </el-card>
</template>

<script>
export default {
  name: "Hall",
  data() {
    return {
      carPoll: [],
      userInfo: {}
    };
  },

  mounted() {
    this.getCarPoll();
    this.userInfo = this.$parent.userInfo;
  },

  methods: {
    msg(message, type) {
      this.$message({
        message,
        type,
        duration: 1500
      });
    },
    async getCarPoll() {
      try {
        await this.$store.dispatch("getCarPoll");
        this.carPoll = this.$store.state.car.carPoll || [];
      } catch (error) {
        this.msg(error.message, "error");
      }
    },
    async acceptCar(car) {
      let id = car.id,
        username = this.$parent.userInfo.username;
      try {
        await this.$store.dispatch("acceptCar", { id, username });
        await this.getCarPoll();
        this.msg("拼车成功", "success");
      } catch (error) {
        this.msg(error.message, "error");
      }
    },
  },
  computed: {
    carList() {
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
      .header {
        span {
          font-size: 18px;
        }
      }
    }
  }
}
</style>
