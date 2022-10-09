<template>
  <el-card shadow="hover" class="container">
    <div class="carInfo">
      <div class="header">
        <span class="time">{{ car.ctime }}</span>
        <span><el-tag type="success" class="tag"> 拼车成功 </el-tag></span>
      </div>
      <div>
        <span
          ><i class="el-icon-location posF"></i
          >{{ (car.place||"").split("-")[0] }}</span
        >
      </div>
      <div>
        <span
          ><i class="el-icon-location posT"></i
          >{{ (car.place||"").split("-")[1] }}</span
        >
      </div>
    </div>
    <div class="comments">
      <div style="margin-top: 20px">
        <el-input
          placeholder="请输入内容"
          v-model="myComment.content"
          class="input-with-select"
          @keyup.enter.native = "sendComment"
        >
          <el-button
            slot="append"
            icon="el-icon-thumb"
            type="primary"
            style="background-color: #409eff; color: white;"
            @click="sendComment"
            >发布评论</el-button
          >
        </el-input>
      </div>
      <div class="coList">
        <div class="item" v-for="co in comments" :key="co.id">
          <el-avatar> {{ (co.nickname||"").substring(0,1) }} </el-avatar>
          <el-tooltip class="item" effect="light" :content="'评论时间：'+co.dtime" placement="right" >
            <div class="content">{{ co.content }}</div>
          </el-tooltip>
          <i class="el-icon-delete del" type="danger" v-if="userInfo.role == 2" @click="del(co)"></i>
        </div>
      </div>
    </div>
  </el-card>
</template>

<script>
import {reqDeleteComment,reqSaveComment,reqGetCommentList} from '@/api'
export default {
  name: "OchMisChzuIndex",

  data() {
    return {
      comments: [],
      car: {},
      myComment: {
        cid: 0,
        content: "",
        nickname: ""
      },
      userInfo: {}
    };
  },

  mounted() {
    this.car = this.$route.params.car || JSON.parse(localStorage.getItem("car"));
    this.userInfo = this.$parent.userInfo;
    this.getComments();
  },

  methods: {
    msg(message, type) {
      this.$message({
        message,
        type,
        duration: 1500
      });
    },
    async getComments(){
      let res = await reqGetCommentList(this.car.id);
      if(res.status == 200) {
        this.comments = res.data;
      }
      console.log(this.comments,res)
    },
    async sendComment(){
      console.log(this.car.id)
      this.myComment.cid = this.car.id;
      this.myComment.nickname = this.userInfo.nickname;
      let res = await reqSaveComment(this.myComment);
      if(res.status == 200){
        this.getComments();
        this.msg('发布成功','success')
        this.myComment = {};
      }else{
        this.msg('发布失败','error')
      }
    },
    async del(co){
      let res = await reqDeleteComment(co.id);
      if(res.status == 200){
        this.getComments();
        this.msg('删除成功','success')
      }else{
        this.msg('删除失败','error')
      }
    }
  },
};
</script>

<style lang="less" scoped>
.flex_row {
  display: flex;
  flex-direction: row;
  align-items: center;
}
.flex_col {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}
.container {
  height: fit-content;
  .carInfo {
    .flex_col();
    .header {
      .flex_row();
      justify-content: center;
      .time {
        font-size: 30px;
        margin-right: 20px;
      }
    }
    div {
      margin-bottom: 10px;
      span {
        font-size: 18px;
        .tag {
          font-size: 16px;
        }
        .posF {
          color: rgb(112, 233, 132);
        }
        .posT {
          color: rgb(255, 178, 91);
        }
      }
    }
  }
  .comments {
    .coList {
      margin-top: 50px;
      .item {
        margin-top: 20px;
        .flex_row();
        .content {
          margin-left: 20px;
          border: 2px solid rgb(234, 232, 232);
          border-radius: 10px;
          padding: 10px;
          font-size: 18px;
          font-weight: 300;
        }
        .del {
          margin-left: 20px;
          font-size: 20px;
          display: none;
          &:hover{
            color: red;
            transition: all 1s;
          }
        }
        &:hover {
          .del{
            display: block;
          }
        }
      }
    }
  }
}
</style>
