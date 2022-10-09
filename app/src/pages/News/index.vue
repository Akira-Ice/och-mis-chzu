<template>
  <el-card shadow="hover" class="container">
    <div class="title">新闻公告</div>
    <div class="block">
      <el-carousel height="280px" arrow="never" trigger="click">
        <el-carousel-item v-for="(item,index) in newsImg" :key="index">
          <el-image :src="item" fit="cover"  style="width: 100%;"></el-image>
        </el-carousel-item>
      </el-carousel>
    </div>
    <div class="collapse">
      <el-collapse v-model="activeNames" @change="handleChange">
        <el-collapse-item :name="index" v-for="(news,index) in newsList" :key="index" class="item">
          <template slot="title">
            <h1>{{news.title}}</h1>
          </template>
          <pre>{{news.content}}</pre>
        </el-collapse-item>
      </el-collapse>
    </div>
  </el-card>
</template>

<script>
import {reqGetListNews} from '@/api';
export default {
  name: "OchMisChzuIndex",

  data() {
    return {
      activeNames: ["0"],
      newsList: [],
      newsImg:[
          'https://tse1-mm.cn.bing.net/th/id/OIP-C.s7u5lYGtm4L3PQQdwiPKiwHaEo?w=272&h=180&c=7&r=0&o=5&dpr=1.32&pid=1.7',
          'https://tse3-mm.cn.bing.net/th/id/OIP-C.9X9jhRy0ITFiTBwlAqGdsQHaDt?w=347&h=174&c=7&r=0&o=5&dpr=1.32&pid=1.7',
          'https://tse1-mm.cn.bing.net/th/id/OIP-C.9yXoKoMV5dMZg7SKTk17agHaFl?w=257&h=194&c=7&r=0&o=5&dpr=1.32&pid=1.7'
      ]
    };
  },

  mounted() {
    this.getNewsList();
  },

  methods: {
    async getNewsList(){
      let res = await reqGetListNews();
      if(res.status == 200){
        this.newsList = res.data;
      }
    },
    handleChange(val) {
    },
  },
};
</script>

<style lang="less" scoped>
.container {
  height: fit-content;
  .block {
    padding: 10px 0;
    .el-carousel__item h3 {
      color: #475669;
      font-size: 14px;
      opacity: 0.75;
      line-height: 150px;
      margin: 0;
    }

    .el-carousel__item:nth-child(2n) {
      background-color: #99a9bf;
    }

    .el-carousel__item:nth-child(2n + 1) {
      background-color: #d3dce6;
    }
  }
  .title {
    font-size: 40px;
    font-weight: 300;
    text-align: center;
    padding: 20px;
  }
  .collapse {
    padding: 10px 20px;
    h1 {
      width: fit-content;
      padding-left: 10px;
      border-style: solid;
      border-left-width: 5px;
      border-color: rgb(211,220,230);
      border-top: none;
      border-right: none;
      border-bottom: none;
    }
    .item{
      margin-bottom: 20px;
      pre{
        font-size: 14px;
        font-weight: 300;
        white-space: pre-wrap;
        padding: 20px;
      }
    }
  }
}
</style>
