<template>
  <el-card shadow="hover" class="container">
    <div class="title">发布公告</div>
    <el-form ref="form" :model="newsForm" label-width="80px">
      <el-form-item label="公告标题">
        <el-input v-model="newsForm.title" placeholder="请输入标题"></el-input>
      </el-form-item>
      <el-form-item label="公告内容">
        <el-input type="textarea" v-model="newsForm.content" rows="5" placeholder="请输入内容" @keyup.enter.native = "addNews"></el-input>
      </el-form-item>
      <el-form-item style="display: flex;flex-direction: row;justify-content: flex-end;">
        <el-button @click="cancel">取消</el-button>
        <el-button type="primary" @click="addNews">立即发布</el-button>
      </el-form-item>
    </el-form>
  </el-card>
</template>

<script>
import {reqAddNews} from '@/api'
export default {
  name: "index",
  data(){
    return {
      userInfo: {},
      newsForm: {
        "content": "",
        "title": "",
        "writer": ""
      },
    }
  },
  mounted() {
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
    async addNews(){
      this.newsForm.writer = this.userInfo.username;
      let res = await reqAddNews(this.newsForm);
      if(res.status == 200){
        this.msg('添加成功','success')
        this.$router.push('/news')
      } else {
        this.msg('添加失败','error')
      }
    },
    cancel(){
      this.$router.push('/news')
    }
  }
}
</script>

<style lang="less" scoped>
.flex {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
}
.container {
  padding: 20px;
  height: fit-content;
  .title {
    font-size: 40px;
    font-weight: 300;
    text-align: center;
    padding: 20px;
  }
}
</style>