<template>
  <div class="container">
    <div class="tabar">
      <div class="left" @click="toLink(-1)">
        <i class="el-icon-s-promotion icon"></i>
        <h1>大学生网约车系统</h1>
      </div>
      <div class="center">
        <h2 @click="toLink(0)">新闻公告</h2>
        <h2 @click="toLink(1)">约车大厅</h2>
        <h2 @click="toLink(2)">个人中心</h2>
        <h2 @click="toLink(3)" v-if="userInfo.role == 2">管理中心</h2>
      </div>
      <div class="right">
        <div class="unLogin" v-if="!userInfo.username">
          <router-link to="/login"><h2>登录</h2></router-link>
          <router-link to="/register"><h2>注册</h2></router-link>
        </div>
        <div ref="" class="Logined" v-if="userInfo.username">
          <el-dropdown trigger="click" @command="handleCommand">
            <span class="el-dropdown-link">
              <el-avatar>
                {{ (userInfo.nickname || "").substring(0, 1) }}
              </el-avatar>
            </span>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item icon="el-icon-user-solid" command="1"
                >修改信息</el-dropdown-item
              >
              <el-dropdown-item
                v-if="userInfo.role == 2"
                icon="el-icon-circle-plus"
                command="2"
                >发布公告</el-dropdown-item
              >
              <el-dropdown-item icon="el-icon-error" command="3"
                >退出登录</el-dropdown-item
              >
            </el-dropdown-menu>
          </el-dropdown>
        </div>
      </div>
    </div>
    <div class="main">
      <h1
        class="animate__animated animate__flipInX"
        v-show="this.$route.path == '/home'"
      >
        欢迎使用大学生网约车管理系统
      </h1>
      <transition
        mode="out-in"
        enter-active-class="animate__animated animate__bounceInLeft"
        leave-active-class="animate__animated animate__backOutRight"
      >
        <router-view></router-view>
      </transition>
    </div>
    <el-dialog
      title="修改信息"
      :visible.sync="dialogFormVisible"
      :modal="false"
    >
      <el-form :model="form">
        <el-form-item label="用户名" :label-width="formLabelWidth">
          <el-input
            v-model="form.username"
            autocomplete="off"
            disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="姓名" :label-width="formLabelWidth">
          <el-input v-model="form.nickname" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="密码" :label-width="formLabelWidth">
          <el-input
            v-model="form.password"
            autocomplete="off"
            show-password
          ></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="saveUpdate">保 存</el-button>
      </div>
    </el-dialog>

    <svg
      v-show="this.$route.path == '/home'"
      xmlns="http://www.w3.org/2000/svg"
      width="100%"
      height="100%"
      id="svg"
      viewBox="0 0 1440 200"
      class="transition duration-300 ease-in-out delay-150"
    >
      <defs>
        <linearGradient id="gradient" x1="0%" y1="50%" x2="100%" y2="50%">
          <stop offset="5%" stop-color="#002bdc88" />
          <stop offset="95%" stop-color="#32ded488" />
        </linearGradient>
      </defs>
      <path
        d="M 0,500 C 0,500 0,166 0,166 C 117.30143540669857,163.16746411483254 234.60287081339715,160.33492822966508 321,179 C 407.39712918660285,197.66507177033492 462.88995215311,237.82775119617227 547,221 C 631.11004784689,204.17224880382773 743.8373205741627,130.35406698564594 857,116 C 970.1626794258373,101.64593301435407 1083.7607655502393,146.75598086124404 1181,165 C 1278.2392344497607,183.24401913875596 1359.1196172248804,174.62200956937798 1440,166 C 1440,166 1440,500 1440,500 Z"
        stroke="none"
        stroke-width="0"
        fill="url(#gradient)"
        class="transition-all duration-300 ease-in-out delay-150 path-0"
      />
      <defs>
        <linearGradient id="gradient" x1="0%" y1="50%" x2="100%" y2="50%">
          <stop offset="5%" stop-color="#002bdcff" />
          <stop offset="95%" stop-color="#32ded4ff" />
        </linearGradient>
      </defs>
      <path
        d="M 0,500 C 0,500 0,333 0,333 C 120.02870813397132,355.54545454545456 240.05741626794264,378.0909090909091 323,372 C 405.94258373205736,365.9090909090909 451.7990430622009,331.18181818181813 550,324 C 648.2009569377991,316.81818181818187 798.7464114832536,337.1818181818182 898,329 C 997.2535885167464,320.8181818181818 1045.2153110047846,284.09090909090907 1127,280 C 1208.7846889952154,275.90909090909093 1324.3923444976076,304.4545454545455 1440,333 C 1440,333 1440,500 1440,500 Z"
        stroke="none"
        stroke-width="0"
        fill="url(#gradient)"
        class="transition-all duration-300 ease-in-out delay-150 path-1"
      />
    </svg>
  </div>
</template>

<script>
import { reqUpdateUserById } from "@/api";

export default {
  name: "Home",
  data() {
    return {
      userInfo: {},
      form: {},
      dialogFormVisible: false,
      formLabelWidth: "120px",
    };
  },

  mounted() {
    this.userInfo = this.$store.state.user.userInfo;
  },

  methods: {
    msg(message, type) {
      this.$message({
        message,
        type,
        duration: 1500,
      });
    },
    handleCommand(command) {
      if (command == "1") {
        this.dialogFormVisible = true;
        this.form = this.userInfo;
        this.form.password = "";
      } else if (command == "2") {
        this.$router.push("/newsadd");
      } else {
        this.$store.dispatch("Clear");
        this.msg("退出成功", "success");
        this.$router.push("/login");
      }
    },
    toLink(index) {
      if (index == -1) this.$router.push("/home");
      else if (index == 0) this.$router.push("/news");
      else if (index == 1) {
        if (!this.userInfo.username) {
          this.msg("请先登录", "warning");
          this.$router.push("/login");
        } else {
          this.$router.push("/hall");
        }
      } else if (index == 2) {
        if (!this.userInfo.username) {
          this.msg("请先登录", "warning");
          this.$router.push("/login");
        } else {
          this.$router.push("/personal");
        }
      } else this.$router.push("/manage");
    },
    async saveUpdate() {
      this.dialogFormVisible = false;
      let res = await reqUpdateUserById(this.form);
      if (res.status == 200) {
        this.userInfo = this.form;
        console.log(this.form, this.userInfo);
        this.msg("修改成功", "success");
      } else {
        this.msg("修改失败", "error");
      }
    },
  },
  computed: {},
};
</script>

<style lang="less" scoped>
.flex {
  display: flex;
  flex-direction: row;
  align-items: center;
}
.container {
  .path-1 {
    animation: pathAnim-1 4s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
  }
  @keyframes pathAnim-1 {
    0% {
      d: path(
        "M 0,500 C 0,500 0,333 0,333 C 120.02870813397132,355.54545454545456 240.05741626794264,378.0909090909091 323,372 C 405.94258373205736,365.9090909090909 451.7990430622009,331.18181818181813 550,324 C 648.2009569377991,316.81818181818187 798.7464114832536,337.1818181818182 898,329 C 997.2535885167464,320.8181818181818 1045.2153110047846,284.09090909090907 1127,280 C 1208.7846889952154,275.90909090909093 1324.3923444976076,304.4545454545455 1440,333 C 1440,333 1440,500 1440,500 Z"
      );
    }
    25% {
      d: path(
        "M 0,500 C 0,500 0,333 0,333 C 112.89952153110048,354.88516746411483 225.79904306220095,376.77033492822966 324,380 C 422.20095693779905,383.22966507177034 505.7033492822966,367.8038277511962 601,364 C 696.2966507177034,360.1961722488038 803.3875598086124,368.0143540669856 907,378 C 1010.6124401913876,387.9856459330144 1110.7464114832535,400.1387559808612 1199,393 C 1287.2535885167465,385.8612440191388 1363.6267942583731,359.4306220095694 1440,333 C 1440,333 1440,500 1440,500 Z"
      );
    }
    50% {
      d: path(
        "M 0,500 C 0,500 0,333 0,333 C 120.06698564593302,358.6842105263158 240.13397129186603,384.36842105263156 327,379 C 413.86602870813397,373.63157894736844 467.53110047846906,337.2105263157895 569,319 C 670.468899521531,300.7894736842105 819.7416267942582,300.7894736842105 907,319 C 994.2583732057418,337.2105263157895 1019.5023923444976,373.63157894736844 1098,379 C 1176.4976076555024,384.36842105263156 1308.248803827751,358.6842105263158 1440,333 C 1440,333 1440,500 1440,500 Z"
      );
    }
    75% {
      d: path(
        "M 0,500 C 0,500 0,333 0,333 C 109.43540669856458,303.47846889952154 218.87081339712915,273.95693779904303 315,275 C 411.12918660287085,276.04306220095697 493.9521531100479,307.65071770334936 594,325 C 694.0478468899521,342.34928229665064 811.3205741626793,345.4401913875598 904,333 C 996.6794258373207,320.5598086124402 1064.7655502392345,292.58851674641147 1150,290 C 1235.2344497607655,287.41148325358853 1337.6172248803828,310.2057416267943 1440,333 C 1440,333 1440,500 1440,500 Z"
      );
    }
    100% {
      d: path(
        "M 0,500 C 0,500 0,333 0,333 C 120.02870813397132,355.54545454545456 240.05741626794264,378.0909090909091 323,372 C 405.94258373205736,365.9090909090909 451.7990430622009,331.18181818181813 550,324 C 648.2009569377991,316.81818181818187 798.7464114832536,337.1818181818182 898,329 C 997.2535885167464,320.8181818181818 1045.2153110047846,284.09090909090907 1127,280 C 1208.7846889952154,275.90909090909093 1324.3923444976076,304.4545454545455 1440,333 C 1440,333 1440,500 1440,500 Z"
      );
    }
  }
  .path-0 {
    animation: pathAnim-0 4s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
  }
  @keyframes pathAnim-0 {
    0% {
      d: path(
        "M 0,500 C 0,500 0,166 0,166 C 117.30143540669857,163.16746411483254 234.60287081339715,160.33492822966508 321,179 C 407.39712918660285,197.66507177033492 462.88995215311,237.82775119617227 547,221 C 631.11004784689,204.17224880382773 743.8373205741627,130.35406698564594 857,116 C 970.1626794258373,101.64593301435407 1083.7607655502393,146.75598086124404 1181,165 C 1278.2392344497607,183.24401913875596 1359.1196172248804,174.62200956937798 1440,166 C 1440,166 1440,500 1440,500 Z"
      );
    }
    25% {
      d: path(
        "M 0,500 C 0,500 0,166 0,166 C 121.52153110047843,143.11004784688996 243.04306220095685,120.2200956937799 326,114 C 408.95693779904315,107.7799043062201 453.3492822966508,118.22966507177034 536,117 C 618.6507177033492,115.77033492822966 739.5598086124402,102.86124401913875 842,122 C 944.4401913875598,141.13875598086125 1028.4114832535886,192.32535885167465 1125,205 C 1221.5885167464114,217.67464114832535 1330.7942583732056,191.83732057416267 1440,166 C 1440,166 1440,500 1440,500 Z"
      );
    }
    50% {
      d: path(
        "M 0,500 C 0,500 0,166 0,166 C 82.32535885167468,143.25358851674642 164.65071770334936,120.50717703349282 273,115 C 381.34928229665064,109.49282296650718 515.7224880382774,121.2248803827751 600,137 C 684.2775119617226,152.7751196172249 718.4593301435407,172.59330143540672 816,163 C 913.5406698564593,153.40669856459328 1074.4401913875597,114.4019138755981 1189,110 C 1303.5598086124403,105.5980861244019 1371.77990430622,135.79904306220095 1440,166 C 1440,166 1440,500 1440,500 Z"
      );
    }
    75% {
      d: path(
        "M 0,500 C 0,500 0,166 0,166 C 78.45933014354068,132.4019138755981 156.91866028708137,98.80382775119617 254,114 C 351.08133971291863,129.19617224880383 466.78468899521533,193.1866028708134 567,197 C 667.2153110047847,200.8133971291866 751.9425837320575,144.44976076555022 841,145 C 930.0574162679425,145.55023923444978 1023.4449760765549,203.01435406698565 1124,216 C 1224.555023923445,228.98564593301435 1332.2775119617227,197.49282296650716 1440,166 C 1440,166 1440,500 1440,500 Z"
      );
    }
    100% {
      d: path(
        "M 0,500 C 0,500 0,166 0,166 C 117.30143540669857,163.16746411483254 234.60287081339715,160.33492822966508 321,179 C 407.39712918660285,197.66507177033492 462.88995215311,237.82775119617227 547,221 C 631.11004784689,204.17224880382773 743.8373205741627,130.35406698564594 857,116 C 970.1626794258373,101.64593301435407 1083.7607655502393,146.75598086124404 1181,165 C 1278.2392344497607,183.24401913875596 1359.1196172248804,174.62200956937798 1440,166 C 1440,166 1440,500 1440,500 Z"
      );
    }
  }
  @borderColor: rgb(234, 232, 232);
  width: 100%;
  height: 100vh;
  .tabar {
    .flex();
    padding: 10px 0;
    width: 100%;
    height: 8%;
    background-color: white;
    justify-content: space-between;
    border-bottom: 1px solid @borderColor;
    position: fixed;
    z-index: 2;
    .left {
      .flex();
      flex-grow: 1;
      margin-left: 10px;
      .icon {
        font-size: 40px;
        color: #46affb;
      }
    }
    .center {
      .flex();
      flex-grow: 1.5;
      h2 {
        margin-left: 10px;
        color: #3273dc;
        font-weight: 400;
        padding: 10px;
        border-radius: 5px;
        &:hover {
          transition: all 0.5s;
          background-color: #66aaf8;
          color: white;
        }
      }
    }
    .right {
      flex-grow: 0;
      margin-right: 20px;
      .unLogin {
        .flex();
        .el-dropdown-link {
          cursor: pointer;
          color: #409eff;
        }
        .el-icon-arrow-down {
          font-size: 12px;
        }
        .demonstration {
          display: block;
          color: #8492a6;
          font-size: 14px;
          margin-bottom: 20px;
        }
        h2 {
          color: black;
          margin-right: 10px;
        }
      }
      .Logined {
        .flex();
        .icon {
          font-size: 25px;
        }
      }
    }
  }
  .main {
    width: 70%;
    height: fit-content;
    padding-bottom: 20px;
    position: absolute;
    top: 12%;
    left: 50%;
    transform: translateX(-50%);
    h1 {
      width: 100%;
      text-align: center;
      font-size: 40px;
      position: absolute;
      margin-top: 18%;
      animation-duration: 2s;
      animation-direction: alternate;
      animation-iteration-count: infinite;
    }
  }
}
</style>
