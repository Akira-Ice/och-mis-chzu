<template>
  <el-card shadow="hover" class="container">
    <div class="title">管理中心</div>
    <el-collapse v-model="activeName" accordion>
      <el-collapse-item class="carL" name="1">
        <template slot="title">
          <h1>拼车列表</h1>
        </template>
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
            v-for="car in carPoll"
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
              <span
                ><el-tag
                  :type="!car.status ? 'warning' : 'success'"
                  class="tag"
                >
                  {{ !car.status ? "正在拼车" : "拼车成功" }}
                </el-tag></span
              >
              <span>
                <el-button :disabled="car.status == 0" @click="toComment(car)"
                  >查看评论</el-button
                >
                <el-button type="danger" @click="del(car)">删除</el-button>
              </span>
            </div></el-card
          >
        </div>
      </el-collapse-item>
      <el-collapse-item class="userL" name="2">
        <template slot="title">
          <h1>用户列表</h1>
        </template>
        <div class="cards">
          <el-card shadow="never" class="card">
            <div class="content header">
              <span>用户名</span>
              <span>姓名</span>
              <span>角色</span>
              <span>激活状态</span>
              <span>操作</span>
            </div>
          </el-card>
          <el-card
            shadow="hover"
            class="card"
            v-for="user in userList"
            :key="user.id"
          >
            <div class="content">
              <span>{{ user.username }}</span>
              <span>{{ user.nickname }}</span>
              <span
                ><el-tag :type="user.role == 2 ? 'danger' : 'info'" class="tag">
                  {{ user.role == 2 ? "管理员" : "普通用户" }}
                </el-tag></span
              >
              <span
                ><el-tag :type="user.status ? 'success' : 'danger'" class="tag">
                  {{ user.status ? "已激活" : "未激活" }}
                </el-tag></span
              >
              <span>
                <el-button type="primary" @click="showDialog(user)"
                  >编辑</el-button
                ></span
              >
            </div>
          </el-card>
        </div>
      </el-collapse-item>
    </el-collapse>
    <el-dialog
      title="修改信息"
      append-to-body="true"
      :visible.sync="dialogFormVisible"
      modal="true"
      center="true"
      width="40%"
    >
      <el-form :model="form">
        <el-form-item label="用户名" :label-width="formLabelWidth">
          <el-input
            v-model="form.username"
            autocomplete="off"
            disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="密码" :label-width="formLabelWidth">
          <el-input
            v-model="form.password"
            autocomplete="off"
            show-password
            @keyup.enter.native="saveUpdate"
          ></el-input>
        </el-form-item>
        <el-form-item label="姓名" :label-width="formLabelWidth">
          <el-input v-model="form.nickname" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="激活状态" :label-width="formLabelWidth">
          <el-switch
            v-model="form.status"
            active-color="#13ce66"
            inactive-color="#ff4949"
            :active-value="1"
            :inactive-value="0"
          >
          </el-switch>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="saveUpdate">保 存</el-button>
      </div>
    </el-dialog>
  </el-card>
</template>

<script>
import {
  reqGetUserList,
  reqUpdateUserById,
  reqDeleteCarpool,
  reqDeleteOrderByUser,
} from "@/api";
export default {
  name: "OchMisChzuIndex",

  data() {
    return {
      activeName: "1",
      userList: [],
      carPoll: [],
      userInfo: {},
      dialogFormVisible: false,
      form: {},
      formLabelWidth: "120px",
    };
  },

  async mounted() {
    try {
      await this.getCarPoll();
    } catch (error) {
      this.msg(error.message, "error");
    }
    this.carPoll.sort((b, a) => {
      return a.status - b.status;
    });
    let res = await reqGetUserList();
    if (res.status == 200) {
      this.userList = res.data;
    }
    this.userInfo = this.$parent.userInfo;
  },

  methods: {
    msg(message, type) {
      this.$message({
        message,
        type,
        duration: 1500,
      });
    },
    showDialog(user) {
      this.dialogFormVisible = true;
      this.form = user;
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
        await this.$store.dispatch("getCarPoll");
        this.carPoll = this.$store.state.car.carPoll || [];
      } catch (error) {
        this.msg(error.message, "error");
      }
    },
    async saveUpdate() {
      this.dialogFormVisible = false;
      let res = await reqUpdateUserById(this.form);
      if (res.status == 200) {
        this.msg("修改成功", "success");
      } else {
        this.msg("修改失败", "error");
      }
    },
    async del(car) {
      let res;
      res = await reqDeleteCarpool(car.id);
      if (res.status == 200) {
        this.msg("删除成功", "success");
        this.getCarPoll();
      } else {
        res = await reqDeleteOrderByUser(car.id, this.userInfo.username);
        if (res.status == 200) {
          this.msg("删除成功", "success");
          this.getCarPoll();
        } else {
          this.msg("删除失败", "error");
        }
      }
    },
  },
};
</script>

<style lang="less" scoped>
.flex {
  display: flex;
  flex-direction: row;
  align-items: center;
}
.container {
  height: fit-content;
  .title {
    font-size: 40px;
    font-weight: 300;
    text-align: center;
    padding: 20px;
  }
  .el-collapse {
    border: none;
  }
  .userL,
  .carL {
    margin-bottom: 20px;
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
    .cards {
      margin-top: 10px;
      .card {
        margin-bottom: 10px;
        padding: 10px 0px;
        .content {
          .flex();
          span {
            &:nth-child(-n + 3) {
              width: 100px;
            }
            overflow: hidden;
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
}
.el-dialog__wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  .el-input {
    width: 80%;
    margin-left: 20px;
  }
  .el-switch{
    margin-left: 20px;
  }
}
</style>
